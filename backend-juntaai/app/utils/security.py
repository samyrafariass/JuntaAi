# Utilidades gerais reutilizáveis, como: Hash de senha, geracão/verificação de JWT, Mnaipulação de datas, string, etc
# Funções de hash_password, verify_password, instância do CryptContext com bcrypt - security
# imports
import os
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from passlib.context import CryptContext
from datetime import datetime, timedelta
from jose import JWTError, jwt
from typing import Optional
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from app.model.db_model import Usuaria
from app.schemas.auth_schema import TokenData

# Config
SECRET_KEY = os.getenv('SECRET_KEY')
ALGORITHM = os.getenv("ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES: int = os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES")

# Config token recuperação de senha
TOKEN_EXPIRE = os.getenv("TOKEN_EXPIRE")

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

# Compara os hashs
def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

# Transforma a senha em Hash
def get_hash_password(Senha: str) -> str:
    return pwd_context.hash(Senha)

# Cria token JWT
def create_access_token(data: dict, expires_delta: Optional[timedelta]):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expires_delta = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)

    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

# Decodifica token JWT
def verify_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        Email: str = payload.get('sub')
        if Email is None:
            raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, 
            detail="Não conseguimos verificar suas credenciais."
        )
        return TokenData(Email = Email) 
    except JWTError:
        return None

# Verifica se a usuária corresponde ao seu token
def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    token_data = verify_token(token)
    usuaria = db.query(Usuaria).filter(Usuaria.Email == token_data.Email).first()
    if usuaria is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, 
            detail="A usuária ainda não foi cadastrada!"
        )
    return usuaria

# Verifica a atividade da usuária (se está ou não ativa)
def get_current_active_user(current_user: Usuaria = Depends(get_current_user)):
    if not current_user.is_active:
        raise HTTPException(
            status_code=404,
            detail="Usuária não está ativa!",
        )
    return current_user

# Token de recuperação de senha
def gerar_token_recuperacao(Email: str):
    expire = datetime.utcnow() + timedelta(minutes=TOKEN_EXPIRE)
    payload = {"sub": Email, "exp": expire}
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

# # Validação do token de recuperação de senha
def validar_token_recuperacao(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload.get("sub")
    except JWTError:
        return None