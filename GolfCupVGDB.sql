#Databassystem - SQL Uppgift [Lexicon.Net] Mattias Gustafsson

drop database GolfCupVGDB;
create database GolfCupVGDB;
use GolfCupVGDB;

create table Spelare(
	PersonNr char(13),
    Namn varchar(20),
    Ålder tinyint,
    primary key(PersonNr)
)engine=innodb;

create table Tävling(
	Tävlingsnamn varchar(20),
    Datum date,
    primary key(Tävlingsnamn)
)engine=Innodb;
    
create table Konstruktion(
	SerialNr char(10),
    Hårdhet tinyint,
    primary key(SerialNr)
)engine=Innodb;

create table Väder(
	Typ varchar(15),
    Vindstyrka float(3),
    primary key(Typ)
)engine=Innodb;

create table Jacka(
	Märke varchar(15),
    Storlek char(3),
    Material varchar(15),
    PersonNr char(13),
    primary key(PersonNr, Märke),
    foreign key(PersonNr) references Spelare(PersonNr) On Delete Cascade
 )engine=Innodb;
 
create table Klubba(
	Nr tinyint,
    Material varchar(15),
    PersonNr char(15),
    SerialNr char(10),
    primary key(PersonNr, Nr),
 	foreign key(PersonNr) references Spelare(PersonNr) On Delete Cascade,
    foreign key(SerialNr) references Konstruktion(SerialNr)
)engine=Innodb;

create table Delta(
	Tävlingsnamn varchar(20),
    PersonNr char(13),
    primary key(Tävlingsnamn, PersonNr),
    foreign key(Tävlingsnamn) references Tävling(Tävlingsnamn),
    foreign key(PersonNr) references Spelare(PersonNr) On Delete Cascade
)engine=Innodb;

create table HarVäder(
	Typ varchar(15),
    Tävlingsnamn varchar(25),
    primary key(Typ, Tävlingsnamn),
    foreign key(Typ) references Väder(Typ),
    foreign key(Tävlingsnamn) references Tävling(Tävlingsnamn)
)engine=Innodb;

#Insert Spelare
Insert into Spelare (PersonNr, Namn, Ålder)
Values ('19990101-1111', 'Johan Andersson', '25');

Insert into Spelare (PersonNr, Namn, Ålder)
Values ('19990101-2222', 'Nicklas Jansson', '35');

Insert into Spelare (PersonNr, Namn, Ålder)
Values ('19990101-3333', 'Annika Persson', '20');

Insert into Spelare (PersonNr, Namn, Ålder)
Values ('19990101-4444', 'Lars Svensson', '49');

#Insert Tävling
Insert into Tävling (Tävlingsnamn, Datum)
Values ('Big Golf Cup Skövde', '2021-06-10');

Insert into Tävling (Tävlingsnamn, Datum)
Values ('Sweden Golf Tour 22', '2022-01-11');

#Insert Väder
Insert into Väder (Typ, Vindstyrka)
Values ('Hagel', '10');

Insert into Väder (Typ, Vindstyrka)
Values ('Regn', '15.5');

#Insert HarVäder
Insert into HarVäder (Typ, Tävlingsnamn)
Values ('Hagel', 'Big Golf Cup Skövde');

Insert into HarVäder (Typ, Tävlingsnamn)
Values ('Regn', 'Sweden Golf Tour 22');

#Insert Delta
Insert into Delta (Tävlingsnamn, PersonNr)
Values ('Big Golf Cup Skövde', '19990101-1111');

Insert into Delta (Tävlingsnamn, PersonNr)
Values ('Big Golf Cup Skövde', '19990101-2222');

Insert into Delta (Tävlingsnamn, PersonNr)
Values ('Big Golf Cup Skövde', '19990101-3333');

Insert into Delta (Tävlingsnamn, PersonNr)
Values ('Big Golf Cup Skövde', '19990101-4444');

Insert into Delta (Tävlingsnamn, PersonNr)
Values ('Sweden Golf Tour 22', '19990101-4444');

#Insert Jacka
Insert into Jacka (Märke, Storlek, Material, PersonNr)
Values ('GolfPro', 'M', 'Fleece', '19990101-1111');

Insert into Jacka (Märke, Storlek, Material, PersonNr)
Values ('TexFlex', 'M', 'GoreTex', '19990101-1111');

Insert into Jacka (Märke, Storlek, Material, PersonNr)
Values ('GolfHero', 'S', 'Bomull', '19990101-3333');

Insert into Jacka (Märke, Storlek, Material, PersonNr)
Values ('MR GolfMan', 'XXL', 'Polyester', '19990101-4444');

#Insert Konstruktion
Insert into Konstruktion (SerialNr, Hårdhet)
Values ('1111111111', '5');

Insert into Konstruktion (SerialNr, Hårdhet)
Values ('2222222222', '10');

Insert into Konstruktion (SerialNr, Hårdhet)
Values ('3333333333', '7');

#Insert Klubba
Insert Into Klubba (Nr, Material, PersonNr, SerialNr)
Values ('1', 'Trä', '19990101-2222', '2222222222'); 

Insert Into Klubba (Nr, Material, PersonNr, SerialNr)
Values ('2', 'Trä', '19990101-3333', '1111111111'); 

Insert Into Klubba (Nr, Material, PersonNr, SerialNr)
Values ('3', 'Järn', '19990101-1111', '1111111111');

Insert Into Klubba (Nr, Material, PersonNr, SerialNr)
Values ('4', 'Järn', '19990101-4444', '3333333333');

#Operation 1
Select Ålder From Spelare Where Namn = 'Johan Andersson';

#Operation 2
Select Datum From Tävling Where Tävlingsnamn = 'Big Golf Cup SKövde';

#Operation 3
Select Material From Klubba Where PersonNr In (Select PersonNr From Spelare Where Namn = 'Johan Andersson');

#Operation 4
Select * From Jacka Where PersonNr in (Select PersonNr From Spelare Where Namn = 'Johan Andersson');

#Operation 5
Select * From Spelare Where PersonNr In (Select PersonNr From Delta Where TävlingsNamn = 'Big Golf Cup Skövde');

#Operation 6
Select Vindstyrka From Väder Where Typ In (Select Typ From HarVäder Where Tävlingsnamn = 'Big Golf Cup Skövde');

#Operation 7
Select * From Spelare Where Ålder < 30;

#Operation 8
Delete From Jacka Where PersonNr In (Select PersonNr From Spelare Where Namn = 'Johan Andersson');

#Operation 9
SET SQL_SAFE_UPDATES = 0; #Disable safe mode
Delete From Spelare Where Namn = 'Nicklas Jansson';
SET SQL_SAFE_UPDATES = 1; #Enable safe mode

#Operation 10
SELECT AVG(Ålder) AS MedelÅlder FROM Spelare;