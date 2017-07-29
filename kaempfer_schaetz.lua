
-- TriggerGroup - Kaempfer

item_type = "trigger"
item_name = "Kaempfer"

if exists(item_name, item_type) == 0 then
    permGroup(item_name, item_type)
end




-- Trigger - Schaetz

code_type = "trigger"
code_name = "Schaetz"
code_group = "Kaempfer"
code_regex = {"(ist absolut fit|ist leicht geschwaecht|fuehlte sich auch schon besser|ist leicht angekratzt|ist nicht mehr taufrisch|sieht recht mitgenommen aus|wankt bereits bedenklich|ist in keiner guten Verfassung|braucht dringend einen Arzt|steht auf der Schwelle des Todes) und ist damit"}
code_string = "schaetz()"

if exists(code_name, code_type) == 0 then
    permRegexTrigger(code_name, code_group, code_regex, code_string)
end


function schaetz()
  if not isOpen then   -- this checks for the first line, and initializes your variables
    text = ""
    len = 1
    isOpen = true
    -- Gegner merken
    local wo = line:find(matches[2]) - 2
    target = string.sub(line, 0, wo)
  end

  text = text .. line .. " "   
  len = len + 1   
  
  if string.match(line, " gross\.$") then   
    len = 0
    isOpen = false
    -- do other stuff here to actually work with all the text you just captured
    schaetz_ausgabe()
  end

  setTriggerStayOpen("Schaetz", len)   -- this sets the number of lines for the trigger to capture
end



function schaetz_ausgabe()

-- ----------------------------------------------------------------------------
-- LP in %

  if string.match(text, "ist absolut fit und ist damit") then
    schaetz_abs = 1
  elseif string.match(text, "ist leicht geschwaecht und ist damit") then
    schaetz_abs = 0.9
  elseif string.match(text, "fuehlte sich auch schon besser und ist damit") then
    schaetz_abs = 0.8
  elseif string.match(text, "ist leicht angekratzt und ist damit") then
    schaetz_abs = 0.7
  elseif string.match(text, "ist nicht mehr taufrisch und ist damit") then
    schaetz_abs = 0.6
  elseif string.match(text, "sieht recht mitgenommen aus und ist damit") then
    schaetz_abs = 0.5
  elseif string.match(text, "wankt bereits bedenklich und ist damit") then
    schaetz_abs = 0.4
  elseif string.match(text, "ist in keiner guten Verfassung und ist damit") then
    schaetz_abs = 0.3
  elseif string.match(text, "braucht dringend einen Arzt und ist damit") then
    schaetz_abs = 0.2
  elseif string.match(text, "steht auf der Schwelle des Todes und ist damit") then
    schaetz_abs = 0.1
  end


