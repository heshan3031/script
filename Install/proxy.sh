#!/bin/bash
#creando carpetas
Alex="/etc/alexmod80" && [[ ! -d ${Alex} ]] && mkdir ${Alex}
SCProxy="/etc/proxymx" && [[ ! -d ${SCProxy} ]] && mkdir ${SCProxy}

#SCRIPT PROXY COLOR PYTHON
#YA LOS COLORES YA ESTAN MODIFICADOS Y YA SON ACEPTADOS EN EL BANNER DEL PROXY
#SCRIPT CREADO 12/MAYO/2020
#by @Alemod80
#@ConectedMX_Vip
#@conectedmx
#modified by GililloGonzalez
#archivo creado oficialmente x Alexmod80
#mi opcion es ayudar a los demas y ese es mi meta
#este script lo pueden usar de forma gratuita
#LIBRE DE MINERIA
#este archivo no lo pueden vender y en caso de que les haigan vendido x favor de comunicarse con el creador de este script
#archivo proxy color python
cd $HOME
publico=https://raw.githubusercontent.com/GililloGonz4/script/master/Install/Proxy-Publico.sh
privado=https://raw.githubusercontent.com/GililloGonz4/script/master/Install/Proxy-Privado.sh

#instalacion de paquetes python
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "INSTALANDO PAQUETES PYTHON"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
apt-get install python -y >/dev/null 2>&1
apt-get install python-pip -y >/dev/null 2>&1
#descargando archivo
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "DESCARGANDO ARCHIVOS"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
wget $publico >/dev/null 2>&1
wget $privado >/dev/null 2>&1

#moviendo el archivo y dando los permisos para aceptarlos sin problemas
mv -f Proxy-Publico.sh ${SCProxy}/Proxy-Publico.sh && chmod +x ${SCProxy}/Proxy-Publico.sh
mv -f Proxy-Privado.sh ${SCProxy}/Proxy-Privado.sh && chmod +x ${SCProxy}/Proxy-Privado.sh
rm -rf Proxy-Privado.sh 2>/dev/null
rm -rf Proxy-Publico.sh 2>/dev/null
rm -rf /bin/proxy 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/GililloGonz4/script/master/Install/proxy > /bin/proxy
chmod +x /bin/proxy
rm -rf proxy
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\e[37mINSTALACION FINALIZADA"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
clear
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
echo -e "\e[1;37mCOMANDO PARA ENTRAR AL MENÚ"
echo -e "\e[1;33mDIJITE>>> proxy PARA PODER ENTRAR\nAL PANEL PROXY SOCKS"
echo -e "By @Alexmod80\ncanal telegram: @conectedmx\ngrupo telegram: @ConectedMX_Vip"
echo -e "\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m"
rm -rf proxy.sh*
read -p "enter para entrar al panel"
proxy