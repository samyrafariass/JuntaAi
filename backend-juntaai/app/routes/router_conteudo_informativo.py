from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Conteudo_Informativo, Acessa_Usuaria_Conteudo
from schemas.conteudo_informativo_schema import ResponseConteudoInformativo

router_conteudo_informativo = APIRouter(prefix="/conteudo-informativo", tags=["Conteudo-Informativo"])
