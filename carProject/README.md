Voud trouvez cinq fichiers texte :

* main.lua : le fichier que lance Corona 
* config.lua : le fichier de configuration de l'application 
* build.settings : le fichier de configuration pour compiler l'application 
* constants.lua : des constantes 
* utils.lua : des utilitaires 

Seul le premier est réellement requis pour lancer le simulateur. Les deux suivants sont nécessaires pour compiler l'application. Les deux derniers comportent des bouts de code utiles et utilsées par toutes les applications. 

### main.lua 

Pour le moment, nous allons limiter main.lua à son expression la plus simple, à savoir : 

```lua 
require("constants")
require("utils")
```
Ceci chargera les fichiers utils.lua et constants.lua


### config.lua 
Le fichier config.lua est un peu plus compliqué :
```lua
local aspectRatio = display.pixelHeight / display.pixelWidth

local aspectRatio = display.pixelHeight / display.pixelWidth
application = {
  content={
   width= (aspectRatio<1.5 and 800 or math.floor(1200/aspectRatio+1),
   height= (aspectRatio>1.5 and 1200 or math.floor(800*aspectRatio+1),
   scale = "letterBox",
   fps = 30,
   imageSuffix = {
     ["@2x"] = 1.3,
   },
  }
}
```


### build.settings

Le fichier build settings est un fichier quasi vide, qui ne contient pour le moment que des données d'orientation. (ici, il force l'orientation en portrait)

```lua
-- Supported values for orientation:-- Supported values for orientation:-- portrait, portraitUpsideDown, landscapeLeft, landscapeRight
settings = {
 orientation = { default = "portrait", supported = { "portrait", "portraitUpsideDown" } },

plugins = {    },
 iphone = { plist = {} },
    android = {    }
}
```

### constants.lua