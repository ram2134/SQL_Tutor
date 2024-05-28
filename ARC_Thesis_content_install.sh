#!/bin/bash

# Update the package list
apt update

# Install wget
apt install -y wget

# Download the Oracle Java installer
wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb

# Install the Oracle Java installer
dpkg -i jdk-20_linux-x64_bin.deb

# Fix missing dependencies if any
apt-get install -f -y

# Verify that Java is installed
java -version

# Setup Java alternatives
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-20.0.2/bin/java 1
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-20.0.2/bin/javac 1

# Choose default Java version
echo 1 | update-alternatives --config java

# Install PostgreSQL and contrib package
apt install -y postgresql postgresql-contrib

# Start PostgreSQL service
service postgresql start

# Switch to PostgreSQL user and create database, users
sudo -u postgres psql << EOF
CREATE ROLE testuser WITH PASSWORD 'Testuser@123';
CREATE ROLE xdatauser WITH PASSWORD 'Xdatauser@123';
CREATE DATABASE xdatadb;
GRANT ALL PRIVILEGES ON DATABASE xdatadb TO xdatauser;
GRANT ALL PRIVILEGES ON DATABASE xdatadb TO testuser;
EOF

# Clone required scripts
git clone https://github.com/ram2134/Mtech_thesis_scripts.git

# Move scripts to the required destination
mv Mtech_thesis_scripts/Engine.php /var/www/app/modules
chmod 777 /var/www/app/modules/Engine.php

mv Mtech_thesis_scripts/Tutor.php /var/www/app/modules
chmod 777 /var/www/app/modules/Tutor.php

mv Mtech_thesis_scripts/xdata_script.sh /var/www/app/compilers
chmod 777 /var/www/app/compilers/xdata_script.sh

mv Mtech_thesis_scripts/xdata_wrapper.sh /var/www/app/compilers/wrappers
chmod 777 /var/www/app/compilers/wrappers/xdata_wrapper.sh

mv Mtech_thesis_scripts/t1.argfile /tmp

# Clone XData-DataGen
git clone https://github.com/ram2134/XData-DataGen.git
chmod -R 777 XData-DataGen
chmod -R 777 /tmp
chmod g+s /tmp

mv XData-DataGen/XData/Z3\ files/z3 /usr/bin
mv XData-DataGen/XData/Z3\ files/libz3.so /usr/lib
mv XData-DataGen/XData/Z3\ files/libz3java.so /usr/lib
chmod 777 /usr/bin/z3

echo "All tasks completed successfully."

