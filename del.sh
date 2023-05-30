#!/bin/bash

path_to_dir=/home/ubuntu/folder_script


find "$path_to_dir" -type d -empty -delete


echo "The script ran successfully $(date), the directory $path_to_dir cleared of empty folders" >>/home/ubuntu/del_script/del.log
