#!/bin/bash

setDirectionOfPutout() {
exec 8>&1
exec 1>>$1
exec 9>&2
exec 2>>$1
}

resetSTDOUT() {
exec 1>&8
exec 2>&9
}

printInfo() {
local info=$1
echo -e "${info}"
}

printErr() {
local err=$1
echo -e "ERROR: ${err}"
}
