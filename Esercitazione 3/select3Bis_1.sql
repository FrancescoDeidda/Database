-- EESERCITAZIONE 2 --> TERZA PARTE

-- a) Selezionare il codice e il nome dei corsi tenuti da docenti il cui cognome abbia penultima lettera 'n' o 'r'.

select segreteria.corsi.cod_corso, segreteria.corsi.nome from segreteria.corsi 
join segreteria.docenti on docente = cod_docente where segreteria.docenti.nome like '%n' or segreteria.docenti.nome like '%r';

-- b) Selezionare per ogni esame: i dati dell'esame, la matricola e l'età degli studenti che lo hanno sostenuto, 
--    ordinati per anno corso (hint: la funzione age (timestamp, timestamp) restituisce un interval che rappresentà l'età 
--    calcolata tra i due time stamp fortniti. Il rimestamp attuale si ottiene utilizzando current_timestamp)

select segreteria.esami.*, age(current_timestamp, data_nascita) as età from segreteria.esami join segreteria.studenti on studente = matricola
order by anno_corso;

-- c) Selezionare, per ogni corso il cui nome sia “Programmazione” o “Algebra”, gli esami
--    superati con un voto compreso tra 21 e 27 e visualizzare: i dati del corso e la data
--    dell’esame. Ordinare i risultati per data.

select cod_corso, nome, docente, data_esame from segreteria.esami join (select * from segreteria.corsi where nome = 'Programmazione' or nome = 'Algebra') 
on cod_corso = corso where voto >= 21 and voto <= 27;

-- d) Selezionare i dati dei docenti di Roma e i dati dei relativi corsi (hint: l'indirizzo deve
--    terminare la stringa 'Roma') ordinati in maniera decrescente in base al codice del corso

select * from segreteria.corsi join (select * from segreteria.docenti where indirizzo like '%, Roma') on cod_docente = docente
order by cod_corso desc



-- ESERCITAZIONE 3 --> PRIMA PARTE

-- a) Selezionare il codice e il nome dei prodotti venduti da magazzini che si trovano in via
--    'Giove' il cui prezzo sia inferiore di 50

select codp, nome from prodotti.inventario join (select codp, nome from prodotti.prodotto) on prodotto = codp where prezzo < 50;

-- b) Selezionare il codice, il nome e la quantità dei prodotti presenti magazzini il cui codice
--    contenga 'M0' ordinati per prezzo

select codp, nome, quantita from prodotti.inventario join (select codp, nome from prodotti.prodotto) 
on prodotto = codp where magazzino like '%M01%';

-- c) Selezionare le coppie di magazzini (i loro codici) in cui è presente lo stesso prodotto
--    imponendo che il prodotto sia di una categoria diversa da ‘alimentari’

select magazzino1, magazzino2 from (select magazzino as magazzino1, codp as codp1 from prodotti.prodotto join prodotti.inventario 
 											on prodotto = codp where categoria != 'alimentari')
join (select magazzino as magazzino2, codp as codp2 from prodotti.prodotto join prodotti.inventario 
	  										on prodotto = codp where categoria != 'alimentari') on codp1 = codp2
											where magazzino1 < magazzino2;
-- d) Selezionare i dati dei magazzini in cui è presente uno dei seguenti prodotti: biscotti,
--    frigo o forno, in quantità superiore a 20

select distinct prodotti.magazzino.* from prodotti.magazzino join (select magazzino from prodotti.inventario join
(select codp from prodotti.prodotto where nome = 'biscotti' or nome = 'frigo' or nome = 'forno')
on prodotto = codp) on codm = magazzino;

-- e) Selezionare il codice del magazzino e la categoria dei prodotti in esso presenti il cui
--    prezzo sia compreso tra 50 e 500 ordinati per categoria, e a parità di categoria per
--    codice magazzino decrescente, eliminando eventuali duplicati.

select distinct magazzino, categoria from prodotti.inventario join (select codp, categoria from prodotti.prodotto) 
							   on prodotto = codp where prezzo >= 50 and prezzo <= 500 order by categoria, magazzino desc;
