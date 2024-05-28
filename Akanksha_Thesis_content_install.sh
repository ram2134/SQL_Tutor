##install oracle java


# Update the package list
apt update

#install wget
apt install wget

# Download the Oracle Java installer
wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb

# Install the Oracle Java installer
dpkg -i jdk-20_linux-x64_bin.deb

# Verify that Java is installed
java -version

update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-20.0.2/bin/java 1
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-20.0.2/bin/javac 1
update-alternatives --config java




##Install the postgresql 

#install package
apt install postgresql postgresql-contrib

#Start postgresql
service postgresql start

#cget postgresql terminal
psql -U postgres

#create database ,users 
CREATE ROLE testuser WITH PASSWORD 'Testuser@123';
CREATE ROLE xdatauser WITH PASSWORD 'Xdatauser@123';
create database xdatadb;
grant all privileges on database xdatadb to xdatauser;
grant all privileges on database xdatadb to testuser;


##Get all the required scripts

git clone https://github.com/akku126/Mtech_thesis_scripts.git

#move scripts to required destination

mv /Mtech_thesis_scripts/Engine.php /var/www/app/modules
chmod 777 /var/www/app/modules/Engine.php


mv /Mtech_thesis_scripts/Tutor.php /var/www/app/modules
chmod 777 /var/www/app/modules/Tutor.php

mv /Mtech_thesis_scripts/xdata_script.sh /var/www/app/compilers
chmod 777 /var/www/app/compilers/xdata_script.sh


mv /Mtech_thesis_scripts/xdata_wrapper.sh /var/www/app/compilers/wrappers
chmod 777 /var/www/app/compilers/wrappers/xdata_wrapper.sh

mv /Mtech_thesis_scripts/t1.argfile /tmp

#get XData-DataGen
git clone https://github.com/akku126/XData-DataGen.git
chmod -R 777 /XData-DataGen
chmod -R 777 /tmp

chmod g+s /tmp

mv /XData-DataGen/XData/Z3\ files/z3 /usr/bin
mv /XData-DataGen/XData/Z3\ files/libz3.so /usr/lib
mv /XData-DataGen/XData/Z3\ files/libz3java.so /usr/lib
chmod 777 /usr/bin/z3





