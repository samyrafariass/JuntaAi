# Imports
from fastapi import FastAPI
from app.routes import router_usuaria, alerta, orgao, classificacao, conteudo_informativo, tipo_violencia, router_auth

# Criando a FastAPI
app = FastAPI() 

# Teste da API
@app.get('/')
def root():
    return {"mensagem": "FastAPI do Junta Aí!"}

# Funções de inicialização e encerramento do banco


# Inclusão de rotas
app.include_router(router_usuaria)
#app.include_router(router_rede_apoio)
#app.include_router(router_denuncia)
#app.include_router(alerta.router)
#app.include_router(orgao.router)
#app.include_router(classificacao.router)
#app.include_router(conteudo_informativo.router)
#app.include_router(tipo_violencia.router)
#app.include_router(router_auth)