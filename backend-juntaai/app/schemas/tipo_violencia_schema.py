from pydantic import BaseModel
from typing import Optional

class RecomendacaoCanalDenuncia(BaseModel):
    Id_Usuaria: int
    Resposta: str
    Status: bool

class RecomendacaoRedeApoio(BaseModel):
    Id_Usuaria: int
    Resposta: str
    Status: bool

class ResponseTipoViolencia(BaseModel):
    Id_Tipo_Violencia: int
    Sessao: int
    Pergunta: str
    Resposta: str
    Status: bool

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON
