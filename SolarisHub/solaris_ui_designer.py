import tkinter as tk
from tkinter import ttk, colorchooser, filedialog, messagebox, simpledialog

# --- Modèle d'élément UI ---
class UIElement:
    def __init__(self, element_type, props):
        self.type = element_type
        self.props = props.copy()
        self.widget = None  # Tkinter widget (pour l'aperçu)
        self.selected = False

    def to_lua(self, varname):
        # Génère le code Lua pour cet élément
        p = self.props
        if self.type == "Frame":
            return f"{varname} = SolarisUi.CreateFrame({p['size']}, {p['position']}, {p['bgcolor']}, {p['border']})"
        elif self.type == "Button":
            return f"{varname} = SolarisUi.CreateButton({repr(p['text'])}, {p['size']}, {p['position']}, {p['bgcolor']}, {p['textcolor']}, {p['font']})"
        elif self.type == "Label":
            return f"{varname} = SolarisUi.CreateTextLabel({repr(p['text'])}, {p['size']}, {p['position']}, {p['textcolor']}, {p['font']}, {p['bgtransp']})"
        elif self.type == "TextBox":
            return f"{varname} = SolarisUi.CreateTextBox({repr(p['placeholder'])}, {p['size']}, {p['position']}, {p['textcolor']}, {p['font']}, {p['bgtransp']})"
        elif self.type == "Image":
            return f"{varname} = SolarisUi.CreateImageLabel({repr(p['image'])}, {p['size']}, {p['position']}, {p['bgtransp']})"
        # Ajoute d'autres types si besoin
        return f"-- {self.type} non supporté"

