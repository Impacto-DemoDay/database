CREATE DATABASE IF NOT EXISTS database_impacto;

USE database_impacto;

-- Tabelas para o Usuário e ONGs
CREATE TABLE IF NOT EXISTS usuarios (
	id_usuarios int NOT NULL UNIQUE AUTO_INCREMENT,
	nome varchar(255) NOT NULL,
    	cpf varchar(16) NOT NULL UNIQUE,
    	data_nascimento date NOT NULL,
    	genero enum('masculino', 'feminino', 'outros') NOT NULL,
    	email varchar(255) NOT NULL,
    	senha varchar(255) NOT NULL,
    	telefone varchar(18) NOT NULL,
    	telefone_reserva varchar(18) NULL,
    	interesses enum('doador', 'voluntario', 'ambos'),
    	data_cadastro datetime NOT NULL,
    	atualizado_em datetime NOT NULL,
	pontuacao int NOT NULL,
    	PRIMARY KEY (id_usuarios)
);

CREATE TABLE IF NOT EXISTS ongs(
	id_ongs int NOT NULL UNIQUE AUTO_INCREMENT,
    	nome varchar(255) NOT NULL,
    	cnpj varchar(20) NOT NULL UNIQUE,
    	email varchar(255) NOT NULL,
    	senha varchar(255) NOT NULL,
    	telefone varchar(18) NOT NULL,
    	telefone_reserva varchar(18) NULL,
    	causa varchar(255) NOT NULL,
    	foto_perfil varchar(255) NULL,
    	local_atuacao varchar(255) NOT NULL,
    	sobre_ong text NULL,
    	data_criacao datetime NOT NULL,
    	data_alteracao datetime NOT NULL,
    	PRIMARY KEY (id_ongs)
);

-- Tabelas para doações, causas e trabalhos voluntários
CREATE TABLE IF NOT EXISTS doacoes(
	id_doacoes int NOT NULL UNIQUE AUTO_INCREMENT,
    	valor int NOT NULL,
    	motivo varchar(255) NULL,
    	data_doacao datetime NOT NULL,
    	analise_pagamento boolean NOT NULL DEFAULT false,
    	PRIMARY KEY (id_doacoes),
    	id_usuarios int,
    	id_ongs int,
    	FOREIGN KEY (id_usuarios) REFERENCES usuarios(id_usuarios),
    	FOREIGN KEY (id_ongs) REFERENCES ongs(id_ongs)
);

CREATE TABLE IF NOT EXISTS causas(
	id_causas int NOT NULL UNIQUE AUTO_INCREMENT,
    	nome_causa varchar(255) NOT NULL,
    	descricao text,
	PRIMARY KEY (id_causas)
);

CREATE TABLE IF NOT EXISTS trabalhos_voluntarios(
	id_trabalhos_voluntarios int NOT NULL UNIQUE AUTO_INCREMENT,
    	descricao text NOT NULL,
    	especializacao varchar(255) NOT NULL,
    	localizacao varchar(255) NOT NULL,
    	genero enum('feminino', 'masculino', 'outros') NOT NULL,
    	data_trabalho datetime NOT NULL,
    	duracao_trablho time NOT NULL,
    	PRIMARY KEY (id_trabalhos_voluntarios),
	id_usuarios int,
    	id_ongs int,
    	id_causas int,
    	FOREIGN KEY (id_usuarios) REFERENCES usuarios(id_usuarios),
    	FOREIGN KEY (id_ongs) REFERENCES ongs(id_ongs),
    	FOREIGN KEY (id_causas) REFERENCES causas(id_causas)
);

-- Tabelas com o endereço do usuário e feedbacks
CREATE TABLE IF NOT EXISTS endereco_usuarios(
	id_endereco_usuarios int NOT NULL UNIQUE AUTO_INCREMENT,
    	cep varchar(12) NOT NULL,
    	rua varchar(255) NOT NULL,
    	numero varchar(10) NULL,
    	logradouro varchar(255) NOT NULL,
    	cidade varchar(255) NOT NULL,
    	estado varchar(255) NOT NULL,
    	pais varchar(255) NOT NULL,
    	PRIMARY KEY (id_endereco_usuarios),
    	id_usuarios int,
    	FOREIGN KEY (id_usuarios) REFERENCES usuarios(id_usuarios)
);

CREATE TABLE IF NOT EXISTS feedback_tabalho(
	id_feedback_tabalho int NOT NULL UNIQUE AUTO_INCREMENT,
    	satisfacao integer NOT NULL,
    	comentario text NULL,
    	PRIMARY KEY(id_feedback_tabalho),
    	id_usuarios int,
    	id_trabalhos_voluntarios int,
    	FOREIGN KEY (id_usuarios) REFERENCES usuarios(id_usuarios),
    	FOREIGN KEY (id_trabalhos_voluntarios) REFERENCES trabalhos_voluntarios(id_trabalhos_voluntarios)
);

-- Tabela que relaciona causas e usuários
CREATE TABLE IF NOT EXISTS causas_usuarios (
	id_causas_usuarios int NOT NULL UNIQUE AUTO_INCREMENT,
    	id_usuarios int,
    	id_causas int,
    	PRIMARY KEY (id_causas_usuarios),
    	FOREIGN KEY (id_usuarios) REFERENCES usuarios(id_usuarios),
    	FOREIGN KEY (id_causas) REFERENCES causas(id_causas)
);
