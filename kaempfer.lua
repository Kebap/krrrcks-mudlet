-- Alias - Kämpfer: Grüße

function kaempfer_gruesse(matches)
    send("stehe still")
    send("gruesse "  .. matches[2])
end

local code_string = "kaempfer_gruesse(matches)"
local code_regex = "^#gruesse (.+)$"
tempAlias(code_regex, code_string)