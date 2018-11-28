#!/bin/ksh
find ./ -type f | xargs grep "${@}"
