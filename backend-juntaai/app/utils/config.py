# Configurações globais da aplicação (variáveis de ambiente, chaves secretas, configurações do banco...)
#imports
import pyodbc
import os
from dotenv import load_dotenv
from urllib.parse import quote_plus

# leitura dos arquivos .env
load_dotenv()

class Settings:
    DB_SERVER: str = os.getenv("DB_SERVER")
    DB_PASSWORD: str = os.getenv("DB_PASSWORD")
    DB_USERNAME: str = os.getenv("DB_USER")
    DB_DATABASE: str = os.getenv("DB_NAME")
    DB_TRUSTED_CONNECTION: str = os.getenv("DB_TRUSTED_CONNECTION")

    if DB_TRUSTED_CONNECTION.lower() == 'yes':
        print(f'Conexão via Autenticação Windows')
        DATABASE_URL_AUTHENTICATION_WINDOWS = f"mssql+pyodbc://{DB_SERVER}/{DB_DATABASE}?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
        try:
            conn = pyodbc.connect(DATABASE_URL_AUTHENTICATION_WINDOWS)
            print("✅ Autenticação Windows bem-sucedida!")
        except Exception as e:
            print("❌ Erro:", e)

    else:
        print(f'Conexão via SQL Server')
        DATABASE_URL_AUTHENTICATION_SQL = f"mssql+pyodbc://{DB_USERNAME}:{quote_plus(DB_PASSWORD)}@{DB_SERVER}/{DB_USERNAME}?driver=ODBC+Driver+17+for+SQL+Server"
        try:
            conn = pyodbc.connect(DATABASE_URL_AUTHENTICATION_SQL)
            print("✅ Autenticação SQL bem-sucedida!")
        except Exception as e:
            print("❌ Erro:", e)

settings = Settings()
