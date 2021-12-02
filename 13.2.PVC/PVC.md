## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
Обновляю deployments для frontend и backend
kubectl apply -f https://raw.githubusercontent.com/alexspedan/devops-netology/main/13.2.PVC/pvc.yaml -n staging
перейдем в namespace staging
kubectl config set-context --current --namespace=staging

* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

![](https://github.com/alexspedan/devops-netology/raw/main/13.2.PVC/13.2N1.png)

## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
Меняю accessModes: на ReadWriteMany
>.  alexsp@master1:~$ kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes_postgres_statefulset/master/storage.yml
persistentvolume/postgres-pv configured
![](https://github.com/alexspedan/devops-netology/raw/main/13.2.PVC/13.2N2.png)
* фронтенды тоже подключаются к этому же PV с таким же режимом;
kubectl apply -f 
* файлы, созданные бекендом, должны быть доступны фронту.
![](https://github.com/alexspedan/devops-netology/raw/main/13.2.PVC/13.2.p3.png)
---
