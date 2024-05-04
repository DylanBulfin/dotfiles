left_only = [
    ["grv", "1", "2", "3", "4", "5", "6"],
    ["tab", "q", "w", "f", "p", "b"],
    ["esc", "a", "r", "s", "t", "g"],
    ["_", "z", "x", "c", "d", "v"],
    [],
]

left_flat = [x for sublist in left_only for x in sublist]

right_only = [
    ["7", "8", "9", "0", "-", "+", "bspc"],
    ["j", "l", "u", "y", ";", "[", "]", "\\"],
    ["m", "n", "e", "i", "o", "'", "ret"],
    ["k", "h", ",", ".", "/"],
    ["left", "down", "up", "right"],
]

right_flat = [x for sublist in right_only for x in sublist]

shared = [[], [], [], [], ["spc"]]

mod_map = {
    "a": "AR", "r": "MR", "s": "CR", "t": "SR", "n": "SL", "e": "CL", "i": "ML", "o": "AL",
}

class Layer:
    def __init__(self, hand, alt, meta, ctrl, shift):
        self.hand = hand # "L" or "R", "L" means left hand should be modified (e.g. a right hand mod was pressed)
        self.alt = alt
        self.meta = meta
        self.ctrl = ctrl
        self.shift = shift

    def name(self):
        return f"{self.hand}{self.alt}{self.meta}{self.ctrl}{self.shift}"

    def mod_list(self):
        s = ""
        if self.alt:
            s += "A"
        if self.meta:
            s += "M"
        if self.ctrl:
            s += "C"
        if self.shift:
            s += "S"
        return s

def get_modified_key(key, layer):
    if key == "_":
        return key

    if key in mod_map.keys():
        m = mod_map[key][0]
        if mod_map[key][1] == layer.hand:
            if m in layer.mod_list():
                return "_"
            else:
                if m == "A":
                    return f"@{Layer(layer.hand, 1, layer.meta, layer.ctrl, layer.shift).name()}"
                elif m == "M":
                    return f"@{Layer(layer.hand, layer.alt, 1, layer.ctrl, layer.shift).name()}"
                elif m == "C":
                    return f"@{Layer(layer.hand, layer.alt, layer.meta, 1, layer.shift).name()}"
                elif m == "S":
                    return f"@{Layer(layer.hand, layer.alt, layer.meta, layer.ctrl, 1).name()}"

    if key in left_flat and layer.hand == "R":
        return key
    if key in right_flat and layer.hand == "L":
        return key

    name = ""
    if layer.alt:
        name += "A-"
    if layer.meta:
        name += "M-"
    if layer.ctrl:
        name += "C-"
    if layer.shift:
        name += "S-"

    name += key
    return name

def get_modified_base(key):
    if key in mod_map.keys():
        m = mod_map[key][0]
        if m == "A":
            return f"(toggle-layer {Layer(mod_map[key][1], 1, 0, 0, 0).name()})"
        if m == "M":
            return f"(toggle-layer {Layer(mod_map[key][1], 0, 1, 0, 0).name()})"
        if m == "C":
            return f"(toggle-layer {Layer(mod_map[key][1], 0, 0, 1, 0).name()})"
        if m == "S":
            return f"(toggle-layer {Layer(mod_map[key][1], 0, 0, 0, 1).name()})"

    else:
        return key


LAYERS = [
    Layer("L", 0, 0, 0, 1),
    Layer("L", 0, 0, 1, 0),
    Layer("L", 0, 0, 1, 1),
    Layer("L", 0, 1, 0, 0),
    Layer("L", 0, 1, 0, 1),
    Layer("L", 0, 1, 1, 0),
    Layer("L", 0, 1, 1, 1),
    Layer("L", 1, 0, 0, 0),
    Layer("L", 1, 0, 0, 1),
    Layer("L", 1, 0, 1, 0),
    Layer("L", 1, 0, 1, 1),
    Layer("L", 1, 1, 0, 0),
    Layer("L", 1, 1, 0, 1),
    Layer("L", 1, 1, 1, 0),
    Layer("L", 1, 1, 1, 1),
    Layer("R", 0, 0, 0, 1),
    Layer("R", 0, 0, 1, 0),
    Layer("R", 0, 0, 1, 1),
    Layer("R", 0, 1, 0, 0),
    Layer("R", 0, 1, 0, 1),
    Layer("R", 0, 1, 1, 0),
    Layer("R", 0, 1, 1, 1),
    Layer("R", 1, 0, 0, 0),
    Layer("R", 1, 0, 0, 1),
    Layer("R", 1, 0, 1, 0),
    Layer("R", 1, 0, 1, 1),
    Layer("R", 1, 1, 0, 0),
    Layer("R", 1, 1, 0, 1),
    Layer("R", 1, 1, 1, 0),
    Layer("R", 1, 1, 1, 1)
]

ROWS = 5

def generate():
    for layer in LAYERS:
        layer_str = f"(deflayer {layer.name()}\n"
        for i in range(ROWS):
            row = ""
            for key in left_only[i]:
                row += f" {get_modified_key(key, layer)}"
            for key in shared[i]:
                row += f" {get_modified_key(key, layer)}"
            for key in right_only[i]:
                row += f" {get_modified_key(key, layer)}"


            layer_str += row + "\n"

        layer_str += ")\n"

        print(layer_str)

    # for n in [x.name() for x in LAYERS]:
    #     print(f"{n} (layer-toggle {n}))")
generate()
