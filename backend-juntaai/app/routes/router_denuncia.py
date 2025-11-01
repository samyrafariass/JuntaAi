# importações
from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Denuncia, Gera_Denuncia_Usuaria, Usuaria, Orgao
from schemas.denuncia_schema import CreateDenuncia, UpdateDenuncia,  VinculaDenunciaUsuaria, SendDenunciaForOrgao, CancelDenuncia, CancelVinculacaoDenunciaUsuaria, ResponseDenuncia

router_denuncia = APIRouter(prefix="/denuncias", tags=["Denuncias"])

# Ler todas as denúncias da tabela associativa
@router_denuncia.get("/denuncias-associativas", response_model=ResponseDenuncia, status_code=201)
def ler_associacao_denuncia_usuaria(db: Session = Depends(get_db)):
    return db.query(Gera_Denuncia_Usuaria).all()

# Ler a denúncia pelo id 
@router_denuncia.get("/{Id_Denuncia}", response_model=ResponseDenuncia, status_code=201)
def ler_denuncia_por_id (Id_Denuncia: int, db: Session = Depends(get_db)):
    denuncia = db.query(Denuncia).filter(Denuncia.Id_Denuncia == Id_Denuncia).first()
    if not denuncia:
        raise HTTPException(status_code=404, detail="Rede de Apoio não encontrada")
    return denuncia

# Consultar todas as denuncias
@router_denuncia.get("/", response_model=ResponseDenuncia, status_code=201)
def consultar_denuncias(db: Session = Depends(get_db)):
    return db.query(Denuncia).all()

# Criar denúncia para usuaria
@router_denuncia.post("/", response_model=ResponseDenuncia, status_code=201)
def criar_denuncia(create: CreateDenuncia, db: Session = Depends(get_db)):
    try:
        denuncia = db.query(Denuncia).filter(Denuncia.Violencia_Sofrida == create.Violencia_Sofrida).first()
        if denuncia:
            raise HTTPException(status_code=401, detail="Denuncia já cadastrada!")

        nova_denuncia = Denuncia(**create.model_dump())
        db.add(nova_denuncia)
        db.commit()
        db.refresh(nova_denuncia)
        return nova_denuncia
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

# Adicionar a denuncia na tabela associacita
@router_denuncia.post("/vincula-denuncia-usuaria", response_model=ResponseDenuncia, status_code=201)
def vincula_denuncia_usuaria(vincular_denuncia: VinculaDenunciaUsuaria, db:Session = Depends(get_db)):
    try:
        denuncia = db.query(Denuncia).filter(Denuncia.Id_Denuncia == vincular_denuncia.Id_Denuncia).first()
        usuaria = db.query(Usuaria).filter(Usuaria.Id_Usuaria == vincular_denuncia.Id_Usuaria).first()
        if not denuncia or not usuaria:
            raise HTTPException(status_code=404, detail="Denuncia ou usuária não encontrada!")
        
        gera_nova_denuncia = Gera_Denuncia_Usuaria(**vincular_denuncia.model_dump())
        db.add(gera_nova_denuncia)
        db.commit()
        db.refresh(gera_nova_denuncia)
        return gera_nova_denuncia
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

# Enviar denúncia pro orgao
@router_denuncia.post("/envia-denuncia-pro-orgao", response_model=ResponseDenuncia, status=201)
def envia_denuncia_pro_orgao(envia_denuncia: SendDenunciaForOrgao, db: Session = Depends(get_db)):
    try:
        denuncia = db.query(Denuncia).filter(Denuncia.Id_Denuncia == envia_denuncia.Id_Denuncia).first()
        if not denuncia:
            raise HTTPException(status_code=404, detail="Denúncia não encontrada")

        orgao = db.query(Orgao).filter(Orgao.Id_Orgao == envia_denuncia.Id_Orgao).first()
        if not orgao:
            raise HTTPException(status_code=404, detail="Órgão não encontrado")

        denuncia.Id_Orgao = envia_denuncia.Id_Orgao
        db.commit()
        db.refresh(denuncia)
        return denuncia
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# Atualizar dados da denúncia por id
@router_denuncia.put("/{Id_Denuncia}", response_model=ResponseDenuncia, status_code=201)
def atualiza_denuncia(Id_Denuncia: int, update: UpdateDenuncia, db: Session = Depends(get_db)):
    try:
        denuncia = db.query(Denuncia).filter(Denuncia.Id_Denuncia == update.Id_Denuncia).first()
        if not denuncia:
            raise HTTPException(status_code=404, detail="Denuncia não encontrada!")
        
        db_denuncia = update.model_dump(exclude_unset=True)

        for key, value in db_denuncia.items():
            setattr(denuncia, key, value)
        
        db.commit()
        db.refresh(db_denuncia)
        return db_denuncia
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# Cancelar/Deletar uma denúncia pelo id e na tabela associativa
@router_denuncia.delete("/{Id_Denuncia}", response_model=ResponseDenuncia, status_code=200)
def delete_denuncia_por_id(Id_Denuncia: int, db: Session = Depends(get_db)):
    try:
        denuncia = db.query(Denuncia).filter(Denuncia.Id_Denuncia == Id_Denuncia).first()
        if not denuncia:
            raise HTTPException(status_code=404, detail="Denuncia não encontrada")
        
        denuncia.Status_Denuncia = False
        db.delete(denuncia)
        db.commit()
        return {"detail": f"Denuncia deletada com sucesso!"}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# Deletar uma denúncia na tabela associativa
@router_denuncia.delete("/delete-denuncia-tabela-associativa", response_model=ResponseDenuncia, status_code=200)
def delete_vinculacao_denuncia_usuaria(delete_associacao: CancelVinculacaoDenunciaUsuaria, db: Session = Depends(get_db)):
    try:
        denuncia_vinculada = db.query(Gera_Denuncia_Usuaria).filter(Gera_Denuncia_Usuaria.Id_Denuncia == delete_associacao.Id_Denuncia, Gera_Denuncia_Usuaria.Id_Usuaria == delete_associacao.Id_Usuaria).first()
        if not denuncia_vinculada:
            raise HTTPException(status_code=404, detail="Vinculação não encontrada")

        db.delete(denuncia_vinculada)
        db.commit()
        return {"detail": f"Denuncia deletada e desvilculada com sucesso!"}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))
