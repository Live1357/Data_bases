create database firma
CREATE TABLE pracownicy
(
    nazwisko character varying(30) NOT NULL,
    imie character varying(30) NOT NULL,
    id_pracownika integer NOT NULL,
    adres character varying(50),
    telefon character(9),
    PRIMARY KEY (id_pracownika)
);
CREATE TABLE godziny
(
    id_godziny integer NOT NULL,
    "data" date NOT NULL,
    liczba_godzin int NOT NULL,
	id_pracownika int NOT NULL,
    PRIMARY KEY (id_godziny)
);
CREATE TABLE pensje
(
    id_pensji integer NOT NULL,
    stanowisko character varying(50) NOT NULL,
    kwota int NOT NULL,
	id_premii int,
    PRIMARY KEY (id_pensji)
);
CREATE TABLE premie
(
    id_premii integer NOT NULL,
    rodzaj character varying(20) NOT NULL,
    kwota int NOT NULL,
    PRIMARY KEY (id_premii)
);
ALTER TABLE public.godziny
    ADD CONSTRAINT godziny_id_pracownika_fkey FOREIGN KEY (id_pracownika)
    REFERENCES public.pracownicy (id_pracownika) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
ALTER TABLE public.pensje
    ADD CONSTRAINT pensje_id_premii_fkey FOREIGN KEY (id_premii)
    REFERENCES public.premie (id_premii) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
INSERT INTO Pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
(1,'Wojciech', 'Mann', 'ul. Stawowa 2', 666666666),
(2,'Artur', 'Grechuta', 'al. Zagłębia 13', 123456789),
(3,'Dawid', 'Kowalski', 'ul. Majowa 1', 987654321),
(4,'Dawid', 'Październik', 'ul. Styczniowa 4', 546654456),
(5,'Dawid', 'Grudzień', 'ul. Wrześniowa 6', 345543567),
(6,'Jakub', 'Talarek', 'ul. Leśnicza 7', 555666777),
(7,'Dominik', 'Talarek', 'ul. Leśnicza 7', 444555666),
(8,'Tomasz', 'Jumi', 'ul. Wsparcia 40', 790790790),
(9,'Krzysztof','Śmiały','ul. Długa 5',540670760),
(10,'Jakub','Brzechwa', 'al. Róż 4', 767789987)
INSERT INTO Godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES
(1,'2020-04-01', 8, 1),
(2,'2020-02-02',8,2),
(3,'2020-03-03',8,3),
(4,'2020-03-03',7,4),
(5,'2020-03-04',4,5),
(6,'2020-04-01',10,6),
(7,'2020-03-28',18,7),
(8,'2020-03-29',15,8),
(9,'2020-03-29',8,9),
(10,'2020-03-24',8,10)
INSERT INTO premie (id_premii, rodzaj, kwota)
VALUES
(1,'Punktualność',300),
(2,'Punktualność',350),
(3,'Premia wydajnościowa',500),
(4,'Premia wydajnościowa',550),
(5,'Premia wydajnościowa',550),
(6,'Staż pracy',600),
(7,'Staż pracy',600),
(8,'Frekwencja',200),
(9,'Brak premii',0),
(10,'Punktualność',350)
INSERT INTO pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES
(1,'Stażysta',0, 9),
(2,'Kierownik',10000,1),
(3,'Księgowa',3000,2),
(4,'Pracownik biurowy',2600,5),
(5,'Pracownik produkcyjny',3200,3),
(6,'Pracownik produkcyjny',3300,4),
(7,'Pracownik produkcyjny',3200,6),
(8,'Pracownik biurowy',2650,7),
(9,'Pracownik biurowy',2600,8),
(10,'Pracownik produkcyjny',3300,10)
