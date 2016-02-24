#!/bin/sh

#################################
# $1 directory of pom.xml : resource name of job 
# $2 goal of maven        : compilie, test, package...
# $3 value of -DskipTests : false or true(default)
#################################

optionTests=""

echo "#1: " $1
echo "#2: " $2
echo "#3: " $3

if [ $3 ]; then

    optionTests="-DskipTests=$3"

else
    if [$2 ! "package"]; then
      optionTests=""
    else
      optionTests="-DskipTests=true"
    fi
fi

echo "optionTests: $optionTests"

mvn_cmd=" -f "$1"/pom.xml "$optionTests" "$2

echo "mvn_cmd : " $mvn_cmd

mvn $mvn_cmn 

#exit 1
