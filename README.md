https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#apt-repo-fresh-install

Go to the download page for the MySQL APT repository at https://dev.mysql.com/downloads/repo/apt/.

```
wget https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.16-1_all.deb
sudo apt-get install
sudo apt-get install mysql-server
```

```
ls -la /etc/apt/sources.list.d
total 44
drwxr-xr-x 2 root root 4096 Mar 27 10:35 .
drwxr-xr-x 7 root root 4096 Mar 27 10:35 ..
-rw-r--r-- 1 root root  126 Mar 17 21:37 git-core-ubuntu-ppa-focal.list
-rw-r--r-- 1 root root  126 Mar 17 21:37 git-core-ubuntu-ppa-focal.list.save
-rw-r--r-- 1 root root  106 Mar 17 21:37 google-cloud-sdk.list
-rw-r--r-- 1 root root  106 Mar 17 21:37 google-cloud-sdk.list.save
-rw-r--r-- 1 root root  495 Mar 27 10:35 mysql.list
-rw-r--r-- 1 root root  108 Mar 17 21:37 nodesource.list
-rw-r--r-- 1 root root  108 Mar 17 21:37 nodesource.list.save
-rw-r--r-- 1 root root  142 Mar 17 21:37 wireshark-dev-ubuntu-stable-focal.list
-rw-r--r-- 1 root root  142 Mar 17 21:37 wireshark-dev-ubuntu-stable-focal.list.save

cat /etc/apt/sources.list.d/mysql.list 
### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out entries below, but any other modifications may be lost.
# Use command 'dpkg-reconfigure mysql-apt-config' as root for modifications.
deb http://repo.mysql.com/apt/ubuntu/ focal mysql-apt-config
deb http://repo.mysql.com/apt/ubuntu/ focal mysql-8.0
deb http://repo.mysql.com/apt/ubuntu/ focal mysql-tools
#deb http://repo.mysql.com/apt/ubuntu/ focal mysql-tools-preview
deb-src http://repo.mysql.com/apt/ubuntu/ focal mysql-8.0
```


For raw MySQL server, not docker, I followed the below article:
INSTALLING MYSQL 8.0 UNDER WSL 2 AND UBUNTU
https://www.58bits.com/blog/2020/05/03/installing-mysql-80-under-wsl-2-and-ubuntu

then: 

```
mysql -h 127.0.0.1 -u root -p 
```



for docker compose, I added 

```
    ports:
      - 13306:330
```

then the following worked:

```
 mysql -h 127.0.0.1 -P 13306 -u root --password=example 
```

Earlier I saw the below error:

```
ERROR: for docker-compose-sandbox_db_1  Cannot start service db: Ports are not available: listen tcp 0.0.0.0:3306: bind: Only one usage of each socket address (protocol/network address/port) is normally permitted.

ERROR: for db  Cannot start service db: Ports are not available: listen tcp 0.0.0.0:3306: bind: Only one usage of each socket address (protocol/network address/port) is normally permitted.
```

So I used the port 13306.
Using 3306 port worked after killing MySQL server on the Windows side

```
    ports:
      - 3306:3306
```


```console
# --network: docker network ls
# -path: seems ok with /migrations/, as otherwise it gives a different error = error: open /migrationsssssss: no such file or directory
# tcp(db:3306): cannot be 127.0.0.1 because the db container is on a different IP
docker run -v migrations:/migrations --network docker-compose-sandbox_default migrate/migrate -path=/migrations/ -database "mysql://root:example@tcp(db:3306)/mysql?multiStatements=true" up 2
error: first : file does not exist
```

