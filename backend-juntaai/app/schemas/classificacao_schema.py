from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from shared import EnderecoBase

class ClassificaOrgao(BaseModel):
    Id_Orgao: int
    Descricao: str
    Telefone: str
    Endereco: EnderecoBase

class AtualizaClassificacaoOrgao(BaseModel):
    Id_Classificacao: int
    Id_Orgao: Optional[int]
    Descricao: Optional[str]
    Telefone: Optional[str]
    Endereco: Optional[EnderecoBase]

class ResponseClassificacao(BaseModel):
    Id_Classificacao: int
    Id_Orgao: int
    Descricao: str
    Telefone: str
    Endereco: EnderecoBase

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON