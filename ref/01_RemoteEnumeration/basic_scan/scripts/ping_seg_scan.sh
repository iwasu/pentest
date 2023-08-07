#!/bin/sh
NETWORK=$1
for n in $(seq 1 254); do
  IPADDR="$NETWORK.$n"
  ping $IPADDR -c 1 > /dev/null
  arp -n $IPADDR | awk "{ print \"$IPADDR\", \$4 }" | grep -v incomplete
done
