# Задача 1, 5, 6 
Схемы с архитектурой по заданиям 1, 5, 6 находяться по ссылке:
https://github.com/andrey16100/architecture-sprint-2/blob/main/task156.drawio

# Задача 2, 3, 4
Во всех задачах применем стандартный механизм запуска и инициализации.
Необхожимо перейти в соответвующую директорию:
mongo-sharding - Шардирование 
mongo-sharding-repl - Репликация
sharding-repl-cache - Кеширование

И выболнить следеующие команды.

Запускаем mongodb и приложение

```shell
docker compose up -d
```
Заполняем mongodb данными
Инициализируем шарды
Инициализируем роутер и наполните его тестовыми данными

```shell
./scripts/mongo-init.sh
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs