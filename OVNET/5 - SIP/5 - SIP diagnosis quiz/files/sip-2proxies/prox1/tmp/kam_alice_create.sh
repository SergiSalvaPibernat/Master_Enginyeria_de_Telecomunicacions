#!/usr/bin/expect -f
spawn kamctl add alice xxxx
expect "'kamailio@localhost': "
sleep 1
send "kamailiorw\r"
expect "# "
