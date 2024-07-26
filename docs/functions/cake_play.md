# cake.play(name)

Mediante la estructura de "sound" se puede reproducir sonidos de una forma más comoda.

Ej:
```lua
    --Importar libería.
    require('cakemaker.cake')
    
    -- Incrementar la CPU.
    os.cpu(333)

    -- Cargar escena.
    cake.load_scene("src/scenes/default.json")

    while true do
        -- Leér las entradas.
        buttons.read()

        -- Actualizar eventos.
        cake.update()
        
        -- Establecer el modo "pixelado".
        screen.bilinear(0)

        -- Voltear animación.
        cake.play("jump")

        -- Mostrar en pantalla.
        screen.flip()
    end
```