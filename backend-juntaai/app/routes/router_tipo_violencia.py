# imports
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Tipo_Violencia, Sofre_Tipo_Violencia_Usuaria
from schemas.tipo_violencia_schema import RecomendacaoCanalDenuncia, RecomendacaoRedeApoio, ResponseTipoViolencia

router_tipo_violencia = APIRouter(prefix="/tipo-violencia", tags=["Tipo-Violencias"])

# listar o questionário com perguntas e respostas
@router_tipo_violencia.get("/perguntas-questionario", response_model=list[ResponseTipoViolencia], status_code=200)
def listar_questionario(db: Session = Depends(get_db)):
    return db.query(Tipo_Violencia).all()

# listar respostas das usuárias
@router_tipo_violencia.get("/respostas-usuarias", response_model=list[ResponseTipoViolencia], status_code=200)
def listar_respostas_por_usuaria(Id_Usuaria: int, db: Session = Depends(get_db)):
    respostas = db.query(Sofre_Tipo_Violencia_Usuaria).filter(Sofre_Tipo_Violencia_Usuaria.Id_Usuaria == Id_Usuaria).all()
    if not respostas:
        raise HTTPException(status_code=404, detail="Nenhuma resposta encontrada para esta usuária")

    return respostas 

# recomendação de redes de apoio com base nas respostas da usuária
@router_tipo_violencia.get("/{Id_Usuaria}/recomendacao-canal-denuncia", response_model=ResponseTipoViolencia, status_code=200)
def recomendacao_rede_apoio(Id_Usuaria: int, rede_apoio: RecomendacaoRedeApoio, db: Session = Depends(get_db)):
    pass

# recomendação de redes de apoio com base nas respostas da usuária
@router_tipo_violencia.get("/{Id_Usuaria}/recomendacao-rede-apoio", response_model=ResponseTipoViolencia, status_code=200)
def recomendacao_canal_denuncia(Id_Usuaria: int, canal_denuncia: RecomendacaoCanalDenuncia, db: Session = Depends(get_db)):
    pass


