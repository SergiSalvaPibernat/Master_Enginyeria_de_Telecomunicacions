$TTL    60000
@       IN      SOA     ns1.example.com. hostmaster.example.com. (
                          20150427              ; Serial
                          28800                 ; Refresh
                          14400                 ; Retry
                          2419200               ; Expire
                          300 )                 ; Negative Cache TTL
;
@       IN      NS      ns1
ns1     IN      A       198.51.100.1
prox2   IN      A       198.51.100.2
bob     IN      A       198.51.100.3
user2   IN      CNAME   bob.example.com.

example.com.           172800  IN   NAPTR	30 0 "s" "SIP+D2U" "" _sip._udp.example.com.
example.com.           172800  IN   NAPTR	20 0 "s" "SIP+D2T" "" _sip._tcp.example.com.
_sip._udp.example.com. 3600    IN   SRV     0 0 5060 prox2.example.com.
_sip._tcp.example.com. 3600    IN   SRV     0 0 5060 prox2.example.com.
