#!/bin/bash
mkdir /etc/bot &>/dev/null
wget -O /etc/bot/bott https://raw.githubusercontent.com/scriptsmx/script/master/PLUSX/bot &>/dev/null
chmod +x /etc/bot/bott
encender(){
read -p "DIJITE SU TOKEN: " token
read -p "DIJITE SU ID:" id
echo ""
}
start_bot () {
unset PIDBOT
PIDBOT=$(ps aux|grep -v grep|grep "bott")
if [[ ! $PIDBOT ]]; then
screen -dmS verybot /etc/bot/bott "$token" "$id"
echo "	BOT ENCENDIDA"
else
killall bott
echo "	BOT APAGADA"
fi
}

unset PID_BOT
PID_BOT=$(ps x|grep -v grep|grep "bott")
[[ ! $PID_BOT ]] && PID_BOT="\033[1;31m[ ✖ OFF ✖]    " || PID_BOT="\033[1;32m[ EN LINEA ]"
echo ""
echo -e "\033[1;31m[1] =  \e[1;33mENCENDER| APAGAR BOT $PID_BOT \033[0m"
echo -e "\033[1;31m[2] =  \e[1;33mVOLVER"
echo -e "\033[1;31m[0] =  \e[1;31mSALIR  \033[0m"
echo ""
echo -ne "\e[1;31m❭❭❭\e[1;35mSELECIONE UNA OPCIÓN\e[1;31m ❬❬❬\e[1;37m:\e[1;33m "; read selection
case $selection in
1)
encender
start_bot;;
2)menu;;
0)exit;;
esac
