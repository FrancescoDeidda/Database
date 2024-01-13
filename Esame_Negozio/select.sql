-- a) Selezionare nome, marca e categoria dei prodotti presenti in vetrine del reparto 'donna' il cui
--    prezzo sia inferiore a 130, ordinati per marca ed eliminando i duplicati.

select distinct nomeprodotto,marca, categoria from negozio.vetrina join negozio.presenza on vetrina = codicev 
join negozio.prodotto on prodotto = codicep where prezzo < 130 and nomeReparto = 'donna' order by marca;

-- b) Selezionare la metratura della vetrina più piccola in cui è presente almeno un prodotto di marca 'Trussardi'.

select min(metratura) from negozio.vetrina join negozio.presenza on vetrina = codiceV 
where prodotto in (select codicep from negozio.prodotto where marca = 'Trussardi');

-- c) Selezionare i dati delle vetrine che vendono esclusivamente prodotti il cui costo sia superiore al costo medio dei prodotti

select negozio.vetrina.* from negozio.vetrina join negozio.presenza on vetrina = codiceV where prodotto not in 
(select codiceP from negozio.prodotto where prezzo > (select avg(prezzo) from negozio.prodotto));

-- d) Selezionare i dati dei prodotti che sono presenti in almeno 2 vetrine, esclusi i prodotti
--    presenti nelle vetrine il cui reparto è ‘bambino’

select * from negozio.prodotto where codiceP in
(select codiceP from negozio.prodotto join negozio.presenza on prodotto = codiceP where vetrina not in 
(select codiceV from negozio.vetrina where nomereparto = 'bambino') group by codiceP having count(vetrina)>1);

-- e) Selezionare il codice delle coppie di prodotti che sono venduti dalla stessa vetrina

select * from negozio.presenza as p1 join
negozio.presenza as p2 on p1.prodotto < p2.prodotto and p1.vetrina = p2.vetrina;
