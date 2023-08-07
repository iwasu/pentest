# nmap option
  - Scan  
    ~~~
    # Base(vanilla scan)
    nmap -sT -Pn -iL [target name].txt
    
    # TCP Scan and import target list from file
    ## Half open scanning
    nmap -sS -Pn -iL [target name].txt
    ## Advanced
    nmap -sS -Pn -A -iL [target name].txt

    # reverse scanning
    nmap -s
    ~~~

  - export to XML file  
    ~~~
    nmap -sS -Pn -A -oX sample.xml -iL [target name].txt
    ~~~

  - Sample Scan Command
    ~~~
    sudo nmap -sSV -p1- -T4 --max-retries 1 -Pn -vv -n -r -O --reason -iL [target name].txt -oA nmap-[target name]-sSV-TCP
    sudo nmap -sTV -p1- -T4 --max-retries 1 -Pn -vv -n -r -O --reason -iL [target name].txt -oA nmap-[target name]-sTV-TCP
    sudo nmap -sSV -p1-10000 -T4 --max-retries 1 -Pn -vv -n -r -O --reason -iL [target name].txt -oA nmap-[target name]-sSV-TCP-1
    sudo nmap -sSV -p10001- -T4 --max-retries 1 -Pn -vv -n -O --reason -iL [target name].txt -oA nmap-[target name]-sSV-TCP-2
    sudo nmap -sUV --top-ports 100 -T4 -Pn -vv -n --reason -iL [target name].txt -oA nmap-[target name]-sUV-UDP
    sudo nmap -sS -sV -Pn -T4 -iL [target name].txt -oA target-sS-sV-TCP
    ~~~

  - ICMP
      - Timestamp
        ~~~
        nmap -PP ...
        ~~~
      - Address Mask
        ~~~
        nmap -PM ...
        ~~~
      - ARP
        ~~~
        nmap -PR ...
        ~~~
