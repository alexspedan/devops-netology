# Домашнее задание к занятию "09.03 Jenkins"

## Подготовка к выполнению

1. Установить jenkins по любой из [инструкций](https://www.jenkins.io/download/)
2. Запустить и проверить работоспособность
3. Сделать первоначальную настройку
4. Настроить под свои нужды
5. Поднять отдельный cloud
6. Для динамических агентов можно использовать [образ](https://hub.docker.com/repository/docker/aragast/agent)
7. Обязательный параметр: поставить label для динамических агентов: `ansible_docker`
8.  Сделать форк репозитория с [playbook](https://github.com/aragastmatb/example-playbook)

## Основная часть

1. Сделать Freestyle Job, который будет запускать `ansible-playbook` из форка репозитория
```
ansible-vault decrypt secret --vault-password-file vault_pass
mkdir ~/.ssh/ && mv ./secret ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa && eval `ssh -T git@github.com -o StrictHostKeyChecking=no`
ansible-galaxy install -r requirements.yml -p roles
ansible-playbook site.yml -i inventory/prod.yml
```
2. Сделать Declarative Pipeline, который будет выкачивать репозиторий с плейбукой и запускать её
```
pipeline {
    agent {
        node {
        label 'ansible_docker'
        }
    }
    stages {
        stege('Build') {
            steps {
                //Get some code from GitHub repository
                git 'https://github.com/alexspedan/example-playbook.git'
                sh ansible-vault decrypt secret --vault-password-file vault_pass
                sh mkdir ~/.ssh/ && mv ./secret ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
                sh 'eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa && eval `ssh -T git@github.com -o StrictHostKeyChecking=no`'
                sh ansible-galaxy install -r requirements.yml -p roles
                ansible-playbook inventory: 'inventory/prod.yml', playbook: site.yml

            }
        }
    }
}

```
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`
4. Перенастроить Job на использование `Jenkinsfile` из репозитория
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline)
6. Заменить credentialsId на свой собственный
```
node("ansible_docker"){
    stage("Git checkout"){
        git credentialsId: 'eeea196f17664883a7cd4eefaa69c312, url: 'git@github.com:alexspedan/example-playbook.git'
    }
    stage("Check ssh key"){
        secret_check=true
    }
    stage("Run playbook"){
        if (secret_check){
	    sh 'ansible-vault decrypt secret --vault-password-file vault_pass'
            sh 'mkdir -p ~/.ssh/ && mv ./secret ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa'
            sh 'eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa && eval `ssh -T git@github.com -o StrictHostKeyChecking=no`'
            sh 'ansible-galaxy install -r requirements.yml -p roles'
            sh 'ansible-playbook site.yml -i inventory/prod.yml'
        }
        else{
            echo 'no more keys'
        }
        
    }
}
```
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозитрий в файл `ScriptedJenkinsfile`
8. Отправить ссылку на репозиторий в ответе


### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
