insert into prodotti.magazzino values ('M01', 'Via Giove 14', 'Roma');
insert into prodotti.magazzino values ('M04', 'Via Venere 5', 'Cagliari');
insert into prodotti.magazzino values ('M05', 'Via Marte 27', 'Milano');
insert into prodotti.magazzino values ('M11', 'Via Saturno 67', 'Milano');
insert into prodotti.magazzino values ('M17', 'Via Plutone 34', 'Roma');
insert into prodotti.magazzino values ('M18', 'Via Marte 76', 'Cagliari');

insert into prodotti.prodotto values ('P01', 'spaghetti', 'alimentari');
insert into prodotti.prodotto values ('P06', 'biscotti', 'alimentari');
insert into prodotti.prodotto values ('P07', 'latte', 'alimentari');
insert into prodotti.prodotto values ('P11', 'camicia uomo', 'abbigliamento');
insert into prodotti.prodotto values ('P13', 'gonna', 'abbigliamento');
insert into prodotti.prodotto values ('P20', 'forno', 'elettrodomestici');
insert into prodotti.prodotto values ('P22', 'frigo', 'elettrodomestici');

insert into prodotti.inventario values ('M01', 'P06', 50, 2.00);
insert into prodotti.inventario values ('M01', 'P07', 400, 1.20);
insert into prodotti.inventario values ('M01', 'P20', 10, 450.00);
insert into prodotti.inventario values ('M04', 'P22', 20, 780.00);
insert into prodotti.inventario values ('M05', 'P22', 45, 700.00);
insert into prodotti.inventario values ('M11', 'P11', 80, 65.00);
insert into prodotti.inventario values ('M11', 'P13', 60, 85.00);
insert into prodotti.inventario values ('M11', 'P20', 15, 430.00);
insert into prodotti.inventario values ('M17', 'P01', 550, 0.75);
