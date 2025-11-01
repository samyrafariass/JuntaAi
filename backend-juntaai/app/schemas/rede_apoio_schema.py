# imports
from pydantic import BaseModel
from typing import Optional
#from datetime import time
from shared import EnderecoBase

class RedeCreate(BaseModel):
    Nome: str
    Responsavel: str
    Descricao: str
    Telefone: str
    Endereco: EnderecoBase
    Horario: str

class RedeUpdate(EnderecoBase):
    Nome: Optional[str]
    Responsavel: Optional[str]
    Descricao: Optional[str]
    Telefone: Optional[str]
    Endereco: Optional[EnderecoBase]
    Horario: Optional[str]

class RedeResponse(BaseModel):
    Id_Rede_Apoio: int
    Nome: str
    Descricao: str
    Telefone: str
    Endereco: EnderecoBase
    Horario: str
