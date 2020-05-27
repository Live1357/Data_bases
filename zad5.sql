--1.
CREATE DATABASE firma;
--2.
CREATE SCHEMA ksiegowosc;
--3.
CREATE TABLE ksiegowosc.pracownicy(
	id_pracownika VARCHAR(6) PRIMARY KEY NOT NULL,
	imie VARCHAR(25),
	nazwisko VARCHAR(40) NOT NULL,
	adres VARCHAR(100) NOT NULL,
	telefon VARCHAR(15)
);
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Lista pracownikow';

CREATE TABLE ksiegowosc.godziny(
	id_godziny VARCHAR(3) PRIMARY KEY NOT NULL,
	data DATE,
	liczba_godzin SMALLINT,
	id_pracownika VARCHAR(6) REFERENCES ksiegowosc.pracownicy(id_pracownika)
);
COMMENT ON TABLE ksiegowosc.godziny IS 'Godziny';

CREATE TABLE ksiegowosc.pensja(
	id_pensji VARCHAR(3) PRIMARY KEY NOT NULL,
	stanowisko VARCHAR(40),
	kwota MONEY NOT NULL
);
COMMENT ON TABLE ksiegowosc.pensja IS 'Pensje';

CREATE TABLE ksiegowosc.premia(
	id_premii VARCHAR(3) PRIMARY KEY NOT NULL,
	rodzaj VARCHAR(40),
	kwota MONEY NOT NULL
);
COMMENT ON TABLE ksiegowosc.premia IS 'Premie';

CREATE TABLE ksiegowosc.wynagrodzenie(
	id_wynagrodzenia INT PRIMARY KEY NOT NULL,
	data DATE,
	id_pracownika VARCHAR(6) REFERENCES ksiegowosc.pracownicy(id_pracownika),
	id_godziny VARCHAR(3) REFERENCES ksiegowosc.godziny(id_godziny),
	id_pensji VARCHAR(3) REFERENCES ksiegowosc.pensja(id_pensji),
	id_premii VARCHAR(3) REFERENCES ksiegowosc.premia(id_premii)
);
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Wynagrodzenia pracownikow';

--4.
INSERT INTO ksiegowosc.pracownicy VALUES 
('e8792','Dawid','Piątek','Kraków ul. Stara 13','+48566788999'),
('e22674','Ignacy','Jakubiak','Kraków ul. Zamkowa 1','+48623623623'),
('e7356','Sonia','Radomska','Kraków ul. Stara 14','+48789243809'),
('e0999','Jan','Mazur','Kraków ul. Zapolska 7','+48666777888'),
('e423','Stanisław','Anders','Kraków ul. Wojska Polskiego 12','+48906438298'),
('e12','Jadwiga','Czubaszek','Kraków ul. Mazurska 12','+48786243908'),
('e123','Grzegorz','Kazimierski','Kraków ul. Długa 77','+48657423908'),
('e2223','Oliwia','Gabon','Kraków ul. Solna 78','+48963254081'),
('e954','Jadwiga','Kalosz','Kraków ul. Solna 12','+48234423423'),
('e45','Mariusz','Przybylski','Kraków ul. Morcinka 54','+48132132132');

INSERT INTO ksiegowosc.godziny VALUES 
('h01','2020-04-12',180,'e8792'),
('h02','2020-04-13',120,'e22674'),
('h03','2020-04-14',183,'e7356'),
('h04','2020-04-15',172,'e423'),
('h05','2020-04-16',190,'e0999'),
('h06','2020-04-17',142,'e12'),
('h07','2020-04-18',111,'e123'),
('h08','2020-04-19',210,'e2223'),
('h09','2020-04-20',180,'e954'),
('h10','2020-04-21',134,'e45');

INSERT INTO ksiegowosc.pensja VALUES 
('p01','Dyrektor',12000),
('p02','Księgowy',5500),
('p03','Księgowy',6200),
('p04','Pracownik techniczny',4200),
('p05','Sekretarka',3150),
('p06','Kucharz',3300),
('p07','Sprzątaczka',2700),
('p08','Projektant',4600),
('p09','Stażysta',1450),
('p10','Kierownik',4895);

INSERT INTO ksiegowosc.premia VALUES 
('b01','Brak',0),
('b02','Za obecnosc',400),
('b03','Za innowacyjnosc',600),
('b04','Motywacyjna',300),
('b05','Motywacyjna',400),
('b06','Za prace ponad norme',400),
('b07','Za prace ponad norme',600),
('b08','Za prace ponad norme',800),
('b09','Za wydajnosc',1100),
('b10','Roczna',500);

