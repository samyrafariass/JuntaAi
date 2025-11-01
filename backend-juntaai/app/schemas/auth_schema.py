# imports
from pydantic import BaseModel, EmailStr
from typing import Optional

class UserLogin(BaseModel):
    Email: EmailStr
    Senha: str

class SolicitarRecuperacao(BaseModel):
    Email: EmailStr

class RedefinirSenha(BaseModel):
    token: str
    Senha: str
    Confirmar_Senha: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    Email: Optional[str]

