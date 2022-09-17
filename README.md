# Rutinszerű feladatok automatizálása grafikus felhasználói felületek esetében

A számítógépek kifejlesztésének és használatának egyik fő motivációja, hogy a segítségével az automatizált módon végrehajtható folyamatok emberi beavatkozás nélkül is végrehajthatóak legyenek. Ennek ellenére számos esetben tapasztalhatjuk, hogy az alkalmazások felhasználói felületén rutinszerűen, repetitíven hajtanak végre műveleteket. A dolgozat azt vizsgálja, hogy ezek a folyamatok a korábban rögzített eseménysorok alapján hogyan ismerhetők fel. Bemutatja az RPA (Robotic Process Automation) eszközkészletét, többek között a folyamatelemzés elterjedt módszereit, alkalmazási lehetőségeit, a grafikus felhasználói felületekhez kapcsolódó speciális eseteket. Az elemzésekhez, automatizálást segítő eszköz elkészítéséhez Microsoft Windows platformon Delphi programozási nyelv kerül felhasználásra.

# Szoftverleírás

## Főmenü
### File

	1) [New flow]: Erre a gombra kattintva tudunk új folyamatot létrehozni.
	2) [Load]: Erre a gombra kattintva tudunk elmentett folyamatokat betölteni a programba.
	3) [Save]: Felépített folyamatot tudunk elmenteni állományba, majd később ezt betölteni, vagy időzíteni (lásd: lejjebb).
		
### Themes
	Itt tudunk változtatni a program megjelenésén. A következő indításnál ezt fogja betölteni.
### Input Type
	Lásd: lejjebb
### Schedule
	Ezen menüpont alatt 2 dolgot tudunk beállítani.
		- A fenti két sorban tudjuk állítani, hogy a folyamat panelen lévő folyamat hányszor fusson le, illetve azt, hogy mennyit várakozzon 1-1 futás között.
		- A “Schedule saved flow” címszó alatt tudunk valóban időzíteni egy folyamatot az alábbiak szerint:
			• Az 1. sorban a “Browse” gombbal tudunk kiválasztani folyamatot.
			• A 2. sorban tudjuk beállítani azt, hogy milyen gyakorisággal induljon el a kiválasztott folyamat.
			• A 3. sorban finom hangolni tudjuk a 2. sorban meghatározott értéket.
			• A 3. sorban lévő “Időzítés” gombra kattintva tudjuk élesíteni a folyamatot.
	
	Hasznos tudnivaló:
			• Hogyha egyszer már bekapcsoltunk egy időzítést, azt kizárólag a Windowsnak a “Task Scheduler” (feladatütemező) moduljából tudjuk kikapcsolni, hiszen ide kerül beírásra.
### About
	Készítői információ
	
## Beviteli felületek
	[Start Flow]: Minden beviteli felületnél középen található ez a gomb, ezzel tudjunk elindítani a folyamatot. Hogyha egyszer elindítottuk, ugyanezzel a gombbal tudjuk leállítani.
	[Add]: Ezzel a gombbal tudunk hozzáadni új lépéseket a folyamatunkhoz.
	[Wait]: Itt tudjuk beállítani, hogy egy adott lépés után mennyi szünetet tartson a program mielőtt a következőre halad.
		
	[Mouse]:
		- Bal oldalt a „Cursor X” és „Cursor Y” feliratok melletti szövegdobozba tudjuk beírni, hogy a képernyőn melyik pixelre helyeződjön el a következő lépésben a kurzor.
			- Ezt a jobb oldalt található “Start Recording” gomb használatával is elérhetjük (Gyorsbillentyűje: R)
		- Az “Mouse Button” felirat mellett tudjuk kiválasztani, hogy melyik egérgombbal legyen a kattintás szimulációja.
		- A ”Click Type” felirat mellett tudjuk pontosítani, hogy valójában milyen kattintásra is van szükségünk.	
	
	[Keyboard Input]:
		- A “Start flow” gomb alatti szövegdobozba tudjuk beírni a kívánt szöveget.
		- “Special keys” gomb
			- Itt tudunk speciális billentyűket, billentyű-kombinációkat megadni a programnak, hogy majd hajtsa végre őket. Hogyha bepipáljuk az "Add Extra key" dobozt, akkor az amelletti szövegdobozba beírt karaktert is hozzáveszi az utasításhoz. (Például így tudunk CTRL+C parancsot kiadni)
	
	[Start / Stop Recording Input]:
		- Ezzel tudjuk elindítani a felhasználó által bevitt inputok rögzítését, majd ezek alapján generálni a folyamatot.
	
## Flow panel
	- A programon fent látjuk ezt, hogyha megadtunk lépéseket. Ezen helyezkednek el az egyes lépések, valamint a hozzájuk tartozó információk.
	- Billentyűzet bevitelnél, hogyha túl hosszú szöveget adunk meg, akkor az nem feltétlenül fér ki az egyes lépésekre, ezt egy csillag jelzi nekünk a lépésnél. Hogyha rávisszük a kurzort, akkor látjuk, hogy valójában milyen szöveget is fog szimulálni a program.
	- A lépéseket az egyes “Delete” gombokra kattintva tudjuk törölni.
	- Drag and Drop stílusban fel tudjuk cserélni a lépések sorrendjét.

## Egyéb információ
	1) Billentyű bevitelnél kizárólag azokat tudja szimulálni a program, amik a jelenlegi billentyűzet kiosztáson szerepelnek (például angol billentyűzet kiosztáson nem tudunk ékezetes karaktereket bevinni).
	2) A folyamatnak a futását akármikor meg tudjuk szakítani az F2 + F3 gombok egyidejű lenyomásával.
	3) Programindításnál az első paraméter mentett állományként töltődik be
