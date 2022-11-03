--ex11
--operatia join pe cel putin 4 tabele (pentru cele 4 entitati medicamente->pacient->tratament->angajat)

select *
from medicamente m
left join pacient p on m.id_pacient = p.id_pacient
left join tratament t on t.id_pacient = p.id_pacient --tratament are 10 inregistrari pentru ca este tabel asociativ
left join angajat a on a.id_angajat = t.id_angajat;

--filtrare la nivel de linii (pentru pacientii cu varsta mai mare de 24)
select p.nume_pacient,p.prenume_pacient,p.varsta,p.boala,p.inaltime,p.greutate
from pacient p
where varsta > 24;


--subcerere sincronizata in care intervin cel putin 3 tabele
select * from pacient p where id_pacient in (select id_pacient from operatie where costuri=p.greutate);



--subcerere nesincronizata in care intervin cel putin 3 tabele
select * from spital where id_sectie in (select id_sectie from sectie where id_echipamente in ( select id_echipamente from echipamente where stare = 'functional'));



--grupari de date + filtrare la nivel de grupuri 
select count(id_ambulanta), destinatie from ambulanta group by destinatie having count(id_ambulanta)>1;--afiseaza numarul de ambulante cu aceeasi destinatie


--functii grup+ordonari (in functie de costuri)
select * from operatie order by costuri;


--2 functii pe siruri de caractere
select lower(nume_angajat)from angajat;--functia numarul 1
select length(tip_operatie)from operatie;--functia numarul 2


--2 functii pe date calendaristice
select sysdate from dual;--functia numarul 1
select round(sysdate, 'month') from dual;--functia numarul 2


--2 functii NVL
select nvl(salariu,0) from angajat ;--atributul "salariu" este not null, deci va afisa prima expresie
select nvl(pret,'fara pret') from medicamente;--atributul "pret" este null, deci va afisa a doua expresie


--functia DECODE
select decode(175, 175, 'operatie a avut succes') from pacient;


--expresia CASE
select id_pacient, inaltime,
case
    when inaltime > 170 then 'Inaltimea pacientului este mai mare de 170'
    when inaltime < 170 then 'Inaltimea pacientului este mai mica de 170'
    else 'The quantity is under 30'
end as rezultat
from pacient;


--clauza WITH  
WITH tabel(medie) as
(SELECT avg(greutate)
from pacient) 
SELECT *
FROM  pacient,tabel
WHERE pacient.greutate>tabel.medie;--afiseam id-urile pentru atributele de greutate care sunt mai mari decat media lor



--ex12. Implementarea a 3 operatii de actualizare sau suprimare a datelor utilizand subcereri
update pacient p
set p.nume_pacient=
(select nume_medicament from medicamente m where p.id_pacient=m.id_pacient);--afisam nume_medicament (din Medicamente) in nume_pacient (din Pacient)
select * from pacient;

update sectie s
set s.locatie_sectie=
(select adresa_spital from spital s2 where s.id_sectie=s2.id_sectie);--afisam coloana adresa_spital (din Spital) in coloana locatie_sectie(din Sectie)
select * from sectie;

update  angajat a
set a.post=
(select destinatie from ambulanta a1 where a.id_angajat=a1.id_angajat);--afisam coloana destinatie ( din ambulanta) in post ( din angajat)
select * from angajat;



--ex13. Crearea unei secvente ce va fi utilizata in inserarea inregistrarilor in tabele
CREATE SEQUENCE echipamente_1
start with 1
increment by 1;
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (echipamente_1.nextval,'pat medical','functional','5');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (echipamente_1.nextval,'masa de operatie','functional','4');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (echipamente_1.nextval,'computer tomograf','functional','3');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (echipamente_1.nextval,'rezonanta magnetica','functional','2');
Insert into echipamente (id_echipamente, nume_echipament, stare, cantitate) values (echipamente_1.nextval,'angiograf','nefunctional','1');

CREATE SEQUENCE sectie_1
start with 1
increment by 1;
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (sectie_1.nextval,1,'Casa Doru','pediatrie','aripa1');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (sectie_1.nextval,2,'Casa Andreea','psihiatrie','aripa2');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (sectie_1.nextval,3,'Casa Mihai','epidemiologie','aripa3');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (sectie_1.nextval,4,'Casa Radu','pneumonologie','aripa4');
Insert into sectie (id_sectie, id_echipamente, nume_sectie, categorie_sectie, locatie_sectie) values (sectie_1.nextval,5,'Casa Dana','boli cronice','aripa5');

