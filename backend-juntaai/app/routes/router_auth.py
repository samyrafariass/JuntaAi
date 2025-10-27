# imports
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
from utils.security import ACCESS_TOKEN_EXPIRE_MINUTES, verify_password, create_access_token, get_hash_password
from model.db_model import Usuaria
from db.database_conection import get_db
from schemas.usuaria_schema import UserCreate, UserResponse

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

