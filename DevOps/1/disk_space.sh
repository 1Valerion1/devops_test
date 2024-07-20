#!/bin/bash

# Проверяем, передан ли параметр email
if [ -z "$1" ]; then
    EMAIL="borovsckih.vadim@yandex.ru"
else
    EMAIL="$1"
fi

# Лимит дискового пространства
threshold=85

# Получаем использование диска в процентах
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)

# Проверяем, превышает ли использование диска установленный порог
if [ $disk_usage -gt $threshold ]; then
    # Формируем сообщение для алерта
    SUBJECT="Disk Space Alert on $(hostname)"
    MESSAGE="Disk space usage on $(hostname) has exceeded ${threshold}%. Current usage is ${disk_usage}%."
    
    # Отправляем email с сообщением
    echo "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
fi

