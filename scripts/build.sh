#!/bin/bash

# Скрипт для сборки Docker образа

set -e

echo "=========================================="
echo "Сборка Docker образа highload-service"
echo "=========================================="

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    echo "Ошибка: Docker не установлен"
    exit 1
fi

# Сборка образа
echo "Сборка образа..."
docker build -t highload-service:latest .

# Проверка размера образа
IMAGE_SIZE=$(docker images highload-service:latest --format "{{.Size}}")
echo "Размер образа: $IMAGE_SIZE"

echo "=========================================="
echo "Образ успешно собран: highload-service:latest"
echo "=========================================="

# Для Minikube - загрузка образа
if command -v minikube &> /dev/null; then
    echo "Обнаружен Minikube. Загрузка образа в Minikube..."
    minikube image load highload-service:latest
    echo "Образ загружен в Minikube"
fi

