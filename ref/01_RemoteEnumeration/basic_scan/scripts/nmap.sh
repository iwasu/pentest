#!/bin/bash

TARGET=$1
echo "[i] TCP scan started."
nmap -v -sS -p1- -Pn --open -T4 -oA nmap-tcp-sS ${TARGET}
echo
echo "******************************************************************************************************"
echo

echo "[i] UDP scan started."
nmap -sU -T4 -v -A --reason --top-port 30 -oA nmap-udp-sU ${TARGET}
echo
echo "******************************************************************************************************"
echo


TCP_OPENNUM=`cat nmap-tcp-sS.nmap | grep " open" | wc -l`
TCP_OPENPORT=`cat nmap-tcp-sS.nmap | grep " open" | cut -d" " -f1 | cut -d"/" -f1 | tr "\n" "," | rev | cut -d"," -f2- | rev`
echo "[i] Exec nmap for fetching detail."
echo "[i] TCP: ${TCP_OPENNUM}"
echo "[i]   Open ports: ${TCP_OPENPORT}"
nmap -sTV -T4 -v -A --reason -oA nmap-tcp-sTV ${TARGET} -p${TCP_OPENPORT}
echo
echo "******************************************************************************************************"
echo

if [ -e "nmap-udp-simple.nmap" ]; then
  UDP_OPENNUM=`cat nmap-udp-simple.nmap | grep ' open' | grep -v filtered | wc -l`
  UDP_OPENPORT=`cat nmap-udp-simple.nmap | grep ' open' | grep -v filtered | cut -d" " -f1 | cut -d"/" -f1 | tr "\n" "," | rev | cut -d"," -f2- | rev`
  echo "[i] UDP: ${UDP_OPENNUM}"
  echo "[i]   Open ports: ${UDP_OPENPORT}"
  if [ ${UDP_OPENNUM} -ne 0 ]; then
    nmap -sUV -T4 -v -A --reason -oA nmap-udp-sUV -p${UDP_OPENPORT} ${TARGET}
  fi

  echo
  echo "******************************************************************************************************"
  echo
fi

echo "[i] nmap to ${TARGET} done."
