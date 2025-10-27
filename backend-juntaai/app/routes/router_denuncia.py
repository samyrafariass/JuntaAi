# importações
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from db_schemas import CreateDenuncia, UpdateDenuncia, ResponseDenuncia
from app.models.db_model import Denuncia

router_denuncia = APIRouter(prefix="/denuncias", tags=["Denuncias"])

# POST - CRIA
@router_denuncia.post("/", response_model=ResponseDenuncia, status_code=201)
def create_denuncia(create: CreateDenuncia, db: Session = Depends(get_db)) -> ResponseDenuncia:
    db_denuncia = db.query(Denuncia).filter(Denuncia.gera == create.gera).first() #filtrar/buscar na tabela associativa
    if db_denuncia:
        raise HTTPException(status_code=400, detail="Denúncia já registrada")

    new_denuncia = Denuncia(**create.dict())
    db.add(new_denuncia)
    db.commit()
    db.refresh(new_denuncia)
    return new_denuncia

# PUT - ATUALIZA
@router_denuncia.put("{id_denuncia}", response_model=ResponseDenuncia, status_code=200)
def update_denuncia(id_denuncia: int, update: UpdateDenuncia, db: Session = Depends(get_db)) -> ResponseDenuncia:
    denuncia = db.query(Denuncia).filter(Denuncia.id == id_denuncia).first()
    if not denuncia:
        raise HTTPException(status_code=404, detail="Denuncia não encontrada")
    
    update_db = update.dict(exclude_unset=True)

    for key, value in update_db.items():
        setattr(denuncia, key, value)
    
    db.commit()
    db.refresh(denuncia)
    return denuncia

# GET - LÊ
@router_denuncia.get("{id_rede_apoio}", response_model=ResponseDenuncia, status_code=200)
def get_denuncia(id_denuncia: int, db: Session = Depends(get_db)) -> ResponseDenuncia:
    denuncia = db.query(Denuncia).filter(Denuncia.id == id_denuncia).first()
    if not denuncia:
        raise HTTPException(status_code=404, detail="Denuncia não encontrada")
    return denuncia


# DELETE - DELETA
@router_denuncia.delete("{id_rede_apoio}", response_model=ResponseDenuncia, status_code=200)
def delete_denuncia(id_denuncia: int, db: Session = Depends(get_db)) -> ResponseDenuncia:
    denuncia = db.query(Denuncia).filter(Denuncia.id == id_denuncia).first()
    if not denuncia:
        raise HTTPException(status_code=404, detail="Denuncia não encontrada")
    
    db.delete(denuncia)
    db.commit()
    return {"detail": f"Denuncia com o id: {id_denuncia} foi deletada com sucesso!"}
