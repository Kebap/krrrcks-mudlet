
-- TriggerGroup - Krrrcks: Farb-Trigger

-- Trigger - Para-/Normalwelt

-- Prüfung über Portal 23

selectCurrentLine()

if (matches[3] == "gruenlich") then
    fg(farben.vg.info)
    bg(farben.hg.info)
    ME.para = 0
end

if (matches[3] == "roetlich") then
    fg(farben.vg.alarm)
    bg(farben.hg.alarm)
    ME.para = 1
end

zeigeRaum()
resetFormat()

                <regexCodeList>
                    <string>^(.*)Du bist hier im Innern einer (.*) schimmernden Kugel,$</string>
                    <string>^(.*)Im Innern einer (.*) schimmernden Kugel.$</string>
                </regexCodeList>


-- AliasGroup - Krrrcks: Kleinkram

--[[ Hier sammel ich Kleinkram, der nirgendwo anders gut hinpasst. Kleinere Skripte
    und Aliase ]]--


-- Alias - Hilfe

fg("yellow")

echo([[
Folgende Sachen gibt es und funktionieren:

* Umlaute werden erkannt und durch passende Umschreibungen ersetzt.

* Einstellungen und auch Globale Variablen
In "Scripts->Einstellugnen" habe ich einige globale Variablen und 
einstellbare Sachen hinterlegt:

ME: ME ist ein Table, in dem ich alle möglichen Informationen zum User speichere; 
  hier landen bspw. der Name, aber auch in welcher Para-Welt man sich befindet etc. 
  Soweit möglich werden die entsprechenden Werte bspw. aus GMCP-Nachrichten 
  gezogen.
farben: In diesem Table verwalte ich die für die Trigger und Skripte zu verwendenden
  Farben.

* Farbtrigger
In Trigger befinden sich Farbtrigger, welche die Ebenen einfärben.

* Wegeskripte von tf
Ich hatte einige Wegeskripte bei tf, die insbesondere mit einem "/dopath" 
zusammenarbeiteten. Ich habe diese nahezu 1:1 rekonstruiert, sie sind in den Skripten
und den Aliasen zu finden.

* Kleinkram
#haus<name> : Wenn man vor einem Seherhaus steht, kann man es damit  
  aufschließen, betreten und wieder verschließen. Achtung: Kein Leerzeichen
  zwischen "#haus" und dem Namen!
]])

                <regex>^#help$</regex>


-- Alias - Haus betreten

-- Mit "#haus<name>" ein Seherhaus aufschliessen und betreten; 
-- wird der Name weggelassen, wird automatisch ME.name angehaengt.

local wessen = matches[2] 

if wessen == "" then wessen = ME.name end

if wessen then
    send("schliesse haus von " .. wessen .. " auf")
    send("oeffne haus von " .. wessen)
    send("betrete haus von " .. wessen)
    send("schliesse haus")
    send("schliesse haus ab")
end
                <regex>^#haus(.*)$</regex>


-- Alias - Home

expandAlias("#go haus")
expandAlias("#haus")

                <regex>^#home$</regex>


-- AliasGroup - Krrrcks: Alte Wege

-- Die alten tf-Wegeskripte. 

-- Alias - Weg ablaufen

-- Die alten tf-Wegeskripte. 

--[[ Gestartet werden diese mit "#go <ziel>", dann wird 
    Ziel ausgewählt und die Sachen zum Mud geschossen. Dabei
    ist zu beachten, dass die meisten Skripte bei einem Portal
    bzw. beim Sandtiger starten. ]]--

-- Als Beispiel zwei Wege: Sandtiger-Hochebene und zurueck.

wege.he = { "#dopath w n n w w w n nw nw nw w nw nw nw w w no no o no o o", "folge hund" }
wege.he_st = { "folge hund", "#dopath w w sw w sw sw o o so so so o so so so s o o o s s o" }

local kommandos = wege[matches[2]]

if type(kommandos) == "table" then
  alt_ws(kommandos)
end

                <regex>^#go (.*)$</regex>


-- Alias - Altes dopath

-- Ersetzt das alte tf-dopath; übergeben wird ein String mit 
-- Ausgängen.

-- Bspw: "#dopath o o w n" macht dann jeweils send("o"), 
-- send("o"), send("w"), send("n")

alt_dopath(matches[2])

                <regex>^#dopath (.*)$</regex>



-- ScriptGroup - Krrrcks: Einstellungen

-- Einstellungen (Farben etc.)


-- Script - Spieler

-- Variablen zum Spieler

