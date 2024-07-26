# cake_get_all(name)

Devuelve una referencia del objeto, obteniendo todas las propiedades que esta inlcuye.

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