# Imports
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date
from .shared import EnderecoBase

# ---------------- Usuária ----------------
class UserCreate(BaseModel):
    Nome: str
    Data_Nascimento: date
    Endereco: EnderecoBase
    Email: EmailStr
    Senha: str
    Telefone: str = None

class UserUpdate(BaseModel):
    Nome: Optional[str]
    Data_Nascimento: Optional[date]
    Endereco: Optional[EnderecoBase]
    Email: Optional[EmailStr]
    Senha: Optional[str]
    Telefone: str = None

class UserResponse(BaseModel):
    Id_Usuaria: int
    Nome: str
    Email: EmailStr

    class Config:
        from_attributes = True  # permite converter objetos SQLAlchemy para JSON

