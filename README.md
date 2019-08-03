# alexab-git_infra [![Build Status](https://travis-ci.com/otus-devops-2019-05/alexab-git_infra.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/alexab-git_infra)

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

# Выполнено ДЗ №5
 - [x] Сборка образов VM при помощи Packer
 - [x] Задание со *

### В процессе сделано:
 - Установлен и настроен packer по инструкции;
 - Установлен Application Default Credentials (ADC)по инструкции;
 - Создан шаблон packer ubuntu16.json;
 - Параметризирован созданный шаблон с помощью variables.json, так же создан variables.json.example для примера;
 - Подключены скрипты для провижининга install_ruby.sh и install_mongodb.sh в шаблон ubuntu16.json из предыдущего ДЗ №4;
 - Создан образ reddit-base из шаблона ubuntu16.json;
 - Создан инстанс из образа reddit-base, установлены зависимости и запущено приложение;
 - Создан шаблон immutable.json, создан systemd unit reddit.service, шаблон параметризирован с помощью immutable_vars.json;
 - Создан образ reddit-full из шаблона с развернутым приложеним reddit;
 - Создан скрипт create-reddit-vm.sh для запуска вирутальной машины gcluod на основе семейства reddit-full;
 - Файлы immutable_vars.json и variables.json добавлены в .gitignore;

## PR checklist
 - [x] Выставил label с номером домашнего задания
 - [x] Выставил label с темой домашнего задания

# Выполнено ДЗ №6
 - [x] Практика IaC с использованием Terraform  
 - [x] Задание со *
 - [x] Задание с **

### В процессе сделано:
 - Установлен и настроен Terraform по инструкции;
 - Установлен Application Default Credentials (ADC)по инструкции;
 - Создана виртуальная машина с помощью terraform apply;
 - Добавлен SSH ключ для пользователя appuser в main.tf;
 - Создан outputs.tf для вывода app_external_ip;
 - Определено правило фаерволла для приложения в main.cf;
 - Добавлен тег инстансу VM в main.cf;
 - Добавлен provisioner Systemd unit puma.service в main.cf;
 - Добавлен provisioner deploy.sh для развертывания приложения;
 - Добавлены параметры подключения provisioners, используя для подключения приватный ключ пользователя appuser
 - Созданы входные переменные и обновлен main.cf для их использования;
 - Определена input переменная для приватного ключа, обновлен main.cf;
 - Отформатированны все конфигурационные файлы с помощью terraform fmt;
 - Создан terraform.tfvars.example.

### Задание со * 
 - Добавлены ssh ключи пользователей appuser1, appuser2 в метаданных проекта с помощью terraform;
 - Добавлен ssh ключ appuser_web в веб-интерфейсе;
 - После применения конфигурации terraform apply ssh ключ пользователя appuser_web, добавленный при помощи веб-интерфейса, был удален;
 - В случае использования одинакового ssh ключа в метаданных проекта и метаданных экзепляра виртуальный машины, будет использован  ssh ключ экземпляра витруальной машины.

### Задание с ** 
 - Cоздан файл конфигурации lb.tf с описанием HTTP балансировщика, направляющего трафик на инстанс приложения reddit-app;
 - Добавлена переменная в outputs.tf для вывода ip адреса HTTP балансировщика;
 - Добавлен в код еще один terraform ресурс для нового инстанса: reddit-app2;
 - Добавлен в группу HTPP балансироващика инстантс reddit-app2;
 - Добавлен в outputs.tf адрес второго инстанса;
 - Проверена работа приложения при выключении одного инстанса;
 - Удалено описание reddit-app2;
 - Конфиграционные файлы переписаны с использованием заданием количества инстансов через параметр ресурса count.

### Проблемы конфигурации приложения
 - Добвление нового инстанса приложения ведёт к изменениям в конфигурационных файлах main.tf, lb.rt, outputs.tf;
 - Для повышения автоматизации необходимо перейти на создания инстансов приложения из шаблона, тогда отпадёт необходимость в ручной модификации конфигурационных файлов.


## PR checklist
 - [x] Выставил label с темой домашнего задания

# Выполнено ДЗ №7
 - [x] Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform.

