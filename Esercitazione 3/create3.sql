create schema prodotti;

create table prodotti.magazzino(
	codM varchar (3) primary key,
	indirizzo varchar (50),
	citta varchar (20)
);

create table prodotti.prodotto(
	codP varchar (3) primary key,
	nome varchar (20),
	categoria varchar (20)
);

create table prodotti.inventario(
	magazzino varchar (3),
	prodotto varchar (3),
	quantita integer not null check (quantita > 0),
	prezzo float not null check (prezzo > 0.00),
	foreign key (magazzino) references prodotti.magazzino (codM)
	on delete cascade on update cascade,
	foreign key (prodotto) references prodotti.prodotto (codP)
	on delete cascade on update cascade,
	primary key (magazzino, prodotto)
);