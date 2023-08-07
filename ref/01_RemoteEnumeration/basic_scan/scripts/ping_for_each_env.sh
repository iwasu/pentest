#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
  #pingMainOSX () {
  #  RESULT=`ping $1 -c 5`
  #  echo $RESULT
  #}
  OS='Mac'
  #ping 192.168.0.1 -c 5
  #ping 1.1.1.1 -c 5
  #pingMainOSX 192.168.24.1
else if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
else if [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

