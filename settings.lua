-- Farben

farben = {}

-- komm: Kommunikation wie teile-mit
-- ebenen: Einfaerben der "normalen" Ebenen
-- info: Einfaerben von Informationen des Muds (Status Gegner)
-- alarm: Alarm-Nachrichten
-- script: Nachrichten, die nicht vom Mud, sondern von einem Script stammen.

farben.vg = 
  { komm = "cyan",
    ebenen = "magenta",
    info = "green",
    alarm = "white",
    script = "dark_green" }

farben.hg = 
  { komm = "black",
    ebenen = "black",
    info = "black", 
    alarm = "red",
    script = "black" }


-- Einstellungen fuer Farben Kampfscroll

function msg (type, what)
  -- setzt VG und HG je nach Typ der Kommunikation
  local vg = farben.vg[type]
  local hg = farben.hg[type]

  if vg and hg then
      cecho("<"..vg..":"..hg..">"..what)
  else
    echo(what)
  end
end


-- Mapper

-------------------------------------------------------
-- Benutzerdefinierte Einstellungen fuer den Mapper. --
-------------------------------------------------------

mapperconf = {}

-- Farbe fuer Mitteilungen des Mappers
mapperconf.color = "blue"

-- Standardabstand zwischen zwei Raeumen
mapperconf.scale = 5