### В процессе сделано:
 - Определил ресурс файервола для доступа по протоклу ssh в конфигурационном файле main.tf;
 - Импортировал существующую инфраструктуру в Terraform;
 - Создан ресурс IP адреса;
 - Созданы образы с помощью packer: reddit-app-base с установленными Ruby и reddit-db-base, содержащий установленную MongoDB;
 - Разделил main.tf на несколько конфигов: app.tf - конфигурация для VM с приложением, db.tf - конфигурация для VM с СУБД;
 - Созданы соответсвующие variables.tf;
 - Вынес правила фаервола в конфигурационный файл vpc.tf;
 - Cоздал модуль конфигуации приложения в директории modules/app;
 - Cоздал модуль конфигуации базы данных в директории modules/db;
 - Cоздал модуль конфигуации фаервола в директории modules/vpc;
 - Параметризировал модуль vpc за счет использования input переменных;
 - Создал директории stage и prod и перенёс в каждую из директорий конфигурационные файлы из директории terraform;
 - Открыл доступ по ssh в stage для в всех, в prod только для ip адреса рабочей станции;
 - Создал и применил конфигурацию storage-bucket.tf.

### Задание со * 
 - Создал ключ доступа к API, добавил переменную окружения GOOGLE_APPLICATION_CREDENTIALS, содержащую путь к ключу доступа;
 - Создал конфигурационный файл backend.tf в дрироекториях prod и stage для хранения стейт-файла terraform;
 - Перенес конфигурационные файлы Terraform в другую директорию (вне репозитория). При запуске из этой директории terraform apply сообщает что нет необходимости внесения изменений: No changes. Infrastructure is up-to-date;
 - Запустил применение конфигураций одновременно из разных директорий, в результате terraform блокирует стейт-файл: Terraform acquires a state lock to protect the state from being written by multiple users at the same time;

### Задание с **
 - Добавил необходимые provisioner в модули для деплоя и работы приложения;
 - Пренес файлы, используемые в provisioner, в директории модуля;
 - Добавиал outputs.tf в модуль db для предачи ip адреса в модуль app;
 - Добавил provisioner в модуль db для изминения привязки сервиса mongodb к сетевому интерфейсу;
 - Настроил переменную окружения DATABASE_URL для соединения с базой данных, находящейся на инстансе reddit-db;
 
 
## PR checklist
 - [x] Выставил label с темой домашнего задания

# Выполнено ДЗ №8
 - [x] Управление конфигурацией.Основные DevOps инструменты. Знакомство с Ansible.

### В процессе сделано:
 - Установил ansible;
 - Запустил вирутальные машины stage с помощью terrafom apply;
 - Создал ansible/inventory с настройками подключения к виртуальным машинам по ssh;
 - Проверил соединения с appserver и dbserver при помощи ansible;
 - Изучил работу модулей ansible: command и shell;
 - Заменил формат inventory на YAML;
 - Написал ansible плейбук clone.yml;
 - Удалил директорию ~/reddit на appserver и запустил ansible-playbook clone.yml. Получил PLAY RECAP:  appserver: ok=2 changed=1. Плейбук отработал и внес изменения (клонировал reddit.git) в соответсвии с заданием. При повторном запуске ansible-playbook clone.yml в PLAY RECAP changed будет равняться 0, так как reddit.git уже склонирован на целевой виртуальной машине. 

### Задание со * 
 - Написал скрипт для создания динамического инвентори reddit-hosts-list.py;
 - Проверил работу скрипта инвентори с помощью комманды ansible all -m ping;
 - В файле ansible.cfg сделаны настройки для работы с JSON inventory;

## PR checklist
 - [x] Выставил label с темой домашнего задания

# Выполнено ДЗ №9
 - [x] Деплой и управление конфигурацией с Ansible.

### В процессе сделано:
 - Создал новую ветку в гит: ansible-2;
 - Создал плейбук reddit_app.yml, прописал в нем сценарий для MongoDB;
 - Создал шаблон конфига MongoDB templates/mongod.conf.j2, определил переменные в плейбуке;
 - Проверил работоспособность с помощью ansible-playbook reddit_app.yml --check --limit db
 - Добавил в плейбук handlers, systemd unit и шаблон templates/db_config.j2 для приложения;
 - Проверил работоспособность и применил плейбук reddit_app.yml с тегами app-tag для хостов app;
 - Добавил в плейбук reddit_app.yml деплой кода и установку зависимостей;
 - Проверил работоспособность и применил плейбук с тегами deploy-tag для хостов app;
 - Проверил работоспособность приложения;
 - Реорганизовал плейбук по сценариям для приложения, MongoDB и деплоя в файл reddit_app2.yml;
 - Пересоздал инфраструктуру и проверил работоспособность, применим плейбук reddit_app2.yml;
 - Разделил reddit_app2.yml на одтельные плейбуки app.yml, db.yml, deploy.yml;
 - Создал site.yml для управления конфигурацией всей инфраструктурой;
 - Пересоздал инфраструктуру и проверил работоспособность, применим плейбук site.yml;
 - Изменил провижининг в Packer на использование плейбуков ansible ansible/packer_app.yml и ansible/packer_db.yml;

