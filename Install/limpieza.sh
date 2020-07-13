#script/install
#limpieza automatica alas 5 am empieza la limpieza automatica
echo "Limpiando sistema y Reiniciando Servicios" 
echo 3 > /proc/sys/vm/drop_caches &> /dev/null
sysctl -w vm.drop_caches=3 &> /dev/null
swapoff -a && swapon -a &> /dev/null
#reiniciando servicios
service ssh restart > /dev/null 2>&1
service squid restart > /dev/null 2>&1
service squid3 restart >/dev/null 2>&1
echo "Limpieza Finalizada"
#finalizada
