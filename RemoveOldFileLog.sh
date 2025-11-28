#!/bin/bash
CONFIG="paths.conf"

while IFS= read -r path; do
    # Saltar líneas vacías o comentarios
    [ -z "$path" ] && continue
    [[ "$path" =~ ^# ]] && continue

    # Si es un directorio, busco dentro; si es un patrón, lo uso directo
    if [ -d "$path" ]; then
        echo "Procesando directorio: $path"
        find "$path" -maxdepth 1 -type f -mtime +30 -print -delete
    else
        echo "Procesando patrón: $path"
        find $(dirname "$path") -maxdepth 1 -type f -name "$(basename "$path")" -mtime +30 -print -delete
    fi

done < "$CONFIG"

# how to use:
#------------
#  chmod +x cleaner.sh
# ./cleaner.sh
