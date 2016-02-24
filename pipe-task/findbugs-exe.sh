#!/bin/sh

findbugs_cmd="-Xmx512m -jar /findbugs-3.0.1/lib/findbugs.jar -textui "
findbugs_report_file='findbugs_report.html'
findbugs_err_word='Warnings generated: '

# findbugs execute
java $findbugs_cmd $1 | tee $findbugs_report_file

# keyword find & ...
echo '..... ls -os '
ls -os

line_cnt='cat $findbugs_report_file | wc -l'
cnt=`cat $findbugs_report_file | grep -n "$findbugs_err_word" | awk -F "$findbugs_err_word" "{print $2}"`

echo "cnt =  $cnt| $findbugs_report_file line_cnt=$line_cnt"

if [ $cnt ]; then
	echo 'cnt is null'
        exit 1
fi

echo 'what is cnt'

if [ $cnt -gt 0 ]; then
	echo "findbugs warnings $cnt detected"
        exit 1
else
        echo "findbugs check success"
        exit 0
fi

