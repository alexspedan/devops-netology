## Домашнее задание к занятию "5.4. Практические навыки работы с Docker"
## Задача 1
В данном задании вы научитесь изменять существующие Dockerfile, адаптируя их под нужный инфраструктурный стек.
Измените базовый образ предложенного Dockerfile на Arch Linux c сохранением его функциональности.
```
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:vincent-c/ponysay && \
    apt-get update
 
RUN apt-get install -y ponysay

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology”]
------------------------------------------
FROM archlinux:latest

RUN pacman -Sy

RUN pacman -Su --noconfirm ponysay

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology”]
``` 
Для получения зачета, вам необходимо предоставить:
Написанный вами Dockerfile
Скриншот вывода командной строки после запуска контейнера из вашего базового образа
![](https://github.com/alexspedan/devops-netology/blob/main/5.4.Docker/1.1.png)
Ссылку на образ в вашем хранилище docker-hub
https://hub.docker.com/repository/docker/alexspedan/devops-netology
## Задача 2
В данной задаче вы составите несколько разных Dockerfile для проекта Jenkins, опубликуем образ в dockerhub.io и посмотрим логи этих контейнеров.



Составьте 2 Dockerfile:
Общие моменты:
Образ должен запускать Jenkins server
Спецификация первого образа:
Базовый образ - amazoncorreto
Присвоить образу тэг ver1
```
FROM amazoncorretto
LABEL maintainer="Alex Pedan"
LABEL version="1.0"

ADD https://pkg.jenkins.io/redhat-stable/jenkins.repo /etc/yum.repos.d/jenkins.repo

RUN rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key && \
    yum update -y && \
    yum install -y jenkins

EXPOSE 8080/tcp
EXPOSE 50000

USER jenkins

CMD ["-jar", "/usr/lib/jenkins/jenkins.war"]
ENTRYPOINT ["java"]
```
Спецификация второго образа:
Базовый образ - ubuntu:latest
Присвоить образу тэг ver2
```
FROM ubuntu
LABEL maintainer="Alex Pedan"
LABEL version="2.0"

ADD https://pkg.jenkins.io/debian-stable/jenkins.io.key /

RUN apt-get update -y && \
    apt-get install -y gnupg ca-certificates && \
    apt-key add /jenkins.io.key && \
    bash -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && \
    apt-get update -y && \
    apt-get install -y openjdk-8-jdk openjdk-8-jre jenkins

EXPOSE 8080/tcp
EXPOSE 5000

USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.24.6 docker-workflow:1.26"
WORKDIR "/usr/share/jenkins"
CMD ["-jar", "jenkins.war"]
ENTRYPOINT ["java"]
```
Соберите 2 образа по полученным Dockerfile
# docker build . -f amazon.Dockerfile -t alexspedan/51virtamazon:v1.0
# docker build . -f ubuntu.Dockerfile -t alexspedan/51virtubuntu:v2.0
Запустите и проверьте их работоспособность
```
docker run -it -p 8080 -p 50000 04ac3bd21654

docker run -it -p 8080 -p 50000 9939e95a5b9c
```
Опубликуйте образы в своём dockerhub.io хранилище
```
docker push alexspedan/51virtamazon:v1.0
docker push alexspedan/51virtubuntu:v2.0
```
Для получения зачета, вам необходимо предоставить:
Наполнения 2х Dockerfile из задания
Скриншоты логов запущенных вами контейнеров (из командной строки)
Скриншоты веб-интерфейса Jenkins запущенных вами контейнеров (достаточно 1 скриншота на контейнер)
Ссылки на образы в вашем хранилище docker-hub
![](https://github.com/alexspedan/devops-netology/blob/main/5.4.Docker/Task2/2.1Run.PNG)
![](https://github.com/alexspedan/devops-netology/blob/main/5.4.Docker/Task2/2.2.jenkins.png)
## Задача 3
В данном задании вы научитесь:
объединять контейнеры в единую сеть
исполнять команды "изнутри" контейнера
Для выполнения задания вам нужно:
Написать Dockerfile:
Использовать образ https://hub.docker.com/_/node как базовый
Установить необходимые зависимые библиотеки для запуска npm приложения https://github.com/simplicitesoftware/nodejs-demo
docker build . -f node2.Dockerfile -t alexspedan/54node2:v1.0
Выставить у приложения (и контейнера) порт 3000 для прослушки входящих запросов
```
FROM node:12
# создание директории приложения
WORKDIR /usr/src/app
# установка зависимостей
# символ астериск ("*") используется для того чтобы по возможности 
# скопировать оба файла: package.json и package-lock.json
RUN git clone https://github.com/simplicitesoftware/nodejs-demo.git
RUN npm install
# Если вы создаете сборку для продакшн
# RUN npm ci --only=production
# копируем исходный код
COPY . .
EXPOSE 3000
CMD [ "node", "server.js" ]
```
Соберите образ и запустите контейнер в фоновом режиме с публикацией порта
```
docker build . -f node2.Dockerfile -t alexspedan/54node2:v1.0
docker run -d --name node2 --publish=3000:3000 alexspedan/54node2:v1.0
```
Запустить второй контейнер из образа ubuntu:latest
```
docker run -d --name node2 --publish=3000:3000 alexspedan/51virtubuntu:v1.0
```
Создайть docker network и добавьте в нее оба запущенных контейнера
docker network create node_net
docker network connect node_net node1
docker network connect node_net node2
Используя docker exec запустить командную строку контейнера ubuntu в интерактивном режиме
Используя утилиту curl вызвать путь / контейнера с npm приложением
Для получения зачета, вам необходимо предоставить:
Наполнение Dockerfile с npm приложением
Скриншот вывода вызова команды списка docker сетей (docker network cli)
Скриншот вызова утилиты curl с успешным ответом

Как оформить ДЗ?
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.


