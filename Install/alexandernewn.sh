#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
clear
cd $HOME
Da="/etc/consumo"
SCPdir="/etc/newadm"
SCPinstal="$HOME/install"
SCPidioma="${SCPdir}/idioma"
SCPusr="${SCPdir}/ger-user"
SCPfrm="/etc/ger-frm"
SCPfrm3="/etc/adm-lite"
SCPinst="/etc/ger-inst"

## PAQUETES PRINCIPALES 
apt-get install grep -y &>/dev/null
apt-get install figlet -y &>/dev/null
apt-get install lolcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get install net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "gawk"|head -1) ]] || apt-get install gawk -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "mlocate"|head -1) ]] || apt-get install mlocate -y &>/dev/null
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;
###PAQUETES A INSTALAR

grep -v "^Port 22" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config &>/dev/null
echo "Port 22" >> /etc/ssh/sshd_config
grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
grep -v "^Port 441" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config &>/dev/null
echo "Port 441" >> /etc/ssh/sshd_config
grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

rm $(pwd)/$0 &> /dev/null
msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' &&NEGRITO='\e[1m' && SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -bar2)cor="\e[0;31m=-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="\e[0;31m=-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-=-=-=-==-=-=-=--=-==-=-=-=-" && echo -e "${cor}${SEMCOR}";;
 esac
}
fun_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
mm_decho (){
local i stepping
stepping="0.01"

# When first argument is empty or not given, it just echoes a new line
# and leaves.
if [ ! "$1" ]; then 
echo
return
fi

# If a second argument is given (delay stepping), check it for validity
# (if it is a float) and set stepping according to the argument.
if (( $# > 1 )) && 
[[ ($2 = $(echo $2 | grep -oE '[[:digit:]]')) ||
($2 = $(echo $2 | grep -oE '[[:digit:]]+\.[[:digit:]]+')) ]] 
then
stepping="$2"
# In case the previous test failed, but we have a second argument,
# meaning it is invalid, just print the message, complain a bit and then
# quit the function with false.
elif (( $# > 1 )); then
echo "$1"
echo ".! mm_decho() oops: second argument is invalid!" 1>&2
echo ".! must be /float but is: \"$2\", leaving function.." 1>&2
return false 2>/dev/null
fi

# Do delayed printing of first input argument. Calculate the
# length of first arg. and substract one. Then make it a /for/
# sequence going through all the characters of the string,
# printing these and wait the delay stepping time.
for i in $(seq 0 $((${#1}-1))); do
echo -ne "${1:$i:1}"
sleep $stepping
done
echo
}

###INTALAR PAQUETES PARA BANER Y AVISOS

msg -bar
inst_components () {
echo -e "\033[31m  -- INSTALANDO PAQUETES --  \e[1;32m by Alexmod80"
msg -bar
sleep 2s
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null && mm_decho "  INSTALANDO jq" "0.08"
[[ $(dpkg --get-selections|grep -w "php"|head -1) ]] ||  apt-get install php -y >/dev/null 2>&1 && mm_decho "  INSTALANDO php" "0.08"
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null && mm_decho "  INSTALANDO nano" "0.08"
[[ $(dpkg --get-selections|grep -w "bc"|head -1) ]] || apt-get install bc -y &>/dev/null && mm_decho "  INSTALANDO bc" "0.08"
[[ $(dpkg --get-selections|grep -w "sudo"|head -1) ]] || apt-get install sudo -y &>/dev/null && mm_decho "  INSTALANDO sudo" "0.08"
[[ $(dpkg --get-selections|grep -w "lsof"|head -1) ]] || apt-get install lsof -y &>/dev/null && mm_decho "  INSTALANDO lsof" "0.08"
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null && mm_decho "  INSTALANDO figlet" "0.08"
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || apt-get install lolcat -y &>/dev/null && mm_decho "  INSTALANDO lolcat" "0.08"
[[ $(dpkg --get-selections|grep -w "cowsay"|head -1) ]] || apt-get install cowsay -y &>/dev/null && mm_decho "  INSTALANDO cowsay" "0.08"
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null && mm_decho "  INSTALANDO screen" "0.08"
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null && mm_decho "  INSTALANDO python" "0.08"
[[ $(dpkg --get-selections|grep -w "python-pip"|head -1) ]] || apt-get install python-pip -y &>/dev/null && mm_decho "  INSTALANDO python-pip" "0.08"
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null && mm_decho "  INSTALANDO python3" "0.08"
[[ $(dpkg --get-selections|grep -w "python3-pip"|head -1) ]] || apt-get install python3-pip -y &>/dev/null && mm_decho "  INSTALANDO python3-pip" "0.08"
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null && mm_decho "  INSTALANDO curl" "0.08"
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null && mm_decho "  INSTALANDO ufw" "0.08"
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null && mm_decho "  INSTALANDO unzip" "0.08"
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null && mm_decho "  INSTALANDO zip" "0.08"
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 85;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 } && mm_decho "  INSTALANDO apache2" "0.08"
 msg -bar2
 sleep 2
 clear 
}

inst_components

funcao_idioma () {
msg -bar2
echo -e "\e[1;33mSelecione Un Idioma\e[0m"
msg -bar2
declare -A idioma=( [1]="en English" [2]="fr Franch" [3]="de German" [4]="it Italian" [5]="pl Polish" [6]="pt Portuguese" [7]="es Spanish" [8]="tr Turkish" )
for ((i=1; i<=12; i++)); do
valor1="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor1 ]] && break
valor1="\033[1;32m[$i] > \033[0;31m$valor1"
    while [[ ${#valor1} -lt 37 ]]; do
       valor1=$valor1" "
    done
echo -ne "$valor1"
let i++
valor2="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor2 ]] && {
   echo -e " "
   break
   }
valor2="\033[1;32m[$i] > \033[0;31m$valor2"
     while [[ ${#valor2} -lt 37 ]]; do
        valor2=$valor2" "
     done
echo -ne "$valor2"
let i++
valor3="$(echo ${idioma[$i]}|cut -d' ' -f2)"
[[ -z $valor3 ]] && {
   echo -e " "
   break
   }
valor3="\033[1;32m[$i] > \033[0;31m$valor3"
     while [[ ${#valor3} -lt 37 ]]; do
        valor3=$valor3" "
     done
echo -e "$valor3"
done
msg -bar2
unset selection
while [[ ${selection} != @([1-8]) ]]; do
echo -ne "\033[1;37mSELECIONE: " && read selection
tput cuu1 && tput dl1
done
pv="$(echo ${idioma[$selection]}|cut -d' ' -f1)"
[[ ${#id} -gt 2 ]] && id="es" || id="$pv"
byinst="true"
}
install_fim () {
msg -ama "$(source trans -b es:${id} "Instalacion Completa, Utilize los Comandos"|sed -e 's/[^a-z -]//ig')" && msg bar2
echo -e " menu / adm /mod" && msg -verm "$(source trans -b es:${id} "En seguida se reiniciara su VPS "|sed -e 's/[^a-z -]//ig')"
[[ $(find /etc/newadm/ger-user -name nombre.log|grep -w "nombre.log"|head -1) ]] || wget -O /etc/newadm/ger-user/nombre.log https://raw.githubusercontent.com/GililloGonz4/script/master/Install/nombre.log &> /dev/null
msg -bar2
rm -rf /etc/rc.local
echo '#!/bin/sh -e' >> /etc/rc.local
sudo chmod +x /etc/rc.local
echo '#!/bin/bash' > /bin/port5050
sudo chmod +x /bin/port5050
echo '#!/bin/bash' > /bin/autobadvpn
sudo chmod +x /bin/autobadvpn
echo "sudo port5050 &&  sudo notfy ||" >> /etc/rc.local
echo "sudo autobadvpn" >> /etc/rc.local
echo "sleep 5s" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
wget https://raw.githubusercontent.com/GililloGonz4/script/master/Install/notfy.sh -O /bin/notfy &> /dev/null
chmod +rwx /bin/notfy
sleep 10
reboot
}
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
verificar_arq () {
[[ ! -d ${Da} ]] && mkdir ${Da}
[[ ! -d ${SCPdir} ]] && mkdir ${SCPdir}
[[ ! -d ${SCPusr} ]] && mkdir ${SCPusr}
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
[[ ! -d ${SCPfrm3} ]] && mkdir ${SCPfrm3}
case $1 in
"menu"|"message.txt"|"banner.txt")ARQ="${SCPdir}/";; #Menu
"dados.sh")ARQ="${Da}/";; #consumo
"painel.zip")ARQ="${SCPfrm3}/";; #painel
"usercodes")ARQ="${SCPusr}/";; #User
"openssh.sh")ARQ="${SCPinst}/";; #Instalacao
"squid.sh")ARQ="${SCPinst}/";; #Instalacao
"dropbear.sh")ARQ="${SCPinst}/";; #Instalacao
"autdropbear.sh")ARQ="${SCPinst}/";; #Instalacao
"openvpn.sh")ARQ="${SCPdir}/";; #Instalacao
"ssl.sh")ARQ="${SCPinst}/";; #Instalacao
"sslh.sh")ARQ="${SCPinst}/";; #nuevo
"errormanager.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsocksGo.sh")ARQ="${SCPinst}/";; #Instalacao
"shadown.sh")ARQ="${SCPinst}/";; #Instalacao
"ssrrmu.sh")ARQ="${SCPinst}/";; #Instalacao
"panelweb.sh")ARQ="${SCPfrm}/";; #Instalacao
"hacker.sh")ARQ="${SCPfrm}/";; #Instalacao
"utiliza")ARQ="${SCPdir}/";; #Instalacao
"squidmx")ARQ="${SCPdir}/";; #squid
"danted.conf")ARQ="${SCPdir}/";; #Instalacao
"webmin.sh")ARQ="${SCPinst}/";; #Instalacao
"shadowsocks.sh")ARQ="${SCPinst}/";; #Instalacao
"v2ray.sh")ARQ="${SCPinst}/";; #Instalacao
"v2-ray.sh")ARQ="${SCPinst}/";; #Instalacao
"sockspy.sh"|"PDirect.py"|"PPub.py"|"PPriv.py"|"POpen.py"|"PGet.py")ARQ="${SCPinst}/";; #Instalacao
*)ARQ="${SCPfrm}/";; #Ferramentas
esac
mv -f ${SCPinstal}/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
NOTIFY () {
msg -bar
msg -ama " NOTIFY-(Notificasion Remota)"
msg -bar
echo -e "\033[1;94m Es una APP que le enviara notificasiones cuando\n un usuario sea bloquedo o este expirado, e info de VPS."
echo -e "\033[1;97m Primero Descargar el APP Notify"
echo -e "\033[1;92mDescargar:\033[1;34m https://www.dropbox.com/s/7sot0ed3bjm9sq5/Notify.apk"
echo -e "\033[1;97m Seguido instalela y abrala esta le genera un TOKEN"
msg -bar
echo -e "\033[1;91mEspere unos segundos instalando Paquetes"
#
apt-get install npm -y > /dev/null 2>&1
#
npm install -g notify-cli > /dev/null 2>&1
#
ln -s /usr/bin/nodejs /usr/bin/node > /dev/null 2>&1
#
npm cache clean -f > /dev/null 2>&1
#
npm install -g n > /dev/null 2>&1
#
n stable > /dev/null 2>&1
#
msg -bar
echo -e "\033[1;97mIgrese un nombre para el VPS:\033[0;37m"; read -p "su nombre es?: " nombr
echo "${nombr}" > /etc/newadm/ger-user/nombre.log
echo -e "\033[1;97mIgrese su TOKEN:\033[0;37m"; read -p "clave notify?: " key
notify -r $key > /dev/null 2>&1
msg -bar
echo -e "\033[1;32m    TOKEN AGREGADO CON EXITO"
msg -bar
NOM="$(less /etc/newadm/ger-user/nombre.log)"
NOM1="$(echo $NOM)"
notify -i "✅MENSAJE DE PRUEBA EXITOSO✅" -t "🔰VPS IP: $NOM1🔰" > /dev/null 2>&1
echo -e "\033[1;34mSE ENVIO EL MENSAJE DE PRUEBA "
}
fun_ip
wget -O /usr/bin/trans https://raw.githubusercontent.com/GililloGonz4/script/master/Install/trans &> /dev/null
wget -O /bin/Desbloqueo.sh https://raw.githubusercontent.com/GililloGonz4/script/master/Install/Desbloqueo.sh &> /dev/null
chmod +x /bin/Desbloqueo.sh
clear
msg -bar2
echo -e "\e[1;31mBIENVENIDO Y GRACIAS POR UTILIZAR NEW-ADM Mod\e[0m"
echo -e "\e[31mby @Alexmod80\e[0m"
figlet *2020* | lolcat
 echo -e " "
msg -bar2
msg -bra "[ NEW - ULTIMATE - SCRIPT - MOD ] ➣ \033[1;33m[\033[1;34mBY-ALEXANDER \033[1;33m]\033[0m"
echo ""
[[ $1 = "" ]] && funcao_idioma || {
[[ ${#1} -gt 2 ]] && funcao_idioma || id="$1"
 }
error_fun () {
msg -bar2 && msg -verm "$(source trans -b es:${id} "Esta Key era de otro servidor por lo que fue excluida"|sed -e 's/[^a-z -]//ig') " && msg -bar2
[[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}
exit 1
}
invalid_key () {
msg -bar2 && msg -verm "Key no valida! " && msg -bar2
[[ -e $HOME/lista-arq ]] && rm $HOME/lista-arq
exit 1
}
while [[ ! $Key ]]; do
msg -ne "Pegar Key Aquí: " && read Key
tput cuu1 && tput dl1
done
msg -ne "Key: "
cd $HOME
wget -O $HOME/lista-arq $(ofus "$Key")/$IP > /dev/null 2>&1 && echo -e "\033[1;32m Verificado" || {
   echo -e "\033[1;32m Verificado"
   invalid_key
   exit
   }
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') && echo "$IP" > /usr/bin/vendor_code
sleep 1s
updatedb
if [[ -e $HOME/lista-arq ]] && [[ ! $(cat $HOME/lista-arq|grep "KEY INVALIDA!") ]]; then
   msg -bar2
   msg -ama "$(source trans -b es:${id} "BIENVENIDO, GRACIAS POR UTILIZAR"|sed -e 's/[^a-z -]//ig'): \033[1;31m[NEW-ULTIMATE]"
   REQUEST=$(ofus "$Key"|cut -d'/' -f2)
   [[ ! -d ${SCPinstal} ]] && mkdir ${SCPinstal}
   pontos="*"
   stopping="$(source trans -b es:${id} "Verificando Actualizaciones"|sed -e 's/[^a-z -]//ig')"
   for arqx in $(cat $HOME/lista-arq); do
   msg -verm "${stopping}${pontos}"
   wget -O ${SCPinstal}/${arqx} ${IP}:85/${REQUEST}/${arqx} > /dev/null 2>&1 && verificar_arq "${arqx}" || error_fun
   tput cuu1 && tput dl1
   pontos+="*"
   done
   sleep 1s
   msg -bar2
   listaarqs="$(locate "lista-arq"|head -1)" && [[ -e ${listaarqs} ]] && rm $listaarqs   
   cat /etc/bash.bashrc|grep -v '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' > /etc/bash.bashrc.2
   echo -e '[[ $UID != 0 ]] && TMOUT=15 && export TMOUT' >> /etc/bash.bashrc.2
   mv -f /etc/bash.bashrc.2 /etc/bash.bashrc
   echo "${SCPdir}/menu" > /usr/bin/menu && chmod +x /usr/bin/menu
   echo "${SCPdir}/menu" > /usr/bin/adm && chmod +x /usr/bin/adm
   echo "${SCPdir}/menu" > /usr/bin/mod && chmod +x /usr/bin/mod
   echo "$Key" > ${SCPdir}/key.txt
   [[ -d ${SCPinstal} ]] && rm -rf ${SCPinstal}   
   [[ ${#id} -gt 2 ]] && echo "es" > ${SCPidioma} || echo "${id}" > ${SCPidioma}
   echo -e "\e[1;31m$(source trans -b es:${id} "Desea Instalar NOTIFY?(Default n)")"
  echo -e "\033[1;92mDescargar:\033[1;34m https://www.dropbox.com/s/7sot0ed3bjm9sq5/Notify.apk"
  echo -e "\033[1;34mFUNICONA SOLO PARA VERCIONES UBUNTU 16-17-18-19"
   msg -bar2
   read -p " [ s | n ]: " NOTIFY   
   [[ "$NOTIFY" = "s" || "$NOTIFY" = "S" ]] && NOTIFY
   msg -bar2
   sed -i "126d" /etc/ssh/sshd_config > /dev/null 2>&1
sed -i '$a Port 22' /etc/ssh/sshd_config  > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
   [[ ${byinst} = "true" ]] && install_fim
else
invalid_key
fi
