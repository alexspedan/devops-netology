# Домашнее задание к занятию "6.6. Troubleshooting"

## Задача 1

Перед выполнением задания ознакомьтесь с документацией по [администрированию MongoDB](https://docs.mongodb.com/manual/administration/).

Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD операция в MongoDB и её 
нужно прервать. 

Вы как инженер поддержки решили произвести данную операцию:
- напишите список операций, которые вы будете производить для остановки запроса пользователя
```
При установлении факта деградации производительности системы, вычислить проблемные запросы возможно используя следующий вызов mongo-shell:
db.currentOP({“secs_running”,{$gte:5}}), далее найти <opid> и остановить командой db.killOp(<opid>)

```
- предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB
```
можно выставить ограничение на время выполнение запросов
```

## Задача 2

Перед выполнением задания познакомьтесь с документацией по [Redis latency troobleshooting](https://redis.io/topics/latency).

Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL. 
Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и
увеличивается пропорционально количеству реплик сервиса. 

При масштабировании сервиса до N реплик вы увидели, что:
- сначала рост отношения записанных значений к истекшим
- Redis блокирует операции записи

Как вы думаете, в чем может быть проблема?
```
Redis может заблокировать записи Были превышены лимиты для активного и ленивого методов. Наступил предел I\O, запись заблокировалась
```

## Задача 3

Перед выполнением задания познакомьтесь с документацией по [Common Mysql errors](https://dev.mysql.com/doc/refman/8.0/en/common-errors.html).

Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы,
пользователи начали жаловаться на ошибки вида:
```python
InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '
```

Как вы думаете, почему это начало происходить и как локализовать проблему?
```
Слишком большой объем данных. Превышен net_read_timeout по умолчания 30 сек.
```
Какие пути решения данной проблемы вы можете предложить?
```
можно увеличить тайм-аут;
оптимизировать работу таблицы например добавить индексы
писать более простые запросы, которые требуют меньше времени на обработку.

```
## Задача 4

Перед выполнением задания ознакомтесь со статьей [Common PostgreSQL errors](https://www.percona.com/blog/2020/06/05/10-common-postgresql-errors/) из блога Percona.

Вы решили перевезти гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с 
большим объемом данных лучше, чем MySQL.

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

`postmaster invoked oom-killer`

Как вы думаете, что происходит?
```
Закончилась оперативная память.
```

Как бы вы решили данную проблему?
```
проверить количество соединений ( не находится ли база под атакой), добавить фильтры url
использовать profiler
оценить работу с памятью на хосте, -если установлен swap 0, увеличить swap, если используют некритичные приложения - остановить.

```
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---