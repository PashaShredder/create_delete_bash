# Скрипт для создания пустых папок 

### 1) Cоздаем директорию для выполнения операции и переходим в неё
```bash
sudo mkdir folder_script
```
```bash
cd folder_script/ 
```
### 2) Cоздаем файл с расширение “.sh” чтобы оболочка понимала что это будет скрипт
```bash
touch folder.sh
```
### 3) Добавляем права выполнения для данного файла
```bash
sudo chmod +x folder.sh  
```
### 4) Редактируем файл и добавляем следующее
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

echo "Скрипт завершен в $(date)" >> $path_to_save/script.log
```



### 5 Запуск скрипта 
```bash
./folder.sh 
```

# Выполнение скрипта через CRON

### 1) Команда для редактирования расписания cron
```bash
crontab -e 
```
### 2) Добавление в конец файла скрипта который будет выполняться в 0 минут , 1 час, * - каждый день, * - каждый месяц, * - каждый день недели.
```bash
0 1 * * * /bin/bash /home/ubuntu/folder_script/folder.sh 
```
### 3) Установка таймера на 3 минуты (опционально)
```bash
(*/3 * * * * /bin/bash /home/ubuntu/folder_script/folder.sh ) 
```
### 4) Просмотреть список добавленных задач
```bash
crontab -l
```




# Добавление в systemd timer для выполнения скрипта к примеру раз в 30 сек.
### 1) создание и редактирование конфигурационного файла таймера
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
### 2) создание и редактирование конфигурационного файла таймера
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

 ### перезагрузка конфигурационных файлов systemd
 ```bash
 sudo systemctl daemon-reload 
 ```
 ### команда запуска в авто режиме при старте системы
 ```bash
 sudo systemctl enable folder_script.timer
 ```
 ### немедленный запуск таймера(one shot к примеру как единичный запуск)
 ```bash
 sudo systemctl start folder_script.timer 
 ```
 ### отображение логов запуска скрипта
 journalctl -u folder_script.service 
 ### список таймеров systemd а также информацию о запланированных последующих запусках
 ```bash
 systemctl list-timers 
```

# Создание скрипта для удаления пустых папок в указанной директории и его дальнейший запуск через systemd
### 1) Создаём и переходим в директорию
```bash
mkdir del_script/
cd del_script/
```
### 2) Добавляем следующие содержимое в наш файл
```bash
nano del.sh
```
```bash
#!/bin/bash

path_to_dir=/home/ubuntu/folder_script


find "$path_to_dir" -type d -empty -delete


echo "Скрипт успешно отработал в $(date), директория $path_to_dir очищена от пустых папок " >>/home/ubuntu/del_script/del.log
```

### 3) Делаем наш файл исполняемым
```bash
chmod +x del.sh
```
## 4) Редактируем файлы del.timer и del.service добавляя следующие содержимое
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
### Включаем таймер del.timer для автоматического запуска скрипта
```bash
systemctl enable del.timer
```
