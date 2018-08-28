#!/bin/bash

setDirectionOfPutout() {
exec 8>&1
exec 1>>$1
}

resetSTDOUT() {
exec 1>&8
}

printInfo() {
local info=$1
echo -e "${info}"
}

printErr() {
local err=$1
echo -e "ERROR: ${err}"
}
