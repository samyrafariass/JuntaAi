from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Alerta, Orgao
from schemas.orgao_schema import CreateOrgao, UpdateOrgao, AlertaRecebido, ResponseOrgao

router_orgao = APIRouter(prefix="/orgaos", tags=["Orgaos"])