# cake_get(name, propierty)

La función recibe dos parámetros, "name", nombre del objeto que se está por manipular y
"propierty", la propiedad que se va a extraer.

La función solo devuelve una referencia del objeto, no es una copia.

Ej:
```lua
    --Importar libería.
    require('cakemaker.cake')
    
    -- Incrementar la CPU.
    os.cpu(333)

    -- Cargar escena.
    cake.load_scene("src/scenes/default.json")

    -- Obtener objeto.
    local player = cake.get("player", "x")

    while true do
        -- Leér las entradas.
        buttons.read()

        -- Actualizar eventos.
        cake.update()
        
        -- Establecer el modo "pixelado".
        screen.bilinear(0)

        -- Mostrar la posición del jugador.
        screen.print(0, 0, tostring(player))

        -- Mostrar en pantalla.
        screen.flip()
    end
```