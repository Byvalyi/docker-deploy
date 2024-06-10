#!/bin/bash

# Переменные
IMAGE_NAME="my-static-website"
CONTAINER_NAME="static-website"
PORT=8080

# Создание Docker образа
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Проверка наличия уже запущенного контейнера и его остановка
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping existing container..."
    docker stop $CONTAINER_NAME
fi

# Удаление старого контейнера
if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
    echo "Removing existing container..."
    docker rm $CONTAINER_NAME
fi

# Запуск нового контейнера
echo "Starting new container..."
docker run -d -p $PORT:80 --name $CONTAINER_NAME $IMAGE_NAME

echo "Deployment complete. Access your website at http://localhost:$PORT"
