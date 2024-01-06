create schema prestiti;

create table prestiti.cliente(
	IDcliente varchar (3) primary key,
	cognome varchar (25) not null,
	nome varchar (25) not null,
	citta_residenza varchar (25),
	unique (cognome, nome)
);

create table prestiti.filiale(
	IDfiliale varchar(3) primary key,
	importo_max decimal not null,
	citta varchar(25)
);

create table prestiti.prestito(
	IDprestito varchar(3) primary key,
	filiale varchar (3) not null references prestiti.filiale(IDfiliale) on delete no action,
	importo decimal not null,
	data_accensione date not null check (data_accensione <= data_scadenza),
	data_scadenza date not null
);

create table prestiti.accordato_a(
	prestito varchar (3) not null references prestiti.prestito(IDprestito) on delete cascade on update cascade,
	cliente varchar (3) not null references prestiti.cliente(IDcliente) on delete cascade on update cascade,
	primary key (prestito,cliente)
);