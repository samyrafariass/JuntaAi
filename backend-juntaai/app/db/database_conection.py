# Conexão com o banco de dados
# imports
from sqlalchemy import create_engine # Cria conexão com SQL Server
from sqlalchemy.orm import sessionmaker, declarative_base
from app.utils.config import settings

# Cria engine de conexão
engine = create_engine(settings.DATABASE_URL_AUTHENTICATION_WINDOWS,
                       pool_size=20,       # número de conexões abertas no pool
                       max_overflow=5,     # conexões extras temporárias
                       pool_timeout=20,    # tempo em segundos para esperar conexão livre
                       pool_recycle=1500,   # tempo em segundos para reciclar conexão
                       echo=False) # para ver todas as queries que estão sendo executadas

# Cria sessões para comunicação com o banco, podendo pode fazer consultas, adicionar, modificar e deletar dados dentro da sessão, e depois dar commit para salvar as mudanças
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base para os modelos ORM
Base = declarative_base()

# Abre e fecha conexão com o banco de dados
def get_db():
    db = SessionLocal()
    try:
        yield db       # fornece a sessão
    finally:
        db.close()     # fecha a sessão