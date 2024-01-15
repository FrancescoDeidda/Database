create schema negozio;

create table negozio.vetrina(
	codiceV int primary key,
	nomeVetrina varchar (20) unique not null,
	nomeReparto varchar (20) check (nomeReparto in ('uomo', 'donna', 'bambino')) not null,
	metratura int check (metratura >= 10 and metratura <= 200)
);

create table negozio.prodotto(
	codiceP int primary key,
	nomeProdotto varchar (20) not null,
	marca varchar (20) not null,
	catregoria varchar (20)  not null,
	prezzo decimal (10,2) check (prezzo > 1 ) not null
);

create table negozio.presenza(
	vetrina int references negozio.vetrina(codiceV) on delete cascade  on update cascade,
	prodotto int references negozio.prodotto(codiceP) on delete restrict on update cascade,
	quantita int check (quantita > 0),
	primary key (vetrina, prodotto)
);

