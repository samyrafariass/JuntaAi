from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Classificacao, Orgao
from schemas.classificacao_schema import ClassificaOrgao, AtualizaClassificacaoOrgao, ResponseClassificacao

router_classificacao = APIRouter(prefix="/classificacoes", tags=["Classificacoes"])

