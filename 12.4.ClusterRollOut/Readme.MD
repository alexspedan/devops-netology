# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

1. Configure all hosts at GCP
add to Global Vars
ansible_connection: ssh 
ansible_ssh_user: alexsp
2. Test inventory for configured hosts
ansible -i ~/study/Netology/devops-netology/12.4.ClusterRollOut/repo/kubespray/inventory/mycluster/inventory.ini all -m ping
study/Netology/devops-netology/12.4.ClusterRollOut/repo/kubespray/inventory/mycluster/inventory.ini
+ master 34.125.94.4
+ node 1 34.125.244.80
+ worker1 34.125.126.57
+ worker 2 34.125.244.210
ssh tester_aimc@34.125.126.57
добавил ключ по мануалу
https://souvikhaldar.medium.com/how-to-add-the-public-ssh-key-to-a-gcp-virtual-machine-ef5703e8e596

# проверяю ансибл
ansible -i ~/study/Netology/devops-netology/12.4.ClusterRollOut/repo/kubespray/inventory/mycluster/inventory.ini all -m ping
юзер задается в глобал варс алл
# Запускаю плейбук
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
