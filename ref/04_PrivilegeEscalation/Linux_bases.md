# builtin commands
- OS and system information
  ~~~sh
  # Dists
  cat /etc/issue
  cat /etc/*-release
  uname -a
  hostname

  # kernel and cpu type
  cat /proc/version
  uname -mrs
  rpm -q kernel
  dmesg | grep Linux
  ls /boot | grep vmlinuz-
  cat /proc/cpuinfo

  # Shell
  ps -p $$
  echo $PATH
  #export PATH=${PATH}:/some/path2
  cat /etc/profile
  cat ~/.bash_profile
  cat ~/.bashrc
  cat ~/.profile
  cat ~/.bash_logout
  cat ~/.bash_history
  cat ~/.nano_history
  cat ~/.atftp_history
  cat ~/.mysql_history
  cat ~/.php_history
  history
  env
  set
  ~~~

- Around devices
  ~~~sh
  # Printer
  lpstat -a
  # Any mount
  df -ah
  cat /etc/fstab
  ~~~

- Users and passwords
  ~~~sh
  cat /etc/passwd
    grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}' # List of super users
    awk -F: '($3 == "0") {print}' /etc/passwd
    cat /etc/passwd | cut -d":" # List of users
  cat /etc/group  
  finger
    pinky
    users
    who -a
  w
  last
  lastlog
  lastlog --user root  
  whoami
  id
  sudo -l
  ls -alh /var/log/
  ls -alh /var/mail/
  cat /var/mail/root
  ls -alh /var/spool/mail/
  cat /var/spool/mail/root

  ls -ahlR /root/
  ls -ahlR /home/

  cat /etc/shadow  # needs root
  cat /etc/sudoers # needs root

  strings ./*.txt | grep password
  grep -l -i pass /var/log/*.log 2>/dev/null
  # searches for the string 'password' and output the line number
  find / -maxdepth 10 -name *.conf -type f | grep -Hn pass; 2>/dev/null
  find / -maxdepth 10 -name *etc* -type f | grep -Hn pass; 2>/dev/null  # as above, but in *etc*
  ~~~

- check permissions
  ~~~sh
  find / -perm -4000 -type f 2>/dev/null               # Find SUID files
  find / -uid 0 -perm -4000 -type f 2>/dev/null        # Find SUID files owned by root
  /usr/bin/find / -perm -g=s -o -perm -4000 ! -type l -maxdepth 3 -exec ls -ld {} \\; 2>/dev/null
  find / -perm -2000 -type f 2>/dev/null               # Find files with GUID bit set
  find / -perm -2 -type f 2>/dev/null                  # Find word-writable files
  find / -perm -2 -type d 2>/dev/null                  # Find word-writable directories
  ls -aRl /etc/ | awk '$1 ~ /^.*w.*/' 2>/dev/null      # Anyone can reconfigure
  ls -aRl /etc/ | awk '$1 ~ /^..w/' 2>/dev/null        # Owner can reconfigure
  ls -aRl /etc/ | awk '$1 ~ /^.....w/' 2>/dev/null     # Group can reconfigure
  ls -aRl /etc/ | awk '$1 ~ /w.$/' 2>/dev/null         # Other can reconfigure
  find /etc/ -readable -type f 2>/dev/null             # Anyone
  find /etc/ -readable -type f -maxdepth 1 2>/dev/null # Anyone
  find / -writable -type d 2>/dev/null                 # world-writeable directories
  find / -perm -222 -type d 2>/dev/null                # world-writeable directories
  find / \( -perm -o+w -perm -o+x \) -type d 2>/dev/null # world-writeable & executable folders
    find / -perm -o+w -type d 2>/dev/null                # world-writeable directories
    find / -perm -o+x -type d 2>/dev/null                # world-executable folders
  find / -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print   # world-writeable files
  find /dir -xdev \( -nouser -o -nogroup \) -print   # Noowner files
  ~~~

