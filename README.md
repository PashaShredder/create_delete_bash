# Script to create empty folders 

### 1) Create a directory to perform the operation and go to it
```bash
sudo mkdir folder_script
```
```bash
cd folder_script/ 
```
### 2) We create a file with the extension “.sh” so that the shell understands that this will be a script
```bash
touch folder.sh
```
### 3) Add execute permissions for this file
```bash
sudo chmod +x folder.sh  
```
### 4) Edit the file and add the following
```bash
sudo nano folder.sh 
```
```bash
#!/bin/bash  

folders_count=10

path_to_save=/home/ubuntu/folder_script/


current_date=$(date +%Y.%m.%d)


for ((i=1;i<=$folders_count;i++)); do
 
 folder_name="${current_date}_Папка$i"

  mkdir -p "$path_to_save/$folder_name"
done

echo "Script finished in $(date)" >> $path_to_save/script.log
```



### 5) Running a script
```bash
./folder.sh 
```

# Executing a script via CRON

### 1) Command to edit cron schedule
```bash
crontab -e 
```
### 2) Adding a script to the end of the file that will be executed at 0 minutes , 1 hour, * - every day, * - every month, * - every day of the week.
```bash
0 1 * * * /bin/bash /home/ubuntu/folder_script/folder.sh 
```
### 3) Setting the timer to 3 minutes (optional)
```bash
(*/3 * * * * /bin/bash /home/ubuntu/folder_script/folder.sh ) 
```
### 4) View a list of added tasks
```bash
crontab -l
```




# Adding a timer to systemd to execute a script, for example, once every 30 seconds.
### 1) creating and editing a timer configuration file
 ```bash
 sudo nano /etc/systemd/system/folder_script.timer 
```
```bash
[Unit]
Description=Folder Script Timer

[Timer]  
OnUnitActiveSec=30s 
Unit=folder_script.service  

[Install]  
WantedBy=timers.target  
```
### 2) creating and editing a timer configuration file
 ```bash
 sudo nano /etc/systemd/system/folder_script.service
 ```
 
```bash
[Unit]
Description=Folder Script Service 

[Service]  
Type=simple  
ExecStart=/bin/bash /home/ubuntu/folder_script/folder.sh 

[Install]
WantedBy=multi-user.target 
```

 ### reloading systemd config files
 ```bash
 sudo systemctl daemon-reload 
 ```
 ### command to run in auto mode at system startup
 ```bash
 sudo systemctl enable folder_script.timer
 ```
 ### immediate start of the timer (one shot for example as a single launch)
 ```bash
 sudo systemctl start folder_script.timer 
 ```
 ### display logs of the script run
 journalctl -u folder_script.service 
 ### a list of systemd timers as well as information about scheduled subsequent runs
 ```bash
 systemctl list-timers 
```

# Creating a script to delete empty folders in a specified directory and then running it through systemd
### 1) Create and change directory
```bash
mkdir del_script/
cd del_script/
```
### 2) Add the following content to our file
```bash
nano del.sh
```
```bash
#!/bin/bash

path_to_dir=/home/ubuntu/folder_script


find "$path_to_dir" -type d -empty -delete


echo "The script ran successfully $(date), the directory $path_to_dir cleared of empty folders" >>/home/ubuntu/del_script/del.log
```

### 3) Making our file executable
```bash
chmod +x del.sh
```
## 4) Editing del.timer and del.service files adding the following content
```bash
nano /etc/systemd/system/del.timer
```
```bash
[Unit]
Description=Delete Script Timer

[Timer]
OnUnitActiveSec=40s
Unit=del.service

[Install]
WantedBy=timers.target
```

```bash
nano /etc/systemd/system/del.service
```
```bash
[Unit]
Description=Delete Script Service

[Service]
Type=simple
ExecStart=/bin/bash /home/ubuntu/del_script/del.sh

[Install]
WantedBy=multi-user.target
```
### Turn on the del.timer timer to automatically run the script
```bash
systemctl enable del.timer
```
