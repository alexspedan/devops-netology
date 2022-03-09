# Дипломный проект практикум в Яндекс.Облако
  * [Этапы выполнения:](#этапы-выполнения)
     * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
     * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
     * [Создание тестового приложения](#создание-тестового-приложения)
     * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
     * [Установка и настройка CI/CD](#установка-и-настройка-cicd)

## Этапы выполнения:
Для выполнения дипломного проекта в репозитории devops-netology создаю папку [diploma](https://gitlab.com/alex.s.pedan/devops-netology/-/tree/main/diploma/)
копия [diploma](https://github.com/alexspedan/devops-netology/tree/main/diploma)

### Создание облачной инфраструктуры
Для управления облачной инфраструктурой использую Terraform. Коофигурации хранятся на репозитории в папке [terraform](https://gitlab.com/alex.s.pedan/devops-netology/-/tree/main/diploma/terraform)
копия [terraform](https://github.com/alexspedan/devops-netology/tree/main/diploma/terraform).
Для развертывания кластера kubernetes создаю 3 yandex instances.

### Создание Kubernetes кластера

Для создания кластера kubernetes использую [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)
Вывод команды kubectl get pods --all-namespaces ![]()

---
### Создание тестового приложения
В качестве тестового приложения будет использоваться проект страницы резюме.
[CV](https://gitlab.com/alex.s.pedan/resume-project.git)
копия
[CV](https://github.com/alexspedan/resume-project)
Для деплоя в kubernetes собран контейнер docker pull alexspedan/cv-project

### Подготовка cистемы мониторинга и деплой приложения
Конфигурационные файлы для k8s хранятся в репозитории [k8s configs](https://github.com/alexspedan/devops-netology/tree/main/diploma/k8s-configs)
Приложение доступно по [ссылке](http://51.250.3.51:30163/) или http://apedan.tk
Дашборд графаны доступен: [по ссылке](http://51.250.3.51:30062/) 
[K8s cluster dashboard](http://51.250.3.51:30062/d/efa86fd1d0c121a26444b636a3f509a8/kubernetes-compute-resources-cluster?orgId=1&refresh=10s&from=1646661302739&to=1646664902739)

### Установка и настройка CI/CD
Для автоматической сборки и деплоя используется GitlabCI pipeline.
Для сборки и деплоя в kubernetes используется 2 stage. Pipeline доступен по ссылке: [Gitlab Pipeline](https://gitlab.com/alex.s.pedan/resume-project/-/blob/75eba9ebe6e360318058617afc7a3501531e000a/.gitlab-ci.yml)
