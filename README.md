# FS19_HelperAdvanced
![HelperAdvanced Logo](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/logo_HelperAdvanced.png "HelperAdvanced Logo")

Helfer sind immer da, Helfer sind unpersönlich, Helfer springen wenn man es will ... ok, letzteres ändere ich nicht :lool:
Aber grundsätzlich sind das die Helfer von GIANTS.

Mit den Erweiterten Helfern ändert sich das allerdings grundlegend.
Helfer haben von jetzt an Namen und müssen erst eingestellt werden damit sie für dich arbeiten können. Wenn ein Helfer eingestellt ist zahlst du Lohn für diesen Helfer, ob du ihn zur Arbeit schickst oder nicht spielt da keine Rolle, der Grundlohn muß trotzdem entrichtet werden. Schickst du ihn zur Arbeit bekommt er für diese Arbeit die er ausführt nochmal etwas auf den Grundlohn drauf gezahlt.
Aber das ist jetzt noch nicht alles, die Helfer sind grundsätzlich erstmal keine Experten auf dem Feld (gut das waren sie bei GIANTS noch nie) sondern sie müssen lernen. Sie bringen eventuell ein paar Fähigkeiten mit aber sind noch lange nicht perfekt. Für jede Tätigkeit die ein Helfer ausführen kann ist es auch möglich für den Helfer Erfahrung zu erlangen und somit besser zu werden.

#### Was das jetzt im Einzelnen heißt?
Ein Helfer der 0 (wortwörtlich NULL) Erfahrung hat fährt bedeutend langsamer beim Arbeiten als ihr und er verbraucht mehr Kraftstoff als ihr für die gleiche Arbeit, er kassiert dafür aber natürlich nur seinen Fähigkeiten entsprechend Lohn. Mit steigender Erfahrung wird der Helfer schneller und verbraucht weniger Kraftstoff, das geht soweit das ein Helfer der 100% Grunderfahrung hat und 100% Erfahrung in der Arbeit die er ausführen soll sogar schneller und Ertragreicher bzw Sparsamer arbeitet als ihr. Es lohnt sich also Helfer zu spezialisieren.

#### Nochwas zum Lohn:
Der Lohn berechnet sich nicht wie bei GIANTS Hinterhofabrechnung für Kindergärten, der Lohn den der Helfer kassiert wird pro Stunde gezahlt, und ich meine nicht Realzeit sondern Spielzeit, also wenn ihr schnell Geld an den Helfer übertragen wollt dann dreht doch ruhig auf 120fache Zeitbeschleunigung, 60€ sind 60€ pro Stunde, egal ob Echtzeit oder 120fach ... nochmal: ich bin NICHT GIANTS! Und der Grundlohn wird für jeden eingestellten Helfer gezahlt egal ob er was tut!
Normale Arbeitszeiten des Helfers sind 06:00 bis 20:00 Uhr Montag bis Freitag, muß er zu anderen Zeiten Arbeiten erhöht sich die Lohnzahlung um 30%.

Ach ja, entlassen werden kann ein Helfer frühestens 7 Tage nach der Einstellung, also überlegt euch ob ihr Helfer einstellt die ihr eigentlich nur mal für ein Feld braucht und danach nicht, dann macht es lieber selber.

#### Wie funktioniert es?
Eigentlich so wie immer, ihr setzt euch in ein Fahrzeug und aktiviert den Helfer, danach erscheint ein Menü und ihr könnt einen Helfer auswählen den ihr einstellt, oder sofern schon einer eingestellt wurde, diesen Auswählen und zuweisen, danach startet er seine Arbeit.
Ihr könnt euch auch außerhalb eines Fahrzeuges über die Helfer informieren wenn ihr die __Numpad *__ Taste drückt, dann öffnet sich das Helfermenü.
Hattet ihr einem Fahrzeug einmal einen Helfer zugewiesen merkt sich das Fahrzeug (ja klingt komisch, ist aber so) welcher Helfer auf ihm gefahren ist, startet ihr also nochmals die Helferauswahl im Fahrzeug braucht ihr diesen nicht mehr auszuwählen sondern nur noch auf "Helfer auswählen" klicken und der letzte Helfer des Fahrzeuges wird wieder auf dieses Aufsteigen, vorausgesetzt das der Helfer auch noch frei ist und nicht bereits auf einem anderen Fahrzeug unterwegs ist.

