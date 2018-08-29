#!/bin/bash
. libautotest

# check the return of the commands
# success: 0
# error: not 0
checkReturn() {
local ret=$1
local cmd=$2

if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "${cmd} is OK."
else
    printErr "${cmd}: return is ${ret}"
    printErr "${cmd} is failed."
    exit ${ret}
fi
}

# build Workspace
setDirectionOfPutout workspace.log
date
buildWorkspace
checkReturn $? buildWorkspace
removeOldFiles ${LOGDIR}
removeOldFiles ${SRCDIR}
mv workspace.log ${LOGDIR}
resetSTDOUT

# get source from GitLab
setDirectionOfPutout ${LOGDIR}/gitclone.log
date
runGitclone
resetSTDOUT

# build source
setDirectionOfPutout ${LOGDIR}/buildsource.log
date
buildSource
resetSTDOUT

# copy program to the target
setDirectionOfPutout ${LOGDIR}/target.log
date
runProgramOnTarget
resetSTDOUT

# run example and generate the report
setDirectionOfPutout ${LOGDIR}/report
date
generateReport
resetSTDOUT
