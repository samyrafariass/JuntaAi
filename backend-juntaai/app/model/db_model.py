# imports
import datetime
from typing import Optional
from sqlalchemy import Boolean, Column, Date, DateTime, ForeignKeyConstraint, Identity, Index, Integer, PrimaryKeyConstraint, String, Table, text
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from app.db.database_conection import Base

class Base(DeclarativeBase):
    pass

class Classificacao(Base):
    __tablename__ = 'Classificacao'
    __table_args__ = (
        PrimaryKeyConstraint('Id_Classificacao', name='PK__Classifi__0AB3C903C30B84E1'),
    )

    Id_Classificacao: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Descricao: Mapped[str] = mapped_column(String(100, 'Latin1_General_CI_AS'), nullable=False)
    Telefone: Mapped[str] = mapped_column(String(15, 'Latin1_General_CI_AS'), nullable=False)
    CEP: Mapped[str] = mapped_column(String(10, 'Latin1_General_CI_AS'), nullable=False)
    Rua_Avenida: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Num_Imovel: Mapped[int] = mapped_column(Integer, nullable=False)
    Bairro: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Cidade: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Estado: Mapped[str] = mapped_column(String(2, 'Latin1_General_CI_AS'), nullable=False)

    Orgao: Mapped[list['Orgao']] = relationship('Orgao', back_populates='Classificacao')


class Conteudo_Informativo(Base):
    __tablename__ = 'Conteudo_Informativo'
    __table_args__ = (
        PrimaryKeyConstraint('Id_Conteudo', name='PK__Conteudo__95B4D6EBA6ACF216'),
    )

    Id_Conteudo: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Conteudo: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Descricao: Mapped[str] = mapped_column(String(100, 'Latin1_General_CI_AS'), nullable=False)

    Acessa_Usuaria_Conteudo: Mapped[list['Acessa_Usuaria_Conteudo']] = relationship('Acessa_Usuaria_Conteudo', back_populates='Conteudo_Informativo')


class Rede_Apoio(Base):
    __tablename__ = 'Rede_Apoio'
    __table_args__ = (
        PrimaryKeyConstraint('Id_Rede_Apoio', name='PK__Rede_Apo__C6FE48D0D43C34BD'),
    )

    Id_Rede_Apoio: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Nome: Mapped[str] = mapped_column(String(50, 'Latin1_General_CI_AS'), nullable=False)
    Responsavel: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Descricao: Mapped[str] = mapped_column(String(100, 'Latin1_General_CI_AS'), nullable=False)
    Telefone: Mapped[str] = mapped_column(String(15, 'Latin1_General_CI_AS'), nullable=False)
    CEP: Mapped[str] = mapped_column(String(10, 'Latin1_General_CI_AS'), nullable=False)
    Rua_Avenida: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Num_Imovel: Mapped[int] = mapped_column(Integer, nullable=False)
    Bairro: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Cidade: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Estado: Mapped[str] = mapped_column(String(2, 'Latin1_General_CI_AS'), nullable=False)
    Horario: Mapped[str] = mapped_column(String(15, 'Latin1_General_CI_AS'), nullable=False)

    Usuaria: Mapped[list['Usuaria']] = relationship('Usuaria', secondary='Utiliza_Rede_Apoio_Usuaria', back_populates='Rede_Apoio')


class Tipo_Violencia(Base):
    __tablename__ = 'Tipo_Violencia'
    __table_args__ = (
        PrimaryKeyConstraint('Id_Tipo_Violencia', name='PK__Tipo_Vio__90EDEE9577280935'),
    )

    Id_Tipo_Violencia: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Sessao: Mapped[int] = mapped_column(Integer, nullable=False)
    Pergunta: Mapped[str] = mapped_column(String(50, 'Latin1_General_CI_AS'), nullable=False)
    Resposta: Mapped[str] = mapped_column(String(50, 'Latin1_General_CI_AS'), nullable=False)
    Status: Mapped[Optional[bool]] = mapped_column(Boolean)

    Usuaria: Mapped[list['Usuaria']] = relationship('Usuaria', secondary='Sofre_Tipo_Violencia_Usuaria', back_populates='Tipo_Violencia')


