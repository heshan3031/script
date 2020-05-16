#!/bin/bash 

NOM=`less /root/nombre.log`
NOM1=`echo $NOM`
notify -i "⚠️ LA VPS: $NOM1 FUE REINICIANDA ⚠️" -t "❗️El Reinicio fue ✅EXITOSO✅❗️"



