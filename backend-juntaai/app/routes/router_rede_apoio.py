# importações
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from db_schemas import CreateRede, UpdateRede, ResponseRede
from app.models.db_model import RedeApoio

router_rede = APIRouter(prefix="/redes_apoio", tags=["Redes_Apoio"])

# POST - CRIA
@router_rede.post("/", response_model=ResponseRede, status_code=201)
def create_rede_apoio(create: CreateRede, db: Session = Depends(get_db)) -> ResponseRede:
    db_rede_apoio = db.query(RedeApoio).filter(RedeApoio.nome == create.nome).first()
    if db_rede_apoio:
        raise HTTPException(status_code=400, detail="Rede de Apoio já registrada!")

    new_rede = RedeApoio(**create.dict())
    db.add(new_rede)
    db.commit()
    db.refresh(new_rede)
    return new_rede

# PUT - ATUALIZA
@router_rede.put("{id_rede_apoio}", response_model=ResponseRede, status_code=200)
def update_rede_apoio(id_rede_apoio: int, update = UpdateRede, db: Session = Depends(get_db)) -> ResponseRede:
    rede_apoio = db.query(RedeApoio).filter(RedeApoio.id == id_rede_apoio).first()
    if not rede_apoio:
        raise HTTPException(status_code=404, detail="Rede de Apoio não encontrada")
    
    update_db = update.dict(exclude_unset=True)

    for key, value in update_db.items():
        setattr(rede_apoio, key, value)
    
    db.commit()
    db.refresh(rede_apoio)
    return rede_apoio

# GET - LÊ
@router_rede.get("{id_rede_apoio}", response_model=ResponseRede, status_code=200)
def get_rede_apoio(id_rede_apoio: int, db: Session = Depends(get_db)) -> ResponseRede:
    rede_apoio = db.query(RedeApoio).filter(RedeApoio.id == id_rede_apoio).first()
    if not rede_apoio:
        raise HTTPException(status_code=404, detail="Rede de Apoio não encontrada")
    return rede_apoio

# DELETE - DELETA
@router_rede.delete("{id_rede_apoio}", response_model=ResponseRede, status_code=200)
def delete_rede_apoio(id_rede_apoio: int, db: Session = Depends(get_db)) -> ResponseRede:
    rede_apoio = db.query(RedeApoio).filter(RedeApoio.id == id_rede_apoio).first()
    if not rede_apoio:
        raise HTTPException(status_code=404, detail="Rede de Apoio não encontrada")
    
    db.delete(rede_apoio)
    db.commit()
    return {"detail": f"Rede de Apoio com o id: {id_rede_apoio} deletada com sucesso!"}
