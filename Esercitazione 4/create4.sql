create schema progetti;

create table progetti.progetto (
	codP varchar (3) primary key,
	nome varchar (50),
	anno integer,
	budget integer not null check (budget > 10000)
);

create table progetti.dipendente (
	codD varchar (3) primary key,
	cognome varchar (50) not null,
	nome varchar (50) not null,
	citta varchar (20)
);

create table progetti.partecipa (
	progetto varchar(3),
	dipendente varchar (3),
	mesi integer check (mesi >= 3 and mesi <= 24),
	ruolo varchar (50),
	foreign key (progetto) references progetti.progetto(codP) on update restrict on delete cascade,
	foreign key (dipendente) references progetti.dipendente(codD) on update restrict on delete cascade,
	primary key (progetto,dipendente)
);