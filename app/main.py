# Imports
from fastapi import FastAPI
from app.routes import router_usuaria

# Criando a FastAPI
app = FastAPI() 

# Teste da API
@app.get('/')
def root():
    return {"mensagem": "FastAPI do Junta Aí!"}

# Funções de inicialização e encerramento do banco


# Inclusão de rotas
app.include_router(router_usuaria)
