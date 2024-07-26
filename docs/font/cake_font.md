# Cake Font

Es una librería aparte de cakemaker y funciona igual que screen.print()
pero con la fuente de minecraft.

Ej:
```lua
    --Importar libería.
    require('cakemaker.cake')
    
    -- Añadir Fuente.
    local font = require('cakemaker.font')

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

        -- Mostrar texto.
        font.print(0, 0, "¡Hola Mundo!")

        -- Mostrar en pantalla.
        screen.flip()
    end
```