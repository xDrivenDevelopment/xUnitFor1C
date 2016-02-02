Настройка vagrant для запуска 1с предприятия в виртуальной машине. 
Для правильной работы необходимо скачать ..\..\distr\ установочные пакеты 1с(i386) , в файле conf/nethasp.ini прописать ip адресс своего сервера лицензирования и выполнить комманду 
```
vagrant up
```
Для запуска тестов после всех установок необходимо выполнить 
```
vagrant ssh -c /vagrant/externals/vagrant/run-tests.sh
``` 
результат работы можно увидеть перейти по адрессу http://localhost:6080/vnc_auto.html *пароль* 123456 или же подключившись любым vnc viewer по адрессу 192.168.33.10:5901 пароль 123456

Для желающих автоматически скачать пакеты, можно использовать такую последовательность комманд 
```
V8ERSION=8_3_6_1760
V8USER=ВАШЛОГИН
V8PASSW=ПАРОЛЬ

mkdir -p ../../distr
cd ../../distr

wget --http-user=$V8USER -v --http-passwd=$V8PASSW --continue  http://downloads.v8.1c.ru/get/Info/Platform/$V8ERSION/deb.tar.gz
wget --http-user=$V8USER -v --http-passwd=$V8PASSW --continue  http://downloads.v8.1c.ru/get/Info/Platform/$V8ERSION/client.deb.tar.gz


tar xvf ./client.deb.tar.gz
tar xvf ./deb.tar.gz

```
