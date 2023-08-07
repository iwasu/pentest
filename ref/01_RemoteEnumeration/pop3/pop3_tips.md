# POP3
## Research
  -

## Commands
  - Banner Detection
    ~~~
    nc -nv <host> 110
    ~~~

  - Plain Auth
    ~~~
    $ telnet <ip> 110
      Trying 119.245.216.177...
      Connected to www.zeeklite.co.jp.
      Escape character is '^]'.
      +OK Dovecot ready.
    CAPA
      +OK
      CAPA
      TOP
      UIDL
      RESP-CODES
      PIPELINING
      STLS
      USER
      SASL PLAIN
      .
    ~~~
