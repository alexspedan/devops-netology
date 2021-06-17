# Домашнее задание к занятию "5.1. Основы виртуализации"
Задача 1
Вкратце опишите, как вы поняли - в чем основное отличие паравиртуализации и виртуализации на основе ОС.
```
Паравиртуализация использует гипервизор для управления железом, при этом для каждой ВМ используется своя ОС, в виртуализации на основе ОС для управления железом используется ОС контейнеры используются для изоляции среды, при этом можно более эффективно управлять ресурсами
```
Задача 2
Выберите тип один из вариантов использования организации физических серверов, в зависимости от условий использования.
Организация серверов:
физические сервера
паравиртуализация
виртуализация уровня ОС
Условия использования:
Высоконагруженная база данных, чувствительная к отказу
Различные Java-приложения
Windows системы для использования Бухгалтерским отделом
Системы, выполняющие высокопроизводительные расчеты на GPU
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.
```
Высоконагруженная база данных, чувствительная к отказу - Виртуализация на уровне ОС, потому что можно создать отказоустойчивый кластер с меньшими ресурсами
Различные Java-приложения Виртуализация на уровне ОС, потому что эти приложения могут часто обновляться, удобнее управлять
Windows системы для использования Бухгалтерским отделом - правиртуализация, т.к. невозможно использовать Linux для виртуализации на уровне ОС
Системы, выполняющие высокопроизводительные расчеты на GPU - физические сервера, т.к можно собрать более производительную конфигурацию.
```
Задача 3
Как вы думаете, возможно ли совмещать несколько типов виртуализации на одном сервере? Приведите пример такого совмещения.
```
Да, можно, например с паравиртуализацией можно поставить 2 виртуальных машины, в одной из них развернуть контейнеры, но мой взгляд это так и останется паравиртуализацией, т.к. будет использоваться гипервизор для управления железом, но кроме этого добавятся еще и контейнеры.
```

Как оформить ДЗ?
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.