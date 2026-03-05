#!/bin/bash

# переменные принимающие файл, расширение, новое расширение
files=()
extension=""
replacement=""

# проверка передачи параметров
while [[ $# -gt 0 ]]; do
    case $1 in
        --file)
            files+=("$2")
            shift 2
            ;;
        --extension)
            extension="$2"
            shift 2
            ;;
        --replacement)
            replacement="$2"
            shift 2
            ;;
        *)
            echo "Передан лишний параметр: $1"
            exit 1
            ;;
    esac
done

if [[ ${#files[@]} -eq 0 ]]; then
    echo "Ошибка: не указан файл"
    exit 1
fi

if [[ -z $extension ]]; then
    echo "Ошибка: не указано текущее расширение файла"
    exit 1
fi

if [[ -z $replacement ]]; then
    echo "Ошибка: не указано новое расширение файла"
    exit 1
fi

# работа с файлами по замене
for file in "${files[@]}"; do
    if [[ "$file" == *."$extension" ]]; then
        # меняем расширение
        echo "${file%.$extension}.$replacement"
    else
        echo "Некорректный запрос" >&2
        echo "$file"
    fi
done