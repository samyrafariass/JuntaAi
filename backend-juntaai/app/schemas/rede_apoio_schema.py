# imports
from pydantic import BaseModel
from typing import Optional
from datetime import time
from .shared import EnderecoBase

class RedeCreate(EnderecoBase):
    Nome: str
    Responsavel: str
    Descricao: str
    Telefone: str
    Horario: time # TIME

class RedeUpdate(EnderecoBase):
    Nome: Optional[str]
    Responsavel: Optional[str]
    Descricao: Optional[str]
    Telefone: Optional[str]
    Horario: Optional[time] # TIME

class RedeResponse(EnderecoBase):
    Id_Rede_Apoio: int
    Nome: str
    Descricao: str
    Telefone: str
    Horario: time
