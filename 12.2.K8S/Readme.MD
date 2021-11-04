# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods
  ```
 kubectl apply -f https://raw.githubusercontent.com/alexspedan/devops-netology/main/12.2.K8S/apiVersion%3A%20apps/hello-node-deployment.yaml
 kubectl get deployments
 kubectl get pods
  ```
```
deployment.apps/hello-node-deployment created
root@worker2:/home/tester_aimc# kubectl get deployments
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
hello-node-deployment   2/2     2            2           34s
root@worker2:/home/tester_aimc# kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
hello-node-deployment-84b577b4bc-txnn8   1/1     Running   0          48s
hello-node-deployment-84b577b4bc-wh78l   1/1     Running   0          48s
```

## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)
```
kubectl create serviceaccount developer
kubectl create clusterrole developer --verb=get --verb=list --verb=watch --resource=pods
kubectl create clusterrolebinding developer --serviceaccount=default:developer --clusterrole=developer
TOKEN=$(kubectl describe secrets "$(kubectl describe serviceaccount developer | grep -i Tokens | awk '{print $2}')" | grep token: | awk '{print $2}')
kubectl config set-credentials tester --token=$TOKEN
kubectl config set-context podreader --cluster=kubernetes --user=tester
kubectl config use-context podreader
```
## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 kubectl scale --replicas=5 -f https://raw.githubusercontent.com/alexspedan/devops-netology/main/12.2.K8S/apiVersion%3A%20apps/hello-node-deployment.yaml
 * проверить что все поды перешли в статус running (kubectl get pods)
```
# kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
hello-node-deployment-84b577b4bc-2vgq7   1/1     Running   0          16s
hello-node-deployment-84b577b4bc-jrbwr   1/1     Running   0          16s
hello-node-deployment-84b577b4bc-q4btj   1/1     Running   0          16s
hello-node-deployment-84b577b4bc-txnn8   1/1     Running   0          8m13s
hello-node-deployment-84b577b4bc-wh78l   1/1     Running   0          8m13s
```
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
