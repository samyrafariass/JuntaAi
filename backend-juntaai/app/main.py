# Imports
from fastapi import FastAPI # cria o app=FastApi() e modulariza rotas
from app.routes import router_usuaria, router_rede_apoio, router_denuncia, router_alerta, router_orgao, router_classificacao, router_tipo_violencia, router_conteudo_informativo, router_auth # rotas da api

# Criando a FastAPI
app = FastAPI() 

# Teste da API
@app.get('/')
def root():
    return {"mensagem": "FastAPI do Junta Aí!"}

# Inclusão de rotas
app.include_router(router_usuaria)
app.include_router(router_rede_apoio)
app.include_router(router_denuncia)
app.include_router(router_alerta)
app.include_router(router_orgao)
app.include_router(router_classificacao)
app.include_router(router_tipo_violencia)
app.include_router(router_conteudo_informativo)
app.include_router(router_auth)