# SMTP
## Research
  -

## Commands
  - Banner Detection and check validate command
    ~~~sh
    nc -nv <host> 25
    
    HELP
    VRFY root
    ~~~
  
  - Plain Auth
    ~~~sh
    telnet <host> 25
     220 co.jp ESMTP
    EHLO localhost
     250-hmailserver
    250-SIZE
     250 AUTH LOGIN PLAIN
    AUTH PLAIN c3dyeHJvb3Ryb290Cg==
     535 Authentication failed. Restarting authentication process.
    quit
     221 goodbye
    ~~~

  - STARTTLS(465, 587)
    ~~~sh
    sslscan --starttls-smtp <domain>:<port>
    ~~~

  - One liner VRFY
    ~~~sh
    for user in $(cat users.txt); do echo VRFY $user | nc -nv -w 1 [IP] 25 2>/dev/null | grep ^"250"; done
    #for user in $(cat users.txt); do echo VRFY $user | nc -nv -w 1 10.11.1.72 25 2>/dev/null | grep ^"250"; done
    ~~~

## Script
  - enum