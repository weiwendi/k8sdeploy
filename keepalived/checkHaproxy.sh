#!/bin/bash

ps -ef |grep haproxy |grep -v grep >/dev/null 2>&1
result1=`echo $?`

netstat -lntpd |grep 16443 |grep -v grep >/dev/null 2>&1
result2=`echo $?`

systemctl status haproxy >/dev/null 2>&1
result3=`echo $?`

if [ $result1 -ne 0 ] || [ $result2 -ne 0 ] || [ $result3 -ne 0 ]
then
  exit 1
fi
