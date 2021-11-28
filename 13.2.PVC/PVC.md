## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
Обновляю deployments для frontend и backend
https://raw.githubusercontent.com/alexspedan/devops-netology/main/13.1.Kubernetes/frontend_deployment.yaml
https://raw.githubusercontent.com/alexspedan/devops-netology/main/13.1.Kubernetes/backend_deployment.yaml

* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.
![](https://github.com/alexspedan/devops-netology/raw/main/13.2.PVC/13.2p1.png)
![](https://github.com/alexspedan/devops-netology/raw/main/13.2.PVC/13.2p2.png)

## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
Меняю accessModes: на ReadWriteMany
``` alexsp@master1:~$ kubectl apply -f https://raw.githubusercontent.com/alexspedan/kubernetes_postgres_statefulset/master/storage.yml
persistentvolume/postgres-pv configured ```
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.

---