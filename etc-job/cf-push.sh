#!/bin/sh

#01.register Doamin 
#echo "" > blank.file
#echo "nameserver 52.21.208.105" > append.script 
#sed -f append.script blank.file >> /etc/resolv.conf
echo "cat /etc/resolv.conf origin"
cat /etc/resolv.conf

echo "copy & append"
cp /etc/resolv.conf temp.conf
sed '1 i\nameserver 52.21.208.105' temp.conf > /etc/resolv.conf
#echo "nameserver 52.21.208.105" >> /etc/resolv.conf

echo "cat /etc/resolv.conf modified"
cat /etc/resolv.conf

echo "	CF_API:======$CF_API=
	CF_USERNAME:=$CF_USERNAME=
	CF_PASSWORD:=$CF_PASSWORD=
        CF_ORG:======$CF_ORG=
        CF_SPACE:====$CF_SPACE=
	MANIFEST:====$MANIFEST=
	APP_PATH:====$APP_PATH="

#02.cf push
cf api $CF_API --skip-ssl-validation
cf login -u "$CF_USERNAME" -p "$CF_PASSWORD" -o "$CF_ORG" -s "$CF_SPACE"
cf push -f "$MANIFEST" -p "$APP_PATH"
