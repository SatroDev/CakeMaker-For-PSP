# cake.toHex(color)

Recibe el parámetro "color" de tipo int, usualmente el parámetro que recibe
es un decimal.

En un caso aplicable es usando el "image.pixel(img, x, y)" o "nombreImagen:pixel(x, y)",
que permite obtener el color del pixel de una imagen.

Ej:
```lua
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

        -- Puedes usar una función que se hereda de image.
        imagen:blit(0, 0)
        -- O puedes usar su función de image.
        image.blit(imagen, 0, 0)

        -- Obtener color Hex y en decimal.
        local cx, cy = imagen:pixel(0, 0)

        -- Mostrar un texto con el color del primer pixel de la imagen.
        screen.print(0, 0, cake.toHex(cy), 0.5, cy)

        -- Mostrar en pantalla.
        screen.flip()
    end
```