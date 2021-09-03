# Домашнее задание к занятию "09.05 Gitlab"

## Подготовка к выполнению

1. Необходимо [зарегистрироваться](https://about.gitlab.com/free-trial/)
2. Создайте свой новый проект
3. Создайте новый репозиторий в gitlab, наполните его [файлами](./repository)
4. Проект должен быть публичным, остальные настройки по желанию

## Основная часть

### DevOps

В репозитории содержится код проекта на python. Проект - RESTful API сервис. Ваша задача автоматизировать сборку образа с выполнением python-скрипта:
1. Образ собирается на основе [centos:7](https://hub.docker.com/_/centos?tab=tags&page=1&ordering=last_updated)
2. Python версии не ниже 3.7
3. Установлены зависимости: `flask` `flask-jsonpify` `flask-restful`
4. Создана директория `/python_api`
5. Скрипт из репозитория размещён в /python_api
6. Точка вызова: запуск скрипта
7. Если сборка происходит на ветке `master`: Образ должен пушится в docker registry вашего gitlab `python-api:latest`, иначе этот шаг нужно пропустить

### Product Owner

Вашему проекту нужна бизнесовая доработка: необходимо поменять JSON ответа на вызов метода GET `/rest/api/get_info`, необходимо создать Issue в котором указать:
1. Какой метод необходимо исправить
2. Текст с `{ "message": "Already started" }` на `{ "message": "Running"}`
3. Issue поставить label: feature

### Developer

Вам пришел новый Issue на доработку, вам необходимо:
1. Создать отдельную ветку, связанную с этим issue
2. Внести изменения по тексту из задания
3. Подготовить Merge Requst, влить необходимые изменения в `master`, проверить, что сборка прошла успешно

### Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:
1. Поднять докер-контейнер с образом `python-api:latest` и проверить возврат метода на корректность
2. Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый

## Итог
https://gitlab.com/alex.s.pedan/cicdnetology

После успешного прохождения всех ролей - отправьте ссылку на ваш проект в гитлаб, как решение домашнего задания

## Необязательная часть

Автомазируйте работу тестировщика, пусть у вас будет отдельный конвейер, который автоматически поднимает контейнер и выполняет проверку, например, при помощи curl. На основе вывода - будет приниматься решение об успешности прохождения тестирования

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

<<<<<<< HEAD
---

-----------------------------------------------------------------------------
Пример Метлякова
-----------------------------------------------------------------------------
image: docker:20.10.5
services:
    - docker:20.10.5-dind
stages:
    - build
    - deploy
build:
    stage: build
    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/aragast/netology-example/image:latest .
    except:
        - master
build&deploy:
    stage: deploy
    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/aragast/netology-example/image:latest .
        - docker push $CI_REGISTRY/aragast/netology-example/python-api:latest
    only:
        - master

------------------------------------------------------------------------
image: docker:20.10.5
services:
    - docker:20.10.5-dind
stages:
    - build
    - deploy
build:
    stage: build
    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/alex.s.pedan/cicdnetology/image:latest .
    except:
        - main
build&deploy:
    stage: deploy
    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/alex.s.pedan/cicdnetology/image:latest .
        - docker push $CI_REGISTRY/alex.s.pedan/cicdonaws/helloalpine:latest
    only:
        - main

-------------------------------------------------------------------------
stages:
  - build
  - deploy

build:
  stage: build
  image: ubuntu
  script:
    - mkdir public
    - touch public/index.html
    - echo "<h1>New deployment<h1>" >> public/index.html
  artifacts:
    paths:
      - index.html

deploy:
  stage: deploy
  image: ubuntu
  script:
    - scp -o StrictHostKeyChecking=no index.html -i $SSH_PRIVATE_KEY ubuntu@3.23.79.85:/usr/share/nginx/html
    - ssh -o StrictHostKeyChecking=no ubuntu@3.23.79.85 -i $SSH_PRIVATE_KEY "cd /home/bitnami/htdocs; touch foo.txt; unzip public.zip"


-------------------------------------------------------------
stages:
    -deploy
deploy:
    stage: deploy
    script:
        - apache2 install

-------------------------------------------------------------
image: docker:20.10.5
services:
    - docker:20.10.5-dind
stages:
    - build
    - deploy

build:
    stage: build

    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/alex.s.pedan/cicdnetology/hellowgcp:latest .
    except:
        - main
build&deploy:
    stage: deploy

    script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
        - docker build -t $CI_REGISTRY/alex.s.pedan/cicdnetology/hellowgcp:latest .
        - docker push $CI_REGISTRY/alex.s.pedan/cicdnetology/hellowgcp:latest
    only:
        - main

## How to deploy:
Чтобы деплоилось с мастера:
    only:
        - master
- в этом случае простой нейминг
с
    only:
        - application-branch_name
должен быть внешний роут

Собирать аппликуху нужно темплейтом

Как работает пример:
1. 



stages:
    -docker
services:
    - docker:dind
docker-job
    stage: docker
    image: docker:dind
    scripts:
        - docker build .





-----------------------------------------------------

stages: 
    - build

docker-build:
    image: docker:latest
    stage: build
    services:
        - docker:dind
    befor_script:
        - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
#        - docker build -t $CI_REGISTRY/alex.s.pedan/cicdnetology/hellowgcp:latest .
#    except:
#        - main
# build&deploy:
#    stage: deploy

    script:
        - docker build --pull -t "$CI_REGISTRY_IMAGE" .
        - docker push "$CI_REGISTRY_IMAGE"
#    only:
#        - main

--------------------------------------------------------------------

=======
>>>>>>> ccd96ab1dd2ddb3309b1178c99ffdd84f256c55b
