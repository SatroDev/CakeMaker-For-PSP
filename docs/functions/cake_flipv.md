# cake.flipv(name)

Establece al objeto que se voltee de forma vertical.
Si bien, es una estructura fácil de entender, recomiendo obtener
la referencia del objeto y modificar la propiedad misma, la propiedad "flipv" (booleano).

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
        cake.flipv("player")

        -- Mostrar en pantalla.
        screen.flip()
    end
```