CREATE SEQUENCE angajat_1
start with 1
increment by 1;
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (angajat_1.nextval,'Rotaru','Alex',to_date('11-07-77','DD-mm-YY'),'2500 lei','asistent medical','2 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (angajat_1.nextval,'Mihail','David',to_date('12-04-79','DD-mm-YY'),'7000 lei','chirurg','3 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (angajat_1.nextval,'Dinulescu','Gabriela',to_date('22-03-80','DD-mm-YY'),'3500 lei','medic de garda','4 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (angajat_1.nextval,'Panduru','Manuel',to_date('25-02-85','DD-mm-YY'),'3700 lei','medic consultant','5 ani');
Insert into angajat (id_angajat, nume_angajat, prenume_angajat, data_nasterii, salariu, post, vechime) values (angajat_1.nextval,'Miculescu','Daria',to_date('10-05-84','DD-mm-YY'),'3300 lei','farmacist','6 ani');

CREATE SEQUENCE ambulanta_1
start with 1
increment by 1;
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (ambulanta_1.nextval,1,'Strada Morilor');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (ambulanta_1.nextval,2,'Strada Chiajna');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (ambulanta_1.nextval,3,'Strada Mugurel');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (ambulanta_1.nextval,4,'Strada Morilor');
Insert into ambulanta (id_ambulanta, id_angajat, destinatie) values (ambulanta_1.nextval,5,'Strada Rebreanu');

CREATE SEQUENCE pacient_1
start with 1
increment by 1;
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (pacient_1.nextval,'Sandu','Lucian',25,'scolioza',175,2000);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (pacient_1.nextval,'Manole','Radu',27,'cancer',180,85);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (pacient_1.nextval,'Dobrescu','Andrei',28,'encefalita',176,90);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (pacient_1.nextval,'Zoe','Vlad',29,'anevrism',169,60);
Insert into pacient (id_pacient, nume_pacient, prenume_pacient, varsta, boala, inaltime, greutate) values (pacient_1.nextval,'Primejdie','Bianca',22,'malarie',165,65);

CREATE SEQUENCE medicamente_1
start with 1
increment by 1;
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (medicamente_1.nextval,1,'zypsila','',200);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (medicamente_1.nextval,2,'aciclovir','',150);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (medicamente_1.nextval,3,'ambroxol','',250);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (medicamente_1.nextval,4,'pazopanib','',300);
Insert into medicamente (id_medicamente, id_pacient, nume_medicament, pret, stoc) values (medicamente_1.nextval,5,'nurofen','',50);

CREATE SEQUENCE tratament_1
start with 1
increment by 1;
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,1,1,to_date('13-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,2,2,to_date('12-03-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,3,3,to_date('21-04-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,4,4,to_date('22-04-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,5,5,to_date('05-03-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,1,2,to_date('07-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,2,3,to_date('28-01-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,3,4,to_date('25-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,4,5,to_date('23-02-21','DD-mm-YY'));
Insert into tratament (id_tratament, id_angajat, id_pacient, data_inceput) values (tratament_1.nextval,1,5,to_date('15-03-21','DD-mm-YY'));

CREATE SEQUENCE operatie_1
start with 1
increment by 1;
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (operatie_1.nextval,1,1,2000,'jejunostomie','sala 10',to_date('11-07-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (operatie_1.nextval,2,2,2500,'colostomie','sala 20',to_date('12-07-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (operatie_1.nextval,3,3,3300,'anostomoza','sala 30',to_date('11-08-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (operatie_1.nextval,4,4,1900,'tiroidectomie','sala 40',to_date('21-09-21','DD-mm-YY'));
Insert into operatie (id_operatie, id_angajat, id_pacient, costuri, tip_operatie, sala, data_operatie) values (operatie_1.nextval,5,5,6000,'apendicectomie','sala 50',to_date('23-09-21','DD-mm-YY'));

CREATE SEQUENCE spital_1
start with 1
increment by 1;
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (spital_1.nextval,1,1,'Strada Oceanului','Spitalul Clinic Mircea cel Batran','de urgente');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (spital_1.nextval,2,2,'Strada Boierului','Spitalul Clinic Basarab cel Tanar','pediatrie');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (spital_1.nextval,3,3,'Strada Mijlocie','Spitalul Clinic Radu cel Frumos','psihiatrie');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (spital_1.nextval,4,4,'Strada Tomis','Spitalul Clinic Marius Ilie','ortopedie');
Insert into spital (id_spital, id_sectie, id_angajat, adresa_spital, nume_spital, categorie_spital) values (spital_1.nextval,5,5,'Strada Renovata','Spitalul Clinic Leon Mihnea','boli infectioase');
commit;


--ex14. Crearea unei vizualizari compuse. Exemplu de operatie LMD permisa pe vizualiare si o operatie LMD nepermisa pe vizualiare.
--operatie LMD permisa pe view
create or replace view spital_mare as
select p.id_pacient ID, p.nume_pacient NUME_PACIENT, p.varsta VARSTA, p.boala BOALA, p.inaltime INALTIME, p.greutate GREUTATE
from pacient p join medicamente m on (m.id_pacient=p.id_pacient);

--operatie LMD nepermisa pe view
create or replace view spital_maree as
select id_pacient ID, nume_pacient NUME_PACIENT, varsta VARSTA, boala BOALA, inaltime INALTIME, greutate GREUTATE
from pacient
group by inaltime;--va afisa eroare

-
--ex15. Crearea unui index care sa optimizeze o cerere de tip cautare cu 2 criterii. Specificati cererea.
create index pacientq
on pacient(inaltime, greutate);
select count(*) from pacient where inaltime >50 and inaltime < 500;


--ex16. Formulati in limbaj natural si implementati o cerere ce utilizeaza operatia outer-join si doua cereri ce utilizeaza operatia division
select *
from medicamente m
full outer join pacient p on m.id_pacient = p.id_pacient
full outer join tratament t on t.id_pacient = p.id_pacient
full outer join angajat a on a.id_angajat = t.id_angajat
order by id_medicamente;
select id_pacient from pacient minus select id_pacient from medicamente;--afiseaza medicamentele pe care nu le ia pacientul (in cazul acesta, nu avem)
select id_echipamente from echipamente minus select id_echipamente from sectie;--afiseaza echipamentele care nu se afla in sectie(in cazul acesta, nu avem)