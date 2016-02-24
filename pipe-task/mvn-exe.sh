#!/bin/sh

#################################
# $1 directory of pom.xml : resource name of job 
# $2 goal of maven        : compilie, test, package...
# $3 value of -DskipTests : false or true(default)
#################################

optionTests=""

echo "#1: $1 #2: $2 #3: $3#"

echo "###########################################"
echo "..... ls -os .............................."
ls -os

echo "..... ls -os findbugs-rsc-git/pipe-task ..."
ls -os findbugs-rsc-git/pipe-task

echo "..... ls -os $1 ..........................."
ls -os $1

echo "..... cat findbugs-rsc-git/pipe-task/mvn-exe.sh"
cat findbugs-rsc-git/pipe-task/mvn-exe.sh
echo "###########################################"

if [ $3 ]; then

    optionTests="-DskipTests=$3"

#else
#    if [$2 ! "package"]; then
#      optionTests=""
#    else
#      optionTests="-DskipTests=true"
#    fi
fi

echo "optionTests: $optionTests"

mvn_cmd=" -f $1/pom.xml $2 $optionTests"

echo "mvn_cmd : $mvn_cmd"

mvn $mvn_cmn 

#exit 1
