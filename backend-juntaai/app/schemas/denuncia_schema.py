from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class CreateDenuncia(BaseModel):
    Violencia_Sofrida: str
    Situacao_Atual: str
    Descricao: str
    Data_Hora: datetime
    Status_Denuncia: bool
    Id_Usuaria: int | None = None   

class VinculaDenunciaUsuaria(BaseModel):
    Id_Usuaria: int
    Id_Denuncia: int

class UpdateDenuncia(BaseModel):
    Id_Denuncia: int
    Violencia_Sofrida: Optional[str]
    Situacao_Atual: Optional[str]
    Descricao: Optional[str]
    Data_Hora: Optional[datetime]
    Status_Denuncia: Optional[bool]

class SendDenunciaForOrgao(BaseModel):
    Id_Orgao: int
    Id_Denuncia: int

class CancelVinculacaoDenunciaUsuaria(BaseModel):
    Id_Usuaria: int
    Id_Denuncia: int

class ResponseDenuncia(BaseModel):
    Id_Denuncia: int
    Violencia_Sofrida: str
    Situacao_Atual: str
    Descricao: str
    Data_Hora: datetime
    Status_Denuncia: bool

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON
