# 🤝 JuntaAÍ - Back-end
Back desenvolvido em Python, FastAPI e SQL Server responsável pelas rotas, conexão com o banco de dados, autenticação e segurança dos dados disponibilizados no projeto JuntaAÍ.

## 🛠️ Tecnologias Utilizadas

* [Python](https://www.python.org/)
* [FastAPI](https://fastapi.tiangolo.com/)
* [SQL Server](https://www.microsoft.com/sql-server)
* [SQLAlchemy](https://www.sqlalchemy.org/)
* [Pydantic](https://docs.pydantic.dev/latest/)
* [Uvicorn](https://uvicorn.dev/)
* [JWT](https://jwt.io/)
* [OAuth](https://oauth.net/2/)

---

## 📂 Estrutura Principal

```bash
app/
 ├── db/    # Conexão com o Banco de Dados (BD)
 ├── model/  # Tabelas do Banco de Dados - Gerada via SQLACODEGEN
 ├── routes/ # Rotas da API
 ├── services/   # Regras de negócio
 ├── utils/   # Arquivos de configuração e segurança
 └── main.py    # Aplicação principal
 │ .env # Dados sensíveis da aplicação
 │ requeriments.txt # Imports utilizados
 │ README.md # Apresentação do Back

```
---

> Projeto acadêmico desenvolvido como parte do curso de **Ciência da Computação (UNIT - PE)**.
