#!/bin/sh

findbugs_cmd="-Xmx512m -jar /findbugs-3.0.1/lib/findbugs.jar -textui "
findbugs_report_file='findbugs_report.html'
findbugs_err_word='Warnings generated: '

# findbugs execute
java $findbugs_cmd $1 | tee $findbugs_report_file

# keyword find & ...
echo '..... ls -os '
ls -os

echo '..... cat $findbugs_report_file'
cat $findbugs_report_file 

echo '..... cat $findbugs_report_file | grep -n $findbugs_err_word'
cat $findbugs_report_file | grep -n "$findbugs_err_word"

cnt=`cat $findbugs_report_file | grep -n "$findbugs_err_word" | awk -F "$findbugs_err_word" "{print $2}"`
line_cnt=`cat $findbugs_report_file | wc -l`

echo "cnt =  $cnt# ($findbugs_report_file)line_cnt=$line_cnt"

if [ $cnt ]; then
        exit 1
fi

if [ $line_cnt -gt 0 ]; then
	echo "findbugs warnings $line_cnt detected"
        exit 1
else
        echo "findbugs check success"
        exit 0
fi

