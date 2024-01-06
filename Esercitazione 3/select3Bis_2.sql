-- a) Selezionare i dati dei prodotti che sono presenti esclusivamente in magazzini di Milano

select prodotti.prodotto.* from prodotti.prodotto join (select * from prodotti.inventario join 
									  (select * from prodotti.magazzino where citta = 'Milano') on magazzino = codm)
									  on prodotto = codp;

-- b) Selezionare il codice e la quantità del prodotto presente nell’inventario in quantità maggiore

select prodotto, quantita from prodotti.inventario where quantita = (select max(quantita) from prodotti.inventario);

-- c) Selezionare i dati del prodotto che è presente nell’inventario con prezzo più basso di tutti

select * from prodotti.inventario where prezzo = (select min(prezzo) from prodotti.inventario);

-- d) Selezionare il codice del magazzino in cui è presente il prodotto ‘forno’ in quantità maggiore

select magazzino from prodotti.inventario where quantita = (select max(quantita) from 
	(select * from prodotti.inventario join 
 		(select codp, nome from prodotti.prodotto where nome = 'forno') on prodotto = codp));