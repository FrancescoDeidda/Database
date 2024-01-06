-- a) Selezionare nome, cognome e categoria degli atleti maggiorenni (età maggiore o uguale a
--    18) iscritti a corsi tenuti dall’istruttore 'Roberto', ordinati per nome ed eliminando i duplicati.

select nomeAtleta, cognomeAtleta, categoria from palestra.atleta where eta >= 18 and codiceA in
(select atleta from palestra.iscrizione where corso in (select codiceC from palestra.corso where nomeIstruttore = 'Roberto'));

-- b) Selezionare il codice delle coppie di atleti che hanno stesso nome ma che appartengono a categorie diverse.

select a1.codiceA, a2.codiceA from palestra.atleta as a1 join palestra.atleta as a2 on a1.codiceA > a2.codiceA 
where (a1.categoria != a2.categoria and a1.nomeAtleta = a2.nomeAtleta);

-- c) Selezionare, per ogni corso a cui sono iscritti almeno 3 atleti diversi, il nome del corso e
--    l’eta media degli atleti iscritti a quel corso.

select nomeCorso, etamedia from (select corso, count(atleta) as atleti, avg(eta) as etaMedia from 
(select corso, atleta, eta from palestra.iscrizione join palestra.atleta on atleta = codiceA) group by corso) join 
palestra.corso on corso = codiceC where atleti > 2;

-- d) Selezionare, per ogni corso: il nome del corso, e il nome, il cognome e la categoria
--    dell’atleta più giovane iscritto a quel corso.
	
select * from (select corso, nomeatleta, cognomeatleta, eta, categoria from palestra.iscrizione join palestra.atleta on atleta = codiceA) join
	palestra.corso on corso = codiceC where eta in 
	(select piupiccolo from (select nomecorso, min(eta) as piupiccolo from 
	(select corso, nomeatleta, cognomeatleta, eta, categoria from palestra.iscrizione join palestra.atleta on atleta = codiceA) join
	palestra.corso on corso = codiceC group by nomecorso));

-- e) All'interno dello schema 'palestra', creare una vista 'corsi_abbonamento_open' che contenga
-- i dati dei corsi che abbiano un numero di abbonamenti 'open' superiore a 3. Usando tale
-- vista, per ciascun corso con un numero di abbonamenti 'open' superiore a 3, selezionare: il
-- nome del corso, e l’eta dell’atleta più vecchio e di quello più giovane che sono iscritti a quel corso.

create view palestra.corsi_abbonamento_open as
select corso from 
(select corso, count(abbonamento) as abbonamentiOpen from palestra.iscrizione where abbonamento = 'open' group by corso);

select nomecorso, piupiccolo, piugrande from((select distinct(corso), nomecorso from (select t1.corso, atleta, abbonamento from palestra.corsi_abbonamento_open as t1 join palestra.iscrizione as t2 on t1.corso = t2.corso) join
palestra.corso on codiceC = corso) as t3 join
(select t1.corso, piupiccolo, piugrande from ((select corso, min(eta) as piupiccolo from palestra.atleta join palestra.iscrizione on codiceA = atleta group by corso) as t1 join
(select corso, max(eta) as piugrande from palestra.atleta join palestra.iscrizione on codiceA = atleta group by corso) as t2 on t1.corso = t2.corso))as t4 on t4.corso = t3.corso);

