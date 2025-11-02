from pydantic import BaseModel
from typing import Optional

class AdicionarConteudo(BaseModel):
    Conteudo: str
    Descricao: str

class AtualizarConteudo(BaseModel):
    Id_Conteudo: int
    Conteudo: Optional[str]
    Descricao: Optional[str]

class ResponseConteudo(BaseModel):
    Id_Conteudo: int
    Conteudo: str
    Descricao: str

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON
