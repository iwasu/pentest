# Port forwarding

## rinetd
  - 

## ssh
  - 

## Proxychain
  - cmd
    ~~~
    vim /etc/proxychain.conf
    proxychains nmap -p 3389 -sT -Pn <target>-22 --open
    ~~~
    
## HTTP tunneling
  - nc
    ~~~
    nc -vvn <proxy ip> <port>
    
    CONNECT <target>:<ip> HTTP/1.0
    
    HEAD / HTTP/1.0
    (request)
    ~~~