#### Courseplay, FollowMe und Autodrive
Besonderheiten gibt es bei Courseplay, FollowMe und Autodrive, diese Mods arbeiten etwas anders (Courseplay ist dabei sogar anfälliger da es nicht die vorhandenen Helfer überprüft sondern einfach voraussetzt das welche da sind!) und deshalb gibt es dort eine etwas andere Regelung:
Die Helfer für Courseplay, FollowMe und Autodrive können nicht selbst gewählt werden, sie werden aus dem vorhandenen Helferpool automatisch ausgewählt.
Sind keine weiteren Helfer eingestellt werden für diese beiden Mods automatisch neue Helfer eingestellt. Dies ist in sofern interessant wenn man wirtschaftlich arbeiten will, denn auch für diese automatisch eingestellten Helfer gilt die 7 Tage Mindestbeschäftigung, ihr könnt sie also nicht einfach wieder entlassen. Prüft also vorher ob ihr nicht lieber woanders einen Helfer abziehen wollt, es kostet jeder Helfer der eingestellt ist Geld, nicht vergessen!
Des weiteren werden Courseplay, FollowMe und Autodrive nicht nach der Eignung der Helfer fragen sondern zufällig einen aus der Arbeitslosenliste auswählen, auch wenn der noch gar nichts kann, das spielt für die automatische Einstellung keine Rolle!

#### Die HUD Anzeige
Die HUD-Anzeige ist von den Grafiken her komplett überarbeitbar, dies betrifft auch die Textfarben.
Damit dies ermöglicht wird erstellt dieser Mod eine XML-Datei in eurem "UserProfileAppPath", das heißt in dem Ordner wo ihr die Ordner savegames, mods und screenshots findet und wo eure Spielkonfiguration gespeichert ist (game.xml, gameSettings.xml).
Der Inhalt dieser XML sollte eigentlich selbsterklärend sein aber ich kann ihn erläutere es lieber:

	<HelperAdvancedMenu>
		<tabletFile>mods/FS19_HelperAdvanced/huds/hud_tablet.dds</tabletFile>
		<buttonFile>mods/FS19_HelperAdvanced/huds/hud_tablet_button.dds</buttonFile>
		<buttonHoverFile>mods/FS19_HelperAdvanced/huds/hud_tablet_buttonHover.dds</buttonHoverFile>
		<menuTextColor r="1.000000" g="1.000000" b="1.000000"/>
		<entryTextColor r="0.000000" g="0.000000" b="0.000000"/>
		<entryDeactiveTextColor r="0.300000" g="0.300000" b="0.300000"/>
		<noteTextColor r="0.300000" g="0.000000" b="0.300000"/>
		<textSize>8.543000</textSize>
	</HelperAdvancedMenu>

**tabletFile** - dies gibt den Pfad zur Hintergrundgrafik des HUDs an

**buttonFile** - dies gibt den Pfad zur normalen Buttongrafik des HUDs an

**buttonHoverFile** - dies gibt den Pfad zur Buttongrafik des HUDs an wenn ihr mit der Maus über dem Button seid (Hovereffekt)

**menuTextColor** - die Farbe des Textes in den Menüs und Buttons

**entryTextColor** - die Farbe der Texte in der Anzeige im Hauptbereich des Huds, also wie Helferauflistung zum Beispiel

**entryDeactiveTextColor** - die Farbe der Texte in der Anzeige im Hauptbereich des Huds wenn der Helfer nicht verfügbar ist, weil er zum Beispiel gerade arbeitet

