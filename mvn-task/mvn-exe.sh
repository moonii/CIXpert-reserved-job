#!/bin/sh

#################################
# $1 path/directory of pom.xml : resource name of job 
# $2 goal of maven        : compilie, test, package...
# $3 value of -DskipTests : false or true(default)
#################################

mvn_cmd=" -f $1/pom.xml"
mvn_report_file="$2_report.html"
mvn_result_file="result"
mvn_cnt_file="count.txt"
mvn_err_word='Tests run:'
mvn_no_test="No tests to run"

#echo "###########################################"
echo "#1=$1=#2=$2=#3=$3="
#echo "..... ls -os .............................."
#ls -os
#echo "..... ls -os $1 ..........................."
#ls -os $1
echo "MID_PATH="$MID_PATH"="
if [ $MID_PATH ]; then
	POM_PATH="$1/$MID_PATH/pom.xml"
else
	POM_PATH="$1/pom.xml"
fi
echo "POM_PATH=$POM_PATH="
#echo "###########################################"

if [ $3 ]; then

    optionTests="-DskipTests=$3"

else
	if [ $2 != "test" ]; then
      		optionTests="-DskipTests=true"
    	else
      		optionTests="-DskipTests=false"
    	fi
fi

#mvn_cmd=" -f $1/pom.xml $2 $optionTests"
mvn_cmd=" -f $1 $2 $optionTests"
#echo "mvn_cmd=$mvn_cmd="

# mvn goal execute
mvn $mvn_cmd | tee $mvn_report_file

# keyword find & ...
if [ $2 = "test" ]; then
	# No tests to run check ##########################
	awk "/$mvn_no_test/" $mvn_report_file > $mvn_result_file".no"

	line_num=`cat $mvn_result_file".no" | wc -l`

	#echo "notest.line_num=$line_num="

	if [ $line_num = "1" ]; then
		exit 1
	fi
	##################################################
	#echo "in test=$mvn_report_file="
	
	awk "/$mvn_err_word/" $mvn_report_file > $mvn_result_file

	line_num=`cat $mvn_result_file | wc -l`
	
	#echo "line_num=$line_num="
	
	sed "${line_num}!d" $mvn_result_file | sed "s/,//g"  > $mvn_result_file".2" #| awk '{print $5" "$7" "$9}' > $mvn_cnt_file
	cat $mvn_result_file".2" | awk '{print $5" "$7" "$9}' > $mvn_cnt_file

	#echo "$mvn_cnt_file........................"
 	#cat $mvn_cnt_file

        cntF=`awk '{print $1}' $mvn_cnt_file`
      	cntE=`awk '{print $2}' $mvn_cnt_file`
	cntS=`awk '{print $3}' $mvn_cnt_file`

	cntT=$((cntF+cntE+cntS))
	#echo "cntT=$cntT=............................."

	if [ $cntT -gt 0 ]; then
		exit 1
	else
		exit 0
	fi

fi