ME = {}
ME.name = "Jemand"
ME.stufe = 0

ME.para = 0
ME.vorsicht = 0
ME.fluchtrichtung = ""
ME.lp_alt = 0

GUI = {}
GUI.angezeigt = false
GUI.lp_anzeige_blinkt = false

wege = {}


-- ScriptGroup - Krrrcks: Alte Wege

-- Damit ich vor Einsatz des Mappers schon mal herumirren kann,
-- hier ein paar Funktionen, um die bisherigen Wege nutzen zu können.


-- Script - Wegeskripte fuer tf

function alt_dopath(wegestring)
  if not type(wegestring) == "string" then
        wegestring = ""
    end
    for w in string.gmatch(wegestring, "%a+") do
      send(w)
    end
end

function alt_ws(kommandos, lang)
    if not type(kommandos) == "table" then
        kommandos = {}
    end
    if not lang then
        send("ultrakurz")
    end
    for k,v in ipairs(kommandos) do
        -- Wenn "#dopath" oder "#go", dann das Ali ausführen
        if (type(v) == "string" and string.sub(v,1,7) == "#dopath")
            or (type(v) == "string" and string.sub(v,1,3) == "#go") 
       then 
            expandAlias(v)
        else    
        -- sonst ohne Ali Ersetzung senden (erst mal keine weiteren Ersetzungen
        -- vorgesehen.
            send(v)
        end
    end
    if not lang then
        send("lang")
        send("schau")
    end
end

-- ScriptGroup - Krrrcks: Debug

-- Ein paar Debugging-Funktionen

-- Script - Debug Ausgabe

function debugText(text)
    echo("DEBUG: " .. text)
end

function debugDisplay(obj)
    echo("DEBUG: ")
    display(obj)
end

-- ScriptGroup - Krrrcks: GUI

-- Hierin sammel ich alles, was für die GUI von Wichtigkeit sein könnte

--[[
Etwas trickreich ist folgendes:
Der "Script name" (bspw. "zeigeVitaldaten" muss genau dem Funktionsnamen für 
diese Funktion entsprechen, sonst tut das nicht).
]]--

-- Script - initGMCP

function initGMCP() 
    sendGMCP( [[Core.Supports.Debug 20 ]])
    sendGMCP( [[Core.Supports.Set [ "MG.char 1", "MG.room 1", "comm.channel 1" ] ]])
end

                <eventHandlerList>
                    <string>gmcp.Char</string>
                </eventHandlerList>



-- Script - initBase

function initBase() 
    ME.name = gmcp.MG.char.base.name 
    ME.stufe = gmcp.MG.char.info.level

    if not GUI.angezeigt then
        initGUI()
        GUI.angezeigt = true
    end

end

                <eventHandlerList>
                    <string>gmcp.MG.char.base</string>
                    <string>gmcp.MG.char.info</string>
                </eventHandlerList>


-- Script - zeigeVitaldaten

function zeigeVitaldaten()

  -- GMCP Vitaldaten merken

  ME.lp = gmcp.MG.char.vitals.hp
  ME.lp_max = gmcp.MG.char.maxvitals.max_hp
  ME.kp = gmcp.MG.char.vitals.sp
  ME.kp_max = gmcp.MG.char.maxvitals.max_sp

  -- Werte der Balken aktualisieren
  
  GUI.lp_anzeige:setValue(ME.lp, ME.lp_max, 
      "<b> " .. ME.lp .. "/" .. ME.lp_max .. "</b> ")

  GUI.kp_anzeige:setValue(ME.kp, ME.kp_max, 
      "<b> " .. ME.kp .. "/" .. ME.kp_max .. "</b> ")

  -- Treffer? Dann LP Balken blinken lassen

  if ME.lp < ME.lp_alt then
    -- echo("Au!")
    lp_anzeige_blinken(0.2)
  else
    if not GUI.lp_anzeige_blinkt then
      lp_anzeige_faerben()
    end
  end
  ME.lp_alt = ME.lp

end

function lp_anzeige_faerben()

  -- Je nach LP Verlust wird Farbe gruen/gelb/rot

  local lp_quote = ME.lp / ME.lp_max
  GUI.lp_anzeige:setColor(255 * (1 - lp_quote), 
                          255 * lp_quote, 
                          50)
end

function lp_anzeige_blinken(dauer)

  GUI.lp_anzeige_blinkt = true
  GUI.lp_anzeige:setColor(255, 0, 50) -- rot
  tempTimer(dauer, [[ lp_anzeige_entblinken() ]])

end

function lp_anzeige_entblinken()

  GUI.lp_anzeige_blinkt = false
  lp_anzeige_faerben()

end

                <eventHandlerList>
                    <string>gmcp.MG.char.vitals</string>
                    <string>gmcp.MG.char.maxvitals</string>
                </eventHandlerList>


-- Script - zeigeGift

function zeigeGift()

  ME.gift = gmcp.MG.char.vitals.poison
  local zeile = ""

  -- vergiftet?

  if ME.gift == 0 then
    r = 30
    g = 30
    b = 30
  else  -- Farbuebergang gelb->orange->rot 
    r = 255
    g = 255 - ME.gift * 25
    b = 0
    zeile = "<black>G I F T"
  end

  -- Statuszeile aktualisieren

  GUI.gift:echo(zeile)
  GUI.gift:setColor(r, g, b)

end

                <eventHandlerList>
                    <string>gmcp.MG.char.vitals</string>
                </eventHandlerList>


-- Script - zeigeVorsicht

function zeigeVorsicht()

  ME.vorsicht = gmcp.MG.char.wimpy.wimpy
  ME.fluchtrichtung = gmcp.MG.char.wimpy.wimpy_dir

  -- Prinz Eisenherz?

  if ME.vorsicht == 0 then
    ME.vorsicht = "NIX"
  end

  local zeile = "Vorsicht: " .. ME.vorsicht

  -- Fluchtrichtung anzeigen, nur wenn gesetzt

  if ME.fluchtrichtung ~= 0 then
    zeile = zeile .. ", FR: " .. ME.fluchtrichtung
  end

  -- Statuszeile aktualisieren

  GUI.vorsicht:echo(zeile)

end

                <eventHandlerList>
                    <string>gmcp.MG.char.wimpy</string>
                </eventHandlerList>


-- Script - zeigeRaum

function zeigeRaum()

  ME.raum_kurz = gmcp.MG.room.info.short
  ME.raum_region = gmcp.MG.room.info.domain
  ME.raum_id = string.sub(gmcp.MG.room.info.id, 1, 5) 

  -- Para?

  if ME.para > 0 then
    ME.raum_region = "Para-" .. ME.raum_region
    r = 255
    g = 0
    b = 0
  else
    r = 30
    g = 30
    b = 30
  end

  -- Statuszeile aktualisieren

  GUI.spieler:echo(ME.name .. " [" .. ME.stufe .. "]")

  GUI.ort_raum:echo(ME.raum_kurz)
  GUI.ort_region:echo(ME.raum_region .. " [" .. ME.raum_id .. "]")

  GUI.ort_raum:setColor(r, g, b)
  GUI.ort_region:setColor(r, g, b)

end

                <eventHandlerList>
                    <string>gmcp.MG.room</string>
                </eventHandlerList>


-- Script - zeigeEbenen

function zeigeEbenen()
  fg(farben.vg.ebenen)
  bg(farben.hg.ebenen)
  echo(gmcp.comm.channel.msg)
  resetFormat()
end

                <eventHandlerList>
                    <string>gmcp.comm.channel</string>
                </eventHandlerList>


-- Script - initGUI

function initGUI()

  -- Textfenster begrenzen
  setBorderTop(0)
  setBorderBottom(65) -- bisschen Platz fuer Statuszeile
  setBorderLeft(0)
  setBorderRight(0)

  -- Statuszeile malen. Layout wie folgt:
  -- Zeile 1: spieler (Name, Stufe), gift, trenner_1, vorsicht (Vorsicht, Fluchtrichtung)
  -- Zeile 2: ort_raum (Region, Raumnummer, Para), ort_region (Ort kurz)
  -- Zeile 3: lp_titel, lp_anzeige (Lebenspunkte-Anzeige), kp_titel, kp_anzeige (KP-Anzeige), trenner_2

  GUI.statuszeile = Geyser.Container:new({name = "statuszeile", x=0, y=-70, width = 600, height=70})

  -- Zeile 1
  GUI.spieler = Geyser.Label:new({
    name = "spieler",
    x = 0, y = -65,
    width = 150, height = 20}, GUI.statuszeile)

  GUI.gift = Geyser.Label:new({
    name = "gift",
    x = 150, y = -65,
    width = 50, height = 20}, GUI.statuszeile)

  GUI.trenner_1 = Geyser.Label:new({
    name = "trenner_1",
    x = 200, y = -65,
    width = 50, height = 20}, GUI.statuszeile)

  GUI.vorsicht = Geyser.Label:new({
    name = "vorsicht",
    x = 250, y = -65,
    width = 350, height = 20}, GUI.statuszeile)

  -- Zeile 2  
  GUI.ort_raum = Geyser.Label:new({
    name = "ort_raum",
    x = 250, y = -45,
    width = 350, height = 20}, GUI.statuszeile)

  GUI.ort_region = Geyser.Label:new({
    name = "ort_region",
    x = 0, y = -45,
    width = 250, height = 20}, GUI.statuszeile)

  -- Zeile 3
  GUI.lp_titel = Geyser.Label:new({
    name = "lp_titel",
    x = 0, y = -25,
    width = 100, height = 20}, GUI.statuszeile)
  GUI.lp_titel:echo("Lebenspunkte:")

  GUI.lp_anzeige = Geyser.Gauge:new({
    name = "lp_anzeige",
    x = 100, y = -25, 
    width = 140, height = 20}, GUI.statuszeile)
  GUI.lp_anzeige:setColor(0, 255, 50) 

  GUI.kp_titel = Geyser.Label:new({
    name = "kp_titel",
    x = 240, y = -25,
    width = 110, height = 20}, GUI.statuszeile)
  GUI.kp_titel:echo("&nbsp;Konzentration:")

  GUI.kp_anzeige = Geyser.Gauge:new({
    name = "kp_anzeige",
    x = 350, y = -25,
    width = 150, height = 20}, GUI.statuszeile)
  GUI.kp_anzeige:setColor(0, 50, 250)

  GUI.trenner_2 = Geyser.Label:new({
    name = "trenner_2",
    x = 500, y = -25,
    width = 100, height = 20}, GUI.statuszeile)

end


--[[[
    - <KeyGroup isActive="yes" isFolder="yes">
        <name>Keypad</name> 
        <script /> 
        <command /> 
        <keyCode>-1</keyCode> 
        <keyModifier>-1</keyModifier> 
      - <Key isActive="yes" isFolder="no">
      -   <name>8: norden</name> 
        - <script /> 
    -     <command>norden</command> 
      -   <keyCode>56</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
      -   <name>0: schau</name> 
        - <script /> 
        - <command>schau</command> 
        - <keyCode>48</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
      -   <name>5: schau</name> 
        - <script /> 
        - <command>schau</command> 
        - <keyCode>53</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>+: unten</name> 
        - <script /> 
        - <command>unten</command> 
        - <keyCode>43</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>-: oben</name> 
        - <script /> 
        - <command>oben</command> 
        - <keyCode>45</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>1: suedwesten</name> 
        - <script /> 
        - <command>suedwesten</command> 
        - <keyCode>49</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>3: suedosten</name> 
        - <script /> 
        - <command>suedosten</command> 
        - <keyCode>51</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
      -   <name>7: nordwesten</name> 
        - <script /> 
        - <command>nordwesten</command> 
        - <keyCode>55</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>9: nordosten</name> 
        - <script /> 
        - <command>nordosten</command> 
        - <keyCode>57</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>4: westen</name> 
        - <script /> 
        - <command>westen</command> 
        - <keyCode>52</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>6: osten</name> 
        - <script /> 
        - <command>osten</command> 
        - <keyCode>54</keyCode> 
        - <keyModifier>536870912</keyModifier> 
        </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>2: sueden</name> 
        - <script /> 
        - <command>sueden</command> 
        - <keyCode>50</keyCode> 
        - <keyModifier>536870912</keyModifier> 
      - </Key>
      - <Key isActive="yes" isFolder="no">
        - <name>x: raus</name> 
        - <script /> 
        - <command>raus</command> 
        - <keyCode>42</keyCode>
        - <keyModifier>536870912</keyModifier>
      - </Key>
        <Key isActive="yes" isFolder="no">
          <name>/: kurz</name>
          <packageName></packageName>
          <script>local newmodus = ""

if ME.modus == "lang" then
  newmodus = "kurz"
elseif ME.modus == "kurz" then
  newmodus = "ultrakurz"
elseif ME.modus == "ultrakurz" then
  newmodus = "lang"
else
  newmodus = "kurz"
end

ME.modus = newmodus
send(newmodus)</script>
          <command></command>
          <keyCode>47</keyCode>
          <keyModifier>536870912</keyModifier>
        </Key>
        <Key isActive="yes" isFolder="no">
          <name>,: ausruestung</name>
          <packageName></packageName>
          <script></script>
          <command>ausruestung</command>
          <keyCode>44</keyCode>
          <keyModifier>536870912</keyModifier>
        </Key>
      </KeyGroup>
]]]--

