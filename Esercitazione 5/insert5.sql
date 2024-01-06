insert into prestiti.cliente values('C01', 'Rossi', 'Andrea', 'Cagliari');
insert into prestiti.cliente values('C02', 'Bianchi', 'Maria', 'Cagliari');
insert into prestiti.cliente values('C03', 'Verdi', 'Anna', 'Roma');
insert into prestiti.cliente values('C04', 'Neri', 'Marco', 'Milano');
insert into prestiti.cliente values('C05', 'Rossi', 'Marta', 'Milano');
insert into prestiti.cliente values('C06', 'Bruni', 'Valerio', 'Firenze');
insert into prestiti.cliente values('C07', 'Bruni', 'Paolo', 'Roma');

insert into prestiti.filiale values('F01', 2000000.00, 'Milano');
insert into prestiti.filiale values('F02', 600000.00, 'Roma');
insert into prestiti.filiale values('F03', 1500000.00, 'Roma');
insert into prestiti.filiale values('F04', 500000.00, 'Napoli');
insert into prestiti.filiale values('F05', 500000.00, 'Cagliari');

insert into prestiti.prestito values('P45', 'F03', 80000.00, '1992-02-01', '2012-01-31');
insert into prestiti.prestito values('P56', 'F01', 60000.00, '1995-06-01', '2015-05-31');
insert into prestiti.prestito values('P63', 'F05', 75000.00, '1999-10-10', '2014-09-30');
insert into prestiti.prestito values('P70', 'F02', 200000.00, '2000-01-08', '2019-12-31');
insert into prestiti.prestito values('P81', 'F02', 130000.00, '2002-04-04', '2012-03-31');
insert into prestiti.prestito values('P89', 'F05', 25000.00, '2003-05-02', '2013-04-30');
insert into prestiti.prestito values('P98', 'F01', 110000.00, '2005-06-10', '2025-05-31');

insert into prestiti.accordato_a values('P45', 'C03');
insert into prestiti.accordato_a values('P56', 'C04');
insert into prestiti.accordato_a values('P63', 'C01');
insert into prestiti.accordato_a values('P63', 'C02');
insert into prestiti.accordato_a values('P70', 'C07');
insert into prestiti.accordato_a values('P81', 'C04');
insert into prestiti.accordato_a values('P81', 'C05');
insert into prestiti.accordato_a values('P98', 'C06');
insert into prestiti.accordato_a values('P89', 'C01');