--[[
    Apesar de ser una fuente expererimental, no ofrece el mejor rendimiento.
    La recomiendo solo en caso de mostrar 3-4 textos al estilo minecraft.
    Mi falta de dedicación convierte está fuente en una mala, ya bien, como
    podés apreciar, la forma que se ordenan los caracteres ya te guia 
    que la experiencia no va a ser la más optima.
]]--


local self = {}

function self.load_font(path)
    self.img = image.loadv(path or "cakemaker/ascii.png")
end

self.bit = {}
self.bit["none"] = {8, 88, 8, 8}

self.bit[""] = {0, 0, 0}
-- column 2
self.bit[" "] = {0, 16, 4}
self.bit["!"] = {8, 16, 2}
self.bit['"'] = {16, 16, 5}
self.bit["#"] = {24, 16, 6}
self.bit["$"] = {32, 16, 6}
self.bit["%"] = {40, 16, 6}
self.bit["&"] = {48, 16, 6}
self.bit["'"] = {56, 16, 3}
self.bit["("] = {64, 16, 5}
self.bit[")"] = {72, 16, 5}
self.bit["*"] = {80, 16, 5}
self.bit["+"] = {88, 16, 5}
self.bit[","] = {96, 16, 2}
self.bit["-"] = {104, 16, 6}
self.bit["."] = {112, 16, 3}
self.bit["/"] = {120, 16, 6}


-- column 3
self.bit["0"] = {0, 24, 6}
self.bit["1"] = {8, 24, 6}
self.bit["2"] = {16, 24, 6}
self.bit["3"] = {24, 24, 6}
self.bit["4"] = {32, 24, 6}
self.bit["5"] = {40, 24, 6}
self.bit["6"] = {48, 24, 6}
self.bit["7"] = {56, 24, 6}
self.bit["8"] = {64, 24, 6}
self.bit["9"] = {72, 24, 6}
self.bit[":"] = {80, 24, 2}
self.bit[";"] = {88, 24, 2}
self.bit["<"] = {96, 24, 5}
self.bit["="] = {104, 24, 6}
self.bit[">"] = {112, 24, 5}
self.bit["?"] = {120, 24, 5}

self.bit["@"] = {0, 32, 7}
self.bit["A"] = {8, 32, 6}
self.bit["B"] = {16, 32, 6}
self.bit["C"] = {24, 32, 6}
self.bit["D"] = {32, 32, 6}
self.bit["E"] = {40, 32, 6}
self.bit["F"] = {48, 32, 6}
self.bit["G"] = {56, 32, 6}
self.bit["H"] = {64, 32, 6}
self.bit["I"] = {72, 32, 4}
self.bit["J"] = {80, 32, 6}
self.bit["K"] = {88, 32, 6}
self.bit["L"] = {96, 32, 6}
self.bit["M"] = {104, 32, 6}
self.bit["N"] = {112, 32, 6}
self.bit["O"] = {120, 32, 6}

self.bit["P"] = {0, 40, 6}
self.bit["Q"] = {8, 40, 6}
self.bit["R"] = {16, 40, 6}
self.bit["S"] = {24, 40, 6}
self.bit["T"] = {32, 40, 6}
self.bit["U"] = {40, 40, 6}
self.bit["V"] = {48, 40, 6}
self.bit["W"] = {56, 40, 6}
self.bit["X"] = {64, 40, 6}
self.bit["Y"] = {72, 40, 6}
self.bit["Z"] = {80, 40, 6}

-- Letters: Lowercase
--self.bit["a"] = {0, 48, 6}
self.bit["a"] = {8, 48, 6}
self.bit["b"] = {16, 48, 6}
self.bit["c"] = {24, 48, 6}
self.bit["d"] = {32, 48, 6}
self.bit["e"] = {40, 48, 6}
self.bit["f"] = {48, 48, 5}
self.bit["g"] = {56, 48, 6}
self.bit["h"] = {64, 48, 6}
self.bit["i"] = {72, 48, 2}
self.bit["j"] = {80, 48, 6}
self.bit["k"] = {88, 48, 5}
self.bit["l"] = {96, 48, 3}
self.bit["m"] = {104, 48, 6}
self.bit["n"] = {112, 48, 6}
self.bit["o"] = {120, 48, 6}

self.bit["p"] = {0, 56, 6}
self.bit["q"] = {8, 56, 6}
self.bit["r"] = {16, 56, 6}
self.bit["s"] = {24, 56, 6}
self.bit["t"] = {32, 56, 4}
self.bit["u"] = {40, 56, 6}
self.bit["v"] = {48, 56, 6}
self.bit["w"] = {56, 56, 6}
self.bit["x"] = {64, 56, 6}
self.bit["y"] = {72, 56, 6}
self.bit["z"] = {80, 56, 6}
self.bit["{"] = {88, 56, 6}
self.bit["}"] = {104, 56, 6}
self.bit["~"] = {112, 56, 6}

self.bit["N~"] = {40, 80, 6}
self.bit["n~"] = {40, 80, 6}

function self.print(x, y, txt, color)
    local current_x = 0
    local text = tostring(txt)
    for i=1, string.len(text) do
        local char = text:sub(i, i)

        if string.byte(text:sub(i, i)) == 145 then
            char = "N~"
        elseif string.byte(text:sub(i, i)) == 177 then
            char = "n~"
        elseif string.byte(text:sub(i, i)) == 195 then
            char = ""
        elseif not self.bit[char] then
            char = "none"
            
        end

        image.blit(
            self.img,
            x + current_x,
            y,
            self.bit[char][1],
            self.bit[char][2],
            self.bit[char][3] or 8,
            self.bit[char][4] or 8
        )
        current_x += self.bit[char][3] or 8
    end
end

return self