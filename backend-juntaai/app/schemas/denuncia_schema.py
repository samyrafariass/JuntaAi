from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date
from .shared import EnderecoBase

# ---------------- Usuária ----------------
class CreateDenuncia(BaseModel):
    

class UpdateDenuncia(BaseModel):
    

class CancelDenuncia(BaseModel):


class ResponseDenuncia(BaseModel):
    

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON

