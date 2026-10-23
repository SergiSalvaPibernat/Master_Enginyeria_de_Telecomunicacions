#!/usr/bin/expect -f
spawn kamdbctl create
expect "MySQL password for root: "
send "\r"
expect "Install presence related tables? (y/n): "
send "y\r"
expect "rtpproxy? (y/n): "
send "y\r"
expect "uid_uri_db? (y/n): "
send "y\r"
expect "# "
