# cake.update()

No recibe parámetros ni devuelve, hace que la librería funcione,
más bien, hace posible que los objetos y la lógica funcione. 

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

        -- Mostrar en pantalla.
        screen.flip()
    end
```