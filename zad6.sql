--a	Przy dodawaniu rekordów zawarłem +48 przy numerze telefonu, więc uzupełniam o nawiasy
UPDATE ksiegowosc.pracownicy pr SET telefon = '(' || SUBSTRING(pr.telefon,1,3) || ')' || SUBSTRING(pr.telefon,4,9);
--b	Nie jest możliwe dodanie myślników, ponieważ numer przekroczy określony rozmiar atrybutu telefon. W celu rozwiązania tego problemu rozszerzam go z 15 do 16 znaków.
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon TYPE character varying(16);
UPDATE ksiegowosc.pracownicy pr SET telefon = SUBSTRING(pr.telefon,1,8) || '-' || SUBSTRING(pr.telefon,9,3) || '-' || SUBSTRING(pr.telefon,12,3)
--c
SELECT id_pracownika, UPPER(imie) AS imie, UPPER(nazwisko) AS nazwisko, UPPER(adres) AS adres, telefon FROM ksiegowosc.pracownicy pr
WHERE LENGTH(nazwisko) = (SELECT MAX(LENGTH(nazwisko)) FROM ksiegowosc.pracownicy)
--d
SELECT pr.*, MD5(kwota::VARCHAR(32)) AS pensja FROM ksiegowosc.pracownicy pr, ksiegowosc.wynagrodzenie wy, ksiegowosc.pensja pe
WHERE wy.id_pracownika = pr.id_pracownika AND wy.id_pensji = pe.id_pensji;
--e
SELECT pra.imie, pra.nazwisko, pe.kwota AS pensja, pr.kwota AS premia FROM ksiegowosc.wynagrodzenie wy
LEFT JOIN ksiegowosc.pracownicy pra ON wy.id_pracownika = pra.id_pracownika
LEFT JOIN ksiegowosc.pensja pe ON wy.id_pensji = pe.id_pensji
LEFT JOIN ksiegowosc.premia pr ON wy.id_premii = pr.id_premii;
--f
SELECT CONCAT('Pracownik ', pra.imie, ' ', pra.nazwisko, ', w dniu ', SUBSTRING(wy.data::VARCHAR(15),9,2), '.', 
SUBSTRING(wy.data::VARCHAR(15),6,2), '.', SUBSTRING(wy.data::VARCHAR(15),1,4),' otrzymał pensję całkowitą na kwotę ', (pe.kwota + pr.kwota),
', gdzie wynagrodzenie zasadnicze wynosiło: ', pe.kwota, ', premia: ', pr.kwota, ', nadgodziny: ', 
CASE WHEN godz.liczba_godzin > 160 THEN godz.liczba_godzin-160 ELSE 0 END) AS Raport
FROM ksiegowosc.wynagrodzenie wy, ksiegowosc.pracownicy pra, ksiegowosc.pensja pe, ksiegowosc.premia pr, ksiegowosc.godziny godz
WHERE wy.id_pracownika = pra.id_pracownika AND wy.id_godziny = godz.id_godziny AND wy.id_pensji = pe.id_pensji AND wy.id_premii = pr.id_premii;



