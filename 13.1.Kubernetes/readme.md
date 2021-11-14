## Задание 1: подготовить тестовый конфиг для запуска приложения
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:

- под содержит в себе 3 контейнера — фронтенд, бекенд, базу;
        Собираю контейнеры в докер репозиторий из папки с примером
Backend
>        docker build -t backendtest .
>        docker login
>        docker tag backendtest:latest alexspedan/backendtest:latest
>        docker push alexspedan/backendtest:latest
Frontend
        docker build -t frontendtest .
        docker login
        docker tag frontendtest:latest alexspedan/frontendtest:latest
        docker push alexspedan/frontendtest:latest
- регулируется с помощью deployment фронтенд и бекенд;
        Создаю deployment для контейнеров
- база данных — через statefulset.
        Добавляю бд statefulset
## Задание 2: подготовить конфиг для production окружения
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:

каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
для связи используются service (у каждого компонента свой);
в окружении фронта прописан адрес сервиса бекенда;
в окружении бекенда прописан адрес сервиса базы данных.
