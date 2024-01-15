create schema immobili;

create table immobili.immobile(
	codiceI varchar (3) primary key,
	indirizzo varchar (50) not null,
	tipo varchar (20) check (tipo in ('appartamento','villetta','magazzino')) not null,
	zona varchar (20) check (zona in ('residenziale','centro','periferia')) not null,
	prezzo_richiesto decimal (10,2) not null
);

create table immobili.agente(
	codiceA varchar (3) primary key,
	cognome varchar (20),
	nome varchar (20),
	agenzia varchar (20) not null
);

create table immobili.visita(
	codI varchar (3) references immobili.immobile(codiceI) on delete cascade on update cascade,
	codA varchar (3) references immobili.agente(codiceA) on delete restrict on update cascade,
	data date,
	primary key ( codI, codA, data)
);

create table immobili.vendita(
	codI varchar (3) references immobili.immobile(codiceI) on delete restrict on update cascade primary key,
	codA varchar (3) references immobili.agente(codiceA) on delete restrict on update cascade not null,
	data date,
	prezzo decimal (10,2) not null
);






