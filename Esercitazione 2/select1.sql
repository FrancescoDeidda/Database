-- a) I dati relativi agli esami il cui voto è minore di 21 o maggiore di 27
select * from segreteria.esami where voto <= 21 or voto >= 27;

-- b) Il codice e il cognome dei docenti di cui non è noto l'indirizzo

select cod_docente, cognome from segreteria.docenti where indirizzo is null;

-- c) La matricola degli studenti il cui cognome inizia con 'M' o 'N' e termina con 'i'

select matricola from segreteria.studenti 
where ((cognome like 'M%' or cognome like 'N%') and cognome like '%i');

-- d) La matricola degli studenti che hanno sostenuto nel 2006 o nel 2007 un esame 
--    con voto pari a 30 o 33 (lode)

select studente from segreteria.esami 
where data_esame >= '2006-01-01' and data_esame <= '2007/12/31' and voto >= 30;

-- e) Il cognome e il nome degli studenti nati prima del 1984, con l'eliminazione di 
--    eventuali duplicati

select distinct cognome, nome from segreteria.studenti where data_nascita <= '1984-01-01';

-- f) I dati di tutti gli studenti del biennio, ordinati in modo decrescente rispetto 
--    all'età, e a parità di età, in modo crescente rispetto al cognome (prima) e al nome (poi)

select * from segreteria.studenti where anno_corso = 1 or anno_corso = 2 
order by data_nascita desc, cognome, nome;