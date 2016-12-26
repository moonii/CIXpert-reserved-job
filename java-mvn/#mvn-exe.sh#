#!/bin/sh

#################################
# $1 path/directory of pom.xml : resource name of job NOT USE
# $2 goal of maven        : compilie, test, package...
# $3 value of -DskipTests : false or true(default)
#################################

mvn_cmd=" -f $POM_PATH"
mvn_report_file="$2_report.html"
mvn_result_file="result"
mvn_cnt_file="count.txt"
mvn_err_word='Tests run:'
mvn_no_test="No tests to run"
mvn_fatal="FATAL"
mvn_build_failure="BUILD FAILURE"
#echo "#1=$1=#2=$2=#3=$3=POM_PATH=$POM_PATH"

#if [ $1 = "protoc" ]; then
	##cat source-git/paasxpert.portal.cfclient/bin/install-protoc-apt.sh
	#cat reserved-job-git/mvn-task/install-protoc-apt.sh
	#reserved-job-git/mvn-task/install-protoc-apt.sh

	#echo "install-protoc-apt end"

#fi



if [ $3 ]; then

    optionTests="-DskipTests=$3"

else
	if [ $2 != "test" ]; then
      		optionTests="-DskipTests=true"
    	else
      		optionTests="-DskipTests=false"
    	fi
fi

mvn_cmd=" -f $POM_PATH $2 $optionTests"
#echo "mvn_cmd=$mvn_cmd="

# mvn goal execute
mvn $mvn_cmd | tee $mvn_report_file

# keyword find & check ...
# FATAL check ####################################
awk "/$mvn_fatal/" $mvn_report_file > $mvn_result_file".fatal"

line_num=`cat $mvn_result_file".fatal" | wc -l`
#echo "faltal.line_num=$line_num="
if [ $line_num -gt 0 ]; then
	echo "FATAL ERROR"
	exit 1
fi
##################################################

# BUILD FAILURE check ############################
awk "/$mvn_build_failure/" $mvn_report_file > $mvn_result_file".buildf"

line_num=`cat $mvn_result_file".buildf" | wc -l`
#echo "buildf.line_num=$line_num="
if [ $line_num -gt 0 ]; then
	echo "BUILD FAILURE"
        exit 1
fi
##################################################

# move output
replace="target/classes"
destination="compile-out"

if [ $2 = "package" ]; then

	if [ $1 = "protoc" ]; then
		replace="paasxpert.portal.api/target"
		destination="pkg-out"
	else
        	replace="target"
	        destination="pkg-out"
	fi
fi

filename=`basename $POM_PATH`
output_path=`echo $POM_PATH | sed -e "s#$filename#$replace#g"`
#echo "filename=$filename=output_path=$output_path=destination=$destination="

echo "[DEBUG]cp -r $output_path $destination"
cp -r $output_path $destination

if [ $1 = "protoc" ]; then
	replace="paasxpert.portal.uaaclient/target"
	output_path=`echo $POM_PATH | sed -e "s#$filename#$replace#g"`
	echo "[DEBUG]cp -r $output_path $destination"
	cp -r $output_path $destination

	replace="paasxpert.portal.cfclient/cloudfoundry-client-lib/target"
	output_path=`echo $POM_PATH | sed -e "s#$filename#$replace#g"`
	echo "[DEBUG]cp -r $output_path $destination"
	cp -r $output_path $destination
fi

if [ $2 = "test" ]; then
	# No tests to run check ##########################
	awk "/$mvn_no_test/" $mvn_report_file > $mvn_result_file".no"

	line_num=`cat $mvn_result_file".no" | wc -l`

	#echo "notest.line_num=$line_num="

	if [ $line_num = "1" ]; then
		echo "NO TESTS TO RUN"
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
		echo "TEST ERROR"
		exit 1
	else
		exit 0
	fi

fi