class Usuaria(Base):
    __tablename__ = 'Usuaria'
    __table_args__ = (
        PrimaryKeyConstraint('Id_Usuaria', name='PK__Usuaria__63C76BF0B1375B77'),
        Index('UQ__Usuaria__A9D10534EFE1C4AA', 'Email', unique=True)
    )

    Id_Usuaria: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Nome: Mapped[str] = mapped_column(String(50, 'Latin1_General_CI_AS'), nullable=False)
    Data_Nascimento: Mapped[datetime.date] = mapped_column(Date, nullable=False)
    CEP: Mapped[str] = mapped_column(String(10, 'Latin1_General_CI_AS'), nullable=False)
    Rua_Avenida: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Num_Imovel: Mapped[int] = mapped_column(Integer, nullable=False)
    Bairro: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Cidade: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Estado: Mapped[str] = mapped_column(String(2, 'Latin1_General_CI_AS'), nullable=False)
    Email: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Senha: Mapped[str] = mapped_column(String(256, 'Latin1_General_CI_AS'), unique=True, nullable=False)
    Telefone: Mapped[Optional[str]] = mapped_column(String(15, 'Latin1_General_CI_AS'))

    Rede_Apoio: Mapped[list['Rede_Apoio']] = relationship('RedeApoio', secondary='Utiliza_Rede_Apoio_Usuaria', back_populates='Usuaria')
    Tipo_Violencia: Mapped[list['Tipo_Violencia']] = relationship('TipoViolencia', secondary='Sofre_Tipo_Violencia_Usuaria', back_populates='Usuaria')
    Acessa_Usuaria_Conteudo: Mapped[list['Acessa_Usuaria_Conteudo']] = relationship('Acessa_Usuaria_Conteudo', back_populates='Usuaria_')
    Alerta: Mapped[list['Alerta']] = relationship('Alerta', back_populates='Usuaria_')
    Denuncia: Mapped[list['Denuncia']] = relationship('Denuncia', secondary='Gera_Denuncia_Usuaria', back_populates='Usuaria_')


class Acessa_Usuaria_Conteudo(Base):
    __tablename__ = 'Acessa_Usuaria_Conteudo'
    __table_args__ = (
        ForeignKeyConstraint(['Id_Conteudo'], ['Conteudo_Informativo.Id_Conteudo'], name='FK__Acessa_Us__Id_Co__6A30C649'),
        ForeignKeyConstraint(['Id_Usuaria'], ['Usuaria.Id_Usuaria'], name='FK__Acessa_Us__Id_Us__693CA210'),
        PrimaryKeyConstraint('Id_Usuaria', 'Id_Conteudo', name='PK__Acessa_U__CA9C269EA0B83DED')
    )

    Id_Usuaria: Mapped[int] = mapped_column(Integer, primary_key=True)
    Id_Conteudo: Mapped[int] = mapped_column(Integer, primary_key=True)
    Data_Acesso: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, server_default=text('(getdate())'))

    Conteudo_Informativo: Mapped['Conteudo_Informativo'] = relationship('ConteudoInformativo', back_populates='Acessa_Usuaria_Conteudo')
    Usuaria_: Mapped['Usuaria'] = relationship('Usuaria', back_populates='Acessa_Usuaria_Conteudo')


class Orgao(Base):
    __tablename__ = 'Orgao'
    __table_args__ = (
        ForeignKeyConstraint(['Id_Classificacao'], ['Classificacao.Id_Classificacao'], name='FK__Orgao__Id_Classi__5629CD9C'),
        PrimaryKeyConstraint('Id_Orgao', name='PK__Orgao__34473CB6CAFE5D2A')
    )

    Id_Orgao: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Nome: Mapped[str] = mapped_column(String(50, 'Latin1_General_CI_AS'), nullable=False)
    Descricao_Alerta: Mapped[str] = mapped_column(String(100, 'Latin1_General_CI_AS'), nullable=False)
    Id_Classificacao: Mapped[int] = mapped_column(Integer, nullable=False)
    Solicitacao: Mapped[Optional[bool]] = mapped_column(Boolean, server_default=text('((0))'))

    Classificacao_: Mapped['Classificacao'] = relationship('Classificacao', back_populates='Orgao')
    Alerta: Mapped[list['Alerta']] = relationship('Alerta', back_populates='Orgao')
    Denuncia: Mapped[list['Denuncia']] = relationship('Denuncia', back_populates='Orgao')


Sofre_Tipo_Violencia_Usuaria = Table(
    'Sofre_Tipo_Violencia_Usuaria', Base.metadata,
    Column('Id_Usuaria', Integer, primary_key=True),
    Column('Id_Tipo_Violencia', Integer, primary_key=True),
    ForeignKeyConstraint(['Id_Tipo_Violencia'], ['Tipo_Violencia.Id_Tipo_Violencia'], ondelete='CASCADE', name='FK__Sofre_Tip__Id_Ti__6E01572D'),
    ForeignKeyConstraint(['Id_Usuaria'], ['Usuaria.Id_Usuaria'], name='FK__Sofre_Tip__Id_Us__6D0D32F4'),
    PrimaryKeyConstraint('Id_Usuaria', 'Id_Tipo_Violencia', name='PK__Sofre_Ti__2AC9B51947B60AED')
)


