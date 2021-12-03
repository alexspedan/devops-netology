# Домашнее задание к занятию "13.5 поддержка нескольких окружений на примере Qbec"
Приложение обычно существует в нескольких окружениях. Для удобства работы следует использовать соответствующие инструменты, например, Qbec.

## Задание 1: подготовить приложение для работы через qbec
Приложение следует упаковать в qbec. Окружения должно быть 2: stage и production. 

Требования:
* stage окружение должно поднимать каждый компонент приложения в одном экземпляре;
* production окружение — каждый компонент в трёх экземплярах;
* для production окружения нужно добавить endpoint на внешний адрес.

Устанавливаю QBEC
wget https://github.com/splunk/qbec/releases/download/v0.14.8/qbec-linux-amd64.tar.gz
tar -C ~/qbec -xzf qbec-linux-amd64.tar.gz
sudo mv qbec /usr/local
export PATH=$PATH:/usr/local/qbec
qbec completion | sudo tee /etc/bash_completion.d/qbec
>  Инициирую проект
>  qbec init
>  Корректирую файлы деплоймента
>  Проверяю результат
![](https://github.com/alexspedan/devops-netology/raw/main/13.5.Qbec/13.5P1.png)
![](https://github.com/alexspedan/devops-netology/raw/main/13.5.Qbec/13.5N2.png)
![](https://github.com/alexspedan/devops-netology/raw/main/13.5.Qbec/13.5N3.png)