# import
from pydantic import BaseModel

class EnderecoBase(BaseModel):
    CEP: str
    Rua_Avenida: str
    Num_Imovel: int
    Bairro: str
    Cidade: str
    Estado: str

    class Config:
        orm_mode = True
