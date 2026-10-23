$TTL	60000
@	IN	SOA	ns1.example.com. hostmaster.example.com. (
		          20150427		; Serial
			  28800			; Refresh
			  14400			; Retry
			  2419200		; Expire
			  300 )			; Negative Cache TTL
;
@	IN	NS	ns1
ns1	IN	A	198.51.100.1
prox2	IN      A       198.51.100.2
bob	IN      A       198.51.100.3
user2	IN	CNAME	bob.example.com.
