create schema segreteria;

create domain votazione
as integer default null 
check ((value >= 18 AND value <= 30) or value = 33);

create table segreteria.studenti(
	matricola varchar(6) primary key,
	cognome varchar(50) not null,
	nome varchar(50) not null,
	data_nascita date,
	anno_corso int check (anno_corso >= 1 AND anno_corso <= 3) default 1
);

select * from segreteria.studenti;

create table segreteria.docenti(
	cod_docente varchar(6) primary key,
	cognome varchar(50) not null,
	nome varchar(50) not null,
	indirizzo varchar(50)
);

select * from segreteria.docenti;

create table segreteria.corsi(
	cod_corso varchar(3) primary key,
	nome varchar(50),
	docente varchar(6),
	foreign key (docente) references segreteria.docenti(cod_docente),
	unique(nome, docente)
);

select * from segreteria.corsi;

create table segreteria.esami(
	studente varchar(6),
	corso varchar(3),
	data_esame date not null,
	voto integer not null,
	foreign key (studente) references segreteria.studenti(matricola),
	foreign key (corso) references segreteria.corsi(cod_corso)
);