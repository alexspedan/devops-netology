## Домашнее задание к занятию "6.3. MySQL"
Введение
Перед выполнением задания вы можете ознакомиться с дополнительными материалами.
## Задача 1
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
```
Запускаем контейнер:
docker run -d --name MySQL -e MYSQL_ROOT_PASSWORD='123456' -p 3306:3306 -v /home/alexsp/sql-lab:/backup mysql:8
Подключаемся к контейнеру:
sudo docker exec -it MySQL bin/bash
```
Изучите бэкап БД и восстановитесь из него.
```
create database test_db;
mysql -u root -p test_db < /buckup/test_dump.sql
```
Перейдите в управляющую консоль mysql внутри контейнера.
```
mysql -u root -p
```
Используя команду \h получите список управляющих команд.
```
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/
List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
 
For server side help, type 'help contents'
```
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.
Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```
mysql> SHOW TABLES;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)
```
Приведите в ответе количество записей с price > 300.
```
mysql> SELECT COUNT(*) FROM orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
``` 
В следующих заданиях мы будем продолжать работу с данным контейнером.
## Задача 2
Создайте пользователя test в БД c паролем test-pass, используя:
плагин авторизации mysql_native_password
срок истечения пароля - 180 дней
количество попыток авторизации - 3
максимальное количество запросов в час - 100
аттрибуты пользователя:
Фамилия "Pretty"
Имя "James"
```
root@d24ac1656a6d:/# mysql -u root -p --default-auth=mysql_native_password
mysql> CREATE USER 'test'@'%'
    ->     IDENTIFIED WITH mysql_native_password BY 'test-pass'
    ->     WITH MAX_QUERIES_PER_HOUR 100
    ->     PASSWORD EXPIRE INTERVAL 180 DAY
    ->     FAILED_LOGIN_ATTEMPTS 3
    ->     ATTRIBUTE '{"Name": "James", "lname":"Pretty"}';
Query OK, 0 rows affected (0.03 sec)
```
Предоставьте привелегии пользователю test на операции SELECT базы test_db.
```
GRANT SELECT ON test_db.* TO 'test'@'%';
FLUSH PRIVILEGES;
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE user='test';
+------+------+--------------------------------------+
| USER | HOST | ATTRIBUTE                            |
+------+------+--------------------------------------+
| test | %    | {"Name": "James", "lname": "Pretty"} |
+------+------+--------------------------------------+
1 row in set (0.01 sec)
``` 
 
## Задача 3
Установите профилирование SET profiling = 1. 
```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
Изучите вывод профилирования команд SHOW PROFILES;.
```
mysql> SHOW PROFILES;
Empty set, 1 warning (0.00 sec)
mysql> SELECT * FROM test_db.orders;
+----+-----------------------+-------+
| id | title                 | price |
+----+-----------------------+-------+
|  1 | War and Peace         |   100 |
|  2 | My little pony        |   500 |
|  3 | Adventure mysql times |   300 |
|  4 | Server gravity falls  |   300 |
|  5 | Log gossips           |   123 |
+----+-----------------------+-------+
5 rows in set (0.01 sec)
 
mysql> SHOW PROFILES;
+----------+------------+------------------------------+
| Query_ID | Duration   | Query                        |
+----------+------------+------------------------------+
|        1 | 0.00200400 | SELECT * FROM test_db.orders |
+----------+------------+------------------------------+
1 row in set, 1 warning (0.00 sec)
SHOW PROFILES будет показывать список самых последних запросов/
SHOW PROFILE покажет детальную информацию о выбранном Query_ID из таблицы SHOW PROFILES
 ```
 
Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе
```
mysql> SELECT engine, table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='test_db';
+--------+------------+
| ENGINE | TABLE_NAME |
+--------+------------+
| InnoDB | orders     |
+--------+------------+
1 row in set (0.01 sec)
.
Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:
на MyISAM
mysql> use test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A
 
Database changed
mysql> CREATE TABLE orders_2 LIKE orders;
Query OK, 0 rows affected (0.04 sec)
 
mysql> ALTER TABLE orders_2 ENGINE=MyISAM;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0
 
mysql>
mysql> INSERT INTO orders_2 SELECT * FROM orders;
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0
 
mysql> DROP TABLE orders;
Query OK, 0 rows affected (0.03 sec)
 
mysql> RENAME TABLE orders_2 TO orders;
Query OK, 0 rows affected (0.02 sec)
mysql> SHOW PROFILES;
+----------+------------+---------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                 |
+----------+------------+---------------------------------------------------------------------------------------+
|        2 | 0.00011775 | SHOW ENGINE test_db STATUS                                                            |
|        3 | 0.00023525 | SHOW ENGINE test_db STATUS                                                            |
|        4 | 0.00625200 | SELECT engine, table_name FROM information_schema.TABLES WHERE TABLE_SCHEMA='test_db' |
|        5 | 0.00309600 | CREATE TABLE orders_2 LIKE orders                                                     |
|        6 | 0.00040150 | CREATE TABLE orders2 LIKE orders                                                      |
|        7 | 0.00044900 | onnect test_db                                                                        |
|        8 | 0.00056475 | SELECT DATABASE()                                                                     |
|        9 | 0.00198975 | show databases                                                                        |
|       10 | 0.00240800 | show tables                                                                           |
|       11 | 0.04650275 | CREATE TABLE orders_2 LIKE orders                                                     |
|       12 | 0.06450975 | ALTER TABLE orders_2 ENGINE=MyISAM                                                    |
|       13 | 0.00054400 | mysql>                                                                                |
|       14 | 0.00701400 | INSERT INTO orders_2 SELECT * FROM orders                                             |
|       15 | 0.02617825 | DROP TABLE orders                                                                     |
|       16 | 0.01723925 | RENAME TABLE orders_2 TO orders                                                       |
+----------+------------+---------------------------------------------------------------------------------------+
15 rows in set, 1 warning (0.00 sec)
``` 
 
на InnoDB
```
CREATE TABLE orders_3 LIKE orders;
ALTER TABLE orders_3 ENGINE=InnoDB;
INSERT INTO orders_3 SELECT * FROM orders;
DROP TABLE orders;
RENAME TABLE orders_3 TO orders;
SHOW PROFILES;
![](https://github.com/alexspedan/devops-netology/blob/main/6.3.MySQL/task3.1.png)
```
## Задача 4
Изучите файл my.cnf в директории /etc/mysql.
Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
```
- Для ввода/вывода InnoDB использует метод, самый быстрый bypass
innodb_flush_method=O_DIRECT
```
- Нужна компрессия таблиц для экономии места на диске
```
OPTIMIZE TABLE tbl_name и innodb_file_per_table = 1
 ```
Размер буффера с незакомиченными транзакциями 1 Мб
```
innodb_log_buffer_size = 1M
```
Буффер кеширования 30% от ОЗУ
```
root@d24ac1656a6d:/# cat /proc/meminfo
MemTotal:        5863768 kB
MemAvailable:    1085568 kB
innodb_buffer_pool_size = 325M
``` 
Размер файла логов операций 100 Мб
```
innodb_log_file_size = 100M
```


Как оформить ДЗ?
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

