# Environment
ROOTDIR=/home/zsgjin/work/project/tautotest

EXAMPLESDIR=${ROOTDIR}/examples
LIBDIR=${ROOTDIR}/lib
LOGDIR=${ROOTDIR}/log
SCRIPTDIR=${ROOTDIR}/script
SRCDIR=${ROOTDIR}/src
REPORT=report

GITURL=git@git.foresight-robotics.cn:MC_System/Application.git
REPOSITORY=Application
MCONTROLLER=Motion_controller
INSTALLDIR=${ROOTDIR}/${SRCDIR}/${REPOSITORY}/${MCONTROLLER}/install

TARGET_ARCH=arm
TARGET_IP=192.168.1.29
TARGET_DIR=/home/fst/work/tproject
TARGET_USR=fst
TARGET_PASSWD='fst'

LOCAL_PWD='ubuntu'

# Error

SUCCESSFUL=0
BAD_ARG=1
BUILD_F=2
GIT_F=3
BUILD_F=4
REMOTECMD_F=5
EXISTENCE_F=6
