#!/bin/bash

# Directorio para los archivos generados
outputDir="./dist"
mkdir -p "$outputDir"

# Ejecutar helm template y guardar la salida en un archivo temporal
tempFile="helm-output.tmp"
helm template nexp-api ./ -f values-gcp.yaml -f values.override.yaml > "$tempFile"

# Variables para almacenar el tipo y el nombre del recurso
kind=""
name=""
resourceContent=""
startNewResource=true

# Leer el archivo temporal y dividirlo en archivos separados
while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == "---" ]]; then
        # Escribir el contenido del recurso anterior, si existe
        if [[ -n "$kind" && -n "$name" ]]; then
            outputFile="${outputDir}/${kind}_${name}.yaml"
            echo "Writing ${outputFile}"
            echo "$resourceContent" > "$outputFile"
        fi
        # Reiniciar variables y contenido para el próximo recurso
        kind=""
        name=""
        resourceContent=""
        startNewResource=true
    else
        if [[ "$startNewResource" == true ]]; then
            resourceContent="$line"
            startNewResource=false
        else
            resourceContent="$resourceContent"$'\n'"$line"
        fi
        if [[ "$line" =~ ^kind:\ (.*) ]]; then
            kind=${BASH_REMATCH[1]}
        elif [[ "$line" =~ ^[[:space:]]*name:\ (.*) ]]; then
            name=${BASH_REMATCH[1]}
        fi
    fi
done < "$tempFile"

# Procesar el último recurso si existe
if [[ -n "$kind" && -n "$name" ]]; then
    outputFile="${outputDir}/${kind}_${name}.yaml"
    echo "Writing ${outputFile}"
    echo "$resourceContent" > "$outputFile"
fi

# Eliminar el archivo temporal
rm -f "$tempFile"

echo "Generate files on directory: $outputDir"
