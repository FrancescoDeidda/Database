-- a) Selezionare il budget più alto, più basso, e medio dei progetti.

select max(budget), min(budget), avg(budget) from progetti.progetto;

-- b) Selezionare il nome del progetto col budget più elevato.

select nome from progetti.progetto where budget = (select max(budget) from progetti.progetto);

-- c) Selezionare il nome dei progetti il cui budget è superiore alla media.

select nome from progetti.progetto where budget > (select avg(budget) from progetti.progetto);

-- d) Selezionare i dati dei progetti cui partecipano almeno un dipendente di Cagliari e un dipendente di Sassari.

select distinct p1 from (select codD as dipendente1 from progetti.dipendente where citta = 'Cagliari') join 
(select codD as dipendente2 from progetti.dipendente where citta = 'Sassari') on dipendente1 != dipendente2
join
(select * from (select progetto as p1, dipendente as dip1 from progetti.partecipa) join 
(select progetto as p2, dipendente as dip2 from progetti.partecipa) on dip1 != dip2) 
on dipendente1 = dip1 and dipendente2 = dip2;

-- e) Selezionare il cognome e il nome dei dipendenti che non partecipano a nessun progetto iniziato prima del 2005.

select cognome, nome from (select codD, cognome, nome from progetti.dipendente except (select dipendente, cognome, nome from (select dipendente from (select * from progetti.progetto where anno < 2005) join progetti.partecipa on progetto = codP) join
(select codD, cognome, nome from progetti.dipendente) on dipendente = codD));

-- f) Selezionare il cognome e il nome dei dipendenti che partecipano esclusivamente a progetti del 2005.

select cognome, nome from (select codD, cognome, nome from progetti.dipendente except (select dipendente, cognome, nome from (select dipendente from (select * from progetti.progetto where anno = 2005) join progetti.partecipa on progetto = codP) join
(select codD, cognome, nome from progetti.dipendente) on dipendente = codD));

-- g) Per ogni dipendente (che ha preso parte ad almeno un progetto), selezionare il codice del
-- progetto in cui egli ha lavorato per il maggior numero di mesi.

select dipendente, max(mesi) from progetti.partecipa group by dipendente;