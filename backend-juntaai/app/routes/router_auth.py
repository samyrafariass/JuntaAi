# imports
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from db.database_conection import get_db
from fastapi.security import OAuth2PasswordRequestForm
from utils.security import ACCESS_TOKEN_EXPIRE_MINUTES, verify_password, create_access_token, get_hash_password, gerar_token_recuperacao, validar_token_recuperacao
from model.db_model import Usuaria
from schemas.usuaria_schema import UserCreate, UserResponse
from schemas.auth_schema import SolicitarRecuperacao, RedefinirSenha
from app.utils import token_por_email
from datetime import timedelta

# Rotas modulares
router_auth = APIRouter(prefix='/autenticacao', tags=['Autenticacoes'])

# Registrar a usuária
@router_auth.post("/", response_model=UserResponse)
def registrar_usuaria(usuaria: UserCreate, db: Session = Depends(get_db)):
    if db.query(Usuaria).filter(Usuaria.Email == usuaria.Email).first():
        raise HTTPException(
            status_code=401, # conflito e sem autorização
            detail="Usuária já criada!",
        )
    
    if len(usuaria.Senha) < 8:
            raise HTTPException(status_code=400, detail="A senha deve ter pelo menos 8 caracteres...")
    
    db_user = Usuaria(**usuaria.model_dump())
    db_user.Senha = get_hash_password(db_user.Senha)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# Fazer login 
@router_auth.post("/", response_model=UserResponse)
def login_por_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    usuaria = db.query(Usuaria).filter(Usuaria.Email == form_data.username).first()
    if not usuaria or not verify_password(form_data.Senha, usuaria.hashed_password):
        raise HTTPException(
            status_code=404,
            detail="Algo está errado. Verifique!",
        )
    if not usuaria.is_active:
        raise HTTPException(
            status_code=401, # sem autorização
            detail="Usuária inativa!",
        )
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(data = {'sub': usuaria.Email}, expires_delta = access_token_expires)
    return {'access_token': access_token, "token_type": "bearer"}

# Recuperação de senha por token
@router_auth.post("/solicitar-recuperacao-senha", response_model=UserResponse)
def solicitar_codigo(dados: SolicitarRecuperacao, db: Session = Depends(get_db)):
    usuaria = db.query(Usuaria).filter(Usuaria.Email == dados.Email).first()
    if not usuaria:
        raise HTTPException(status_code=404, detail="Usuária não encontrada.")

    token = gerar_token_recuperacao(usuaria.Email)
    token_por_email.enviar_email(usuaria.Email, token)
    return {"mensagem": "E-mail de recuperação enviado."}


# Validação de token e recuperação de senha
@router_auth.post("/redefinir-senha", response_model=UserResponse)
def redefinir_senha(dados: RedefinirSenha, db: Session = Depends(get_db)):

    email = validar_token_recuperacao(dados.token)
    if not email:
        raise HTTPException(status_code=400, detail="Token inválido ou expirado.")

    usuaria = db.query(Usuaria).filter(Usuaria.Email == email).first()
    if not usuaria:
        raise HTTPException(status_code=404, detail="Usuária não encontrada.")

    if dados.Senha != dados.Confirmar_Senha:
        raise HTTPException(status_code=400, detail="As senhas não coincidem.")

    if len(dados.Senha) < 8:
        raise HTTPException(status_code=400, detail="A nova senha deve ter pelo menos 8 caracteres.")

    usuaria.Senha = get_hash_password(dados.Senha)
    db.commit()
    return {"mensagem": "Senha redefinida com sucesso!"}
