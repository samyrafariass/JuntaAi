# importações
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from schemas.rede_apoio_schema import CreateRede, UpdateRede, ResponseRede
from model.db_model import Rede_Apoio

router_rede = APIRouter(prefix="/redes_apoio", tags=["Redes_Apoio"])

# Consultar todas as redes de apoio
@router_rede.get("/", response_model=list[ResponseRede], status_code=200)
def consultar_redes_apoio(db: Session = Depends(get_db)):
    return db.query(Rede_Apoio).all()

# Consultar rede de apoio por id
@router_rede.get("{Id_Rede_Apoio}", response_model=ResponseRede, status_code=200)
def consultar_rede_apoio_por_id(Id_Rede_Apoio: int, db: Session = Depends(get_db)):
    rede_apoio = db.query(Rede_Apoio).filter(Rede_Apoio.Id_Rede_Apoio == Id_Rede_Apoio).first()
    if not rede_apoio:
        raise HTTPException(status_code=404, detail="Rede de Apoio não encontrada")
    return rede_apoio

# Criar uma rede de apoio
@router_rede.post("/", response_model=ResponseRede, status_code=201)
def criar_rede_apoio(criar_rede_apoio: CreateRede, db: Session = Depends(get_db)):
    try:
        if db.query(Rede_Apoio).filter(Rede_Apoio.Nome == criar_rede_apoio.Nome).first():
            raise HTTPException(status_code=401, detail="Este nome já pertence a uma rede de apoio já cadastrada!")
        
        nova_rede_apoio = Rede_Apoio(**criar_rede_apoio.model_dump())
        db.add(nova_rede_apoio)
        db.commit()
        db.refresh(nova_rede_apoio)
        return nova_rede_apoio
    except Exception as e:
        db.rollback()
        print(f'Erro: {e}')

# Atualizar dados de uma rede de apoio pelo id
@router_rede.put("{Id_Rede_Apoio}", response_model=ResponseRede, status_code=201)
def atualiza_dados_rede_apoio(Id_Rede_Apoio: int, atualizar_rede: UpdateRede, db: Session = Depends(get_db)):
    try:
        rede_apoio = db.query(Rede_Apoio).filter(Rede_Apoio.Id_Rede_Apoio == Id_Rede_Apoio).first()
        if not rede_apoio:
                raise HTTPException(status_code=404, detail="Rede de apoio não encontrada!")

        db_rede_apoio = atualizar_rede.model_dump(exclude_unset=True)

        for key, value in db_rede_apoio.items():
            setattr(rede_apoio, key, value)
        
        db.commit()
        db.refresh(rede_apoio)
        return db_rede_apoio
    except Exception as e:
        db.rollback()
        print(f'Erro: {e}')


# Excluir uma rede de apoio pelo id
@router_rede.delete("{Id_Rede_Apoio}", response_model=ResponseRede, status_code=201)
def delete_rede_apoio(Id_Rede_Apoio: int, db: Session = Depends(get_db)):
    try:
        rede_apoio = db.query(Rede_Apoio).filter(Rede_Apoio.Id_Rede_Apoio == Id_Rede_Apoio).first() 
        if not rede_apoio:
            raise HTTPException(status_code=404, detail="Rede de Apoio não encontrada!")
        
        db.delete(rede_apoio)
        db.commit()
        return {"detail": f"Rede de Apoio deletada com sucesso!"}
    except Exception as e:
        db.rollback()
        print(f'Erro: {e}')