INSERT INTO ksiegowosc.wynagrodzenie VALUES
(1,'2020-05-10','e8792','h01','p01','b09'),
(2,'2020-05-11','e22674','h02','p02','b09'),
(3,'2020-05-14','e7356','h03','p03','b09'),
(4,'2020-05-10','e0999','h05','p04','b01'),
(5,'2020-05-18','e423','h04','p05','b04'),
(6,'2020-05-17','e12','h06','p05','b06'),
(7,'2020-05-14','e123','h07','p07','b02'),
(8,'2020-05-13','e2223','h08','p08','b03'),
(9,'2020-05-16','e954','h09','p09','b01'),
(10,'2020-05-12','e45','h10','p10','b10');

--5.
--a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;
--b
SELECT wy.id_pracownika FROM ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe 
WHERE pe.id_pensji = wy.id_pensji AND pe.kwota > MONEY(1000);
--c
SELECT wy.id_pracownika FROM ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe, ksiegowosc.premia pr
WHERE pe.id_pensji = wy.id_pensji AND pr.id_premii = wy.id_premii AND pr.kwota = MONEY(0) AND pe.kwota > MONEY(2000);
--d
SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';
--e
SELECT * FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';
--f
SELECT imie, nazwisko, liczba_godzin-160 AS nadgodziny FROM ksiegowosc.pracownicy pr, ksiegowosc.godziny godz
WHERE pr.id_pracownika = godz.id_pracownika AND liczba_godzin > 160;
--g
SELECT imie, nazwisko FROM ksiegowosc.pracownicy pr, ksiegowosc.pensja pe, ksiegowosc.wynagrodzenie wy
WHERE wy.id_pracownika = pr.id_pracownika AND wy.id_pensji = pe.id_pensji AND pe.kwota >= MONEY(1500) AND pe.kwota <= MONEY(3000);
--h
SELECT imie, nazwisko FROM ksiegowosc.pracownicy pra, ksiegowosc.godziny godz, ksiegowosc.premia pr, ksiegowosc.wynagrodzenie wy
WHERE wy.id_pracownika = pra.id_pracownika AND wy.id_godziny = godz.id_godziny AND wy.id_premii = pr.id_premii AND liczba_godzin > 160 AND pr.kwota = MONEY(0);
--i
SELECT pr.id_pracownika, imie, nazwisko, kwota FROM ksiegowosc.pracownicy pr, ksiegowosc.pensja pe, ksiegowosc.wynagrodzenie wy
WHERE wy.id_pensji = pe.id_pensji AND wy.id_pracownika = pr.id_pracownika
ORDER BY kwota;
--j
SELECT pra.id_pracownika, imie, nazwisko, pe.kwota , pr.kwota AS premia FROM ksiegowosc.pracownicy pra, ksiegowosc.pensja pe, ksiegowosc.wynagrodzenie wy, ksiegowosc.premia pr 
WHERE wy.id_pensji = pe.id_pensji AND wy.id_pracownika = pra.id_pracownika AND wy.id_premii = pr.id_premii
ORDER BY pe.kwota DESC, premia DESC;
--k
SELECT COUNT(id_pracownika) AS ilosc_pracownikow, stanowisko FROM ksiegowosc.pensja pe, ksiegowosc.wynagrodzenie wy
WHERE wy.id_pensji = pe.id_pensji
GROUP BY stanowisko;
--l
SELECT AVG(kwota::numeric)::money AS srednia_placa, MIN(kwota) AS minimalna_placa, MAX(kwota) AS maksymalna_placa FROM ksiegowosc.pensja
WHERE stanowisko = 'Kierownik';
--m
SELECT SUM(pe.kwota::numeric)::money + SUM(pr.kwota::numeric)::money AS suma_wynagrodzen FROM ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe, ksiegowosc.premia pr
WHERE wy.id_pensji = pe.id_pensji AND wy.id_premii = pr.id_premii;
--n
SELECT stanowisko, SUM(pe.kwota::numeric)::money + SUM(pr.kwota::numeric)::money AS suma_wynagrodzen FROM ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe, ksiegowosc.premia pr
WHERE wy.id_pensji = pe.id_pensji AND wy.id_premii = pr.id_premii
GROUP BY stanowisko;
--o
SELECT stanowisko, COUNT(wy.id_premii) AS liczba_premii FROM ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe, ksiegowosc.premia pr
WHERE wy.id_pensji = pe.id_pensji AND wy.id_premii = pr.id_premii AND pr.kwota != MONEY(0)
GROUP BY stanowisko
--p
--Modyfikacja lub usunięcie na tabeli "pracownicy" narusza klucz obcy "godziny_id_pracownika_fkey" tabeli "godziny", ponieważ
--klucz (id_pracownika)=(e954) ma wciąż odwołanie w tabeli "godziny".
--DELETE FROM ksiegowosc.pracownicy pr USING ksiegowosc.pensja pe, ksiegowosc.wynagrodzenie wy
--WHERE wy.id_pracownika =  pr.id_pracownika AND wy.id_pensji = pe.id_pensji AND pe.kwota < MONEY(1200);