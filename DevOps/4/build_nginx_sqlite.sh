#!/bin/bash

# Определяем имя файла лога с текущей датой
LOGFILE="build_$(date +%Y-%m-%d_%H-%M-%S).log"

# Переходим в каталог с исходниками SQLite
cd sqlite-amalgamation-3260000

# Создаем каталог для сборки
mkdir -p build
cd build

# Запускаем CMake и сборку, перенаправляя вывод в лог-файл
cmake .. > "../${LOGFILE}" 2>&1
make >> "../${LOGFILE}" 2>&1

# Сообщаем об окончании
echo "Build complete. Log file: ${LOGFILE}"