- Services information
  ~~~sh
  ps aux | grep root
  ps -ef | grep root
  lsof -i
  lsof -i -n
  lsof -u root
  cat /etc/inetd.conf  # List services managed by inetd
  ls -la /usr/sbin/in.*
  cat /etc/xinetd.conf # As above for xinetd

  ls -alh /usr/bin/
  ls -alh /sbin/
  dpkg -l
  rpm -qa
  ls -alh /var/cache/apt/archivesO
  ls -alh /var/cache/yum/

  ls -alh /var/spool/lpd
  ls -alh /var/lib/pgsql
  ls -alh /var/lib/mysql

  # Conf
  cat /etc/syslog.conf
  cat /etc/chttp.conf
  cat /etc/lighttpd.conf
  cat /etc/cups/cupsd.conf
  cat /etc/inetd.conf
  cat /etc/apache2/apache2.conf
  cat /etc/my.conf
  cat /etc/httpd/conf/httpd.conf
  cat /opt/lampp/etc/httpd.conf
  ls -aRl /etc | awk '$1 ~ /^.*r.*/'

  # Versions
  sudo -V
  httpd -v
  apache2 -v
  apache2ctl -M
  mysql --version
  perl -v
  java -version
  python --version
  ruby -v

  # Logs
  ls -alh /var/log/postgresql/
  ls -alh /var/log/proftpd/
  ls -alh /var/log/samba/
  ~~~

- SSH
  ~~~sh
  ls -al ~/.ssh/
  cat ~/.ssh/config
  cat ~/.ssh/known_hosts
  cat ~/.ssh/authorized_keys
  cat /etc/ssh/ssh_config
  cat /etc/ssh/sshd_config

  mkdir -p /tmp/ssh_data/{local,server}
  cp ~/.ssh/* /tmp/ssh_data/local/
  cp /etc/ssh/* /tmp/ssh_data/server/
  ~~~

- HTTP
  ~~~sh
  ls -alhR /var/www/
  ls -alhR /srv/www/htdocs/
  ls -alhR /usr/local/www/apache22/data/
  ls -alhR /opt/lampp/htdocs/
  ls -alhR /var/www/html/
  ~~~

- Jobs / Tasks
  ~~~sh
  crontab -l -u ${USERNAME} # Display scheduled jobs for the specified user – Privileged command
  ls -la /etc/cron* # Scheduled jobs overview (hourly, daily, monthly etc)
  ls -aRl /etc/cron* | awk '$1 ~ /w.$/' 2>/dev/null # What can ‘others’ write in /etc/cron* directories
  ls -alh /var/spool/cron
  ls -al /etc/ | grep cron
  cat /etc/cron*
  cat /etc/at.allow
  cat /etc/at.deny
  cat /etc/cron.allow
  cat /etc/cron.deny
  cat /etc/crontab
  ls -alh /etc/cron.daily
  ls -alh /etc/cron.weekly
  ls -alh /etc/cron.monthly
  cat /etc/anacrontab
  cat /var/spool/cron/crontabs/root
  ~~~

- search files / commands
  ~~~sh
  find / -name ${PROGRAMNAME} 2>/dev/null
  find / -name "*.log"
  which ${PROGRAMNAME}
  strings ./*.txt

  # Interesting files
  find /home –name .rhosts -print 2>/dev/null   # Find rhost config files
  ls -ahlR /root/                               # list files recursively
  find /var/log -type f -exec ls -la {} ; 2>/dev/null
  find /var/log -name "*.log" -type f -exec ls -la {} ; 2>/dev/null
  find /etc/ -maxdepth 1 -name .conf -type f -exec ls -la {} ; 2>/dev/null
  ls -la /etc/.conf

  # For oscp lab
  find / -type -f -name "network-secret.txt"
  locate "network-secret.txt"
  find / -type -f -name "local.txt"
  locate "local.txt"
  ~~~

- Network
  ~~~sh
  /sbin/ifconfig -a
  cat /etc/network/interfaces
  cat /etc/sysconfig/network
  cat /etc/networks
  dnsdomainname
  arp -a
  route
  cat /etc/resolv.conf
  netstat -antp # List all TCP sockets and related PIDs (-p needs root)
  netstat -anup # List all UDP sockets and related PIDs (-p needs root)
  iptables -L   # needs root
  cat /etc/services
  cat /var/lib/dhcp3/dhclient.leases

  # tcpdump
  tcpdump tcp dst ${DESTIP} ${DESTPORT} and tcp dst ${DESTIP} ${DESTPORT}
  tcpdump -n dst host ${DESTIP} -vvv -n -w file.cap
  ~~~

# My tools


# Third tools
- LinEnum.sh
  ~~~
  wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
  chmod 755 ./LinEnum.sh
  ./LinEnum.sh
  ~~~
