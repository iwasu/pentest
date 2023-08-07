#!/bin/sh

# Check argv
if [ $# -ne 2 ]; then
  echo "Usage: ./ftp-search <target> <userlist file>"
  echo "  Please put 'userlist' to current directory."
  exit 1
fi

# ftp
target=$1
echo "[*] Trying connect ftp to $1."

# Read user list
while read username
do
    echo "[*] Username: '$username'"
    ftp -vv -n <<END
open $1
user $username password
close
END
    echo "[*] Done.\n"
done < $2
