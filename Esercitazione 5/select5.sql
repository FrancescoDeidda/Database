-- a) Selezionare i dati dei clienti a cui è stato accordato almeno un prestito da una filiale non
--    situata nella città in cui risiedono, ordinati in senso crescente rispetto al cognome (prima) e al nome (poi).

select * from prestiti.cliente where citta_residenza not in 
(select citta from prestiti.accordato_a join 
(select * from prestiti.prestito join prestiti.filiale on IDfiliale = filiale) on prestito = IDprestito);

-- b) Selezionare il cognome e il nome dei clienti a cui sono stati accordati almeno due prestiti.

select cognome, nome from prestiti.cliente where IDcliente in
(select cliente from (select cliente, count(cliente) as nPrestiti from prestiti.accordato_a group by (cliente))where nPrestiti > 1);

-- c) Selezionare i dati delle filiali che hanno concesso almeno due prestiti di importo superiore a 50000 euro.

select * from prestiti.filiale where IDfiliale in (select filiale from prestiti.prestito where importo > 50000);

-- d) Selezionare i dati delle filiali che non hanno concesso alcun prestito tra il 01/01/2000 e il 31/12/2005.

select * from prestiti.filiale where IDfiliale not in 
(select filiale from prestiti.prestito where data_accensione >= '2000-01-01' and data_accensione <= '2005-12-31');

-- e) Selezionare i dati delle filiali che hanno concesso prestiti esclusivamente a clienti residenti nella propria città.

select * from prestiti.filiale except (select prestiti.filiale.* from prestiti.filiale join (select * from prestiti.prestito join 
(select * from prestiti.accordato_a join 
 (select IDcliente, citta_residenza from prestiti.cliente) on cliente = IDcliente)
 on prestito = IDprestito) on filiale = IDfiliale where citta != citta_residenza);

-- f) Selezionare l’identificativo della filiale che complessivamente ha concesso in prestito la somma più elevata.

select filiale, max(totale) from 
(select filiale, sum(importo) as totale from prestiti.prestito group by filiale) 
group by filiale limit 1;

-- g) Selezionare gli identificativi delle filiali per cui il totale dei prestiti accordati supera il 50%
--    dell’importo massimo che può essere concesso in prestito dalla filiale.

select filiale from 
(select filiale, importo_max, sum(importo) as totale from prestiti.prestito join prestiti.filiale on filiale = IDfiliale group by (filiale, importo_max))
where totale > (importo_max/2);

-- h) Per ogni prestito accordato a più di un cliente, determinare il numero di città diverse in cui
--    risiedono i clienti cui è stato accordato quel prestito.

select prestito, count(distinct(citta_residenza)) as cittaDiverse from prestiti.cliente join  
(select prestito, cliente from prestiti.accordato_a where prestito in 
(select prestito from (select prestito, count(cliente) as nClienti from prestiti.accordato_a group by (prestito)) where nClienti > 1))
on cliente = IDcliente group by prestito;