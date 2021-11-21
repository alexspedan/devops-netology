# Домашнее задание к занятию "12.5 Сетевые решения CNI"
После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
C 4 nod-ами установка не прошла, прошла с 3 нодами
kubectl cluster-info
Kubernetes control plane is running at https://127.0.0.1:6443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
* после применения следует настроить политику доступа к hello world извне.
добавляю deployment 
kubectl apply -f https://raw.githubusercontent.com/alexspedan/devops-netology/main/12.2.K8S/apiVersion%3A%20apps/hello-node-deployment.yaml
Из примера
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/main/10-frontend.yaml
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/main/20-backend.yaml
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/main/30-cache.yaml

Добавляю политику:
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/network-policy/00-default.yaml
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/network-policy/10-frontend.yaml
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/network-policy/20-backend.yaml
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes-for-beginners/master/16-networking/20-network-policy/templates/network-policy/30-cache.yaml

## Задание 2: изучить, что запущено по умолчанию
Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---