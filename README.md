# 🤝 Junta Aí

Projeto Unificado: Experiencia Extensionista / Laboratório de Banco de Dados / Desenvolvimento Seguro

- INÍCIO DA IDEAÇÃO DO PROJETO: 02/01/2025
O projeto se encontra na conclusão de sua fase de Desenvolvimento do MVP (Mínimo Produto Viável)!

- O que é o Junta Aí!?

# Aplicação que tem como objetivo ORIENTAR, ENSINAR e INCENTIVAR a mulher a romper o ciclo da violência em que se encontra, visando reduzir o crescimento alarmante de violência contra a mulher.

# Funciona como uma REDE DE APOIO para mulheres em situação de violência.

---

## 🚀 Funcionalidades

* ✅ Cadastro e login de usuária
* ✅ Acionamento de Alertas em casos de emergências
* ✅ Realização de Denúncias contra agressores
* ✅ Questionário estruturado com recomendação eficiente de redes de apoio e canais de denúncia para o tipo de violência que está sofrendo
* ✅ Conteúdos Informativos (Tipos de Violência, Ciclo da Violência...)
* ✅ Canais de Denúncia simplificados

---

## 🛠️ Tecnologias Utilizadas

Mobile
* [Flutter](https://flutter.dev/)
BackEnd
* [Python](https://www.python.org/)
* [FastAPI](https://fastapi.tiangolo.com/)
* [SQL Server](https://www.microsoft.com/sql-server)
* [SQLAlchemy](https://www.sqlalchemy.org/) (ORM para banco de dados)
* [JWT](https://jwt.io/)
* [OAuth](https://oauth.net/2/)

---

## 📂 Estrutura do Projeto

```bash
app/
 ├── db/    # Conexão com o Banco de Dados (BD)
 │    ├── database_conection.py
 ├── model  # Tabelas do Banco de Dados - Gerada via SQLACODEGEN
 │    ├── db_model.py
 ├── routes
 │    ├── router_alerta.py
 │    ├── router_auth.py
 │    ├── router_classificacao.py
 │    ├── router_conteudo_informativo.py
 │    ├── router_denuncia.py
 |    ├── router_orgao.py
 |    ├── router_rede_apoio.py
 |    ├── router_tipo_violencia.py
 |    ├──router_usuaria.py
 ├── services/   # Regras de negócio
 │    ├── auth_schema.py
 │    ├── classificacao_schema.py
 │    ├── conteudo_informativo_schema.py
 │    ├── denuncia_schema.py
 │    ├── orgao_schema.py
 |    ├── rede_apoio_schema.py
 |    ├── schema_alerta.py
 |    ├── shared.py # EnderecoBase - Atributos em comum das tabelas
 |    ├── tipo_violencia_schema.py
 |    ├── usuaria_schema.py
 ├── utils/   # Arquivos de configuração e segurança
 │    ├── config.py
 │    ├── security.py
 │    ├── token_por_email.py
 └── main.py    # aplicação principal
| .env # dados sensíveis da aplicação
| requeriments.txt # imports utilizados

```

---

## ⚙️ Instalação e Execução

1. Clone este repositório:

```bash
git clone https://github.com/JuntaAi
```

## 🤝 Claboradores

- Curso/Período: 6°Período de CCO (Ciência da Computação)

* **Pedro Lucas**
* **Samyra Farias**
* **Valmir Klenio**
* **Vitória Tirza**
