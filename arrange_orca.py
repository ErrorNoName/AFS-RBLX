import re

# Fichier source et destination
input_file = "c:/Users/jonha/Documents/MyExploit/OrcaV2.lua"
output_file = "c:/Users/jonha/Documents/MyExploit/OrcaV2_arranged.lua"

def add_newlines_and_indent(lua_code):
    # Ajoute des retours à la ligne après les points-virgules, les end, else, elseif, function, local, return, do, then, until
    code = re.sub(r";", ";\n", lua_code)
    code = re.sub(r"\b(end|else|elseif|function|local|return|do|then|until)\b", r"\n\1", code)
    # Ajoute un retour à la ligne après les accolades fermantes
    code = re.sub(r"\}", "}\n", code)
    # Ajoute un retour à la ligne après les parenthèses fermantes suivies d'une accolade ouvrante
    code = re.sub(r"\)\s*{", ")\n{", code)
    # Nettoie les doubles/triples retours à la ligne
    code = re.sub(r"\n{2,}", "\n", code)
    # Sépare les instructions sur la même ligne
    code = re.sub(r"(\bend\b|\})\s*", r"\1\n", code)
    return code

def indent_code(lua_code):
    lines = lua_code.split('\n')
    indent = 0
    indented_lines = []
    for line in lines:
        stripped = line.strip()
        if not stripped:
            indented_lines.append('')
            continue
        # Diminue l'indentation pour end, else, elseif, until
        if re.match(r"^(end|else|elseif|until|})", stripped):
            indent = max(indent - 1, 0)
        indented_lines.append('    ' * indent + stripped)
        # Augmente l'indentation pour function, do, then, repeat, { (sauf si la ligne se termine par end)
        if re.match(r"(function|do|then|repeat|{)", stripped) and not re.match(r".*end$", stripped):
            indent += 1
        # Diminue l'indentation après until
        if re.match(r"^until", stripped):
            indent = max(indent - 1, 0)
    return '\n'.join(indented_lines)

def main():
    with open(input_file, 'r', encoding='utf-8') as f:
        lua_code = f.read()
    code_with_newlines = add_newlines_and_indent(lua_code)
    pretty_code = indent_code(code_with_newlines)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(pretty_code)
    print(f"Fichier arrangé écrit dans {output_file}")

if __name__ == "__main__":
    main()
