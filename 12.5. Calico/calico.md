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
alekseipedan@master1:~$ calicoctl get node
NAME    
node1   
node2   
node3   

alekseipedan@master1:~$ calicoctl get ipPool
NAME           CIDR             SELECTOR   
default-pool   10.233.64.0/18   all()      

alekseipedan@master1:~$ calicoctl get profile
NAME                                                 
projectcalico-default-allow                          
kns.default                                          
kns.kube-node-lease                                  
kns.kube-public                                      
kns.kube-system                                      
ksa.default.default                                  
ksa.kube-node-lease.default                          
ksa.kube-public.default                              
ksa.kube-system.attachdetach-controller              
ksa.kube-system.bootstrap-signer                     
ksa.kube-system.calico-kube-controllers              
ksa.kube-system.calico-node                          
ksa.kube-system.certificate-controller               
ksa.kube-system.clusterrole-aggregation-controller   
ksa.kube-system.coredns                              
ksa.kube-system.cronjob-controller                   
ksa.kube-system.daemon-set-controller                
ksa.kube-system.default                              
ksa.kube-system.deployment-controller                
ksa.kube-system.disruption-controller                
ksa.kube-system.dns-autoscaler                       
ksa.kube-system.endpoint-controller                  
ksa.kube-system.endpointslice-controller             
ksa.kube-system.endpointslicemirroring-controller    
ksa.kube-system.ephemeral-volume-controller          
ksa.kube-system.expand-controller                    
ksa.kube-system.generic-garbage-collector            
ksa.kube-system.horizontal-pod-autoscaler            
ksa.kube-system.job-controller                       
ksa.kube-system.kube-proxy                           
ksa.kube-system.namespace-controller                 
ksa.kube-system.node-controller                      
ksa.kube-system.nodelocaldns                         
ksa.kube-system.persistent-volume-binder             
ksa.kube-system.pod-garbage-collector                
ksa.kube-system.pv-protection-controller             
ksa.kube-system.pvc-protection-controller            
ksa.kube-system.replicaset-controller                
ksa.kube-system.replication-controller               
ksa.kube-system.resourcequota-controller             
ksa.kube-system.root-ca-cert-publisher               
ksa.kube-system.service-account-controller           
ksa.kube-system.service-controller                   
ksa.kube-system.statefulset-controller               
ksa.kube-system.token-cleaner                        
ksa.kube-system.ttl-after-finished-controller        
ksa.kube-system.ttl-controller

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---