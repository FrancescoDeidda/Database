-- a) Selezionare i dati dei prodotti disponibili  nel magazzino 'M11' , con il relativo prezzo,
--    ordinati in senso crescente rispetto alla categoria e, a parità di categoria, ordinati in 
--    senso decrescente rispetto al prezzo

select * from prodotti.prodotto join prodotti.inventario on prodotto = codP where magazzino = 'M11';

-- b) Selezionare il codice e l'indirizzo dei magazzini di Milano in cui è presente almeno un prodotto della categoria
--    'elettrodomestici' in quantità superiore a 20

select * from (select * from prodotti.prodotto join prodotti.inventario on prodotto = codp 
			   where quantita > 20 and categoria = 'elettrodomestici') 
	join prodotti.magazzino on magazzino = codm where citta = 'Milano';

-- c) Selezionare il codice e la città  dei magazzini in cui sono presenti spaghetti

select codm, citta from (select * from prodotti.prodotto join prodotti.inventario on prodotto = codp 
			   where nome = 'spaghetti') 
	join prodotti.magazzino on magazzino = codm;
	
-- d) Selezionare il codice dei magazzini attualmente vuoti (che non contengono cioé nessun prodotto)

select codm from prodotti.magazzino except select distinct magazzino from prodotti.inventario;

-- e) Selezionare il codice dei magazzini che non contengono nessun prodotto della categoria 'alimentari',
--    magazzini vuoti compresi

select codM from prodotti.magazzino except (select distinct magazzino from 
(prodotti.inventario join prodotti.prodotto on prodotto = codP) where categoria = 'alimentari');

-- f) Selezionare il codice dei magazzini che non contengono nessun prodotto della categoria
--    ‘alimentari’, magazzini vuoti esclusi.

select distinct magazzino from prodotti.inventario except (select distinct magazzino from
(prodotti.inventario join prodotti.prodotto on prodotto = codP) where categoria = 'alimentari');

-- g) Selezionare il codice dei magazzini che contengono solo prodotti della categoria ‘alimentari’.

select distinct magazzino from 
(prodotti.inventario join prodotti.prodotto on prodotto = codP) where categoria = 'alimentari' except (
select distinct magazzino from 
(prodotti.inventario join prodotti.prodotto on prodotto = codP) where categoria != 'alimentari');

-- h) Selezionare il codice dei prodotti che sono presenti in almeno due magazzini.

select inv1.prodotto from prodotti.inventario as inv1 join prodotti.inventario as inv2 
on inv1.prodotto = inv2.prodotto where inv1.magazzino > inv2.magazzino;
