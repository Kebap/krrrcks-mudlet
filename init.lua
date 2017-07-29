if exists("MorgenGrauen", "alias") == 0 then
	permGroup("MorgenGrauen", "alias")
end

if exists("MG Hilfe", "alias") == 0 then
	permAlias("MG Hilfe", "MorgenGrauen", [[^#mghilfe$]],
		[[
local mg_url = "http://mg.mud.de/"
if openWebPage then
	openWebPage( mg_url )
else
	openUrl( mg_url )
end
		]])
end

if exists("MG Skripte neu laden", "alias") == 0 then
	permAlias("MG Skripte neu laden", "MorgenGrauen", [[^#mgneu$]],
		[[
MG = false
MG_Skripte_laden()
]])
end


require("MG.settings")
require("MG.farbiger_text")
require("MG.umlaute")

require("MG.kaempfer")
-- require("MG.kaempfer_schaetz")

-- require("MG.gmcp")
-- require("MG.statuszeile")

-- require("MG.hilfetext")

-- require("MG.wege")
-- require("MG.hauseingang")

-- require("MG.tasten")

-- require("MG.mapper")