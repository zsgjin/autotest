#!/bin/bash

source tenv

removeOldFiles() {
local directory=$1
echo ${LOCAL_PWD} | sudo -S rm ${directory}/* -rfv

if [ $? -eq ${SUCCESSFUL} ]
then
    printInfo "clean ${directory}"
else
    printErr "can't clean ${directory}"
fi
}

buildDir() {
local ret=${SUCCESSFUL}

local dirname=$1
local dirpath=$2

if [ -d ${dirpath} ]
then
    printInfo "${dirname}=${dirpath}"
else
    mkdir -p ${dirpath}
    ret=$?
    if [ ${ret} -eq ${SUCCESSFUL} ]
    then
        printInfo "build ${dirname}=${dirpath}"
    else
        printErr "build ${dirname}"
        ret=${BUILD_F}
    fi
fi

return ${ret}
}

buildWorkspace() {
local ret=${SUCCESSFUL}

buildDir ROOTDIR ${ROOTDIR}
ret=$?
if [ ${ret} -gt ${SUCCESSFUL} ]
then
    return ${ret}
fi

buildDir SRCDIR ${SRCDIR}
ret=$?
if [ ${ret} -gt ${SUCCESSFUL} ]
then
    return ${ret}
fi
buildDir LOGDIR ${LOGDIR}
ret=$?
if [ ${ret} -gt ${SUCCESSFUL} ]
then
    return ${ret}
fi
}
