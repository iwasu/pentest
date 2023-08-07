# For remote research
- IP discovery
  ~~~
  netdiscover -r 10.0.2.0/24
  nmap -sP 10.1.1.0/24
  ~~~

- Discover Services
  - nmap
    ~~~sh
    HOST="192.168.1.1"
    nmap -v -sT --open -oA nmap-openports-tcp_${HOST} ${HOST} # check open ports
    nmap -v -sU --open -oA nmap-openports-udp_${HOST} ${HOST} # check open ports for udp
    nmap -v -sTV -A --version-intensity 6 -p`grep " open" nmap-openports-tcp_${HOST}.nmap | cut -d"/" -f1 | tr '\n' ',' | rev | cut -d"," -f2- | rev` -oA nmap-details-tcp_${HOST} ${HOST} # check details for tcp
    nmap -v -sUV -A --version-intensity 6 -p`grep " open" namp-openports-udp_${HOST}.nmap | cut -d"/" -f1 | tr '\n' ',' | rev | cut -d"," -f2- | rev` -oA nmap-details-udp_${HOST} ${HOST} # check details for udp
    ~~~

    - Fast scanning
      ~~~sh
      nmap -F ${HOST}
      ~~~

  - [TBV] Unicornscan
    ~~~sh
    # -H:  resolve hostnames
    # -m:  scan mode(sf - tcp, U - udp)
    # -Iv: verbose
    unicornscan -H -msf -Iv -p `grep " open" nmap-openports-tcp_${HOST}.nmap | cut -d"/" -f1 | tr '\n' ',' | rev | cut -d"," -f2- | rev` ${HOST} # tcp scan
    unicornscan -H -mU -Iv -p `grep " open" nmap-openports-tcp_${HOST}.nmap | cut -d"/" -f1 | tr '\n' ',' | rev | cut -d"," -f2- | rev` ${HOST} # tcp scan
    ~~~

# TCP
- FTP
  ~~~sh
  nmap --script=*ftp* --script-args=unsafe=1 -p 20,21 ${TARGET}
  ~~~

- SSH
  - server info
    ~~~sh
    nmap --script=ssh2-enum-algos,ssh-hostkey,sshv1.nse ${HOST}
    ~~~
  - User enum
    ~~~sh
    python ./40136.py ${TARGET} -U /usr/share/wordlists/metasploit/unix_users.txt -e --trials 5 --bytes 10
    ~~~

- Telnet
  ~~~sh
  nmap -p ${PORT} --script telnet-brute --script-args userdb=/usr/share/metasploit-framework/data/wordlists/unix_users,passdb=/usr/share/wordlists/rockyou.txt,telnet-brute.timeout=20s ${TARGET}
  ~~~

- SMTP
  - base
    ~~~sh
    smtp-user-enum -M VRFY -U /usr/share/wordlists/metasploit/unix_users.txt -t ${TARGET}
    telnet ${TARGET} 25
      help
      [Any command]
      EHLO barry
    ~~~
  - my tools
    ~~~sh
    (in the meantime)
    ~~~

- HTTP
  - too many > refer to active/http/*

- SMB
  - Many > refer to active/smb/*

- RPC
  ~~~sh
  nmap -sV --script=nfs-* ${HOST}
  rpcinfo -p ${HOST}
  rpcclient -I ${HOST}
  # mount
  mount -t nfs ${HOST}:/home/vulnix /tmp/mnt -nolock
  # enumerate NFS shares
  showmount -e ${HOST}
  ~~~

- MS SQL
  ~~~sh
  nmap -p ${PORT} --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=${PORT},mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER ${TARGET}
  ~~~

# UDP
- connect
  ~~~sh
  nc -u ${HOST} 161
  ~~~

- DNS
  ~~~sh
  # reverse lookup
  # -n: dns server
  TRGTRANGE="192.168.13.200-192.168.13.254"
  DNSSERVER="192.168.13.220"
  HOST="192.168.13.220"
  TRGTDOMAIN="acme.local"
  dnsrecon -r ${TRGTRANGE} -n ${DNSSERVER}
  # bruteforce the acme.local domain for domains and subdomains
  dnsrecon -d ${TRGTDOMAIN} -D /usr/share/golismero/wordlist/dns/dnsrecon.txt -t brt
  # trying zone transfer. -n is the DNS server
  dnsrecon -a -d ${TRGTDOMAIN} -n ${DNSSERVER}
  nmap -sU -p 53 --script=*dns* ${HOST}
  
  ## find DNS (A) records by trying a list of common sub-domains from a wordlist.
  nmap -p 53 --script dns-brute.nse ${DNSSERVER}
  python dnscan.py -d domain.com -w ./subdomains-10000.txt
  # https://github.com/rbsec/dnscan
  ~~~

- SNMP
  ~~~sh
  nmap -sU -p 161,162 --script=*snmp* ${TARGET}
  xprobe2 -v -p udp:161:open ${TARGET}

  snmp-check ${TARGET} -c public
  snmpget -v 1 -c public ${TARGET}
  snmpwalk -v 1 -c public ${TARGET}

  snmpbulkwalk -v2c -c public -Cn0 -Cr10 ${TARGET}
  # find communities with bruteforce
  onesixtyone -c /usr/share/wordlists/dirb/small.txt ${TARGET}
  # find communities with bruteforce
  for i in $(cat /usr/share/wordlists/metasploit/unix_users.txt);do snmpwalk -v 1 -c $i ${TARGET}; done | grep -e "Timeout"
  ~~~

## References
- Github
  - https://github.com/s0wr0b1ndef/OSCP-note/blob/master/ENUMERATION/enumeration
  
- RPC
  - https://pentestlab.blog/tag/rpc/
  - https://haiderm.com/linux-privilege-escalation-using-weak-nfs-permissions/