insert into progetti.progetto values ('P01', 'Marte', 2002, 12000);
insert into progetti.progetto values ('P02', 'Giove', 2004, 25000);
insert into progetti.progetto values ('P03', 'Terra', 2005, 100000);
insert into progetti.progetto values ('P04', 'Venere', 2005, 50000);

insert into progetti.dipendente values ('D01', 'Mocci', 'Efisio', 'Cagliari');
insert into progetti.dipendente values ('D02', 'Sanna', 'Alberto', 'Cagliari');
insert into progetti.dipendente values ('D03', 'Medda', 'Monica', 'Nuoro');
insert into progetti.dipendente values ('D04', 'Cocco', 'Angelo', 'Sassari');
insert into progetti.dipendente values ('D05', 'Salis', 'Antioco', 'Cagliari');

insert into progetti.partecipa values ('P01', 'D02', 3, 'consulente');
insert into progetti.partecipa values ('P01', 'D03', 6, 'tecnico');
insert into progetti.partecipa values ('P01', 'D04', 24, 'responsabile');
insert into progetti.partecipa values ('P02', 'D03', 12, 'responsabile');
insert into progetti.partecipa values ('P03', 'D04', 18, 'responsabile');
insert into progetti.partecipa values ('P04', 'D02', 12, 'consulente');
insert into progetti.partecipa values ('P04', 'D03', 3, 'consulente');
insert into progetti.partecipa values ('P04', 'D04', 6, 'tecnico');
insert into progetti.partecipa values ('P04', 'D05', 12, 'responsabile');