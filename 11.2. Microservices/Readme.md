
# Домашнее задание к занятию "11.02 Микросервисы: принципы"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: API Gateway 

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:
- Маршрутизация запросов к нужному сервису на основе конфигурации
- Возможность проверки аутентификационной информации в запросах
- Обеспечение терминации HTTPS

> | Products | Kong | Tyk.io | APIGee | AWS Gateway | Azure Gateway | Express Gateway | Istio |
> |:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
> | Deployment Complexity | Single node |	Single node | Many nodes with different roles | Cloud vendor PaaS | Cloud vendor PaaS | Flexible | Flexible |
> | Data Stores Required | Cassandra or Postgres | Redis | Cassandra, Zookeeper, and Postgres | Cloud vendor PaaS | Cloud vendor PaaS | Redis | Redis |
> | Open Source |Yes, Apache 2.0 | Yes, MPL |	No | No | No | Yes, Apache 2.0 | Yes |
> |Core Technology | NGINX/Lua | GoLang |	Java |	Not open |	Not open | Node.js Express | Spring, ASP NET, Flask |
> |On Premise | Yes | Yes | Yes | No | No | Yes | Yes |
> | Community/Extensions | Large | Medium | No | No | No | Small | Yes |
> | Authorization/API Keys | Yes |Yes | Yes | Yes | Yes | Yes | Yes |
> | Rate Limiting | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
> | Data Transformation | HTTP | HTTP | Yes | No | No | No | Yes |
> | Integrated Billing | No | No | Yes | No | No | No | No |
> | HTTPS termination	| HTTP | HTTP | Yes | No | No | No | Yes |

Обоснуйте свой выбор.
Я бы выбрал Istio как производительный продускт с бесплатной лицензией.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:
- Поддержка кластеризации для обеспечения надежности
- Хранение сообщений на диске в процессе доставки
- Высокая скорость работы
- Поддержка различных форматов сообщений
- Разделение прав доступа к различным потокам сообщений
- Протота эксплуатации

> | * | Kafka | RabbitMQ | Redis | ZeroMQ | ActiveMQ |
> | Поддержка кластеризации для обеспечения надежности | да | да | да | да | да |
> | Хранение сообщений на диске в процессе доставки | да | да | да | да | да |
> | Высокая скорость работы | да | да	| нет | нет | нет |
> | Поддержка различных форматов сообщений | да | да | да | да | да |
> | Разделение прав доступа к различным потокам сообщений | да | да | да | да | да |
Обоснуйте свой выбор.
Я бы выбрал Kafka как одно из самых производительных и популярных решений на рынке.


## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- Хранит загруженные файлы в бакете images
- S3 протокол

**uploader**
- Принимает файл, если он картинка сжимает и загружает его в minio
- POST /v1/upload

**security**
- Регистрация пользователя POST /v1/user
- Получение информации о пользователе GET /v1/user
- Логин пользователя POST /v1/token
- Проверка токена GET /v1/token/validation

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/user

**POST /v1/token**
- Анонимный доступ.
- Запрос направляется в сервис security POST /v1/token

**GET /v1/user**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис security GET /v1/user

**POST /v1/upload**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис uploader POST /v1/upload

**GET /v1/user/{image}**
- Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/
- Запрос направляется в сервис minio  GET /images/{image}

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизаци
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)
