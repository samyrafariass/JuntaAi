from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import TipoViolencia, Sofre_Tipo_Violencia_Usuaria
from schemas.tipo_violencia_schema import RecomendacaoCanalDenuncia, RecomendacaoRedeApoio, ResponseTipoViolencia

router_tipo_violencia = APIRouter(prefix="/tipo-violencia", tags=["Tipo-Violencias"])
