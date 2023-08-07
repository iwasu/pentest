# Detection
  - Base
    ~~~
    ~~~

  - Port scanning
    ~~~sh
    nmap -p139,445 [IP range] --open
    #nmap -p139,445 10.11.1.2-254 --open
    nmap 10.11.1.5 --script smb-os-discovery.nse
    ~~~

  - Tools
    - nbtscan
      ~~~sh
      nbtscan [IP/IP range]
      #nbtscan 10.11.1.5
      #nbtscan 10.11.1.2-50
      #nbtscan -r 10.11.1.0/24
      ~~~
    - enum4linux http://labs.portcullis.co.uk/tools/enum4linux/
      ~~~
      enum4linux -a 10.11.1.22
      ~~~
    - smbclient
    - net
    - nmblookup
    - rpcclient
      ~~~
      rpcclient -U "" 10.11.1.22
      ~~~

  - Enumeration
    ~~~
    ls -l /usr/share/nmap/scripts/smb*
    nmap -v -p139,445 --script=smb-os-discovery.nse 10.11.1.22
    nmap -v -p139,445 --script=smb-enum-users.nse 10.11.1.22
    nmap -v -p139,445 --script=smb-check-vulns.nse --script-args=unsafe=1 10.11.1.227
    ~~~


# Exploitation
  - SMB Null session (allowed empty username and empty password)
    ~~~
    rpcclient -U "" 10.11.1.22
    Enter WORKGROUP\'s password: (empty)
    rpcclient $> srvinfo
  	BARRY          Wk Sv PrQ Unx NT SNT Samba Server
  	platform_id     :	500
  	os version      :	4.5
  	server type     :	0x9a03
    ~~~

    - rpcclient command
      ~~~
      srvinfo
      enumdomusers
      getdompwinfo
      ~~~

  - Metasploit
    ~~~
    use auxiliary/scanner/smb/smb_version
    set RHOSTS 10.11.1.200-254
    set THREADS 10
    run
    
    ~~~


