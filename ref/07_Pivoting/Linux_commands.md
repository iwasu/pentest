# Useful commands
- Port forwarding
  - rinetd
    - http://www.howtoforge.com/port-forwarding-with-rinetd-on-debian-etch

  - ssh
    ~~~sh
    # ssh -[L/R] [local port]:[remote ip]:[remote port] [local user]@[local ip]
    ssh -L 8080:127.0.0.1:80 root@${HOST}    # Local Port
    ssh -R 10022:127.0.0.1:22 root@${HOST}    # Reverse
    ~~~

  - mknod
    ~~~sh
    # mknod backpipe p ; nc -l -p [remote port] < backpipe  | nc [local IP] [local port] >backpipe
    mknod backpipe p ; nc -l -p 8080 < backpipe | nc 10.1.1.251 80 >backpipe    # Port Relay
    mknod backpipe p ; nc -l -p 8080 0 & < backpipe | tee -a inflow | nc localhost 80 | tee -a outflow 1>backpipe    # Proxy (Port 80 to 8080)
    mknod backpipe p ; nc -l -p 8080 0 & < backpipe | tee -a inflow | nc localhost 80 | tee -a outflow & 1>backpipe    # Proxy monitor (Port 80 to 8080)
    ~~~

  - Proxy chains
    ## Is tunnelling possible? Send commands locally, remotely
    ssh -D 127.0.0.1:9050 -N root@${HOST}
    proxychains ifconfig


  - Copy bash to a new subshell
    # mount a NFS share from a remote server, copy bash from local to remote and execute
    cp -p ./bash /mnt/share/newbash
    ./newbash -p
