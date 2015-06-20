local parse_instructions = {}

parse_instructions.nordea = {separator="tab", startline=2}
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

return parse_instructions
