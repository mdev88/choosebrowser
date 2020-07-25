#!/bin/bash

declare -A browsers # <-- No tocar esta línea!

########################################
###  LA CONFIGURACIÓN COMIENZA AQUÍ  ###

# Path a yad (requerido)
YAD=/usr/bin/yad  

# Habilitá tus navegadores descomentando las líneas
# y editando el path

## Firefox
FIREFOX=/usr/lib/firefox/firefox
browsers["Firefox"]=Firefox:0

## Google Chrome
CHROME=/usr/bin/google-chrome-stable
browsers["Chrome"]=Chrome:1

## Chromium
#CHROMIUM=/usr/lib/chromium-browser
#browsers["Chromium"]=Chromium:2

## Brave browser
#BRAVE=/usr/bin/brave-browser
#browsers["Brave"]=Brave:3


###  FIN DE LA CONFIGURACIÓN  ###
#################################


### NO NECESITÁS CAMBIAR NADA DEBAJO DE ESTA LÍNEA ###


# Verifico que yad esté en el path

if [ ! -f "$YAD" ]; then
    echo "$YAD no se encontró en la ruta configurada."
    exit
fi

# Verifico que se haya recibido un argumento y sólo uno
if [ $# -ne 1 ]; then
	echo "Uso: $0 <URL>"
	exit
fi 


LINK=$1  # Link que se va a abrir

# Armo el comando de yad
YAD_HEAD="$YAD --title Abrir en..."

for key in ${!browsers[@]}; do
    YAD_BUTTONS="$YAD_BUTTONS --button=${browsers[${key}]}"
done

YAD_TAIL=">& /dev/null"


# Muestro el diálogo
$YAD_HEAD $YAD_BUTTONS $YAD_TAIL

# Guardo la respuesta
ANSWER=$?

# Abro el navegador correspondiente
if [ $ANSWER -eq 0 ]; then
	$FIREFOX $LINK &
fi

if [ $ANSWER -eq 1 ]; then
	$CHROME $LINK &
fi

if [ $ANSWER -eq 2 ]; then
	$CHROMIUM $LINK &
fi

if [ $ANSWER -eq 3 ]; then
	$BRAVE $LINK &
fi
