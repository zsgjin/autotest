#!/bin/bash

source tenv.sh

printInfo() {
local info=$1
echo -e "${info}"
}

printErr() {
local err=$1
echo -e "\033[31mERROR: ${err}\033[0m"
}

touchReport() {
if [ -f ${LOGDIR} ]
then
    rm ${LOGDIR} -f
fi
touch ${LOGDIR}
date >> ${LOGDIR}
date
}
putoutExampleResult() {
if [ -f ${LOGDIR} ]
then
    exec 8>&1
    exec 1>>${LOGDIR}
fi

local serialnumber=$1
printInfo "************"
printInfo "****No. ${serialnumber}"
printInfo "************"

if [ $# -gt 4 ] || [ $# -lt 4 ]
then
    printErr "Bad Args, num is $#"
    return ${BAD_ARG}
fi

#local serialnumber=$1
local name=$2
local description=$3

#printInfo "No. ${serialnumber}"
printInfo "Name: ${name}"
printInfo "Description:" && cat ${description}

local example=$4
${example}
local ret=$?
if [[ ${ret} -eq ${SUCCESSFUL} ]]
then
    printInfo "Result: ${ret}"
else
    printErr "Result: ${ret}"
fi

if [ -f ${LOGDIR} ]
then
    exec 1>&8
fi
}
