#!/bin/bash

runGitclone() {
local ret=${SUCCESSFUL}

if [ -d ${SRCDIR} ]
then
    printInfo "SRCDIR is exiting."
else
    buildDir SRCDIR ${SRCDIR}
    ret=$?
    if [ ${ret} -gt ${SUCCESSFUL} ]
    then
        return ${ret}
    fi
fi

cd ${SRCDIR}
printInfo "enter SRCDIR=${SRCDIR}"

if [ -d ${REPOSITORY} ]
then
    printInfo "clean the existing ${REPOSITORY}"
    echo 'ubuntu' |sudo -S rm -r ${REPOSITORY}
fi

printInfo "begin to git clone ${GITURL}"
git clone ${GITURL} 
ret=$?
if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "git clone finished."
else
    printErr "git clone is failed!"
    ret=${GIT_F}
fi

return ${ret}
}

buildSource() {
local ret=${SUCCESSFUL}
local cur_dir=${pwd}

if [ "${cur_dir}" != "${SRCDIR}" ]
then
    cd ${SRCDIR}
else
    printErr "can't find ${SRCDIR}"
fi

echo "enter repository ${SRCDIR}/${REPOSITORY}"
cd ${REPOSITORY}
git checkout -b ${WORKINGBRANCH} ${REMOTE_BRANCH}
if [ $? -eq ${SUCCESSFUL} ]
then
    printInfo "git checkout -b ${WORKINGBRANCH} ${REMOTE_BRANCH}"
else
    printErr "can't checkout ${WORKINGBRANCH}"
    return ${BUILD_F}
fi
echo "enter ${MCONTROLLER} ${ROOTDIR}/${REPOSITORY}/${MCONTROLLER}"
cd ${MCONTROLLER}

echo "begin to make"
make ${TARGET_ARCH}

ret=$?
if [ ${ret} -eq ${SUCCESSFUL} ]
then
    printInfo "source building is finished."
else
    printErr "source building is failed."
    ret=${BUILD_F}
fi

return ${ret}
}