Utiliza_Rede_Apoio_Usuaria = Table(
    'Utiliza_Rede_Apoio_Usuaria', Base.metadata,
    Column('Id_Rede_Apoio', Integer, primary_key=True),
    Column('Id_Usuaria', Integer, primary_key=True),
    ForeignKeyConstraint(['Id_Rede_Apoio'], ['Rede_Apoio.Id_Rede_Apoio'], name='FK__Utiliza_R__Id_Re__6477ECF3'),
    ForeignKeyConstraint(['Id_Usuaria'], ['Usuaria.Id_Usuaria'], ondelete='CASCADE', name='FK__Utiliza_R__Id_Us__656C112C'),
    PrimaryKeyConstraint('Id_Rede_Apoio', 'Id_Usuaria', name='PK__Utiliza___D0C23E6F5DECAD89')
)


class Alerta(Base):
    __tablename__ = 'Alerta'
    __table_args__ = (
        ForeignKeyConstraint(['Id_Orgao'], ['Orgao.Id_Orgao'], name='FK__Alerta__Id_Orgao__59FA5E80'),
        ForeignKeyConstraint(['Id_Usuaria'], ['Usuaria.Id_Usuaria'], name='FK__Alerta__Id_Usuar__5AEE82B9'),
        PrimaryKeyConstraint('Id_Alerta', name='PK__Alerta__F6D737020C682322')
    )

    Id_Alerta: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Status_Alerta: Mapped[bool] = mapped_column(Boolean, nullable=False)
    CEP: Mapped[str] = mapped_column(String(10, 'Latin1_General_CI_AS'), nullable=False)
    Rua_Avenida: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Num_Imovel: Mapped[int] = mapped_column(Integer, nullable=False)
    Bairro: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Cidade: Mapped[str] = mapped_column(String(30, 'Latin1_General_CI_AS'), nullable=False)
    Estado: Mapped[str] = mapped_column(String(2, 'Latin1_General_CI_AS'), nullable=False)
    Id_Orgao: Mapped[int] = mapped_column(Integer, nullable=False)
    Id_Usuaria: Mapped[int] = mapped_column(Integer, nullable=False)
    Data_Hora: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, server_default=text('(getdate())'))

    Orgao_: Mapped['Orgao'] = relationship('Orgao', back_populates='Alerta')
    Usuaria_: Mapped['Usuaria'] = relationship('Usuaria', back_populates='Alerta')


class Denuncia(Base):
    __tablename__ = 'Denuncia'
    __table_args__ = (
        ForeignKeyConstraint(['Id_Orgao'], ['Orgao.Id_Orgao'], name='FK__Denuncia__Id_Org__619B8048'),
        PrimaryKeyConstraint('Id_Denuncia', name='PK__Denuncia__6D66F7F2F08DC993')
    )

    Id_Denuncia: Mapped[int] = mapped_column(Integer, Identity(start=1000, increment=1), primary_key=True)
    Violencia_Sofrida: Mapped[str] = mapped_column(String(20, 'Latin1_General_CI_AS'), nullable=False)
    Situacao_Atual: Mapped[str] = mapped_column(String(15, 'Latin1_General_CI_AS'), nullable=False)
    Descricao: Mapped[str] = mapped_column(String(100, 'Latin1_General_CI_AS'), nullable=False)
    Id_Orgao: Mapped[int] = mapped_column(Integer, nullable=False)
    Data_Hora: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, server_default=text('(getdate())'))
    Status_Denuncia: Mapped[Optional[bool]] = mapped_column(Boolean, server_default=text('((0))'))

    Orgao_: Mapped['Orgao'] = relationship('Orgao', back_populates='Denuncia')
    Usuaria_: Mapped[list['Usuaria']] = relationship('Usuaria', secondary='Gera_Denuncia_Usuaria', back_populates='Denuncia')


Gera_Denuncia_Usuaria = Table(
    'Gera_Denuncia_Usuaria', Base.metadata,
    Column('Id_Usuaria', Integer, primary_key=True),
    Column('Id_Denuncia', Integer, primary_key=True),
    ForeignKeyConstraint(['Id_Denuncia'], ['Denuncia.Id_Denuncia'], ondelete='CASCADE', name='FK__Gera_Denu__Id_De__71D1E811'),
    ForeignKeyConstraint(['Id_Usuaria'], ['Usuaria.Id_Usuaria'], name='FK__Gera_Denu__Id_Us__70DDC3D8'),
    PrimaryKeyConstraint('Id_Usuaria', 'Id_Denuncia', name='PK__Gera_Den__5511048F2A9CD243')
)

