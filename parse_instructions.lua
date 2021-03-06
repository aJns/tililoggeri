local parse_instructions = {}

parse_instructions.nordea = {separator="tab"}
parse_instructions.nordea.remove = {"Tilinumero", "Kirjauspäivä"}
parse_instructions.nordea.keyline = {"Kirjauspäivä",
"Arvopäivä",
"Maksupäivä",
"Määrä",
"Saaja/Maksaja",
"Tilinumero",
"BIC",
"Tapahtuma",
"Viite",
"Maksajan viite",
"Viesti",
"Kortinnumero",
"Kuitti"}
parse_instructions.nordea.format = {date="Maksupäivä",
amount="Määrä",
peer="Saaja/Maksaja",
peer_account="Tilinumero",
code="Viite",
message="Viesti"}
parse_instructions.nordea.format.dateformat = {separator = ".",
order = {"d","M","y"}}

return parse_instructions
