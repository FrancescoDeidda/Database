-- a) Selezionare codice, indirizzo, tipo e zona degli immobili venduti prima del primo Gennaio
--    2005 il cui prezzo di vendita sia inferiore al prezzo richiesto.

select codiceI, tipo, zona from immobili.immobile join immobili.vendita on codiceI = codi
where data < '2005-01-01' and prezzo < prezzo_richiesto;

-- b) Selezionare indirizzo, prezzo richiesto e data delle visite effettuate da agenti di
--    'CambiaCasa', ordinando i risultati per data, dalla più recente alla meno recente.

select indirizzo, prezzo_richiesto, data from immobili.immobile join immobili.visita on codiceI = codi 
join immobili.agente on coda = codiceA where agenzia = 'CambiaCasa' order by data desc;

-- c) Selezionare il nome delle agenzie i cui agenti abbiano effettuato complessivamente almeno
--    3 visite dopo il primo Gennaio 2004.

select agenzia from immobili.visita join immobili.agente on coda = codiceA group by agenzia having count(data)>2;

-- d) Selezionare i dati degli agenti di 'CambiaCasa' che abbiano effettuato almeno due visite
--    dopo il primo Gennaio 2003, ma nessuna vendita dopo il primo Gennaio 2005.

select * from immobili.agente where agenzia = 'CambiaCasa' and codiceA in
(select coda from immobili.visita group by coda having count(data>'2003-01-01')>1) and codiceA not in
(select coda from immobili.vendita where(data>'2005-01-01'));

-- e) All'interno dello schema “immobili”, creare una vista “immobile_invenduto” che contenga i
--    dati di tutti gli immobili che non sono stati ancora venduti. Usando tale vista, per ciascun
--    immobile ancora invenduto (compresi quelli che non sono mai stati visitati), determinare il
--    numero di volte in cui è stato visitato.

create view immobili.immobile_invenduto as
select * from immobili.immobile where codiceI not in (select codi from immobili.vendita);

select codiceI, count(data) as visite from immobili.immobile_invenduto left join immobili.visita on codi = codicei group by codicei;
