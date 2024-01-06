create schema palestra;

create table palestra.corso(
	codiceC int not null primary key,
	nomeCorso varchar (25) unique,
	nomeIstruttore varchar (25) not null,
	capienza int check (capienza >= 15 and capienza <= 30)
);

create table palestra.atleta(
	codiceA int not null primary key,
	nomeAtleta varchar (25) not null,
	cognomeAtleta varchar (25) not null,
	eta int,
	categoria varchar (25) not null check (categoria = 'principiante' or categoria = 'intermedio' or categoria = 'esperto')
);

create table palestra.iscrizione(
	corso int not null references palestra.corso(codiceC) on delete cascade on update cascade,
	atleta int not null references palestra.atleta(codiceA) on delete no action on update cascade,
	abbonamento varchar (25) check (abbonamento = 'open' or abbonamento = 'singolo'),
	primary key(corso,atleta)
);



