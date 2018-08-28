#!/bin/bash

source tenv.sh

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