### Задание со * 
 - В качестве замены своего скприта для ansible dynamic inventory выбрал плагин gcp_compute;
 - Изменил плейбук app.yml, ip адрес хоста MongoDB определяется динамичекски;

### PR checklist
 - [x] Выставил label с темой домашнего задания


# Выполнено ДЗ №10
 - [x] Ansible: работа с ролями и окружениями.

### В процессе сделано:
 - Создал новую ветку в гит: ansible-3;
 - Создал структуру ролей app и db с помощью ansible-galaxy init;
 - Перенес tasks, handlers, templates, files из ansible/app.yml в соответвующие файлы роли app;
 - Перенес tasks, handlers, templates из ansible/db.yml в соответвующие файлы роли db;
 - Проверил работоспособность приложения: создал инфраструктуру stage, применил плейбук site.yml;
 - Создал окружения для stage и prod;
 - Определил окружение по умолчанию в ansible.cfg;
 - Параметризировал конфигурации ролей за счет переменных group_vars;
 - Перенесем все плейбуки в отдельную директорию ansible/playbooks;
 - Перенес файлы из директории ansible от предыдущих ДЗ в ansible/old;
 - Проверил работоспособность приложения: пересоздал инфраструктуру stage, применил плейбук site.yml;
 - Проверил работоспособность приложения: пересоздал инфраструктуру prod, применил плейбук site.yml;
 - Установил коммьюнити-роль jdauphant.nginx;
 - Добавил переменные stage/group_vars/app и prod/group_vars/app для роли jdauphant.nginx;
 - Открыл 80-ый порт для инстанса reddit-app с помощью тега http-server в терраформ-модуле app;
 - Добавил вызов роли jdauphant.nginx в плейбуке app.yml;
 - Создайте файл vault.key, содержащий ключ. Внёс соответсвующие изменения в ansible.cfg;
 - Создл плейбук users.yml для создания пользователей;
 - Создал файлы credentials.yml с данными пользователей для окружения stage и prod;
 - Зашифровал файлы credentials.yml, используя vault.key;
 - Добавил вызов плейбука users.yml в файл site.yml;
 - Применил плейбук site.yml, проверил что пользователи созданы в системе.
 
### Задание со * 
 - Настроил использование динамического инвентори для окружений stage и prod.

### Задание с **
 - Для отладки прохождения тестов установил trytravis;
 - Создал репозиторий alexab-git/trytravis и настроил trytravis;
 - Добавил в .travis.yml следующие проверки: packer validate, tflint, packer validate, ansible-lint;
 - Отладил .travis.yml с помощью  trytravis;
 - Добавил в README.md бейдж со статусом билда.

### PR checklist
 - [x] Выставил label с темой домашнего задания

# Выполнено ДЗ №11
 - [x] Ansible: Разработка и тестирование Ansible ролей и плейбуков

### В процессе сделано:
 - Создал новую ветку в гит: ansible-4;
 - Установил vagrant, создал ansible/Vagrantfile, создал виртуальные машины при помощи комманды vagrant up;
 - Добавил в .gitignore файлы, относящиеся к vagrant;
 - Проверил работоспособность при помощи vagrant box list, vagrant box status, vagrant ssh appserver;
 - Доработал роль db: добавлен провижининг, добавлены таски для установки и управления конфигом MongoDB;
 - Внёс соответсвующие изменения в файл конфигурации roles/db/tasks/main.yml;
 - Проверил работу роли: vagrant provision dbserver;
 - Доработал роль app: добавлен провижининг, добавлены таски для установки ruby и puma;
 - Внёс соответсвующие изменения в файл конфигурации roles/app/tasks/main.yml;
 - Проверил работу роли: vagrant provision appserver;
 - Параметризировал роли app/defaults/main.yml и app/tasks/puma.yml;
 - Параметризировал ansible/playbooks/deploy.yml;
 - Переопределил пользователя при вызове плейбуков с помощью extra_vars;
 - Проверил работу роли: vagrant provision appserver;
 - Установил Molecule, Testinfra на локальную машину используя pip;
 - Выполнил команду molecule init для создания заготовки тестов для роли db;
 - Описал тестовую виртуальную машину в файле db/molecule/default/molecule.yml;
 - Применим playbook.yml, в котором вызывается роль db к созданному хосту;
 - Провел тесты с помощью molecule verify;
 - Добавил проверку, что mongo слушает по нужному порту: tcp/27017
 
### Задание со *
 - Дополнил конфигурацию Vagrant для корректной работы проксирования приложения с помощью nginx;

### Задание с **

### PR checklist
 - [x] Выставил label с темой домашнего задания

