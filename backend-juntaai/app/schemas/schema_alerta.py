from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from shared import EnderecoBase

class CreateAlert(BaseModel):
    Status_Alerta: bool
    Endereco: EnderecoBase
    Id_Orgao: int
    Id_Usuaria: int
    Data_Hora: datetime 

class UpdateAlert(BaseModel):
    Id_Alerta: int
    Status_Alerta: Optional[bool]
    Endereco: Optional[EnderecoBase]
    Id_Orgao: Optional[int]
    Id_Usuaria: Optional[int]
    Data_Hora: Optional[datetime] 

class SendAlertForOrgao(BaseModel):
    Id_Alerta: int 
    Id_Orgao: int

class CancelSendAlert(BaseModel):
    Id_Alerta: int
    Status_Alerta: bool

class ResponseAlert(BaseModel):
    Id_Alerta: int
    Status_Alerta: bool
    Endereco: EnderecoBase
    Id_Orgao: int
    Id_Usuaria: int
    Data_Hora: datetime 

    class Config:
        orm_mode = True  # permite converter objetos SQLAlchemy para JSON