**noteTextColor** - die Farbe der Texte welche auf Besonderheiten hinweisen, zum Beispiel "In Arbeit" oder Hinweis auf die Kosten sobald ein Helfer eingestellt ist

**textSize** - die Standard-Größe der Schrift im Tablet, kann über diesen Wert für extrabreite Auflösungen eingestellt werden


Diese Werte werden NUR vom Clienten ausgewertet, ein Server benötigt diese Daten nicht da er nichts anzeigt, er ist ja nur der Server. Es kann jeder Client sein eigenes Design haben. Die Pfade zu den Grafiken müssen auch nicht unbedingt im "Mods" Ordner liegen, sie können auch in einem anderen Ordner, ausgehend von eurem Spielprofilordner liegen, der Pfad muß lediglich korrekt angegeben werden in der XML.

#### Der Helfer auch InGame umbenannt werden.
Dazu macht ihr in der Liste eurer angestellten Helfer einen Rechtsklick auf den Helfer der umbenannt werden soll, daraufhin öffnet sich ein neues Fenster in dem ihr einen neuen Namen eingeben könnt für den Helfer.
Auch hier gilt für den MP wieder: Nur Admins können Helfer umbennen!

Ein eingestellter Helfer kann zu Lehrgängen geschickt werden um mehr Wissen und Erfahrung zu erlangen und somit effektiver zu arbeiten. Denn wie bereits bekannt spart ein erfahrener Helfer Zeit und Kraftstoff und somit letztendlich natürlich unser Geld.
Natürlich weiß man von vorherigen Versionen des Helfers das ein sehr erfahrener Helfer auch bedeutend mehr Geld pro Stunde verdient, das ist in soweit zwar richtig aber das betrifft nur die Fähigkeiten die er sich selbst beim Arbeiten beigebracht bzw dort gelernt hat. Schickt man einen Helfer auf Lehrgang erlangt dieser zwar Wissen und Erfahrung, aber dies schlägt sich nicht auf seinen Lohn nieder. Weshalb? Nun, da der Chef (also wir) wirtschaftlich arbeiten müssen damit unser landwirtschaftlicher Betrieb Gewinne abwirft zahlt man lieber eine bestimmte Summe um dem Helfer etwas extra beibringen zu lassen als einen unerfahrenen Helfer auf das Feld zu schicken der nicht zu 100% effektiv arbeiten kann und wenn er dann soweit ist daß er es tut ein stattliches Gehalt verlangt (was er ja dann auch verdienen soll). Immerhin soll dieser Helfer uns ja noch lange auf dem Hof dienlich sein also muß man auf lange Sicht mit den Lohnkosten rechnen, bei einem Lehrgang der mich einmalig ca 70.000 € kostet und damit eingesparten Lohnkosten in Höhe von 12,50 € die Stunde, dazu kommen der eingesparte Kraftstoff und die eingesparte Zeit da er schneller arbeiten kann ... da fängt ein wirtschaftlicher denkender Mensch an zu rechnen möchte ich meinen.

#### Wie funktioniert das mit den Lehrgängen?
Ein Arbeiter muß angestellt sein und KEINER Tätigkeit nachgehen, also Freizeit haben. Dann wähle ich in der Helferübersicht den Arbeiter aus, es erscheinen im unteren Bildabschnitt die entsprechenden Lehrgänge, dazu die Beschreibung mitsamt Kosten pro Tag. Wird ein Lehrgang gewählt erscheinen 3 Auswahlmöglichkeiten für die Dauer des Lehrganges, ein Klick darauf startet den Lehrgang für die gewählte Dauer und der Helfer ist bis zum Abschluß des Lehrganges NICHT verfügbar.

#### Weshalb Lehrgänge, der lernt beim Arbeiten doch auch?
Korrekt, aber nicht so schnell. Bei einem Lehrgang lernt der Helfer doppelt so schnell wie bei der eigentlichen Arbeit da er sich speziell nur mit den für den Lehrgang spezifischen Dingen beschäftigen muß, nebenbei erlangt er auch einen kleinen Teil Erfahrung.

