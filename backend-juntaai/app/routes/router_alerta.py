# importações
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Alerta, Orgao
from schemas.schema_alerta import CreateAlert, UpdateAlert, SendAlertForOrgao, CancelSendAlert, ResponseAlert

router_alerta = APIRouter(prefix="/alertas", tags=["Alertas"])

@router_alerta.get("/", response_model=ResponseAlert, status_code=201)
def ler_alertas(db: Session = Depends(get_db)):
    return db.query(Alerta).all()


@router_alerta.get("/{Id_Alerta}", response_model=ResponseAlert, status_code=201)
def ler_alerta_por_id(Id_Alerta: int, db: Session = Depends(get_db)):
    db_alerta = db.query(Alerta).filter(Alerta.Id_Alerta == Id_Alerta).first()
    if not db_alerta:
        raise HTTPException(status_code=404, detail="Alerta não encontrado!")
    
    return db_alerta


@router_alerta.post("/", response_model=ResponseAlert, status_code=201)
def criar_alerta(create: CreateAlert, db: Session = Depends(get_db)):
    try:
        db_alerta = db.query(Alerta).filter(Alerta.Status_Alerta == create.Status_Alerta).first()
        if db_alerta:
            raise HTTPException(status_code=404, detail="Alerta já existe!")
        
        db_alerta = Alerta(**create.model_dump())
        db.add(db_alerta)
        db.commit()
        db.refresh(db_alerta)
        return db_alerta
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


@router_alerta.post("/enviar-alerta", response_model=ResponseAlert, status_code=201)
def enviar_alerta(enviar_alerta_orgao: SendAlertForOrgao, db: Session = Depends(get_db)):
    try:
        db_alerta = db.query(Alerta).filter(Alerta.Id_Alerta == enviar_alerta_orgao.Id_Alerta).first()
        if not db_alerta:
            raise HTTPException(status_code=404, detail="Não foi possível enviar o alerta!")
        
        orgao = db.query(Orgao).filter(Orgao.Id_Orgao == enviar_alerta_orgao.Id_Orgao).first()
        if not orgao:
            raise HTTPException(status_code=404, detail="Órgão não encontrado")

        db_alerta.Id_Orgao = enviar_alerta_orgao.Id_Orgao
        db.add(db_alerta)
        db.commit()
        db.refresh(db_alerta)
        return db_alerta
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


@router_alerta.put("/{Id_Alerta}", response_model=ResponseAlert, status_code=201)
def atualizar_alerta_por_id(Id_Alerta: int, update: UpdateAlert, db: Session = Depends(get_db)):
    try:
        alerta = db.query(Alerta).filter(Alerta.Id_Alerta == update.Id_Alerta).first()
        if not alerta:
            raise HTTPException(status_code=404, detail="Alerta não encontrado!")
        
        db_alerta = update.model_dump(exclude_unset=True)

        for key, value in db_alerta.items():
                setattr(alerta, key, value)
            
        db.commit()
        db.refresh(alerta)
        return alerta
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


@router_alerta.delete("/{Id_Alerta}", response_model=ResponseAlert, status_code=201)
def cancelar_envio_alerta(Id_Alerta: int, db: Session = Depends(get_db)): 
    try:
        db_denuncia = db.query(Alerta).filter(Alerta.Id_Alerta == Id_Alerta).first()
        if not db_denuncia:
            raise HTTPException(status_code=404, detail="Alerta não encontrado!")
        
        db.delete(db_denuncia)
        db.commit()
        return {"detail": f"Alerta deletado com sucesso!"}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

