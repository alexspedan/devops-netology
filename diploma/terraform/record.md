sVp0DM1GMWrDUQ.atlasv1.tplFon2WAIIylqSrvmonLRcsw4DHzcsH1dtNXYt9VCzelNsRJXKVcTCNXD6PJC8QOco ==terraform token

You can view your workspace here:
    https://app.terraform.io/app/example-org-92b5e8/workspaces/getting-started
To see the mock infrastructure you just provisioned and continue exploring
Terraform Cloud, visit:
https://app.terraform.io/fake-web-services


glpat-SwKKyJ9dmQjN-DZLxA4k

ssh-keygen -t rsa -m PEM -f "/Users/alekseipedan/.ssh/service_terraform" -C "service_terraform_enterprise"
https://gitlab.com/alex.s.pedan/devops-netology/
terraform login to generate token:
sUxzhHQO5jr2qQ.atlasv1.BISHz1Bh8UbMMzEvUwkLYlyA2kChP7Ie6sJFtjpcc4btVuZK61s2btMaCDZ9XswyWI4

Разворачиваю кластер Кубернетис:
inventory файл расположен:
/Users/alekseipedan/study/Netology/devops-netology/diploma/kubespray/inventory/cluster

Проверяю:
ansible -i ~/study/Netology/devops-netology/diploma/kubespray/inventory/cluster/inventory.ini all -m ping
Успешно!
#### Запускаю плейбук
ansible-playbook -i inventory/cluster/inventory.ini  --become --become-user=root cluster.yml

#### Создаю Docker file
/home/alexsp/cv_project/DevOps-CV/Dockerfile
делаю билд
sudo docker build -t alexspedan/cv-project:v1 .
sudo docker build -t alexspedan/cv-project:v2 .
push
sudo docker push alexspedan/cv-project:v1
sudo docker push alexspedan/cv-project:v2
проверяю свободный порт
sudo lsof -i -P -n | grep LISTEN

Запускаю контейнер
docker run -d -p 80:80 alexspedan/cv-project:v1
docker run -d alexspedan/cv-project:v2

Проверяю 
kubectl get po -o wide
# Создаю namespace stage:
kubectl config set-context --current --namespace=stage
Делаю деплой:
kubectl create deploy cv-deployment --image=alexspedan/cv-project:v2 --replicas=1
Проверяю что есть под
kubectl get po -o wide

Создаю сервис чтобы сайт было доступен:
https://raw.githubusercontent.com/alexspedan/devops-netology/main/diploma/k8s-configs/cv-service.yaml
Применяю сервис
kubectl apply -f https://raw.githubusercontent.com/alexspedan/devops-netology/main/diploma/k8s-configs/cv-service.yaml

Совместный файл сервис и деплоймент
https://raw.githubusercontent.com/alexspedan/devops-netology/main/diploma/k8s-configs/deploy.yaml
Сайт доступен на:
http://51.250.9.51:30163/
http://cv.alexpedan.ml:30163/

Проверяю как работает certmanager
установка прошла с ошибкой

установка kube-prometheus
kubectl apply --server-side -f manifests/setup
kubectl config set-context --current --namespace=monitoring
kubectl get pods
kubectl expose deployment/grafana --type="NodePort" --port 3000

Графана установлена:
http://178.154.200.244:30062/login

admin


# Настройка CI/CD
Цель:

1. Автоматическая сборка docker образа при коммите в репозиторий с тестовым приложением.
2. Автоматический деплой нового docker образа.

Можно использовать [teamcity](https://www.jetbrains.com/ru-ru/teamcity/), [jenkins](https://www.jenkins.io/) либо [gitlab ci](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/)

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.
2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа.
3. При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистр, а также деплой соответствующего Docker образа в кластер Kubernetes.

Проверяю репозиторий
    - docker login -u alex.s.pedan -p glpat-ckb6sG_XzZu5Tr4ikWra registry.gitlab.com
    - docker build -t registry.gitlab.com/alex.s.pedan/cv-project:1.0.1 .
    - docker push registry.gitlab.com/alex.s.pedan/cv-project:1.0.1  --  ошибка
Так работает:
sudo docker login -u alexspedan -p qRZJ6pb-U-ziDowr2XCCaErN docker.io
sudo docker build -t alexspedan/cv-project:v2.1 .
sudo docker push alexspedan/cv-project:v2.1
Добавляю деплой в кубер:
обновляю деплой:
kubectl set image deployment/cv cv=image:2.0.487450358 -неправильный образ
kubectl set image deployment/frontend cv=alexspedan/cv-project:v2
kubectl apply -f https://raw.githubusercontent.com/alexspedan/devops-netology/main/diploma/k8s-configs/deploy.yaml - stable
kubectl rollout restart cv