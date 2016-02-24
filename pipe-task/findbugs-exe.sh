#!/bin/sh

findbugs_cmd="-Xmx512 -jar /findbugs-3.0.1/lib/findbugs.jar -textui "

java $findbugs_cmd $1

exit 1
