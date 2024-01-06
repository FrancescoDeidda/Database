-- (a) La matricola degli studenti che hanno superato l’esame di Basi di Dati
--     con un voto superiore a 27

select studente from segreteria.esami join segreteria.corsi on cod_corso = corso
where nome = 'Basi di dati' and voto > 27;

-- (b) Il cognome e il nome degli studenti che hanno superato almeno un esame nel 2007,
--     con l’eliminazione di eventuali duplicati

select distinct nome, cognome from segreteria.studenti join segreteria.esami on matricola = studente
where data_esame >= '2007-01-01' and data_esame <= '2007-12-31';

-- (c) I dati relativi agli esami sostenuti dallo studente Mario Monti, ordinati in senso
--     decrescente rispetto al voto e, a parità di voto, in senso crescente rispetto alla data    

select * from segreteria.esami join segreteria.studenti on studente = matricola
where nome = 'Mario' and cognome = 'Monti' order by voto desc, data_esame;

-- (d) Le coppie (matricola1, matricola2) distudenti omonimi (stesso cognome e stesso nome)

select t1.matricola as matricola1, t2.matricola as matricola2
from segreteria.studenti as t1 join segreteria.studenti as t2 on t1.matricola > t2.matricola
where t1.nome = t2.nome or t1.cognome = t2.cognome;

-- (e) I dati degli studenti del primo anno con il codice e il voto dei relativi esami 
--     sostenuti, inclusi gli studenti che non hanno sostenuto alcun esame

select corso, voto from segreteria.esami join (select * from segreteria.studenti where anno_corso = 1)
as studenti1 on studente = matricola;

-- (f) I dati di tutti i docenti con i relativi insegnamenti,
--     inclusi i docenti che non tengono alcun corso

select * from segreteria.docenti join segreteria.corsi on docente = cod_docente;