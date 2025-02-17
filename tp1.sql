DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS enseignement;
DROP TABLE IF EXISTS enseignant;
DROP TABLE IF EXISTS etudiant;
DROP TABLE IF EXISTS salle;
DROP TABLE IF EXISTS departement;
create table departement(
departement_id integer ,
nom_departement varchar(25)unique,
constraint PK_departement primary key (departement_id)
);
create table enseignant(
enseignant_id integer ,
departement_id integer not null,
nom varchar(25) default null,
prenom varchar(25) default null,
grade varchar(25) default null,
telephone varchar(10)default null,
fax varchar(10) default null,
email varchar(100) default null,
constraint PK_enseignant primary key (enseignant_id),
constraint FK_departement_id foreign key (departement_id) references departement(departement_id)
on update restrict on delete restrict ,
constraint CK_check_grade check(grade in ('Vacataire','Moniteur','ATER','MCF','PROF'))
);
create table enseignement(
enseignement_id integer,
departement_id integer,
intitule varchar(60),
description varchar(1000),
constraint PK_enseignement primary key (enseignement_id,departement_id),
constraint FK_departement_id_enseignement foreign key (departement_id) references departement(departement_id)
on update restrict on delete restrict 
);
create table etudiant(
etudiant_id integer,
nom varchar(25) not null,
prenom varchar(25) not null,
date_naissance date not null,
adresse varchar(50) default null,
ville varchar(25) default null,
code_postal varchar(9) default null,
telephone varchar(10) default null,
fax varchar (10) default null,
email varchar(100) default null,
constraint PK_etudiant primary key (etudiant_id)
);
create table salle(
batiment varchar(1),
numero_salle varchar(10),
capacity integer,
constraint PK_salle primary key (batiment,numero_salle),
constraint CK_check_capacite check (capacity>10)
);
create table reservation(
reservation_id integer,
batiment varchar(1) not null,
numero_salle varchar(10) not null,
enseignement_id integer not null,
departement_id integer not null,
enseignant_id integer not null,
date_resa date not null default (current_date),
heure_debut time not null default (current_time),
heure_fin time not null default '23:00:00',
nombre_heures integer not null,
constraint PK_reservation primary key (reservation_id),
constraint FK_reservation_salle foreign key (batiment,numero_salle)references salle(batiment,numero_salle)
on update restrict on delete restrict,
constraint FK_reservation_enseignement foreign key (enseignement_id,departement_id) references enseignement(enseignement_id,departement_id)
on update restrict on delete restrict,
constraint FK_reservation_enseignant foreign key (enseignant_id) references enseignant(enseignant_id)
on update restrict on delete restrict,
constraint CK_reservation_nombre_heures check(nombre_heures >=1),
constraint CK_reservation_heures_debfin check(heure_debut<heure_fin)
);

INSERT INTO Departement VALUES ('1','IRT'); 
INSERT INTO Departement VALUES ('2','IGL'); 
INSERT INTO Departement VALUES ('3','ILA'); 
 
 
INSERT INTO Etudiant VALUES ("1","ben foulen","foulen","1979/02/18","50, 
Rue des alouettes","TUNIS","75021","0143567890",NULL,"foulen@gmail.com"); 
 
INSERT INTO Etudiant VALUES ("2","tounsi","ahmed","1980/08/23","10, Avenue 
des marguerites","bardo","40000","0678567801",NULL,"pat@yahoo.fr"); 
 
INSERT INTO Etudiant VALUES ("3","tounsi", "Jamal","1978/05/12","25, 
Boulevard des 
fleurs","TUNIS","75022","0145678956","0145678956","odent@free.fr"); 
 
INSERT INTO Etudiant VALUES ("4","benmard","ahmed","1979/07/15","56, 
Boulevard des 
fleurs","TUNIS","75022","0678905645",NULL,"deby@hotmail.com"); 
INSERT INTO Etudiant VALUES ("5","foulana", "tounsia","1979/08/15","45, 
Avenue des abeilles","ariana","75022",NULL,NULL,NULL); 
 
INSERT INTO Enseignant 
VALUES("1","1","ousteith","ouahed","MCF","4185","4091","ousteith@gmail.com" 
); 
INSERT INTO Enseignant 
VALUES("2","1","ousteitha","wahida","PROF",NULL,NULL,"wahida@gmail.com"); 
 
 
INSERT INTO Salle VALUES("B","020","15"); 
INSERT INTO Salle VALUES("B","022","15"); 
INSERT INTO Salle VALUES("A","301","45"); 
INSERT INTO Salle VALUES("C","Amphi 8","500"); 
INSERT INTO Salle VALUES("C","Amphi 4","200"); 
 
INSERT INTO Enseignement VALUES ("1","1","Bases de Données 
Relationnelles","Niveau Licence (L3) : Modélisation E/A et UML, Modèle 
relationnel, Algèbre Relationnelle, Calcul relationel, SQL, dépendances 
fonctionnelles et formes normales"); 
INSERT INTO Enseignement VALUES ("2","1","Langage C++","Niveau Master 1"); 
INSERT INTO Enseignement VALUES ("3","1","Mise à Niveau Bases de 
Données","Niveau Master 2 - Programme Licence et Master 1 en Bases de 
Données"); 
 
INSERT INTO Reservation VALUES 
("1","B","022","1","1","1","2008/10/15","08:30:00","11:45:00","3"); 
INSERT INTO Reservation VALUES 
("2","B","022","1","1","2","2008/11/04","08:30:00","11:45:00","3"); 
INSERT INTO Reservation VALUES 
("3","B","022","1","1","2","2008/11/07","08:30:00","11:45:00","3"); 
INSERT INTO Reservation VALUES 
("4","B","020","1","1","1","2008/10/15","08:30:00","11:45:00","3"); 

SELECT nom, prenom
FROM etudiant;
SELECT nom, prenom
FROM etudiant
WHERE ville = 'TUNIS'
UNION
SELECT nom, prenom
FROM etudiant
WHERE ville = 'SFAX';

SELECT nom, prenom
FROM etudiant
WHERE nom LIKE 't%'
UNION
SELECT nom, prenom
FROM etudiant
WHERE nom LIKE 'f%';

SELECT nom, prenom
FROM enseignant
WHERE nom LIKE '%a_';

SELECT d.nom_departement, e.nom, e.prenom
FROM enseignant e
JOIN departement d ON e.departement_id = d.departement_id
ORDER BY d.nom_departement, e.nom, e.prenom;

SELECT COUNT(*) as nombre_moniteurs
FROM enseignant
WHERE grade = 'Moniteur';
SELECT nom, prenom
FROM etudiant
WHERE fax IS NULL;

SELECT intitule
FROM enseignement
WHERE description LIKE '%SQL%' OR description LIKE '%Licence%';

SELECT AVG(capacity) as capacite_moyenne, MAX(capacity) as capacite_maximum
FROM salle;
SELECT batiment, numero_salle, capacity
FROM salle
WHERE capacity < (SELECT AVG(capacity) FROM salle);
SELECT ville, nom, prenom
FROM etudiant
ORDER BY ville, nom, prenom;
