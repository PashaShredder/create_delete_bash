#!/bin/bash

# Указываем путь к директории в которой нужно удалить пустые папки
path_to_dir=/home/ubuntu/folder_script

# Удаление пустых папок в указанной директории

find "$path_to_dir" -type d -empty -delete

# Результат работы скрипта сохраняем в лог файле

echo "Скрипт успешно отработал в $(date), директория $path_to_dir очищена от пустых папок " >>/home/ubuntu/del_script/del.log


# ./del.sh
