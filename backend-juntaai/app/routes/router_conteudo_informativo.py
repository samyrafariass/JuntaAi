from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from datetime import datetime
from app.db.database_conection import get_db
from model.db_model import Conteudo_Informativo, Acessa_Usuaria_Conteudo
from schemas.conteudo_informativo_schema import AdicionarConteudo, AtualizarConteudo, ResponseConteudo

router_conteudo_informativo = APIRouter(prefix="/conteudo-informativo", tags=["Conteudo-Informativo"])

# Listar todos os conteúdos
@router_conteudo_informativo.get("/", response_model=list[ResponseConteudo], status_code=200)
def listar_conteudos(db: Session = Depends(get_db)):
    return db.query(Conteudo_Informativo).all()

# Listar os acesos por conteúdo via ID
@router_conteudo_informativo.get("/{Id_Conteudo}", status_code=200)
def acessos_por_conteudo(Id_Conteudo: int, db: Session = Depends(get_db)):
    try:
        conteudo = db.query(Conteudo_Informativo).filter(Conteudo_Informativo.Id_Conteudo == Id_Conteudo).first()
        if not conteudo:
            raise HTTPException(status_code=404, detail="Conteúdo não encontrado")

        acessos = db.query(Acessa_Usuaria_Conteudo).filter(Acessa_Usuaria_Conteudo.Id_Conteudo == Id_Conteudo).all()

        lista_acessos = [{"Id_Usuaria": acesso.Id_Usuaria, "Data_Acesso": acesso.Data_Acesso or datetime.datetime.utcnow()}
            for acesso in acessos
        ]
        return {"Id_Conteudo": Id_Conteudo, "Conteudo": conteudo.Conteudo, "Descricao": conteudo.Descricao, "Acessos": lista_acessos}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erro ao consultar acessos: {str(e)}")

# Adiciona conteúdo
@router_conteudo_informativo.post("/", response_model=ResponseConteudo, status_code=201)
def adicionar_conteudo(adiciona: AdicionarConteudo, db: Session = Depends(get_db)):
    try:
        db_conteudo = db.query(Conteudo_Informativo).filter(Conteudo_Informativo.Id_Conteudo == adiciona.Id_Conteudo).first()
        if not db_conteudo:
            raise HTTPException(status_code=404, detail="Conteúdo não encontrado")

        novo_conteudo = Conteudo_Informativo(Conteudo=adiciona.Conteudo, Descricao=adiciona.Descricao)

        db.add(novo_conteudo)
        db.commit()
        db.refresh(novo_conteudo)
        return novo_conteudo
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Erro ao adicionar conteúdo: {str(e)}")

# Atualiza o conteúdo
@router_conteudo_informativo.put("/", response_model=ResponseConteudo, status_code=200)
def atualizar_conteudo(atualiza: AtualizarConteudo, db: Session = Depends(get_db)):
    try:
        conteudo = db.query(Conteudo_Informativo).filter(Conteudo_Informativo.Id_Conteudo == atualiza.Id_Conteudo).first()
        if not conteudo:
            raise HTTPException(status_code=404, detail="Conteúdo não encontrado")

        if atualiza.Conteudo is not None:
            conteudo.Conteudo = atualiza.Conteudo
        if atualiza.Descricao is not None:
            conteudo.Descricao = atualiza.Descricao

        db.commit()
        db.refresh(conteudo)
        return conteudo
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Erro ao atualizar conteúdo: {str(e)}")

# Exclui o conteúdo
@router_conteudo_informativo.delete("/{Id_Conteudo}", response_model=ResponseConteudo, status_code=200)
def excluir_conteudo(Id_Conteudo: int, db: Session = Depends(get_db)):
    try:
        conteudo = db.query(Conteudo_Informativo).filter(Conteudo_Informativo.Id_Conteudo == Id_Conteudo).first()
        if not conteudo:
            raise HTTPException(status_code=404, detail="Conteúdo não encontrado")

        db.delete(conteudo)
        db.commit()
        return conteudo
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=f"Erro ao excluir conteúdo: {str(e)}")

