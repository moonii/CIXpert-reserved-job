#!/bin/sh

# $1 : ci resource name
# $2 : project resource name

pmd_cmd="-Xmx512m -jar /pmd-bin-4.2.6/lib/pmd-4.2.6.jar $2/ xml $1/pmd-rules/EgovInspectionRules_kor.xml"
pmd_err_word='<violation'
pmd_report_file='pmd_report.xml'

java $pmd_cmd | tee $pmd_report_file
cnt="$(grep -c $pmd_err_word $pmd_report_file)"

if [ $cnt -gt 0 ]; then
	echo "pmd violation $cnt deteded"
        exit 1
else
        echo "pmd check success"
        exit 0
fi
