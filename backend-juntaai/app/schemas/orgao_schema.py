from pydantic import BaseModel
from typing import Optional

class CreateOrgao(BaseModel):
    Nome: str
    Descricao_Alerta: str
    Id_Classificacao: int
    Solicitacao: bool

class UpdateOrgao(BaseModel):
    Id_Orgao: int
    Nome: Optional[str]
    Descricao_Alerta: Optional[str]
    Id_Classificacao: Optional[int]
    Solicitacao: Optional[bool]

class ResponseOrgao(BaseModel):
    Id_Orgao: int
    Nome: str
    Descricao_Alerta: str
    Id_Classificacao: int
    Solicitacao: bool

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON
