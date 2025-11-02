from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.db.database_conection import get_db
from model.db_model import Classificacao, Orgao
from schemas.classificacao_schema import ClassificaOrgao, AtualizaClassificacaoOrgao, ResponseClassificacao
from schemas.orgao_schema import ResponseOrgao

router_classificacao = APIRouter(prefix="/classificacoes", tags=["Classificacoes"])

# Listar todas as classificações
@router_classificacao.get("/", response_model=list[ResponseClassificacao], status_code=200)
def lista_classificacao_orgaos(db: Session = Depends(get_db)):
    return db.query(Classificacao).all()

# Listar as classificações por id
@router_classificacao.get("/{Id_Classificacao}/orgaos", response_model=list[ResponseOrgao], status_code=200)
def listar_orgaos_por_classificacao(Id_Classificacao: int, db: Session = Depends(get_db)):
    db_orgao = db.query(Orgao).filter(Orgao.Id_Classificacao == Id_Classificacao).all()
    if not db_orgao:
        raise HTTPException(status_code=404, detail="Nenhum órgão encontrado para esta classificação!")
    return db_orgao

# Atribuir classificação ao orgao
@router_classificacao.post("/atribuir", response_model=ResponseOrgao, status_code=201)
def criar_e_atribuir_classificacao(Id_Orgao: int, nova_classificacao: ClassificaOrgao,  db: Session = Depends(get_db)):

    db_orgao = db.query(Orgao).filter(Orgao.Id_Orgao == Id_Orgao).first()
    if not db_orgao:
        raise HTTPException(status_code=404, detail="Órgão não encontrado!")
        
    # Verifica se o órgão já possui classificação
    if db_orgao.Id_Classificacao:
        raise HTTPException(status_code=400, detail=f"Órgão já possui classificação (Id: {db_orgao.Id_Classificacao}).")

    try:
        with db.begin():
            classificacao = Classificacao(**nova_classificacao.model_dump())
            db.add(classificacao)
            db.flush()  # Garante que o Id_Classificacao será gerado

            # Atribui a classificação ao órgão
            db_orgao.Id_Classificacao = classificacao.Id_Classificacao
            db.add(db_orgao)

        db.refresh(db_orgao)
        return db_orgao

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Erro ao criar e atribuir classificação: {str(e)}")


# Atualizar a classificacao
@router_classificacao.put("/{Id_Classificacao}", response_model=ResponseClassificacao, status_code=200)
def atualizar_classificacao(Id_Classificacao: int, update: AtualizaClassificacaoOrgao, db: Session = Depends(get_db)):
    try:
        db_classificacao = db.query(Classificacao).filter(Classificacao.Id_Classificacao == Id_Classificacao).first()
        if not db_classificacao:
            raise HTTPException(status_code=404, detail="Classificação não encontrada!")

        for key, value in update.model_dump(exclude_unset=True).items():
            setattr(db_classificacao, key, value)

        db.commit()
        db.refresh(db_classificacao)
        return db_classificacao
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

# Excluir a classificacao
@router_classificacao.delete("/{Id_Classificacao}", response_model=ResponseClassificacao, status_code=200)
def excluir_classificacao(Id_Classificacao: int, db: Session = Depends(get_db)):
    try:
        db_classificacao = db.query(Classificacao).filter(Classificacao.Id_Classificacao == Id_Classificacao).first()
        if not db_classificacao:
            raise HTTPException(status_code=404, detail="Classificação não encontrada!")

        db.delete(db_classificacao)
        db.commit()
        return db_classificacao
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

