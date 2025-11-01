# Deve ter um APIRouter instanciado, Rotas @router.post, @router.get..., Uso de Depends(get_db) para acessar o banco e validações e respostas com o schema schemas.usuaria
# GET(Ler) - POST (Criar) - PUT (Atualizar) - DELETE (Deletar)
# Endpoints da API / chamam as services
# imports
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from db.database_conection import get_db
from schemas.usuaria_schema import UserCreate, UserUpdate, UserResponse
from model.db_model import Usuaria
from utils.security import get_current_active_user, get_hash_password
from sqlalchemy import func

# Criação de rotas modulares
router_usuaria = APIRouter(prefix="/usuarias", tags=["Usuarias"])

# Consulta o perfil da usuária
@router_usuaria.get("/perfil", response_model=UserResponse)
def get_perfil(current_user: Usuaria = Depends(get_current_active_user)):
    return current_user

# Consulta a validação do token da usuária
@router_usuaria.get("/verifica-token")
def verificar_endpoint_token(current_user: Usuaria = Depends(get_current_active_user)):
    return{
        "valid": True,
         "Usuaria": current_user
    }

# Ler todas as usuárias
@router_usuaria.get("/", response_model=list[UserResponse])
def list_users(current_user: Usuaria = Depends(get_current_active_user), db: Session = Depends(get_db)):
    return db.query(Usuaria).all()


# Ler a usuária pelo ID
@router_usuaria.get("/{Id_Usuaria}", response_model=UserResponse, status_code=200)
def get_user(Id_Usuaria: int, current_user: Usuaria = Depends(get_current_active_user), db: Session = Depends(get_db)):
    db_usuaria = db.query(Usuaria).filter(Usuaria.Id_Usuaria == Id_Usuaria).first()
    if not db_usuaria:
        raise HTTPException(status_code=404, detail="Usuaria não encontrada")
    return db_usuaria


# Criar/Cadastrar uma usuária
@router_usuaria.post("/", response_model=UserResponse, status_code=201)
def cadastrar_usuaria(criar_usuaria: UserCreate, current_user: Usuaria = Depends(get_current_active_user), db: Session = Depends(get_db)):
    try:
        if db.query(Usuaria).filter(Usuaria.Email == criar_usuaria.Email).first():
            raise HTTPException(status_code=401, detail="Email já registrado!")

        if len(criar_usuaria.Senha) < 8:
            raise HTTPException(status_code=400, detail="A senha deve ter pelo menos 8 caracteres...")

        nova_usuaria = Usuaria(**criar_usuaria.model_dump())
        nova_usuaria.Senha = get_hash_password(criar_usuaria.Senha)
        db.add(nova_usuaria)
        db.commit()
        db.refresh(nova_usuaria)
        return nova_usuaria
    except Exception as e:
        db.rollback()
        print(f'Erro: {e}')


# Atualizar os dados de uma usuária pelo ID
@router_usuaria.put("/{Id_Usuaria}", response_model=UserResponse, status_code=201)
def atualizar_usuaria(Id_Usuaria: int, update: UserUpdate, current_user: Usuaria = Depends(get_current_active_user), db: Session = Depends(get_db)):
    try:
        usuaria = db.query(Usuaria).filter(Usuaria.Id_Usuaria == Id_Usuaria).first()
        if not usuaria:
            raise HTTPException(status_code=404, detail="Usuaria não encontrada!")
        
        update_db = update.model_dump(exclude_unset=True)
        
        # validar email único
        if "Email" in update_db:
            existing_user = db.query(Usuaria).filter(func.lower(Usuaria.Email) == update_db["Email"].lower()).first()
            if existing_user and existing_user.Id_Usuaria != Id_Usuaria:
                raise HTTPException(status_code=401, detail="Email já registrado!")

        for key, value in update_db.items():
            setattr(usuaria, key, value)
        
        db.commit()
        db.refresh(usuaria)
        return update_db
    except Exception as e:
        db.rollback()
        print(f'Erro: {e}')   


# Deletar uma usuária pelo ID
@router_usuaria.delete("/{Id_Usuaria}", status_code=200)
def delete_user(Id_Usuaria: int, current_user: Usuaria = Depends(get_current_active_user), db: Session = Depends(get_db)):
    try:
        db_usuaria = db.query(Usuaria).filter(Usuaria.Id_Usuaria == Id_Usuaria).first()
        if not db_usuaria:
            raise HTTPException(status_code=404, detail="Usuaria não encontrada")
        
        if db_usuaria == current_user.Id_Usuaria:
            raise HTTPException(status_code=403, detail="Você não pode deletar sua própria conta")

        db.delete(db_usuaria)
        db.commit()
        return {"detail": f"Usuaria {Id_Usuaria} excluída com sucesso!"}
    except Exception as e:
        db.rollback()
        print(f'Erro: {e}')


