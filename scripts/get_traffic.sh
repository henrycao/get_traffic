#!bin/sh
##usage sh get_traffic.sh $interface | sh get_traffic.sh eht1

while [ "1" ]
do
        ETH=$1
        RECE1=`cat /proc/net/dev | grep $ETH | tr : " " | awk -F " " '{print $2}'`
        TRAN1=`cat /proc/net/dev | grep $ETH | tr : " " | awk -F " " '{print $10}'`
        sleep 1
        RECE2=`cat /proc/net/dev | grep $ETH | tr : " " | awk -F " " '{print $2}'`
        TRAN2=`cat /proc/net/dev | grep $ETH | tr : " " | awk -F " " '{print $10}'`
        clear

        DATE=`date +%k:%M:%S`

        RX=$((${RECE2}-${RECE1}))
        TX=$((${TRAN2}-${TRAN1}))


        if [ $RX -lt 5120 ]
                then
                RX=$(echo $RX | awk '{print $1/5*8 "byte/s"}')
        elif [ $RX -gt 5242880 ]
                then
                RX=$(echo $RX | awk '{print $1/5242880*8 "Mb/s"}')
        else
                RX=$(echo $RX | awk '{print $1/5120*8 "Kb/s"}')
        fi

        if [ $TX -lt 5120 ]
                then
                TX=$(echo $TX | awk '{print $1/5*8 "byte/s"}')
        elif [ $TX -gt 5242880 ]
                then
                TX=$(echo $TX | awk '{print $1/5242880*8 "Mb/s"}')
        else
                TX=$(echo $TX | awk '{print $1/5120*8 "Kb/s"}')
        fi

        echo  "$DATE Receive $RX "
        echo  "$DATE Transmit $TX "
done