#### Ist es egal welchen Helfer ich zum Lehrgang schicke?
Eigentlich schon, möchte man denken, Hauptsache er lernt dazu ... ABER ... ein gefüllter Topf kann nicht weiter befüllt werden bis das er überläuft ...
#### W A T ?
Soll heißen: hat ein Helfer das maximale Wissen für die Lehrgangsfächer erreicht wird er den Lehrgang beenden.
Aber das ist nicht alles was es bedeutet: ein Anfänger in der Landwirtschaft, sagen wir mal Lehrling mit 10% Grundwissen und Erfahrung, hat noch nichts im Kopf und viel Platz um Wissen aufzunehmen, er lernt also bedeutend schneller während ein alter Hase, sagen wir mal Meister zu ihm, seine Erfahrungen schon gesammelt hat und in vielen Bereichen Wissen erlangt hat und eigentlich des Lernens überdrüssig ist wesentlich länger braucht um sein Wissen auf den höchsten Level anzuheben.
#### Kurzfassung (Bildbeispiele siehe Screenshots):
Je niedriger der Erfahrungswert eines Helfers umso schneller kann in den Fachbereichen Wissen erlangen, je höher die Erfahrung desto langsamer lernt er.

Bitte dazu auch die Screenshots ansehen, dort sieht man sehr gut das die Fähigkeiten gestiegen sind, die Gehälter jedoch gleich geblieben sind. Ebenso kann man dort sehen das ein "Unwissender" schneller lernt als ein "Wissender".

#### Welche Lehrgänge gibt es?
- Allgemeine Landwirtschaft
- - Grundwissen über Wetterverhältnisse, Fahrzeuge sowie Regeln der Lagerhaltung
- - +++ Erfahrung
- - +++ Andere Fähigkeiten
- - > Kraftstoffeinsparung
- Bodenbearbeitung
- - Richtiges Bearbeiten von Feldböden und handhaben der dazugehörigen Maschinen
- - +++ Grubbern
- - +++ Pflügen
- - + Erfahrung
- - > Arbeitsgeschwindigkeit beim Pflügen und Grubbern
- Aussaat + Aufzucht
- - Aussaat und Handhabung von Sämaschinen sowie richtiger Einsatz des Düngers
- - +++ Säen
- - +++ Düngen
- - + Erfahrung
- - > Arbeitsgeschwindigkeit beim Säen, Spritzen und Sprühen
- - > Material-Einsparung von Saatgut bzw Dünger
- Ernte + Einbringung
- - Ernte, Mäh- und Sammelarbeiten inklusive Spezial-Maschinenschulung
- - +++ Dreschen
- - +++ Mähen
- - +++ Pressen
- - + Erfahrung
- - > Arbeitsgeschwindigkeit beim Dreschen, Mähen sowie Ballen pressen
- - > höhere Erträge beim Ernten, Mähen und Pressen

#### Wie lange dauern die Lehrgänge?
Ein Helfer kann für 1, 2 oder 3 Tage auf Lehrgang geschickt werden, jeder Helfer kann so oft auf Lehrgang geschickt werden bis er das maximale Wissen des Lehrgangsthemas erlangt hat.

------------

### Features

