#!/bin/bash

# --- CONFIGURACIÓN DE SEGURIDAD TEMPORAL ---

# 1. Crear el archivo temporal usando mktemp.
# La opción '-t' añade un prefijo para identificar el archivo fácilmente.
# La extensión .png es clave para que 'wl-copy' y 'notify-send' lo reconozcan como imagen.
TEMP_FILE=$(mktemp -t screenshot_XXXXXXXX.png)

# 2. Configurar una 'trampa' (trap) para eliminar el archivo temporal.
# Esta línea asegura que el archivo se borre cuando el script reciba:
# - EXIT: La salida normal o cualquier error.
# - INT: Interrupción (p. ej., Ctrl+C).
# - TERM: Señal de terminación.
trap "rm -f \"$TEMP_FILE\"" EXIT INT TERM

# --- VARIABLES DEL SCRIPT ---

MODE=$1
FILENAME=$(basename "$TEMP_FILE") # Usamos el nombre generado por mktemp para los mensajes

# NOTA: Ya no necesitamos CAPTURE_DIR ni FILEPATH, solo usamos TEMP_FILE

# --- CASOS DEL SCRIPT ---

case $MODE in
    region_temp)
        # Captura, guarda temporalmente, y copia al portapapeles
        grim -g "$(slurp)" - | tee "$TEMP_FILE" | wl-copy
        NOTIFY_MSG="Region screenshoot copied"
        DETAIL_MSG="Image copied to clipboard and saved temporarily."
        ;;
    monitor_temp)
        # Captura, guarda temporalmente, y copia al portapapeles
        grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused).name')" - | tee "$TEMP_FILE" | wl-copy
        NOTIFY_MSG="Monitor screenshoot copied"
        DETAIL_MSG="Image copied to clipboard and saved temporarily."
        ;;
    window_temp)
        # Captura, guarda temporalmente, y copia al portapapeles
        grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | tee "$TEMP_FILE" | wl-copy
        NOTIFY_MSG="Window screenshoot copied"
        DETAIL_MSG="Image copied to clipboard and saved temporarily."
        ;;
    *)
        NOTIFY_MSG="Error"
        DETAIL_MSG="Error taking screenshoot or invalid mode."
        # En caso de error, salimos, y el trap se encargará de borrar TEMP_FILE
        exit 1
        ;;
esac

# --- NOTIFICACIÓN ---

# Usamos TEMP_FILE como miniatura. Si la captura fue exitosa, TEMP_FILE existe.
notify-send "$NOTIFY_MSG" "$DETAIL_MSG" -i "$TEMP_FILE"

# Cuando el script llegue aquí y termine, el 'trap' eliminará automáticamente $TEMP_FILE.
