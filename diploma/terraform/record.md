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
