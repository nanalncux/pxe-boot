# pxe-boot ubuntu-20.04
Конфигурируем сервер сетевой установки ubuntu-20.04
Для запуска сервера необходимо:
 - иметь предустановленную виртуальную машину (или железную) Debian/Ubuntu с прямым доступом в интернет до репозиториев с iso образами. Дополнительный сетевой интерфейс внутренней сети в которой будет работать dhcp сервер и pxe. (можете внести изменения в файлы конфигурации pxe-boot/isc-dhcp-server в соответствии с вашими нуждами, подробнее смотрите в документации isc-dhcp-server)
 - настройте аутентификацию по ssh ключу в эту машину как root.
 - установить ansible со всеми зависимостями на машине в которую будете клонировать файлы этого репозитория. Добавьте в /etc/ansible/hosts следующие строчки
 
 [dhcp]
pxe-test2		ansible_connection=ssh		ansible_user=root
 
 
 Краткое описание процесса.
Playbook-ansible запускается командой:

ansible-playbook mytask.yml

Ansible подключается к виртуальной машине, устанавливает необходимые для работы службы (dhcp,tftp,nginx), создает необходимые каталоги, включает forwardin интерфейсов а затем копирует файлы конфигурации из этого репозитория. Далее запускаетс скрипт wget-unzip-netboot.sh который в свою очередь скачивает live и netboot образы необходимы для установки и перезагружает машину.

Подробнее про каталоги.
 - ansible-playbook - сабж
 - biosboot - менюшка для инсталяции в legacy(bios) режиме загрузки машины через pxelinux.0
 - iptables-rules - правила маршрутизации пакетов в изолированную сеть (nat)
 - isc-dhcp-server - файлы конфигурации сервиса dhcp
 - nginx - настройки веб сервера для отдачи статических файлов необходимых в процессе сутевой установки (preseed, cloud-config, live-iso)
 - preseeed - файлы ответов для установки
    - oem.seed - устанавливает ubuntu на программный RAID1 (user - ubuntu; pass - 123) используется при загрузке в legacy (bios) режиме. Создает разделы (/boot, / , /bla)
    - meta-data, user-data - файлы ответов в формате cloud-config (cloud-init). используется при загрузке в режиме uefi. Так же устанавливает систему на RAID1 с бекапом uefi загрузчика. Создает разделы (/boot, / , /bla)
 - tftp-hpa - файлы конфигурации tftp сервера.
 - uefiboot - хранит загрузчик uefi и файл конфигурации GRUB.
 
Скрипты:
 - iface-get-static.sh - необходим для установки статического адреса. Используется в файле oem.seed. Устанавливает статический адрес интерфейса в устанавливаемой системе.
 - wget-unzip-boot.sh - необходим для скачивания и распаковки установочных образов. Можете изменить ссылки внутри файлов. 
 
 Почитать по теме:
https://ubuntu.com/server/docs/install/netboot-amd64
https://ubuntu.com/server/docs/install/autoinstall-quickstart
https://www.debian.org/releases/stretch/mips/apbs04.html.ru
https://askubuntu.com/questions/1235723/automated-20-04-server-installation-using-pxe-and-live-server-image
https://wiki.syslinux.org/wiki/index.php?title=PXELINUX


Холивар на тему разных вариантов автоустановки
https://discourse.ubuntu.com/t/netbooting-the-live-server-installer/14510


