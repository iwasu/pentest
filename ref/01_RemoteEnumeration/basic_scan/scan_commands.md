# Basic scan command
## Python

## Ruby

## Perl

## PowerShell

## cmd

## shell
- Alive hosts check
~~~
for ip in $(seq 1 254); do ping -c 1 10.x.x.$ip |  grep "bytes from" | cut -d" " -f4 | cut -d":" -f1 & ; done
~~~

# Scan tools
 - TCP Scan
   - vanilla scan
     - nmap
     - pscan.c
   - half open
     - nmap
     - scanrand
     - strobe

