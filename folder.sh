#!/bin/bash  

folders_count=10

path_to_save=/home/ubuntu/folder_script/


current_date=$(date +%Y.%m.%d)


for ((i=1;i<=$folders_count;i++)); do
 
 folder_name="${current_date}_Папка$i"

  mkdir -p "$path_to_save/$folder_name"
done

echo "Script finished in $(date)" >> $path_to_save/script.log
