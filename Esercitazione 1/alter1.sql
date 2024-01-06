alter table segreteria.corsi
add foreign key (docente) references segreteria.docenti(cod_docente) on delete restrict on update cascade;

alter table segreteria.esami
add foreign key (studente) references segreteria.studenti(matricola) on delete restrict on update cascade,
add foreign key (corso) references segreteria.corsi(cod_corso) on delete restrict on update cascade;


alter table segreteria.studenti
alter anno_corso set default 3;

alter table segreteria.docenti
add num_telefono varchar(12) default null;

insert into segreteria.studenti values ('424222', 'Deidda', 'Bellino', '1884-01-07', 1);

alter table segreteria.studenti
add constraint dataMaggioreDi check (data_nascita >= '1900-01-01');