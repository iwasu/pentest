# DNS
## Research
  - 対象ネットワークの権威サーバ
  - ドメイン、サブドメイン
  - ホスト名
  - Email 中継サーバ
  - ホストが使用するOSなどの詳細
  - 内部もしくは非公開である、ホストおよびネットワーク

## Commands
  - Search authority server
    ~~~
    dig [domain] any
    dig www.google.com @<host>
    ~~~

  - Zone Transfer
    ~~~
    dig @auth100.ns.uu.net ucia.gov axfr
    nmap --script=dns-zone-transfer -p 53 ns2.megacorpone.com
    ~~~

  - DNS amp
    ~~~
    ~~~

## Exploit
  - DoS

