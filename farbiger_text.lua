function highlight_info()
    selectCaptureGroup(1)
    fg(farben.vg.info)
    bg(farben.hg.info)
    resetFormat()
end
function highlight_komm()
    selectCurrentLine()
    fg(farben.vg.komm)
    bg(farben.hg.komm)
    resetFormat()
end
function highlight_alarm()
    selectCurrentLine()
    fg(farben.vg.alarm)
    bg(farben.hg.alarm)
    resetFormat()
end


-- Trigger - Kampf: Zustand
function highlight_kampf_zustand(matches)
    local zustand = {}
 
    zustand["ist absolut fit."] = 1
    zustand["ist leicht geschwaecht."] = 0.9 -- Kaempfer Fokus
    zustand["ist schon etwas geschwaecht."] = 0.9 -- untersuche
    zustand["fuehlte sich auch schon besser."] = 0.8 -- Kaempfer Fokus
    zustand["fuehlte sich heute schon besser."] = 0.8 -- untersuche
    zustand["ist leicht angekratzt."] = 0.7 -- Kaempfer Fokus
    zustand["ist leicht angeschlagen."] = 0.7 -- untersuche
    zustand["ist nicht mehr taufrisch."] = 0.6 -- Kaempfer Fokus
    zustand["sieht nicht mehr taufrisch aus."] = 0.6 -- untersuche
    zustand["sieht recht mitgenommen aus."] = 0.5 -- Kaempfer Fokus
    zustand["macht einen mitgenommenen Eindruck."] = 0.5 -- untersuche
    zustand["wankt bereits bedenklich."] = 0.4
    zustand["ist in keiner guten Verfassung."] = 0.3
    zustand["braucht dringend einen Arzt."] = 0.2
    zustand["steht auf der Schwelle des Todes."]= 0.1

    local ausgabe = zustand[matches[1]]

    if ausgabe then 
      ausgabe = " (" .. ausgabe*100 .. "%)" 
    else
      ausgabe = " (???%)"
    end

    selectCurrentLine()
    fg(farben.vg.info)
    bg(farben.hg.info)
    echo(ausgabe)
    resetFormat()
end


-- Funktion an Mudlet bekannt geben
local code_string
local code_regex
local i
local regex

code_string = "highlight_info()"
code_regex = {
    "^Es gibt (.*) sichtbare Ausgaenge: ", 
    "^Es gibt einen sichtbaren Ausgang: ",
    "^Es gibt keinen sichtbaren Ausgang\.$",
    "^Es gibt keine sichtbaren Ausgaenge\.$",
    "^.* faellt tot zu Boden\.$",
    "^Die Angst ist staerker als Du \.\.\. Du willst nur noch weg hier\.$"
}
for i, regex in ipairs(code_regex) do
  tempRegexTrigger(regex, code_string)
end

code_string = "highlight_komm()"
code_regex = {
    "^(.*) teilt Dir mit: (.*)$",
    "^Du teilst (.*) mit: (.*)$",
    "^Du sagst:",
    "sagt:",
    "^Du fragst:",
    "fragt:",
    "Wecker klingelt bei Dir.$",
    "denkt:",
    "Matrix:",
    "[Team"
}
for i, regex in ipairs(code_regex) do
  tempRegexTrigger(regex, code_string)
end

code_string = "highlight_alarm()"
code_regex = {
    "^Du hast (.*) neue Brief(.*) im Postamt liegen.$",
    "Ein Postreiter ruft Dir aus einiger Entfernung zu, dass Du neue Post hast!"
}
for i, regex in ipairs(code_regex) do
  tempRegexTrigger(regex, code_string)
end

code_string = "highlight_kampf_zustand(matches)"
code_regex = {
    "ist absolut fit.",
    "ist leicht geschwaecht.",
    "ist schon etwas geschwaecht.",
    "fuehlte sich auch schon besser.",
    "fuehlte sich heute schon besser.",
    "ist leicht angekratzt.",
    "ist leicht angeschlagen.",
    "ist nicht mehr taufrisch.",
    "sieht nicht mehr taufrisch aus.",
    "sieht recht mitgekommen aus.",
    "macht einen mitgenommenen Eindruck.",
    "wankt bereits bedenklich.",
    "ist in keiner guten Verfassung.",
    "braucht dringend einen Arzt.",
    "steht auf der Schwelle des Todes."
}
for i, regex in ipairs(code_regex) do
  tempRegexTrigger(regex, code_string)
end