- Helfer haben Namen
- Helfer müssen zuerst eingestellt werden
- Helfer bekommen Grundlohn IMMER sobald sie eingestellt sind
- Helfer bekommen Lohn in Höhe entsprechend ihrer Fähigkeiten
- Helfer bekommen "Überstunden" bezahlt
- Helfer werden für mindestens 7 InGame-Tage eingestellt
- Helfer arbeiten schneller und sparsamer bzw ertragreicher je besser Ihre Fähigkeiten sind
- Helfer arbeiten mit Courseplay und FollowMe zusammen
- - Courseplay, FollowMe und AutoDrive bekommen automatisch vorhandenen Helfer zugewiesen
- - sind keine weiteren Helfer eingestellt so wird ein neuer Helfer eingestellt, automatisch !!!
- Helfer verbrauchen bei geringer Erfahrung mehr Saatgut, Dünger und Kraftstoff
- Helfer bringen weniger Ertrag bei geringer Erfahrung beim Dreschen und Mähen
- Im Multiplayer können nur MasterUser/Admins Helfer einstellen, zur Arbeit anheuern kann jeder dem es erlaubt ist Helfer zuzuweisen sofern Helfer eingestellt wurden
- das HUD kann von den Grafiken her selbst gestaltet werden, 5 unterschiedliche HUDs sind im Paket enthalten inklusive Config-XMLs
- Helfer können umbenannt werden direkt im Spiel (rechten Mausklick auf den umzubenennenden Helfer)
- Helfer können Lehrgänge besuchen um effektiver zu arbeiten und Geld einzusparen

### SCREENSHOTS
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced01.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced01.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced02.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced02.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced03.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced03.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced04.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced04.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced05.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced05.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced06.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced06.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced07.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced07.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced08.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced08.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced09.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced09.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced10.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced10.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced11.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced11.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced12.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced12.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced13.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced13.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced14.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced14.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced15.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced15.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced16.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced16.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced17.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced17.png)
[![HelperAdvanced Ingame](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/tn_HelperAdvanced18.png)](https://github.com/BlackyBPG/FS19_HelperAdvanced/blob/master/images/HelperAdvanced18.png)
------------

------------

### CHANGELOG:

- ##### Version 1.9.0.16 (05.10.2021)
- - fix apparently working helpers who are actually not employed by anyone
- - Helpers now always have their own clothes on, so the recognition value is there

- ##### Version 1.9.0.15 (04.10.2021)
- - fix automaticly fired and hired helpers 2nd
- - now the selected helper has right gender model in vehicle
- - multiplayer synchronisation fixed for currently working helpers

- ##### Version 1.9.0.14 (25.08.2021)
- - fix automaticly fired and hired helpers

- ##### Version 1.9.0.13 (20.07.2021)
- - fix missing sowingMachine synchronisation in multiplayer

- ##### Version 1.9.0.12 (10.07.2021)
- - fix wrong dismiss helper after ending loan works

- ##### Version 1.9.0.11 (19.06.2021)
- - fix wrong (negativ) employment time
- - fix MP to SP farmId change error

- ##### Version 1.9.0.10 (13.03.2020)
- - fix addMoney error

- ##### Version 1.9.0.9 (01.03.2020)
- - fix helper hiring for farmmanagers
- - fixed the error when ending/cancel/close the game

- ##### Version 1.9.0.8 (20.02.2020)
- - fixed the error when ending/cancel/close the game

- ##### Version 1.9.0.7 (12.02.2020)
- - fix for the calculation of experience-based consumption/harvest values
- - fix sprayer function for experience-based consumption/harvest values

- ##### Version 1.9.0.6 (09.02.2020)
- - fix specialized learning while working

- ##### Version 1.9.0.5 (20.01.2020)
- - from theorist to practitioner: learned skills are slowly being converted into practical knowledge if the helper is active in the task
- - add InGame changable Tablet buttons
- - fix sprayer usage
- - fix calculation for various usages
- - fix helper fuel and def usage
- - fix combine error without helper

- ##### Version 1.9.0.4 (18.01.2020)
- - fix sprayer functionality

- ##### Version 1.9.0.3 (18.01.2020)
- - Courseplay and AutoDrive hired several new helpers on the dedicated server
- - FollowMe did not start on the dedicated server
- - DedicatedServer and players had different helpers active on the same vehicle

- ##### Version 1.9.0.2 (17.01.2020)
- - correct function with Courseplay, FollowMe and AutoDrive

- ##### Version 1.9.0.1 A (15.01.2020)
- - fix non working save function

- ##### Version 1.9.0.1 (14.01.2020)
- - Initial converted Release for Fs19

------------
