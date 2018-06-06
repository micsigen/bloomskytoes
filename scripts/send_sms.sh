#!/bin/sh

PREFIX=`curl 'http://192.168.1.1/userRpm/LoginRpm.htm?Save=Save' \
	-H 'Connection: keep-alive' \
	-H 'Upgrade-Insecure-Requests: 1' \
	-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36' \
	-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' \
	-H 'Referer: http://192.168.1.1/' \
	-H 'Accept-Encoding: gzip, deflate' \
	-H 'Accept-Language: hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7,de;q=0.6' \
	-H 'Cookie: Authorization=Basic%20YWRtaW46MjEyMzJmMjk3YTU3YTVhNzQzODk0YTBlNGE4MDFmYzM%3D' \
	--compressed`

#<body><script language="javaScript">window.parent.location.href = "http://192.168.1.1/FQCGPAEAAQAUBBLA/userRpm/Index.htm";
#</script></body></html>

PREFIX=`echo $PREFIX | awk -F= '{print $3}' | awk -F/ '{print $4}'`

curl 'http://192.168.1.1/'$PREFIX'/userRpm/lteWebCfg' \
	-H 'Cookie: Authorization=Basic%20YWRtaW46MjEyMzJmMjk3YTU3YTVhNzQzODk0YTBlNGE4MDFmYzM%3D' \
	-H 'Origin: http://192.168.1.1' \
	-H 'Accept-Encoding: gzip, deflate' \
	-H 'Accept-Language: hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7,de;q=0.6' \
	-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36' \
	-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
	-H 'Accept: application/json, text/javascript, */*; q=0.01' \
	-H 'Referer: http://192.168.1.1/'$PREFIX'/userRpm/_lte_SmsNewMessageCfgRpm.htm' \
	-H 'X-Requested-With: XMLHttpRequest' \
	-H 'Connection: keep-alive' \
	--data '{"module":"message","action":3,"sendMessage":{"to":"06308162810","textContent":"Vigyazz csapadek varhato.","sendTime":"2018,6,6,22,21,53"}}' \
	--compressed