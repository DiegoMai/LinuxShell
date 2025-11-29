#config file:
/var/log/app *.log 30
/home/user/tmp *.txt 90
/opt/data backup_*.zip 365



#!/bin/bash

CONFIG="paths.conf"

while IFS= read -r line; do
    # Saltar líneas vacías o comentarios
    [ -z "$line" ] && continue
    [[ "$line" =~ ^# ]] && continue

    # Parsear: directorio, patrón, días
    dir=$(echo "$line" | awk '{print $1}')
    pattern=$(echo "$line" | awk '{print $2}')
    days=$(echo "$line" | awk '{print $3}')

    # Validaciones básicas
    if [ ! -d "$dir" ]; then
        echo "Directorio inexistente: $dir"
        continue
    fi

    if [[ -z "$pattern" || -z "$days" ]]; then
        echo "Línea inválida (faltan campos): $line"
        continue
    fi

    echo "Procesando $dir | patrón: $pattern | >$days días"

    find "$dir" -maxdepth 1 -type f -name "$pattern" -mtime +"$days" -print -delete

done < "$CONFIG"


# how to use:
#------------
chmod +x cleaner.sh
./cleaner.sh
