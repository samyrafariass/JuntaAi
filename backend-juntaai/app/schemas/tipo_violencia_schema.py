from pydantic import BaseModel
from typing import Optional

class RecomendacaoCanalDenuncia:
    pass

class RecomendacaoRedeApoio:
    pass

class ResponseTipoViolencia:
    Id_Tipo_Violencia: int
    Sessao: int
    Pergunta: str
    Resposta: int
    Status: bool

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON