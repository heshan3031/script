#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;31m" [3]="\033[1;33m" [4]="\033[1;32m" )
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
  -bar2)cor="\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m" && echo -e "${cor}${SEMCOR}";;
  -bar)cor="\e[0;31m➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖\e[0m" && echo -e "${cor}${SEMCOR}";;
 esac
}
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}
ssl_stunel () {
[[ $(mportas|grep stunnel4|head -1) ]] && {
msg -ama "Parando Stunnel"
msg -bar
fun_bar "service stunnel4 stop"
msg -bar
msg -ama "Parado Con exito!"
msg -bar
}
}
msg -azu " SSL Stunnel Openssh"

ssl_iniciar() {
msg -bra " Que puerto desea abrir como SSL Openssh"
msg -bar
    while true; do
    read -p " Puerto SSL: " SSLPORT
    [[ $(mportas|grep -w "$SSLPORT") ]] || break
    msg -ama "esta puerta está en uso"
    unset SSLPORT
    done
msg -bar
msg -ama " Instalando SSL"
msg -bar
fun_bar "apt-get install stunnel4 -y"
msg -bar
msg -azu "Presione Enter a todas las opciones"
sleep 3
msg -bar
openssl genrsa 1024 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
cat stunnel.crt stunnel.key > stunnel.pem
mv stunnel.pem /etc/stunnel/
echo -e "client = no\n[ssh]\ncert = /etc/stunnel/stunnel.pem\naccept = ${SSLPORT}\nconnect = 127.0.0.1:22" > /etc/stunnel/stunnel.conf

echo "ENABLED=1 " >> /etc/default/stunnel4
echo "FILES="/etc/stunnel/*.conf" " >> /etc/default/stunnel4
echo "OPTIONS="" " >> /etc/default/stunnel4
echo "PPP_RESTART=0" >> /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
msg -bar
msg -ama "INSTALADO CON EXITO"
msg -bar
}

ssl_portas() {
msg -bra "Que puerto desea agregar como SSL Openssh"
msg -bar
    while true; do
    read -p " Puerto SSL: " SSLPORT1
    [[ $(mportas|grep -w "$SSLPORT1") ]] || break
    echo -e "esta puerta está en uso"
    unset SSLPORT1
    done
msg -bar
msg -ama "Instalando SSL"
msg -bar
fun_bar "apt-get install stunnel4"
msg -bar
msg -azu "Presione Enter a todas las opciones"
sleep 2
msg -bar
openssl genrsa 1024 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
cat stunnel.crt stunnel.key > stunnel.pem
mv stunnel.pem /etc/stunnel/

echo "client = no" >> /etc/stunnel/stunnel.conf
echo "[ssh+]" >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem" >> /etc/stunnel/stunnel.conf
echo "accept = ${SSLPORT1}" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:22" >> /etc/stunnel/stunnel.conf

service stunnel4 restart > /dev/null 2>&1
msg -bar
msg -ama "AGREGADO CON EXITO"
msg -bar
}

ssl_redir() {
msg -bra "Asigne un nombre para el redirecionador"
msg -bra "letras sin espacio ejem: shadow,openvpn,etc..."
msg -bar
read -p " nombre: " namer
msg -bar
msg -bra "A que puerto redirecionara el puerto SSL"
msg -bra "Es decir un puerto abierto en su servidor"
msg -bra "ejemplo: openvpn,shadowsocks,dropbear etc..."
msg -bar
read -p " Local-Port: " portd
msg -bar
msg -bra "Que puerto desea agregar como SSL"
msg -bar
    while true; do
    read -p " Puerto SSL: " SSLPORTr
    [[ $(mportas|grep -w "$SSLPORTr") ]] || break
    echo -e "esta puerta está en uso"
    unset SSLPORT1
    done
msg -bar
msg -ama " Instalando SSL"
msg -bar
fun_bar "apt-get install stunnel4"
msg -bar
msg -azu "Presione Enter a todas las opciones"
sleep 2
msg -bar
openssl genrsa 1024 > stunnel.key
openssl req -new -key stunnel.key -x509 -days 1000 -out stunnel.crt
cat stunnel.crt stunnel.key > stunnel.pem
mv stunnel.pem /etc/stunnel/

echo "client = no" >> /etc/stunnel/stunnel.conf
echo "[${namer}]" >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem" >> /etc/stunnel/stunnel.conf
echo "accept = ${SSLPORTr}" >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:${portd}" >> /etc/stunnel/stunnel.conf

service stunnel4 restart > /dev/null 2>&1
msg -bar
msg -ama " AGREGADO CON EXITO"
msg -bar
}

msg -bar
msg -bra "[1] = ABRIR PUERTO SSL"
msg -bra "[2] = AGREGAR MAS PUERTOS SSL"
msg -verd "[3] = REDIRECIONAR SSL"
msg -verm2 "[4] = DETENER PUERTO SSL"
msg -bra "[0] = SALIR"
msg -bar
while [[ ${varread} != @([0-3]) ]]; do
read -p "Opcion: " varread
done
msg -bar
if [[ ${varread} = 0 ]]; then
exit
elif [[ ${varread} = 1 ]]; then
ssl_iniciar
elif [[ ${varread} = 2 ]]; then
ssl_portas
elif [[ ${varread} = 3 ]]; then
ssl_redir
elif [[ ${varread} = 4 ]]; then
ssl_stunel
fi
msg -bar
rm -rf multissl.sh