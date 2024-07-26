# cake.set(name, propierty, value)

Establece mediante el nombre del objeto e indicando el nuevo valor que tendra la propiedad.
Es una función con una estructura sencilla de enteder, pero lo ideal es usar una referencia del objeto
para obtener y establecer.

Ej:
```lua
    --Importar libería.
    require('cakemaker.cake')
    
    -- Incrementar la CPU.
    os.cpu(333)

    -- Cargar escena.
    cake.load_scene("src/scenes/default.json")

    -- Obtener objeto.
    local player = cake.get("player")

    while true do
        -- Leér las entradas.
        buttons.read()

        -- Actualizar eventos.
        cake.update()
        
        -- Establecer el modo "pixelado".
        screen.bilinear(0)

        -- Mostrar la posición del jugador.
        screen.print(0, 0, tostring(player.x).. " : " .. tostring(player.y))

        -- Mostrar en pantalla.
        screen.flip()
    end
```