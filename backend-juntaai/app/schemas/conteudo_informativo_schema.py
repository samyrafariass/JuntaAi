from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from shared import EnderecoBase

class ResponseConteudoInformativo:
    Id_Conteudo: int
    Conteudo: str
    Descricao: str
    Data_Hora: int

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON