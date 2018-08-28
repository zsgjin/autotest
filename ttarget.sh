#!/bin/bash

source tenv

isNetworkUp(){
local ip_to_check=$1
local is_up=1
local net_status=0

net_status=$(nmap ${ip_to_check} | grep 'Host is up' | wc -l)
if [ ${net_status} -eq ${is_up} ]
then
    printInfo "${ip_to_chek} is up"
    return ${SUCCESSFUL}
else
    printErr "${ip_to_chek} is down"
    return ${TARGET_OFF}
fi

}

runRemoteCmd() {
local passwd=$1
local remotecmd=$2

expect <<EXPECTEOF
spawn ${remotecmd}
expect "password"
send "${passwd}\r"
expect eof
EXPECTEOF
}

runTarget() {
local ret=${SUCCESS}

if [ -d ${INSTALLDIR} ]
then
    echo "INSTALLDIR=${INSTALLDIR}"
else
    echo "can't find INSTALLDIR"
    ret=${EXISTENCE_F}
fi

runRemoteCmd "fst" "scp -r ${INSTALLDIR} ${TARGET_USR}@${TARGET_IP}:${TARGET_DIR}"
ret=$?
if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "scp is done"
else
    printErr "scp is failed"
    ret=${SCP_F}
fi

runRemoteCmd "fst" "ssh ${TARGET_USR}@${TARGET_IP} \"cat ${TARGET_DIR}/shyan\""
ret=$?
if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "remote command is done"
else
    printErr "remote command is failed"
    ret=${REMOTECMD_F}
fi

return ${ret}
}
