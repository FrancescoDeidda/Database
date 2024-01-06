-- h) Selezionare il codice di quei dipendenti che partecipano ai progetti con almeno tre ruoli distinti.

select dipendente from
(select dipendente, count(distinct ruolo) as ruoli from progetti.partecipa group by dipendente) where ruoli >= 3; 

-- i) Selezionare, per ogni dipendente e per ogni ruolo che ricopre, il numero di progetti in cui ricopre quel ruolo.

select dipendente, ruolo, count (progetto) as nProgetti from progetti.partecipa group by (dipendente,ruolo);

-- j) Selezionare, per ogni anno, il budget complessivo destinato ai progetti di quell'anno.

select anno, sum(budget) as totale from progetti.progetto group by anno;

-- k) Selezionare, per ogni progetto a cui partecipano dipendenti per un numero complessivo di
--    mesi superiore a 15, il numero distinto di ruoli che partecipano a quel progetto.

select p1.progetto, mesiTot, ruoli from (select progetto, sum(mesi) as mesiTot from progetti.partecipa group by progetto) as p1
join (select progetto, count(distinct ruolo) as ruoli from progetti.partecipa group by progetto) as p2 on p1.progetto = p2.progetto where mesiTot > 15;

-- l) Selezionare, per ogni progetto, il numero complessivo di mesi destinati ad ogni ruolo (tra
--    quelli che partecipano al progetto).

select progetto, ruolo, sum(mesi) from progetti.partecipa group by (progetto, ruolo);

-- m) Selezionare il progetto a cui sono destinati complessivamente più mesi.

select * from (select progetto, sum(mesi) as mesiTot from progetti.partecipa group by progetto) 
where mesiTot = (select max(mesiTot) from (select progetto, sum(mesi) as mesiTot from progetti.partecipa group by progetto));

-- n) Selezionare i dati dei progetti cui partecipano almeno tre dipendenti che abitano a Cagliari o a Sassari.

select progetto, dipendenti from (select progetto, count(dipendente) as dipendenti from progetti.partecipa where dipendente in 
(select codd from progetti.dipendente where citta = 'Cagliari' or citta = 'Sassari')
group by progetto) where dipendenti >= 3;
