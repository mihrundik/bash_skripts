#!/bin/bash

# переменные
file=""
search=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --file) file="$2"; shift 2 ;;
        --search) search="$2"; shift 2 ;;
        *) echo "Передан лишний параметр"; exit 1 ;;
    esac
done

# параметры переданы
if [[ -z "$file" || -z "$search" ]]; then
    echo "Ошибка: нужно указать --file и --search"
    exit 1
fi

# файл существует
if [[ ! -f "$file" ]]; then
    echo "Ошибка: файл '$file' не существует"
    exit 1
fi

# полный путь
full_path=$(realpath "$file")


# количество совпадений
count=$(grep -c "$search" "$file" 2>/dev/null)

# результат
if [[ -z "$count" || "$count" -eq 0 ]]; then
    echo "Совпадений в файле $full_path не найдено"
else
    echo "Найдено $count совпадений в файле $full_path"
fi