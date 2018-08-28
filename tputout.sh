#!/bin/bash

setDirectionOfPutout() {
exec 8>&1
exec 1>>$1
}

resetSTDOUT() {
exec 1>&8
}
