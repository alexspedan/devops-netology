## Домашнее задание к занятию "6.2. SQL"
Введение
Перед выполнением задания вы можете ознакомиться с дополнительными материалами.
## Задача 1
Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.
Приведите получившуюся команду или docker-compose манифест.
```
version: '3.3'
services:
  db:
    image: postgres:12
    restart: always
    volumes:   
       - /home/alexsp/sql-lab:/sql-data
    environment:
      POSTGRES_PASSWORD: example
 
или docker run --rm -p 8080:8088 \
--network ais2_default \
--name pgadmin4 \
-e "PGADMIN_DEFAULT_EMAIL=asd@asd.asd" \
-e "PGADMIN_DEFAULT_PASSWORD=123456" \
-d dpage/pgadmin4
``` 
 
## Задача 2
В БД из задачи 1:
![](https://docs.google.com/document/d/1W-ys49sob4CNcjcDr-zQ-rdJgnQzQpKSztS1Zhvtu5E/edit#heading=h.57smf380kka5)
```
docker exec -it 86605d90c79b /bin/bash
```
создайте пользователя test-admin-user и БД test_db
```
createuser test-admin-user;
create database test_db;
```
в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
```
CREATE TABLE orders (
id SERIAL PRIMARY KEY,
наименование varchar (50),
цена INT );
CREATE TABLE clients ( id (serial primary key), фамилия (string), страна проживания (string, index), заказ (foreign key orders));
CREATE TABLE clients (
id SERIAL PRIMARY KEY,
фамилия VARCHAR (100),
страна_проживания VARCHAR (100),
заказ INT);
```
предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db

создайте пользователя test-simple-user
createuser test-simple-user;
предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

 
Таблица orders:
- id (serial primary key),
- наименование (string)
- цена (integer)
Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)
Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

## Задача 3
Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:
Подключаемся к  контейнеру: ``` docker exec -it 86605d90c79b /bin/bash ```
Подключаемся к su: su postgres
Подключаемся к постгрес: ``` psql ```
Подключаемся к БД: ``` \connect test_db ```
Смотрим таблицу заказов:
Добавляем в таблицу 1(orders): 
```
INSERT INTO orders (id, наименование, цена) VALUES (
1, 'Шоколад', 10), 
(2, 'Принтер', 3000), 
(3, 'Книга', 500), 
(4, 'Монитор', 7000), 
(5, 'Гитара', 4000);
``` 
Добавляем в таблицу 2(clients): 
```
INSERT INTO clients (id, ФИО, страна_проживания ) VALUES 
(1, 'Иванов Иван Иванович', 'USA'), 
(2, 'Петров Петр Петрович', 'Canada'), 
(3, 'Иоганн Себастьян Бах', 'Japan'), 
(4, 'Ронни Джеймс Дио', 'Russia'),
(5, 'Ritchie Blackmore', 'Russia');
``` 
Таблица orders:
|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|


Таблица clients:

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы

приведите в ответе:
- запросы
- результаты их выполнения.

## Задача 4
Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара 

Приведите SQL-запросы для выполнения данных операций.
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
Подсказк - используйте директиву UPDATE.
```
 
UPDATE clients SET "заказ" = 3 WHERE id = 1;
UPDATE clients SET "заказ" = 4 WHERE id = 2;
UPDATE clients SET "заказ" = 5 WHERE id = 3;

```
![](https://keep.google.com/u/0/media/v2/1DVlPe7aKnhitULGCS6RS-uJoFi5eGpxrV_ytDj_3T1d4NUVgnPXH61N7A3acv3A/1HPT8IBw3FMi8w_Hl7x-wEp9SfBaHvdHsoipstxnXfsfQGT8g1v6OP3I5fC7SIjw?accept=image/gif,image/jpeg,image/jpg,image/png,image/webp,audio/aac&sz=462)

## Задача 5
Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
- Scan - чтение данных из таблицы
- cost - затраты на выполнение первой и всех операций 
- rows - количество строк
- width - размер строки
![](https://keep.google.com/u/0/media/v2/1qvFfYdah3n78DIh7iAFwfVBecFju6QE3R9VRh2sVhA1d0mWt_OXImpHUfkpvk6U/1mLrwa8jzyu7zhAizv6V_IpudSTL0IRIfPpaYESPKqWzz6m0outUVcf4WFEDVvdE?accept=image/gif,image/jpeg,image/jpg,image/png,image/webp,audio/aac&sz=482)
 
## Задача 6
Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
```
pg_dump -U postgres test_db > /sql-data/db_backup.sql
```
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
```
alexsp@alexsp-530U3C-530U4C:~$ sudo docker stop 86605d90c79b
```
Поднимите новый пустой контейнер с PostgreSQL.
```
sudo docker run -d --name ps_db_2 -e POSTGRES_PASSWORD=mysecretpassword -v /home/alexsp/sql-lab:/sql-data postgres:12
```
 Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.
```
sudo docker exec -it ps_db_2 bash
su postgres
psql -U postgres -W test_db < /sql-lab/db_backup.sql
```
Как оформить ДЗ?
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

