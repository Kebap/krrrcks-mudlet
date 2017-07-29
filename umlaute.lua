-- Alias - Umlaute ersetzen

function umlaute_ersetzen(command)
    command = string.gsub(command, 'ü', 'ue' );
    command = string.gsub(command, 'ö', 'oe' );
    command = string.gsub(command, 'ä', 'ae' );
    command = string.gsub(command, 'Ä', 'Ae' );
    command = string.gsub(command, 'Ö', 'Oe' );
    command = string.gsub(command, 'Ü', 'Ue' );
    command = string.gsub(command, 'ß', 'ss' );
    send(command);
end

local code_string = "umlaute_ersetzen(command)"
local code_regex = "ü|ö|ä|Ü|Ö|Ä|ß"
tempAlias(code_regex, code_string)