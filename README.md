krrrcks-mudlet
==============

Mudlet Skripte für das MUD MorgenGrauen. Infos zum Spiel: http://mg.mud.de

Das hier enthaltene Bündel an Skripten ist noch in Entwicklung. 

Wer Fehlerberichte, Anregungen oder Hinweise für Verbesserungen hat, nur her damit.

Viele Grüße [von den Autoren](version.md). Kontakt hier bei Github: [![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/Kebap/krrrcks-mudlet?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


Was schon funktioniert
----------------------

* Hilfreiche Funktionen
 * Mapper malt automatisch Karten
 * Bewegung mittels Nummerntasten am Keypad
 * Unterstützung für Wegeskripte, wie aus TinyFugue bekannt ("go" & "dopath")
 * Umlaute werden bei Eingabe erkannt & beim Versand durch Äquivalente ersetzt

* Farbige Hervorhebungen  
 * Kommunikation wie Ebenen, Mitteilungen, Team, uvm.
 * Infos zur Bewegung wie z.B. sichtbare Ausgänge, Fluchtmeldung.
 
* Statusleiste zeigt allgemeine Infos des Spielers
 * Lebenspunkte & Konzentration
 * Vorsicht, ggf. Fluchtrichtung
 * ggf. Vergiftungen
 * (Manche Teile des "reports" haben Voraussetzungen, die im Spiel erfüllt werden müssen)

* Statusleiste zeigt allgemeine Infos zum Raum, in dem sich der Spieler aktuell befindet:
 * Wie wird der Raum kurz genannt? 
 * Zu welcher Region gehört er? 
 * Ist man in einer Parallelwelt? (Dazu muss man an einer Kugel an
   einem Seherportal vorbeilaufen.)


Was noch offen ist
------------------

* Kampfscroll reduzieren

* Skripte für Kämpfer und andere Gilden

* Detailiertere Bedienungsanleitung 



Kurzanleitung
-------------

* XML Dateien folgender Skripte speichern (Rechte Maustaste, Speichern unter ...)
 * [Grundskript](https://raw.githubusercontent.com/Kebap/krrrcks-mudlet/master/krrrcks.xml) - ohne geht es nicht
 * [Einstellungen](https://raw.githubusercontent.com/Kebap/krrrcks-mudlet/master/settings.xml) - benutzerdefinierte Einstellungen - ausgelagert aber benötigt
 * [Mapper](https://raw.githubusercontent.com/Kebap/krrrcks-mudlet/master/mapper.xml) - optionale Erweiterung, Anleitung mit "mhilfe"
* Ggf. Mudlet [installieren](http://www.mudlet.org/download) (getestet mit 3.0 und 2.1)
* Neues Mudlet Profil erstellen für _mg.mud.de_ Port _23_ (Weitere Charaktere benötigen eigene Profile)
* _Menu_ - _Settings_ - _Enable GMCP_
* _Menu_ - _Scripts_ - _Import_ - zuvor gespeicherte XML Dateien angeben
* Fertig, Skripte können nun benutzt werden.
* Auf Wunsch Skripte wieder entfernen über _Menu_ - _Package Manager_ - Name des Skriptes wählen - _Uninstall_
* Schon kann es wieder von vorne losgehen! :)

Siehe auch: [Mudlet Infos im MorgenGrauen Wiki](http://wiki.morgengrauen.info/index.php?n=MorgenGrauen.Mudlet)
