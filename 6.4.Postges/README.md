## Домашнее задание к занятию "6.4. PostgreSQL"
## Задача 1
Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

```
sudo docker run --name PG -e POSTGRES_PASSWORD=netology -d -p 5432:5432 -v /home/ubuntu/PG:/home/ubuntu/PG postgres:13
sudo docker exec -it PG bin/bash
su postgres
psql
```
Воспользуйтесь командой ``` \? ``` для вывода подсказки по имеющимся в psql управляющим командам.
- Найдите и приведите управляющие команды для:
вывода списка БД
```
\l[+]   [PATTERN]      list databases
```
- подключения к БД
```
Connection
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")
  \conninfo              display information about current connection
 ```
- вывода списка таблиц
```
\dt[S+] [PATTERN]      list tables
```
- вывода описания содержимого таблиц
```
\d[S+]  NAME           describe table, view, sequence, or index
```
- выхода из psql
```
\q                     quit psql
```
## Задача 2
Используя psql создайте БД test_database.
CREATE DATABASE test_database;
Изучите бэкап БД.
```
wget https://raw.githubusercontent.com/netology-code/virt-homeworks/master/06-db-04-postgresql/test_data/test_dump.sql
```
Восстановите бэкап БД в test_database.
```
psql -U postgres -W test_database < /home/ubuntu/PG/test_dump.sql
```
Перейдите в управляющую консоль psql внутри контейнера.
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
```
postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".
```
Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.
Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.
```
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)
 
test_database=# ANALYZE orders;
ANALYZE
test_database=# SELECT avg_width FROM pg_stats WHERE tablename = 'orders' ORDER BY avg_width DESC limit 1;
 avg_width
-----------
        16
(1 row)
``` 
## Задача 3
Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).
```
test_database=# CREATE TABLE orders_range (
test_database(# id INT,
test_database(# title varchar (80),
test_database(# price INT ) PARTITION BY RANGE(price);
CREATE TABLE
```
От 499 до 999999999
```
test_database=# CREATE TABLE orders_1 PARTITION OF orders_range FOR VALUES FROM  (499) TO (999999999);
CREATE TABLE
```
от 0 до 499
```
test_database=# CREATE TABLE orders_2 PARTITION OF orders_range FOR VALUES FROM  (0) TO (499);
CREATE TABLE
``` 
Предложите SQL-транзакцию для проведения данной операции.
```
test_database=# INSERT INTO orders_range SELECT * FROM orders;
INSERT 0 3
``` 
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
Можно автоматически ограничив количество строк
Задача 4
Используя утилиту pg_dump создайте бекап БД test_database.
```
pg_dump test_database > /home/ubuntu/PG/test_database2.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?
```
Создал индекс
```
Как оформить ДЗ?
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

