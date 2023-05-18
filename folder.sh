#!/bin/bash  -  первая строчка “шебанг” означает что скрипт будет выполняться в оболочке “bash”

# Указываем к-во папок для создания и путь к директории куда они должны сохраниться 


folders_count=10

path_to_save=/home/ubuntu/folder_script/

# Получаем текущую дату

current_date=$(date +%Y.%m.%d)

# Создаем цикл для создания папок

for ((i=1;i<=$folders_count;i++)); do

  # Формируем название папки

  folder_name="${current_date}_Папка$i"

  # Создаем папку с заданным названием в директории 

  mkdir -p "$path_to_save/$folder_name"
done

# Сохранение результатов работы скрипта в лог файл

echo "Скрипт завершен в $(date)" >> $path_to_save/script.log




# ./folder.sh -  запуск скрипта 
