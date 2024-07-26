    --Importar libería.
    require('cakemaker.cake')
    
    -- Incrementar la CPU.
    os.cpu(333)

    -- Cargar escena.
    cake.load_scene("src/scenes/default.json")

    local imagen = image.load("res/test.png")

    while true do
        -- Leér las entradas.
        buttons.read()

        -- Actualizar eventos.
        cake.update()
        -- Establecer el modo "pixelado".
        screen.bilinear(0)

        -- Puedes usar una función que se hedera de image.
        imagen:blit(0, 0)
        -- o puedes usar su función de forma de clase.
        image.blit(imagen, 0, 0)

        -- Obtener color y el decimal.
        local cx, cy = imagen:pixel(7, 0)

        -- Mostrar un texto con el color del primer pixel de la imagen.
        screen.print(0, 0, tostring(cx), 0.5, cx)

        -- Mostrar en pantalla.
        screen.flip()
    end