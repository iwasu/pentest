# Nmap scripts
## Search nmap script
  ~~~
  ls -l /usr/share/nmap/scripts/*vuln*
  ~~~

## Ftp
  ~~~
  nmap -Pn -v -p 21 --script=ftp-anon.nse 10.11.1.1-254
  10.11.1.8
  10.11.1.13
  10.11.1.14
  10.11.1.115
  10.11.1.125
  10.11.1.202
  10.11.1.227
  ~~~

## Http
  - example
    ~~~
    nmap -v -p80,443 --script http-vuln-cve2010-2861.nse <host>
    nmap -A -p80,443 --script http-vuln-cve2010-2861.nse 10.11.1.0/24
    nmap -v -p 80 --script=http-vuln-cve2010-2861 10.11.1.210
    nmap -A -p80,443 --script all 10.11.1.0/24
    
    nmap -Pn -v -p 80 --script http-vuln-cve2011-3192 10.11.1.1-254
    ~~~

## SMB
  ~~~
  nmap -v -p 139, 445 --script=smb-security-mode 10.11.1.1-254
  10.11.1.5
  10.11.1.8
  10.11.1.24
  10.11.1.73
  10.11.1.75
  10.11.1.128
  10.11.1.136
  10.11.1.145
  10.11.1.202
  10.11.1.218
  10.11.1.220
  10.11.1.223
  10.11.1.229
  10.11.1.230
  ~~~

