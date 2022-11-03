drop table echipamente;
drop table sectie;
drop table angajat;
drop table ambulanta;
drop table pacient;
drop table medicamente;
drop table tratament;
drop table operatie;
drop table spital;


create table echipamente(
    id_echipamente int primary key,
    nume_echipament varchar(50) not null,
    stare varchar(20) not null,
    cantitate varchar(30) not null
);

create table sectie(
    id_sectie int primary key,
    id_echipamente int references echipamente(id_echipamente),
    nume_sectie varchar(30) not null,
    categorie_sectie varchar(20) not null,
    locatie_sectie varchar(20) not null
);

create table angajat(
    id_angajat int primary key,
    nume_angajat varchar(30) not null,
    prenume_angajat varchar(30) not null,
    data_nasterii varchar(20) not null,
    salariu varchar(10) not null,
    post varchar(30) not null,
    vechime varchar(10) not null
);

create table ambulanta(
    id_ambulanta int primary key,
    id_angajat int references angajat(id_angajat),
    destinatie varchar(30) not null
);

create table pacient(
    id_pacient int primary key,
    nume_pacient varchar(30) not null,
    prenume_pacient varchar(30) not null,
    varsta varchar(10) not null,
    boala varchar(30) not null,
    inaltime varchar(10) not null,
    greutate varchar(10) not null
);

create table medicamente(
    id_medicamente int primary key,
    id_pacient int references pacient(id_pacient),
    nume_medicament varchar(30) not null,
    pret varchar(10),
    stoc varchar(10) not null
);

create table tratament(
    id_tratament int primary key,
    id_angajat int references angajat(id_angajat),
    id_pacient int references pacient(id_pacient),
    data_inceput varchar(30) not null
);

create table operatie(
    id_operatie int primary key,
    id_angajat int references angajat(id_angajat),
    id_pacient int references pacient(id_pacient),
    costuri varchar(10) not null,
    tip_operatie varchar(20) not null,
    sala varchar(10) not null,
    data_operatie varchar(20) not null
);

create table spital(
    id_spital int primary key,
    id_sectie int references sectie(id_sectie),
    id_angajat int references angajat(id_angajat),
    adresa_spital varchar(50) not null,
    nume_spital varchar(50) not null,
    categorie_spital varchar(20) not null
);


Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (1,'pat medical','functional','5');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (2,'masa de operatie','functional','4');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (3,'computer tomograf','functional','3');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (4,'rezonanta magnetica','functional','2');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (5,'angiograf','nefunctional','1');

Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (1,1,'Casa Doru','pediatrie','aripa1');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (2,2,'Casa Andreea','psihiatrie','aripa2');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (3,3,'Casa Mihai','epidemiologie','aripa3');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (4,4,'Casa Radu','pneumonologie','aripa4');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (5,5,'Casa Dana','boli cronice','aripa5');

Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (1,'Rotaru','Alex',to_date('11-07-77','DD-mm-YY'),'2500 lei','asistent medical','2 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (2,'Mihail','David',to_date('12-04-79','DD-mm-YY'),'7000 lei','chirurg','3 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (3,'Dinulescu','Gabriela',to_date('22-03-80','DD-mm-YY'),'3500 lei','medic de garda','4 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (4,'Panduru','Manuel',to_date('25-02-85','DD-mm-YY'),'3700 lei','medic consultant','5 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (5,'Miculescu','Daria',to_date('10-05-84','DD-mm-YY'),'3300 lei','farmacist','6 ani');

Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (1,1,'Strada Morilor');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (2,2,'Strada Chiajna');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (3,3,'Strada Mugurel');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (4,4,'Strada Morilor');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (5,5,'Strada Rebreanu');

Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (1,'Sandu','Lucian',25,'scolioza',175,2000);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (2,'Manole','Radu',27,'cancer',180,85);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (3,'Dobrescu','Andrei',28,'encefalita',176,90);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (4,'Zoe','Vlad',29,'anevrism',169,60);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (5,'Primejdie','Bianca',22,'malarie',165,65);

Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (1,1,'zypsila','',200);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (2,2,'aciclovir','',150);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (3,3,'ambroxol','',250);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (4,4,'pazopanib','',300);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (5,5,'nurofen','',50);

Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (1,1,1,to_date('13-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (2,2,2,to_date('12-03-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (3,3,3,to_date('21-04-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (4,4,4,to_date('22-04-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (5,5,5,to_date('05-03-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (6,1,2,to_date('07-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (7,2,3,to_date('28-01-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (8,3,4,to_date('25-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (9,4,5,to_date('23-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (10,1,5,to_date('15-03-21','DD-mm-YY'));

Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (1,1,1,2000,'jejunostomie','sala 10',to_date('11-07-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (2,2,2,2500,'colostomie','sala 20',to_date('12-07-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (3,3,3,3300,'anostomoza','sala 30',to_date('11-08-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (4,4,4,1900,'tiroidectomie','sala 40',to_date('21-09-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (5,5,5,6000,'apendicectomie','sala 50',to_date('23-09-21','DD-mm-YY'));

Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (1,1,1,'Strada Oceanului','Spitalul Clinic Mircea cel Batran','de urgente');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (2,2,2,'Strada Boierului','Spitalul Clinic Basarab cel Tanar','pediatrie');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (3,3,3,'Strada Mijlocie','Spitalul Clinic Radu cel Frumos','psihiatrie');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (4,4,4,'Strada Tomis','Spitalul Clinic Marius Ilie','ortopedie');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (5,5,5,'Strada Renovata','Spitalul Clinic Leon Mihnea','boli infectioase');
commit;