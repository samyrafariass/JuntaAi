from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from shared import EnderecoBase

class CreateOrgao:
    Nome: str
    Descricao_Alerta: str
    Id_Classificacao: int
    Solicitacao: bool

class UpdateOrgao:
    Id_Orgao: int
    Nome: Optional[str]
    Descricao_Alerta: Optional[str]
    Id_Classificacao: Optional[int]
    Solicitacao: Optional[bool]

class AlertaRecebido:
    Id_Alerta: int

class ResponseOrgao:
    Id_Orgao: int
    Nome: str
    Descricao_Alerta: str
    Id_Classificacao: int
    Solicitacao: bool

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON
