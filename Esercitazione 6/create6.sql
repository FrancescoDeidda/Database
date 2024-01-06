create schema azienda;

create table azienda.dipartimento(
	ID int primary key,
	nome varchar (25) not null,
	citta varchar (25) not null
);

create table azienda.articolo(
	ID int primary key,
	nome varchar (25) not null,
	categoria varchar (25) not null
);

create table azienda.vendita(
	dipartimento int references azienda.dipartimento(ID) on update no action on delete cascade,
	articolo int references azienda.articolo(ID) on update no action on delete cascade,
	prezzo_v decimal check (prezzo_v > 0) not null,
	primary key (dipartimento, articolo)
);

create table azienda.acquisto(
	dipartimento int references azienda.dipartimento(ID) on update no action on delete cascade,
	articolo int references azienda.articolo(ID) on update no action on delete cascade,
	prezzo_a decimal check (prezzo_a > 0) not null,
	primary key (dipartimento, articolo)
);


