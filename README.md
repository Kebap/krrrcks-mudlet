krrrcks-mudlet
==============
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/Kebap/krrrcks-mudlet?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Mudlet Skripte für das MUD MorgenGrauen. Infos zum Spiel: http://mg.mud.de

Das hier enthaltene Bündel an Skripten ist noch in Entwicklung. 

Wer Fehlerberichte, Anregungen oder Hinweise für Verbesserungen hat, nur her damit.

Viele Grüße [von den Autoren](version.md). Kontakt hier bei Github: [![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/Kebap/krrrcks-mudlet?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


Was schon funktioniert
----------------------

* Statusleiste zeigt allgemeine Infos des Spielers
 * Lebenspunkte
 * Konzentration
 * Vorsicht, ggf. Fluchtrichtung
 * ggf. Vergiftungen
 * (Manche Teile des "reports" haben Voraussetzungen, die im Spiel erfüllt werden müssen)

* Statusleiste zeigt allgemeine Infos zum Raum, in dem sich der Spieler aktuell befindet:
 * Wie wird der Raum kurz genannt? 
 * Zu welcher Region gehört er? 
 * Ist man in einer Parallelwelt? (Dazu muss man an einer Kugel an
   einem Seherportal vorbeilaufen.)

* Hilfreiche Funktionen
 * Unterstützung für Wegeskripte, wie aus TinyFugue bekannt (go & dopath)
 * Umlaute werden bei Eingabe erkannt & beim Versand durch Äquivalente ersetzt

* Farbige Hervorhebungen von verschiedenen Informationen
 * Kommunikation wie Ebenen, Mitteilungen, Team, uvm.
 * Hilfen zur Bewegung wie z.B. sichbare Ausgänge, Fluchtmeldung.


Was noch offen ist
------------------

* Mapper

* Kampfscroll reduzieren

* Skripte für Kämpfer und andere Gilden

* Bedienungsanleitung 



Kurzanleitung
-------------

* [XML Datei dieser Skripte](https://raw.githubusercontent.com/Kebap/krrrcks-mudlet/master/krrrcks.xml) speichern (Rechte Maustaste, Speichern unter ...)
* Ggf. Mudlet installieren (getestet mit 3.0 und 2.1)
* Neues Mudlet Profil erstellen für _mg.mud.de_ Port _23_ (Weitere Charaktere benötigen eigene Profile)
* _Menu_ - _Settings_ - _Enable GMCP_
* _Menu_ - _Scripts_ - _Import_ - zuvor gespeicherte XML Datei angeben
* Fertig, Skripte können nun benutzt werden.
* Auf Wunsch Skripte wieder entfernen über _Menu_ - _Package Manager_ - Name des Skriptes wählen - _Uninstall_
* Schon kann es wieder von vorne losgehen! :)

Siehe auch: [Mudlet Infos im MorgenGrauen Wiki](http://wiki.morgengrauen.info/index.php?n=MorgenGrauen.Mudlet)