-- ----------------------------------------------------------------------------
-- Lps relativ zum Caster

  if string.match(text, "und ist damit absolut, unglaublich schwaecher als Du.") then
    schaetz_rel_min = 0
    schaetz_rel_max = ME.lp - 199
  elseif string.match(text, "und ist damit unglaublich schwaecher als Du.") then
    schaetz_rel_min = ME.lp - 199
    schaetz_rel_max = ME.lp - 150
  elseif string.match(text, "und ist damit sehr viel schwaecher als Du.") then
    schaetz_rel_min = ME.lp - 149
    schaetz_rel_max = ME.lp - 110
  elseif string.match(text, "und ist damit viel schwaecher als Du.") then
    schaetz_rel_min = ME.lp - 109
    schaetz_rel_max = ME.lp - 80
  elseif string.match(text, "und ist damit deutlich schwaecher als Du.") then
    schaetz_rel_min = ME.lp - 79
    schaetz_rel_max = ME.lp - 50
  elseif string.match(text, "und ist damit schwaecher als Du.") then
    schaetz_rel_min = ME.lp - 49
    schaetz_rel_max = ME.lp - 30
  elseif string.match(text, "und ist damit etwas schwaecher als Du.") then
    schaetz_rel_min = ME.lp - 29
    schaetz_rel_max = ME.lp - 20
  elseif string.match(text, "und ist damit fast so stark wie Du.") then
    schaetz_rel_min = ME.lp - 19
    schaetz_rel_max = ME.lp - 10
  elseif string.match(text, "und ist damit etwa genauso stark wie Du.") then
    schaetz_rel_min = ME.lp - 9
    schaetz_rel_max = ME.lp + 10
  elseif string.match(text, "und ist damit ein klein wenig staerker als Du.") then
    schaetz_rel_min = ME.lp + 11
    schaetz_rel_max = ME.lp + 20
  elseif string.match(text, "und ist damit etwas staerker als Du.") then
    schaetz_rel_min = ME.lp + 21
    schaetz_rel_max = ME.lp + 30
  elseif string.match(text, "und ist damit staerker als Du.") then
    schaetz_rel_min = ME.lp + 31
    schaetz_rel_max = ME.lp + 50
  elseif string.match(text, "und ist damit deutlich staerker als Du.") then
    schaetz_rel_min = ME.lp + 51
    schaetz_rel_max = ME.lp + 80
  elseif string.match(text, "und ist damit viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 81
    schaetz_rel_max = ME.lp + 120
  elseif string.match(text, "und ist damit sehr viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 121
    schaetz_rel_max = ME.lp + 180
  elseif string.match(text, "und ist damit sehr sehr viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 181
    schaetz_rel_max = ME.lp + 250
  elseif string.match(text, "und ist damit ueberaus sehr viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 251
    schaetz_rel_max = ME.lp + 350
  elseif string.match(text, "und ist damit gewaltig staerker als Du.") then
    schaetz_rel_min = ME.lp + 351
    schaetz_rel_max = ME.lp + 500
  elseif string.match(text, "und ist damit unglaublich staerker als Du.") then
    schaetz_rel_min = ME.lp + 501
    schaetz_rel_max = ME.lp + 1000
  elseif string.match(text, "und ist damit wahnsinnig viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 1001
    schaetz_rel_max = ME.lp + 2000
  elseif string.match(text, "und ist damit weghiermaessig viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 2001
    schaetz_rel_max = ME.lp + 3000
  elseif string.match(text, "und ist damit jenseits aller Grenzen viel staerker als Du.") then
    schaetz_rel_min = ME.lp + 3000
    schaetz_rel_max = "oo"
  else -- huh?
    schaetz_rel_min = 0
    schaetz_rel_max = 0
  end

-- ----------------------------------------------------------------------------
--  Hands oder Waffe, welche DTs werden damit verursacht?
--    [Er|Sie|Es] macht damit folgenden Schaden: 

  local wp, dt = string.match(text, "%. ([^%.]-) macht folgenden Schaden: ([^%.]-)%.")
  if not wp then
    dt = string.match(text, "%. .- macht damit folgenden Schaden: ([^%.]-)%.")
    if not dt then
      schaetz_weapon = "???"
      schaetz_weapon_dt = "???"
    else
      schaetz_weapon = "ohne"
      schaetz_weapon_dt = dt
    end
  else
    -- doppelte Sätze löschen
    wp = string.gsub(wp, "^Eine? ", "")
    schaetz_weapon = wp
    schaetz_weapon_dt = dt
  end

-- ----------------------------------------------------------------------------
--  Wie gut ist die Waffe des Targets? (-6 bis +10)
--    Damit kaempft (er|sie|es) (.*) (als|wie) Du.

  local dmg = string.match(text, "Damit kaempft .- (.*) .- Du%.")
  local wp_qual
  if dmg == "unglaublich viel viel schlechter" then
    wp_qual = "-6"
  elseif dmg == "sehr viel schlechter" then
    wp_qual = "-5"
  elseif dmg == "viel schlechter" then
    wp_qual = "-4"
  elseif dmg == "deutlich schlechter" then
    wp_qual = "-3"
  elseif dmg == "schlechter" then
    wp_qual = "-2"
  elseif dmg == "etwas schlechter" then
    wp_qual = "-1"
  elseif dmg == "etwa genauso gut" then
    wp_qual = "0"
  elseif dmg == "etwas besser" then
    wp_qual = "1"
  elseif dmg == "besser" then
    wp_qual = "2"
  elseif dmg == "deutlich besser" then
    wp_qual = "3"
  elseif dmg == "viel besser" then
    wp_qual = "4"
  elseif dmg == "sehr viel besser" then
    wp_qual = "5"
  elseif dmg == "sehr sehr viel besser" then
    wp_qual = "6"
  elseif dmg == "ueberaus sehr viel besser" then
    wp_qual = "7"
  elseif dmg == "wahnsinnig viel besser" then
    wp_qual = "8"
  elseif dmg == "unbeschreiblich viel besser" then
    wp_qual = "9"
  elseif dmg == "jenseits aller Grenzen viel besser" then
    wp_qual = "10"
  else
    wp_qual = "?"
  end
 
  schaetz_weapon_qual = wp_qual


-- ----------------------------------------------------------------------------
--  Wie gut ist das Target geschuetzt? (-6 bis +13)
--    Damit ist (er|sie|es) (.*) (als|wie) Du geschuetzt.

  local arm = string.match(text, "Damit ist .- (.*) .- Du geschuetzt%.")
  local body_qual
  if arm then
    if arm == "unglaublich viel viel schlechter" then
      body_qual = "-6"
    elseif arm == "sehr viel schlechter" then
      body_qual = "-5"
    elseif arm == "viel schlechter" then
      body_qual = "-4"
    elseif arm == "deutlich schlechter" then
      body_qual = "-3"
    elseif arm == "schlechter" then
      body_qual = "-2"
    elseif arm == "etwas schlechter" then
      body_qual = "-1"
    elseif arm == "genauso gut" then
      body_qual = "0"
    elseif arm == "ein kleines bisschen besser" then
      body_qual = "1"
    elseif arm == "etwas besser" then
      body_qual = "2"
    elseif arm == "besser" then
      body_qual = "3"
    elseif arm == "deutlich besser" then
      body_qual = "4"
    elseif arm == "viel besser" then
      body_qual = "5"
    elseif arm == "sehr viel besser" then
      body_qual = "6"
    elseif arm == "viel viel besser" then
      body_qual = "7"
    elseif arm == "sehr sehr viel besser" then
      body_qual = "8"
    elseif arm == "ueberaus sehr viel besser" then
      body_qual = "9"
    elseif arm == "unglaublich viel besser" then
      body_qual = "10"
    elseif arm == "wahnsinnig viel besser" then
      body_qual = "11"
    elseif arm == "unbeschreiblich viel besser" then
      body_qual = "12"
    elseif arm == "jenseits aller Grenzen viel besser" then
      body_qual = "13"
    end
  else
    body_qual = "?"
  end
 
  schaetz_body_qual = body_qual
 
  if string.match(text, "ungewoehnlich dicke Haut, bzw. Fell") then
    schaetz_body_high = "!("
  else
    schaetz_body_high = "("
  end

-- ----------------------------------------------------------------------------
--  Anfaelligkeiten/Resistenzen *aechz*
--[[  (Er|Sie|Es) ist gegen (schneidenden Schaden|zerschmetternden Schaden|stechenden 
      Schaden|reissenden Schaden|peitschenden Schaden|zerquetschenden Schaden|
      explodierenden Schaden) (extrem anfaellig|sehr anfaellig|anfaellig|geschuetzt|
      sehr gut geschuetzt|extrem gut geschuetzt|voellig immun)
--]]
--[[  ".- ist gegen (^ )- Schaden (.-)%."
      "ist gegen ([%a]-) Schaden ([%a%s]-)%."
--]]
--[[  Ein kleiner Saeuredaemon ist absolut fit und ist damit ueberaus sehr viel staerker als Du. Er 
      kaempft mit aetzenden Klauen. Er macht damit folgenden Schaden: Reissen und Saeure. Damit kaempft 
      er deutlich besser als Du. Ein kleiner Saeuredaemon traegt ein Paar Adamantschuhe. Damit ist er 
      deutlich schlechter als Du geschuetzt. Er ist gegen zerschmetternden Schaden geschuetzt. Er ist 
      gegen schneidenden Schaden geschuetzt. Er ist gegen peitschenden Schaden sehr gut geschuetzt. Er 
      ist gegen reissenden Schaden sehr gut geschuetzt.  Ein kleiner Saeuredaemon ist etwa 187cm gross. 
--]]

  schaetz_max_res = ""
  schaetz_strong_res = ""
  schaetz_weak_res = ""
  schaetz_weak_anf = ""
  schaetz_strong_anf = ""
  schaetz_max_anf = ""
  local res_pat = "ist gegen ([%a]-) Schaden ([%a%s]-)%."

  for dt, r in string.gfind(text, res_pat) do
    dt = string.gsub(dt, 'zerschmetternden', 'Schlaege')
    dt = string.gsub(dt, 'schneidenden', 'Schnitte')
    dt = string.gsub(dt, 'stechenden','Stiche')
    dt = string.gsub(dt, 'peitschenden','Peitschen')
    dt = string.gsub(dt, 'zerquetschenden','Quetschen')
    dt = string.gsub(dt, 'explodierenden','Explosionen')
    dt = string.gsub(dt, 'reissenden','Reissen')
  end 

  if r == "extrem anfaellig" then
    schaetz_max_res = schaetz_max_res .. dt .. ", "
  elseif r == "sehr anfaellig" then
    schaetz_strong_res = schaetz_strong_res .. dt .. ", "
  elseif r == "anfaellig" then
    schaetz_weak_res = schaetz_weak_res .. dt .. ", "
  elseif r == "geschuetzt" then
    schaetz_weak_anf = schaetz_weak_anf .. dt .. ", "
  elseif r == "sehr gut geschuetzt" then
    schaetz_strong_anf = schaetz_strong_anf .. dt .. ", "
  elseif r == "extrem gut geschuetzt" then
    schaetz_max_anf = schaetz_max_anf .. dt .. ", "
  elseif r == "voellig immun" then
    schaetz_max_anf = schaetz_max_anf .. dt .. "!, "
  end

-- ----------------------------------------------------------------------------
--  Groesse merken
  schaetz_size = string.match(text, "ist etwa ([0-9]+)cm gross.")
  
-- ----------------------------------------------------------------------------
--  Ist das Target nicht mehr absolut fit, rechnen wir mal hoch, wieviel er
--  ungefaehr haette...

--[[
  if schaetz_abs then
    if schaetz_abs ~= 1 then
      if schaetz_rel_max == "oo" then
        schaetz_calc_100 = "Leben(10): " .. schaetz_rel_min * 10 / schaetz_abs .. " - oo"
      else
        schaetz_calc_100 = "Leben(10): " .. schaetz_rel_min * 10 / schaetz_abs .. " - " .. schaetz_rel_max * 10 / schaetz_abs 
      end
    else
      schaetz_calc_100 = ""
    end
  end
--]]



-- ----------------------------------------------------------------------------
--  Die Ruestungsliste scrollt auch so genug, also killen wir erstmal
--  saemtliche Artikel
--    traegt ([^.]*)%.

  local armor = string.match(text, "traegt ([^.]*)%.")
  
  if not armor then
    armor = "ohne"
  else
  
    armor = string.gsub(armor, "keine zusaetzliche Ruestung", "ohne")
    armor = string.gsub(armor, "den ", "")
    armor = string.gsub(armor, "die ", "")
    armor = string.gsub(armor, "das ", "")
    armor = string.gsub(armor, "einem ", "")
    armor = string.gsub(armor, "einen ", "")
    armor = string.gsub(armor, "eine ", "")
    armor = string.gsub(armor, "ein ", "")

--  Sachen, die nur scrollen, einen aber nicht interessieren (ToDo: Schalter
--  einbauen)

    armor = string.gsub(armor, "``Born to Kill''-Stirnband", "")
    armor = string.gsub(armor, "Eisschamanenpanzer", "ESP")
    armor = string.gsub(armor, "Anti-Feuer-Ring", "AFR")
    armor = string.gsub(armor, "drakonischen Waffenguertel", "Waffenguertel")
    armor = string.gsub(armor, "Kette mit Schaedelanhaenger", "DD-Kette")
    armor = string.gsub(armor, "Ruestung des Hydratoeters", "HyRue")
    armor = string.gsub(armor, "traumhafte Wespentaille", "")
    armor = string.gsub(armor, "schwarzen Siegelring", "")
    armor = string.gsub(armor, "Paar ", "")
    armor = string.gsub(armor, "goldenen Nasenring", "")
    armor = string.gsub(armor, "Polar-Button", "")
    armor = string.gsub(armor, "rotes Zipfelmuetzchen", "")
    armor = string.gsub(armor, "Schleimklumpen", "")
    armor = string.gsub(armor, "MASTERBLOCK", "")
    armor = string.gsub(armor, "Scoreamulett", "")
    armor = string.gsub(armor, "Goldkette", "")
    armor = string.gsub(armor, "magische Sonnenuhr", "")
    armor = string.gsub(armor, "adamantenen Ehering", "")
    armor = string.gsub(armor, "Verlobungsring", "")
    armor = string.gsub(armor, "Matrixkristall", "")
    armor = string.gsub(armor, "Armbanduhr", "")
    armor = string.gsub(armor, "Rucksack", "")
    armor = string.gsub(armor, "Drachentoeter-Orden", "")
    armor = string.gsub(armor, "Hundehalsband", "")
    armor = string.gsub(armor, "Fussring", "")
    armor = string.gsub(armor, ", ,", ",")
    armor = string.gsub(armor, ", ,", ",")
    armor = string.gsub(armor, ", ,", ",")

--  Fuehrende Kommata loeschen...
    if string.sub(armor,1,2) == ", " then
      armor = string.sub(armor,3)
    end
  end
  
  schaetz_armor = armor

-- ----------------------------------------------------------------------------
-- Start Ausgabe

  fg(farben.vg.info)
  bg(farben.hg.info)

-- ----------------------------------------------------------------------------
-- Lps und Waffe ausgeben (unproblematisch)

  if schaetz_abs  then 
    schaetz_abs  = " (" .. schaetz_abs * 100 .. "%)" 
  else
    schaetz_abs  = " (???%)"
  end


  echo("\n" .. target .. " (" .. schaetz_size .. " cm) geschaetzt:")
  echo("\nLeben" .. schaetz_abs .. ": " .. schaetz_rel_min .. " - " .. schaetz_rel_max)
  echo("\nWaffe (" .. schaetz_weapon_qual .. "): " .. schaetz_weapon .. " (" .. schaetz_weapon_dt .. ")")

 -- Ruestungen ausgeben
  echo("\nRuestung " .. schaetz_body_high .. schaetz_body_qual .. "): " .. schaetz_armor)

  -- Resistenzen ausgeben:
  if schaetz_max_res ~= "" then echo("\nResis (!): " .. schaetz_max_res) end
  if schaetz_strong_res ~= "" then echo("\nResis (+): " .. schaetz_strong_res) end
  if schaetz_weak_res ~= "" then echo("\nResis (-): " .. schaetz_weak_res) end
  if schaetz_weak_anf ~= "" then echo("\nResis (-): " .. schaetz_weak_anf) end
  if schaetz_strong_anf ~= "" then echo("\nResis (+): " .. schaetz_strong_anf) end
  if schaetz_max_anf ~= "" then echo("\nResis (!): " .. schaetz_max_anf) end

-- ----------------------------------------------------------------------------
-- Ende Ausgabe

  resetFormat()

end
