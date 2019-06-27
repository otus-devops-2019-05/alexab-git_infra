# alexab-git_infra
alexab-git Infra repository

# Выполнено ДЗ №4

 - [x] Деплой тестового приложения
 - [x] Задание со *
 ### В процессе сделано:
 - Установлен и настроен gcloud для работы с аккаунтом по инструкции;
 - Создан хост с помощью gcloud по инструкции;
 - Установлен ruby с помощью скрипта gist;
 - Установлен и запущен MongoDB с помощью скрипта gist;
 - Проведен деплой тестового приложения reddit с помощью скрипта gist;
 - Создан скрипт установки Ruby: install_ruby.sh;
 - Создан скрипт установки MongoDB: install_mongodb.sh;
 - Создан скрипт деплоя приложения: deploy.sh;
 - Создан startup-script.sh для деплоя инстанса и установки приложения;
 - Удалено и создано правило межсетевого экрана default-puma-server;

### Данные серверов GCP
testapp_IP = 35.198.80.80
testapp_port = 9292

### Деплой инстанса с установкой приложения с помощью startup-script
```shell
gcloud compute instances create reddit-app \ 
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--metadata-from-file startup-script=startup_script.sh
```
### Удаление и создание правила межсетевого экрана с помощью gcloud из консоли 
```shell
gcloud compute firewall-rules delete default-puma-server
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --source-ranges="0.0.0.0/0" --target-tags=puma-server
```

## PR checklist
 - [x] Выставил label с номером домашнего задания
 - [x] Выставил label с темой домашнего задания
