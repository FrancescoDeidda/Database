-- a) Selezionare nome, cognome e categoria degli atleti maggiorenni (età maggiore o uguale a
--    18) iscritti a corsi tenuti dall’istruttore 'Roberto', ordinati per nome ed eliminando i duplicati.

select nomeAtleta, cognomeAtleta, categoria from palestra.atleta where codiceA in
(select distinct(atleta) from palestra.iscrizione where corso in 
  	(select codiceC from palestra.corso where nomeIstruttore = 'Roberto')) order by nomeAtleta;

-- b) Selezionare il codice delle coppie di atleti che hanno stesso nome ma che appartengono a categorie diverse.

select a1.codiceA, a1.nomeAtleta, a2.codiceA, a2.nomeAtleta 
from palestra.atleta as a1 join palestra.atleta as a2 on a1.codiceA > a2.codiceA
where (a1.nomeAtleta = a2.nomeAtleta and a1.categoria != a2.categoria);

-- c) Selezionare, per ogni corso a cui sono iscritti almeno 3 atleti diversi, il nome del corso e
--    l’eta media degli atleti iscritti a quel corso.

select nomeCorso, etamedia from palestra.corso join
(select corso, avg(eta) as etamedia from palestra.atleta join (select * from palestra.iscrizione join 
(select corsoMag3 from (select corso as corsoMag3, count(atleta) as atleti from palestra.iscrizione group by corsoMag3) where atleti > 2)
on corso = corsoMag3) on atleta = codiceA group by corso) on corso = codiceC;

-- d) Selezionare, per ogni corso: il nome del corso, e il nome, il cognome e la categoria
--    dell’atleta più giovane iscritto a quel corso.

select nomeCorso, nomeAtleta, cognomeAtleta, categoria from palestra.corso join
(select corso, nomeAtleta, cognomeAtleta, categoria from palestra.atleta join 
 (select corso, min(eta) as piugiovane from palestra.iscrizione join 
palestra.atleta on atleta = codiceA group by corso) on eta = piugiovane) on codiceC = corso;

-- e) All'interno dello schema 'palestra', creare una vista 'corsi_abbonamento_open' che contenga
--    i dati dei corsi che abbiano un numero di abbonamenti 'open' superiore a 3. Usando tale
--    vista, per ciascun corso con un numero di abbonamenti 'open' superiore a 3, selezionare: il
--    nome del corso, e l’eta dell’atleta più vecchio e di quello più giovane che sono iscritti a quel corso.

create view corsi_abbonamento_open as
select * from palestra.corso where codiceC in 
(select corso from (select corso, count(abbonamento) from palestra.iscrizione where abbonamento = 'open' group by corso));

select nomeCorso, piugiovane, piuanziano from (select corso, min(eta) as piugiovane, max(eta) as piuanziano from palestra.atleta join 
(select * from palestra.iscrizione where corso in (select codiceC from corsi_abbonamento_open))
on atleta = codiceA group by corso) join palestra.corso on corso = codiceC;

