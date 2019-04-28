#/bin/bash

echo -e "\033[1;33m- - - - -> \033[01;34mScript para configurar certificado SSL"
echo -e "\033[1;33m #################"
echo -e "\033[1;31mTelegram @ANDROID9_0_MX"
sleep 2

apt-get update -y
clear
yum update -y
apt-get install openssh-server -y
clear
apt-get install curl -y
clear
yum install openssh-server -y
clear
apt-get install openssh-client -y
clear
yum install openssh-client -y
clear
apt-get install stunnel4 -y
clear
yum install stunnel4 -y
clear
apt-get install stunnel -y
clear
yum install stunnel -y
clear

echo -e "\033[1;31mCAPTURANDO IP"
ip=$(curl https://api.ipify.org/)
echo $ip
clear

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mPRESIONA ENTER"
echo -e "\033[1;33m #################"
sleep 1

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mGENERANDO CERTIFICADO"
echo -e "\033[1;33m #################"
sleep 1
openssl genrsa 2048 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt

echo -e "\033[1;31mCREANDO NUEVA CONFIGURACIÓN"
echo -e "\033[1;33m ######################################"
sleep 2
rm /etc/stunnel/stunnel.conf
clear
rm /etc/default/stunnel4
clear
cat stunnel.crt stunnel.key > stunnel.pem 
mv stunnel.pem /etc/stunnel/
clear
echo -e "\033[1;34mESCRIBE EL PUERTO SSL DE ESCUCHA  STUNNEL4"
echo -e "\033[1;32mPUERTO S S L DIRECTO"
read -p ": " portssl
clear
echo -e "\033[1;34mESCRIBE EL PUERTO LOCAL SHADOWSOCKS PYTHON"
echo -e "\033[1;32mPUERTO LOCAL"
read -p ": " portlocal
clear
echo -e "\033[1;34mESCRIBE EL PUERTO DE ESCUCHA SSL SHADOWSOCKS PYTHON"
echo -e "\033[1;32mPUERTO SSL ESCUCHA"
read -p ": " portshadow
clear

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mC O N F I G U R A N D O STUNNEL.CONF"
echo -e "\033[1;33m #################"
sleep 1

echo -e "\033[1;31m ###"
sleep 1
echo -e "\033[1;31m #########"
sleep 1
echo -e "\033[1;31m ################"
sleep 1
echo -e "\033[1;31m ########################"
sleep 1
echo -e "\033[1;31m ##################################"
sleep 1


echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf
echo "client = no " >> /etc/stunnel/stunnel.conf
echo "sslVersion = ALL " >> /etc/stunnel/stunnel.conf
echo "socket = a:SO_REUSEADDR=1 " >> /etc/stunnel/stunnel.conf
echo "socket = l:TCP_NODELAY=1 " >> /etc/stunnel/stunnel.conf
echo "socket = r:TCP_NODELAY=1 " >> /etc/stunnel/stunnel.conf
echo "" >> /etc/stunnel/stunnel.conf
echo "[ssh] " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:22 " >> /etc/stunnel/stunnel.conf
echo "accept = $portssl" >> /etc/stunnel/stunnel.conf
echo -e "\033[1;31mAGREGANDO PUERTO LOCAL PARA SHADOWSOCKS:\033[0m $portlocal" 
echo -e "\033[1;31mPUERTO DE ESCUCHA SHADOWSOCKS SSL:\033[0m $portshadow"
echo "" >> /etc/stunnel/stunnel.conf
echo "[stunnel] " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:$portlocal " >> /etc/stunnel/stunnel.conf
echo "accept = $portshadow " >> /etc/stunnel/stunnel.conf


echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mC O N F I G U R A N D O STUNNEL4"
echo -e "\033[1;33m ###################"
sleep 1

echo "ENABLED=1 " >> /etc/default/stunnel4
echo "FILES="/etc/stunnel/*.conf" " >> /etc/default/stunnel4
echo "OPTIONS="" " >> /etc/default/stunnel4
echo "PPP_RESTART=0" >> /etc/default/stunnel4

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31mI N I C I A N D O STUNNEL4"
echo -e "\033[1;33m ###################"
sleep 1

echo -e "\033[1;33m ######################################"
echo -e "\033[1;31m ##### PUEDEN SALIR ALGUNOS ERRORES NO TE PREOCUPES...######"
echo -e "\033[1;33m ######################################"
sleep 1
service ssh start 1>/dev/null 2 /dev/null
/etc/init.d/ssh start 1>/dev/null 2 /dev/null
service sshd start 1>/dev/null 2 /dev/null
/etc/init.d/sshd start 1>/dev/null 2 /dev/null
service sshd restart 1>/dev/null 2 /dev/null
/etc/init.d/sshd restart 1>/dev/null 2 /dev/null
service ssh restart 1>/dev/null 2 /dev/null
/etc/init.d/ssh restart 1>/dev/null 2 /dev/null
service stunnel4 start 1>/dev/null 2 /dev/null
/etc/init.d/stunnel4 start 1>/dev/null 2 /dev/null
service stunnel4 restart
/etc/init.d/stunnel4 restart 1>/dev/null 2 /dev/null
systemctl start stunnel4 1>/dev/null 2 /dev/null
systemctl restart stunnel 1>/dev/null 2 /dev/null
clear

echo -e "\033[1;33m #######ALGUNOS ERRORES SALDRÁN###############"
sleep 2
echo -e "\033[1;33m ###########REINICIADO...###########"
clear

echo -e "\033[1;33m ###################"
echo -e "\033[1;31mCOMPLETADA LA INSTALACIÓN"
echo -e "\033[1;33m ######################################"
echo -e "\033[1;33m- - - - -> \033[01;34mSU IP DEL HOST:\033[0m $ip"
echo -e "\033[1;33m- - - - -> \033[01;34mPUERTO SSL DIRECTO:\033[0m $portssl"
sleep 1
echo -e "\033[1;33m- - - - -> \033[01;34mPUERTO SHADOWSOCKS PYTHON LOCAL:\033[0m $portlocal"
sleep 1
echo -e "\033[1;33m- - - - -> \033[01;34mPUERTO SHADOWSOCKS PYTHON SSL:\033[0m $portshadow"
sleep 1
echo -e "\033[1;31mES NECESARIO REINICIAR sudo reboot o reboot"
sleep 2
echo -e "\033[1;33m- - ->>TELEGRAM \033[01;34mhttps://t.me/ANDROID9_0_MX"
sleep 1
echo -e "\033[1;33m- - ->>TELEGRAM \033[01;34mBY GILILLO GONZALEZ"
sleep 1
echo -e "\033[1;33m- - ->>CREADO POR GILILLO GONZALEZ \033[01;34m "
sleep 1
sudo reboot