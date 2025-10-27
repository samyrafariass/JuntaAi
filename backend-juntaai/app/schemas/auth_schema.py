# imports
from pydantic import BaseModel, EmailStr
from typing import Optional

class UserLogin(BaseModel):
    Email: EmailStr
    Senha: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    Email: Optional[str]

