# alexab-git_infra
alexab-git Infra repository

# Выполнено ДЗ №3
 - [x] [Знакомство с облачной инфраструктурой. Google Cloud Platform](#gcp)
 - [x] Задание со *
### В процессе сделано:
 - Активирован аккаунт GCP, созданы виртаульные машины bastion, someinternalhost
 - Подключение по ssh к виртуальной машине bastion
 - Подключние по ssh к someinternalhost, используя SSH Forwarding на виртуальной машине bastion
 - Подключения к someinternalhost в одну команду
 - Подключение к someinternalhost по команде: ssh someinternalhost
 - Установлен и настроен VPN-сервер для серверов CGP, порт udp 18121
 - Настроен и протестирован доступ с локальной машины по ssh на хост someinternalhost через VPN тоннель
 - Создан и поключен валидный сертификат для веб-интерфейса Pritunl

<a name="gcp"><h4>Данные серверов GCP</h4></a>

bastion_IP = 35.198.80.80
someinternalhost_IP = 10.156.0.3

### Подключение к someinternalhost в одну команду
 Для подключения в одну команду ипользуем опцию ProxyJump:
```shell 
ssh -J appuser@35.198.80.80 appuser@10.156.0.3
```
 Где -J - опция ProxyJump, 35.198.80.80 - ip-адрес bastion, 10.156.0.3 - ip-адрес someinterlahost 

### Подключение к someinternalhost по команде: ssh someinternalhost
 Для подключения из консоли по команде ssh someinternalhost вненсём изменения в конфигурационный файл ~/.ssh/config:
```text
 Host bastion
	User appuser
	Hostname 35.198.80.80
 Host someinternalhost
	User appuser
	Hostname 10.156.0.3
	ProxyJump bastion
```
### Создание и подключение сертификата веб-интерфейса Pritunl
Для создания и подлючения валидного сертификата в веб-интерфейсе Pritunl необходимо:
 - Зайти в веб-интерфейс панели управления Pritunl
 - В разделе Settings прописать Lets Encrypt Domain, взяв за основу ip-адрес bastion и добавив домен sslip.io: 35.198.80.80.sslip.io
 - Сохранить настройки

Проверить установки сертификата по адресу https://35.198.80.80.sslip.iq

## PR checklist
 - [x] Выставил label с номером домашнего задания
 - [x] Выставил label с темой домашнего задания

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
