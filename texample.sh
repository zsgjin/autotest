#!/bin/bash

source tenv.sh

touchReport() {
local ret=${SUCCESSFUL}

if [ -d ${LOGDIR} ]
then
    printInfo "enter LOGDIR=${LOGDIR}"
else
    mkdir -p ${LOGDIR}
    printInfo "mkdir -p ${LOGDIR}"
fi

cd ${LOGDIR}

if [ -f ${REPORT} ]
then
    printInfo "clean the existing report"
    echo ${LOCAL_PWD} | sudo -S rm ${REPORT} -rfv
fi

touch ${REPORT}
date >> ${REPORT}
printInfo "new report"

return ${ret}
}

printPatternOfReport() {
local pnum=$1
local pname=$2
local pdescription=$3

printInfo "********************"
printInfo "No.$pnum"
printInfo "Example: ${pname}"
printInfo "Description: ${pdescription}"

sudo ./${pname}
ret=$?
if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "Result: ${ret}"
else
    printErr "${ret}"
fi
}

generateReport() {
local ret=${SUCCESSFUL}
local report=${LOGDIR}/report

cd ${EXAMPLESDIR}
ret=$?
if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "enter EXAMPLESDIR=${EXAMPLESDIR}"
else
    printErr "can't find EXAMPLESDIR"
    exit ${EXISTENCE_F}
fi

local cnt=1
local examples=$(cat ./list)
for example int ${examples}
do
    if [ -d ${example} ]
    then
        cd ${example}
        local des=$(cat ./description)
        printPatternOfReport ${cnt} ${example} "${des}"
    else
        printInfo "********************"
        printInfo "No.$cnt"
        printInfo "Example: ${example}"
        printErr "can't find the example--${example}"
    fi
    
    cnt=$[${cnt}+1]
done
}
