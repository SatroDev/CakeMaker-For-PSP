# Objects

Es una estructura que organiza los objetos como la arquitectua [MVC](https://es.wikipedia.org/wiki/Modelo–vista–controlador).

Posee propiedades que permite facilitar la programación.

Ej: 

```json
{
    "name": "player",
    "animation": "default",
    "speed": 10,
    "x": 0,
    "y": 0,
    "w": 0,
    "h": 0,
    "angle": 0,
    "rotation": 0,
    "visible": true,
    "center": false,
    "behaviors": []
}
```

## Behaviors

En cakemaker se implementa behaviors (comportamientos) personalizados, con el objetivo de añadir código ya hecho y agilizar el desarrollo.

Por defecto en cakemaker se incluye 3 comportamientos,
- entity -> Puede interactuar con los obstáculos.
- obstacle -> Interactúa con los objetos "entity".
- camera -> establece una cámara y se fija al objeto.

Ejemplo:

```json
{
    "name": "player",
    "animation": "default",
    "speed": 10,
    "x": 0,
    "y": 0,
    "w": 0,
    "h": 0,
    "angle": 0,
    "rotation": 0,
    "visible": true,
    "center": false,
    "behaviors": [
        "entity",
        "obstacle",
        "camera"
    ]
}
```

Para añadirlos en cakemaker deberás hacer lo siguiente:

    Crear la función y hacer referencia a ella.

```lua
    --Importar libería.
    require('cakemaker.cake')
    
    -- Incrementar la CPU.
    os.cpu(333)

    -- Cargar escena.
    cake.load_scene("src/scenes/default.json")

    -- Lo que se va a ejecutar.
    function my_function(obj):
        -- El objeto dara vueltas.
        obj.rotate = 2
    end

    -- Lo asociamos.
    game.behaviors["nombre"] = my_function

    while true do
        -- Leer las entradas.
        buttons.read()

        -- Actualizar eventos.
        cake.update()
        -- Desactivar el Anti-aliasing.
        screen.bilinear(0)

        -- Mostrar en pantalla.
        screen.flip()
    end
```

    Incluir en "behaviors" del objeto que se encuentra dentro del json.

```json
{
    "name": "player",
    "animation": "default",
    "speed": 10,
    "x": 0,
    "y": 0,
    "w": 0,
    "h": 0,
    "angle": 0,
    "rotation": 0,
    "visible": true,
    "center": false,
    "behaviors": [
        "nombre"
    ]
}
```
