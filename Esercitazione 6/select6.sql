-- a) Selezionare il nome dei dipartimenti che vendono solo articoli di cancelleria e acquistano articoli di più categorie.

select nome from azienda.dipartimento where id in (select dipartimento from azienda.acquisto where dipartimento in 
 (select dipartimento from azienda.vendita where articolo in 
  (select id from azienda.articolo where categoria = 'cancelleria')));

-- b) Creare, all'interno dello schema azienda, una vista VenditaArticoli che contenga, per ogni
--    articolo in vendita, le informazioni dell'articolo, del dipartimento, e il prezzo di vendita.

create view azienda.VenditaArticoli as
select dipartimento, articolo, prezzo_v, nome, citta from azienda.vendita join azienda.dipartimento on dipartimento = id;

-- c) Usando la vista VenditaArticoli, selezionare le città in cui si vende un'unica categoria di prodotti.
	
select citta from (select citta, count(distinct(categoria)) as nCategorie from azienda.VenditaArticoli join azienda.articolo on articolo = azienda.articolo.id
group by citta) where nCategorie = 1 ;

-- d) Usando la vista VenditaArticoli, selezionare per ogni articolo venduto da più di un dipartimento:
--    il nome dell'articolo, il numero di dipartimenti che lo vende, e la differenza tra il prezzo massimo e minimo di vendita.

select * from azienda.VenditaArticoli;

select nome, dipartimenti, (prezzo_a - prezzo_v) as differenza from azienda.acquisto join (select articolo as idArticolo, nome, prezzo_v, dipartimenti from (select articolo as idArticolo, nome as nomeArticolo, dipartimenti from azienda.articolo join (select * from 
 	(select articolo, count(articolo) as dipartimenti from azienda.VenditaArticoli group by articolo) 
 where dipartimenti > 1) on articolo = id) join azienda.VenditaArticoli on articolo = idArticolo) on articolo = idArticolo;

-- e) Usando la vista VenditaArticoli, per ogni categoria che contiene più di due articoli, selezionare
--    il numero di articoli diversi e il prezzo medio degli articoli appartenenti a quella categoria.

select categoria, count(distinct(id)), avg(prezzo_v) from (select * from azienda.articolo join azienda.venditaarticoli on articolo = id) where categoria in
(select categoria from
(select categoria, count(categoria) as nArticoli from azienda.articolo group by categoria)where narticoli > 2) group by categoria;

-- f) Usando la vista VenditaArticoli, selezionare, per ogni articolo, il prezzo di vendita più basso e il 
--    dipartimento che lo vende a quel prezzo.

select dipartimento, articolo, prezzo_v from azienda.venditaarticoli where prezzo_v in
	(select prezzominimo from 
	 	(select articolo, min(prezzo_v) as prezzoMinimo from azienda.venditaarticoli group by articolo));

-- g) Definire (all’interno dello schema azienda) una vista “statistiche” che contiene, per ogni
--    articolo, l’identificativo dell’articolo (attributo “ID”), il nome dell’articolo (attributo “nome”), il
--    numero di dipartimenti che vendono tale articolo (attributo “num_v”), il numero di dipartimenti
--    che acquistano tale articolo (attibuto “num_a”), la media dei prezzi di vendita relativi a tale
--    articolo (attributo “prezzo_v_medio”), la media dei prezzi di acquisto relativi a tale articolo
--    (attributo “prezzo_a_medio”).

create view azienda.statistiche as
	select id, nome, num_v, num_a, prezzo_v_medio, prezzo_a_medio from azienda.articolo join 
		(select articolo as a1, count(dipartimento) as num_v from azienda.vendita group by a1) on id = a1 join
				(select articolo as a2, count(dipartimento) as num_a from azienda.acquisto group by a2) on id = a2 join 
					(select articolo as a3, avg(prezzo_v) as prezzo_v_medio from azienda.vendita group by a3) on id = a3 join 
						(select articolo as a4, avg(prezzo_a) as prezzo_a_medio from azienda.acquisto group by a4) on id = a4;
					
-- h) Usando la vista “statistiche”, per ogni articolo venduto da almeno due dipartimenti e acquistato
--    da almeno due dipartimenti, selezionare il nome dell’articolo, l’identificativo del dipartimento
--    che vende l’articolo al prezzo più basso e l’identificativo del dipartimento che acquista l’articolo al prezzo più basso.

select id, nome, acquirentePMin, venditorePMin from azienda.articolo join 
(select articolo as a1, dipartimento as acquirentePMin, prezzo_a from azienda.acquisto where (articolo, prezzo_a) in (select articolo, min(prezzo_a) as min_a from azienda.acquisto where articolo in 
	(select id from azienda.statistiche where (num_v = 2 and num_a = 2)) group by articolo)) on id = a1 join 
			(select articolo as a2, dipartimento as venditorePMin, prezzo_v  from azienda.vendita where (articolo, prezzo_v) in (select articolo, min(prezzo_v) as min_v from azienda.vendita where articolo in 
				(select id from azienda.statistiche where (num_v = 2 and num_a = 2)) group by articolo)) on id = a2;

-- i) Creare una vista “acquisti_per_dip” che contenga, per ogni dipartimento, il numero di articoli
--    che acquista. Creare una vista “vendite_per_dip” che contenga, per ogni dipartimento, il numero
--    di articoli che vende. Usando le due viste appena create, selezionare i dipartimenti che vendono
--    più articoli di quanti ne acquistino.

create view azienda.acquisti_per_dip as
select dipartimento as d1, count(articolo) as articoliAcquistati from azienda.acquisto group by dipartimento;

create view azienda.vendite_per_dip as
select dipartimento as d2, count(articolo) as articoliVenduti from azienda.vendita group by dipartimento;

select d1 as dipartimento from azienda.acquisti_per_dip join azienda.vendite_per_dip on d1 = d2 where articolivenduti > articoliacquistati;

-- j) Usando la vista “vendite_per_dip”, selezionare le coppie di dipartimenti che vendono lo stesso numero di articoli.

select v1.d2 as dip1, v2.d2 as dip2 from ((select * from azienda.vendite_per_dip) as v1 join 
			   (select * from azienda.vendite_per_dip) as v2 on v1.d2 > v2.d2) where v1.articolivenduti = v2.articolivenduti;
