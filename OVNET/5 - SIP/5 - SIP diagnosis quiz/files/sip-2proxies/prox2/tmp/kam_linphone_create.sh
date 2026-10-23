#!/usr/bin/expect -f
spawn kamctl add linphone xxxx
expect "'kamailio@localhost': "
sleep 1
send "kamailiorw\r"
expect "# "