# --- Application principale ---
class SolarisUIDesigner(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Solaris UI Designer")
        self.geometry("1200x700")
        self.elements = []
        self.selected = None
        self.canvas_elements = []
        self.next_id = 1

        # Variables pour le Drag & Drop
        self.dragging_element = None
        self.drag_start_x = 0
        self.drag_start_y = 0
        self.drag_element_start_props_x = 0  # Offset X de l'élément au début du drag
        self.drag_element_start_props_y = 0  # Offset Y de l'élément au début du drag

        self.setup_sidebar()
        self.setup_canvas()
        self.setup_properties()

    def setup_sidebar(self):
        sidebar = tk.Frame(self, width=200, bg="#181818")
        sidebar.pack(side="left", fill="y")
        tk.Label(sidebar, text="Ajouter un élément", bg="#181818", fg="#fff", font=("Segoe UI", 12, "bold")).pack(pady=10)
        for name in ["Frame", "Button", "Label", "TextBox", "Image"]:
            b = tk.Button(sidebar, text=name, command=lambda n=name: self.add_element(n),
                         bg="#282828", fg="#fff", activebackground="#a97fc7", activeforeground="#fff",
                         relief="flat", font=("Segoe UI", 10, "bold"), bd=0, highlightthickness=0)
            b.pack(fill="x", padx=16, pady=4, ipady=4)
        tk.Button(sidebar, text="Exporter Lua", command=self.export_lua,
                  bg="#a97fc7", fg="#fff", font=("Segoe UI", 10, "bold"), relief="flat", bd=0, highlightthickness=0, activebackground="#7e5a9b").pack(side="bottom", pady=20, padx=16, fill="x")
        tk.Button(sidebar, text="Nouveau projet", command=self.new_project,
                  bg="#444", fg="#fff", font=("Segoe UI", 10), relief="flat", bd=0, highlightthickness=0, activebackground="#222").pack(side="bottom", pady=2, padx=16, fill="x")
        tk.Button(sidebar, text="Importer JSON", command=self.import_json,
                  bg="#444", fg="#fff", font=("Segoe UI", 10), relief="flat", bd=0, highlightthickness=0, activebackground="#222").pack(side="bottom", pady=2, padx=16, fill="x")

    def setup_canvas(self):
        self.canvas = tk.Canvas(self, bg="#444", width=800, height=700)
        self.canvas.pack(side="left", fill="both", expand=True)
        self.canvas.bind("<ButtonPress-1>", self.on_canvas_press)
        self.canvas.bind("<B1-Motion>", self.on_canvas_drag)
        self.canvas.bind("<ButtonRelease-1>", self.on_canvas_release)

    def setup_properties(self):
        self.prop_frame = tk.Frame(self, width=300, bg="#23202b")
        self.prop_frame.pack(side="right", fill="y")
        tk.Label(self.prop_frame, text="Propriétés", bg="#23202b", fg="#fff", font=("Segoe UI", 13, "bold")).pack(pady=10)
        self.prop_widgets = {}
        tk.Button(self.prop_frame, text="Exporter JSON", command=self.export_json,
                  bg="#444", fg="#fff", font=("Segoe UI", 10), relief="flat", bd=0, highlightthickness=0, activebackground="#222").pack(side="bottom", pady=8, padx=16, fill="x")

    def add_element(self, element_type):
        # Valeurs par défaut
        props = {
            "size": "UDim2.new(0,100,0,40)",
            "position": "UDim2.new(0,50,0,50)",
            "bgcolor": "Color3.fromRGB(40,40,40)",
            "border": "0",
            "text": "Button" if element_type == "Button" else "Label",
            "textcolor": "Color3.fromRGB(255,255,255)",
            "font": "Enum.Font.SourceSans",
            "bgtransp": "0",
            "placeholder": "Entrer du texte...",
            "image": "rbxassetid://0"
        }
        if element_type == "Frame":
            props = {k: props[k] for k in ["size", "position", "bgcolor", "border"]}
        elif element_type == "Button":
            props = {k: props[k] for k in ["text", "size", "position", "bgcolor", "textcolor", "font"]}
        elif element_type == "Label":
            props = {k: props[k] for k in ["text", "size", "position", "textcolor", "font", "bgtransp"]}
        elif element_type == "TextBox":
            props = {k: props[k] for k in ["placeholder", "size", "position", "textcolor", "font", "bgtransp"]}
        elif element_type == "Image":
            props = {k: props[k] for k in ["image", "size", "position", "bgtransp"]}

        elem = UIElement(element_type, props)
        self.elements.append(elem)
        self.draw_elements()
        self.select_element(elem)

    def draw_elements(self):
        self.canvas.delete("all")
        for idx, elem in enumerate(self.elements):
            x, y, w, h = self.parse_position_size(elem.props)
            border_color = "#a97fc7" if elem.selected else "#555"
            fill_color = "#282828"

            if elem.type == "Frame":
                fill_color = self.roblox_color_to_hex(elem.props.get("bgcolor", "Color3.fromRGB(40,40,40)"))
                r = self.canvas.create_rectangle(x, y, x+w, y+h, fill=fill_color, outline=border_color, width=2, tags=f"elem_{idx}")
                self.canvas.create_text(x+5, y+5, anchor="nw", text="Frame", fill="#ccc", font=("Segoe UI", 8), tags=f"elem_{idx}_text")
            elif elem.type == "Button":
                fill_color = self.roblox_color_to_hex(elem.props.get("bgcolor", "Color3.fromRGB(60,60,60)"))
                text_color = self.roblox_color_to_hex(elem.props.get("textcolor", "Color3.fromRGB(255,255,255)"))
                r = self.canvas.create_rectangle(x, y, x+w, y+h, fill=fill_color, outline=border_color, width=2, tags=f"elem_{idx}")
                self.canvas.create_text(x+w//2, y+h//2, text=elem.props.get("text", "Button"), fill=text_color, font=("Segoe UI", 9), tags=f"elem_{idx}_text")
            elif elem.type == "Label":
                bg_transp = float(elem.props.get("bgtransp", "0"))
                if bg_transp < 1.0:
                    fill_color = self.roblox_color_to_hex(elem.props.get("bgcolor", "Color3.fromRGB(40,40,40)"))
                else:
                    fill_color = ""
                
                text_color = self.roblox_color_to_hex(elem.props.get("textcolor", "Color3.fromRGB(255,255,255)"))
                r = self.canvas.create_rectangle(x, y, x+w, y+h, fill=fill_color, outline=border_color if bg_transp < 1.0 else "", width=2 if bg_transp < 1.0 else 0, tags=f"elem_{idx}")
                self.canvas.create_text(x+5, y+5, anchor="nw", text=elem.props.get("text","Label"), fill=text_color, font=("Segoe UI", 9), tags=f"elem_{idx}_text")
            elif elem.type == "TextBox":
                fill_color = self.roblox_color_to_hex(elem.props.get("bgcolor", "Color3.fromRGB(30,30,30)"))
                text_color = self.roblox_color_to_hex(elem.props.get("textcolor", "Color3.fromRGB(220,220,220)"))
                r = self.canvas.create_rectangle(x, y, x+w, y+h, fill=fill_color, outline=border_color, width=2, tags=f"elem_{idx}")
                self.canvas.create_text(x+10, y+h//2, anchor="w", text=elem.props.get("placeholder", "..."), fill=text_color, font=("Segoe UI", 9), tags=f"elem_{idx}_text")
            elif elem.type == "Image":
                r = self.canvas.create_rectangle(x, y, x+w, y+h, fill="#111", outline=border_color, width=2, tags=f"elem_{idx}")
                self.canvas.create_text(x+w//2, y+h//2, text="Image", fill="#ccc", font=("Segoe UI", 9), tags=f"elem_{idx}_text")

    def roblox_color_to_hex(self, color_str):
        try:
            if "Color3.fromRGB" in color_str:
                parts = color_str.replace("Color3.fromRGB(", "").replace(")", "").split(",")
                r, g, b = int(parts[0]), int(parts[1]), int(parts[2])
                return f"#{r:02x}{g:02x}{b:02x}"
            elif "Color3.new" in color_str:
                parts = color_str.replace("Color3.new(", "").replace(")", "").split(",")
                r, g, b = int(float(parts[0])*255), int(float(parts[1])*255), int(float(parts[2])*255)
                return f"#{r:02x}{g:02x}{b:02x}"
        except:
            pass
        return "#CCCCCC"

    def parse_position_size(self, props):
        def parse_udim2(s):
            try:
                parts = s.replace("UDim2.new(", "").replace(")", "").split(",")
                x = int(parts[1])
                y = int(parts[3])
                return x, y
            except:
                return 50, 50
        def parse_size(s):
            try:
                parts = s.replace("UDim2.new(", "").replace(")", "").split(",")
                w = int(parts[1])
                h = int(parts[3])
                return w, h
            except:
                return 100, 40
        x, y = parse_udim2(props.get("position", "UDim2.new(0,50,0,50)"))
        w, h = parse_size(props.get("size", "UDim2.new(0,100,0,40)"))
        return x, y, w, h

    def select_element(self, elem_to_select):
        if self.selected == elem_to_select:
            return 
        
        for e in self.elements:
            e.selected = False
        if elem_to_select:
            elem_to_select.selected = True
        self.selected = elem_to_select
        
        self.draw_elements()
        if elem_to_select:
            self.show_properties(elem_to_select)
        else:
            for w in self.prop_widgets.values():
                w.destroy()
            self.prop_widgets = {}
            if hasattr(self, 'prop_inner'):
                self.prop_inner.destroy()

    def show_properties(self, elem):
        for w in self.prop_widgets.values():
            w.destroy()
        self.prop_widgets = {}
        if hasattr(self, 'prop_inner'):
            self.prop_inner.destroy()
        self.prop_inner = tk.Frame(self.prop_frame, bg="#333")
        self.prop_inner.pack(fill="both", expand=True)
        row = 0
        for k, v in elem.props.items():
            label = tk.Label(self.prop_inner, text=k, bg="#222", fg="#fff", font=("Segoe UI", 10, "bold"), bd=0, relief="flat")
            label.pack(fill="x", padx=10, pady=(8 if row==0 else 2, 2))
            entry = tk.Entry(self.prop_inner, bg="#444", fg="#fff", insertbackground="#fff", relief="flat", font=("Segoe UI", 10))
            entry.insert(0, v)
            entry.pack(fill="x", padx=10, pady=2)
            entry.bind("<FocusOut>", lambda e, key=k, ent=entry: self.update_prop(key, ent.get()))
            self.prop_widgets[k] = entry
            row += 1
        del_btn = tk.Button(self.prop_inner, text="Supprimer", command=self.delete_selected, bg="#c44", fg="#fff", relief="flat", font=("Segoe UI", 10, "bold"), activebackground="#a22")
        del_btn.pack(fill="x", padx=10, pady=10)

    def update_prop(self, key, value):
        if self.selected:
            self.selected.props[key] = value
            self.draw_elements()

    def delete_selected(self):
        if self.selected in self.elements:
            self.elements.remove(self.selected)
            self.selected = None
            self.draw_elements()
            for w in self.prop_widgets.values():
                w.destroy()
            self.prop_widgets = {}

    def on_canvas_click(self, event):
        self.select_element(None)

    def find_element_at(self, x, y):
        for elem in reversed(self.elements):
            ex, ey, ew, eh = self.parse_position_size(elem.props)
            if ex <= x <= ex + ew and ey <= y <= ey + eh:
                return elem
        return None

    def on_canvas_press(self, event):
        found_element = self.find_element_at(event.x, event.y)
        if found_element:
            self.select_element(found_element)
            self.dragging_element = found_element
            self.drag_start_x = event.x
            self.drag_start_y = event.y
            current_pos_x, current_pos_y = self.parse_udim2_offsets(self.dragging_element.props.get("position"))
            self.drag_element_start_props_x = current_pos_x
            self.drag_element_start_props_y = current_pos_y
        else:
            self.on_canvas_click(event)

    def on_canvas_drag(self, event):
        if self.dragging_element:
            dx = event.x - self.drag_start_x
            dy = event.y - self.drag_start_y

            new_props_x = self.drag_element_start_props_x + dx
            new_props_y = self.drag_element_start_props_y + dy
            
            current_pos_str = self.dragging_element.props.get("position", "UDim2.new(0,0,0,0)")
            try:
                parts = current_pos_str.replace("UDim2.new(", "").replace(")", "").split(",")
                scale_x = parts[0].strip()
                scale_y = parts[2].strip()
            except:
                scale_x = "0"
                scale_y = "0"

            self.dragging_element.props["position"] = f"UDim2.new({scale_x}, {new_props_x}, {scale_y}, {new_props_y})"
            
            self.draw_elements()
            self.show_properties(self.dragging_element)

    def on_canvas_release(self, event):
        self.dragging_element = None

    def parse_udim2_offsets(self, udim2_str):
        try:
            parts = udim2_str.replace("UDim2.new(", "").replace(")", "").split(",")
            offset_x = int(parts[1])
            offset_y = int(parts[3])
            return offset_x, offset_y
        except:
            return 0, 0

    def export_lua(self):
        if not self.elements:
            messagebox.showinfo("Export", "Aucun élément à exporter.")
            return
        lua = [
            "-- Généré par Solaris UI Designer",
            "local SolarisUi = require(path_to_SolarisUi)",
            ""
        ]
        for idx, elem in enumerate(self.elements):
            varname = f"elem{idx+1}"
            lua.append(elem.to_lua(varname))
        lua.append("-- Ajoutez vos parents et hiérarchies ici")
        file = filedialog.asksaveasfilename(defaultextension=".lua", filetypes=[("Lua files", "*.lua")])
        if file:
            with open(file, "w", encoding="utf-8") as f:
                f.write("\n".join(lua))
            messagebox.showinfo("Export", f"Code Lua exporté dans {file}")

    def new_project(self):
        if messagebox.askyesno("Nouveau projet", "Effacer tous les éléments ?"):
            self.elements.clear()
            self.selected = None
            self.draw_elements()
            for w in self.prop_widgets.values():
                w.destroy()
            self.prop_widgets = {}

    def import_json(self):
        file = filedialog.askopenfilename(defaultextension=".json", filetypes=[("JSON files", "*.json")])
        if not file:
            return
        import json
        with open(file, "r", encoding="utf-8") as f:
            data = json.load(f)
        self.elements.clear()
        for elem in data.get("elements", []):
            self.elements.append(UIElement(elem["type"], elem["props"]))
        self.selected = None
        self.draw_elements()
        for w in self.prop_widgets.values():
            w.destroy()
        self.prop_widgets = {}

    def export_json(self):
        import json
        data = {"elements": [{"type": e.type, "props": e.props} for e in self.elements]}
        file = filedialog.asksaveasfilename(defaultextension=".json", filetypes=[("JSON files", "*.json")])
        if file:
            with open(file, "w", encoding="utf-8") as f:
                json.dump(data, f, indent=2)
            messagebox.showinfo("Export", f"Projet exporté dans {file}")

if __name__ == "__main__":
    SolarisUIDesigner().mainloop()