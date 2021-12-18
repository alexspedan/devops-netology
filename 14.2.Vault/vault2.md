alekseipedan@master1:~$ kubectl apply -f https://gitlab.com/k11s-os/k8s-lessons/-/raw/main/Vault/manifests/00-cm.yaml
configmap/vault-config created
alekseipedan@master1:~$ kubectl apply -f https://gitlab.com/k11s-os/k8s-lessons/-/raw/main/Vault/manifests/01-ss.yaml
statefulset.apps/vault created
alekseipedan@master1:~$ kubectl apply -f https://gitlab.com/k11s-os/k8s-lessons/-/raw/main/Vault/manifests/02-svc.yaml
service/vault created

alekseipedan@master1:~$ kubectl get svc
NAME    TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
vault   ClusterIP   None         <none>        8200/TCP   98s

https://gitlab.com/k11s-os/k8s-lessons/-/tree/main/Vault/manifests

run minikube
minikube start --vm-driver=docker  
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh


yum install iputils
yum install nmap

https://pastebin.com/z48T9cGW