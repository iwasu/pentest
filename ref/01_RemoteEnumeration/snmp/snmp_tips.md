# Commands
  - Ref
    - http://publib.boulder.ibm.com/infocenter/pseries/v5r3/index.jsp?topic=/com.ibm.aix.progcomm/doc/progcomc/mib.htm
  - Base
    ~~~
    ~~~

  - Scan
    ~~~
    nmap -sU -p161,162 --open 10.11.1.200-250
    onesixtyone -c [community list] -i [ip list]
    ~~~
    
    - Create IP list
      ~~~
      for ip in $(seq 2 254); do echo 10.11.1.$ip; done > ips
      ~~~

  - SNMP enum
    - Public
      ~~~
      snmpwalk -v 2c -c public <host> .
      snmpwalk -v 2c -c public <host> system
      snmpwalk -v 2c -c <community> <host> system
      
      snmp-check <host>
      ~~~

  - Microsoft Windows SNMP
    ~~~
    1.3.6.1.2.1.25.1.6.0    System Processes
    1.3.6.1.2.1.25.4.2.1.2  Running Programs
    1.3.6.1.2.1.25.4.2.1.4  Processes Path
    1.3.6.1.2.1.25.2.3.1.4  Storage Units
    1.3.6.1.2.1.25.6.3.1.2  Installed Software Name
    1.3.6.1.4.1.77.1.2.25   User Accounts
    1.3.6.1.2.1.6.13.1.3    Open TCP Local Ports
    ~~~

    - snmpwalk to windows
      ~~~
      # System Processes
      snmpwalk -v1 -c public <host> 1.3.6.1.2.1.25.1.6.0
      snmpwalk -v1 -c public 10.11.1.227 1.3.6.1.2.1.25.1.6.0
      
      ~~~


  - Sample community list
    ~~~
    public
    private
    manager
    ~~~

# Exploitation
  - Metasploit
    - enum
      ~~~
      use auxiliary/scanner/snmp/snmp_enum
      use auxiliary/scanner/snmp/snmp_login

      set RHOST <target>      
      ~~~

