#!/bin/sh

#will be creating our inputdirectory and synchronisation directory
INPUTDIR="/fuzzing/inputs"
SYNCDIR="/fuzzing/syncdir"

mkdir -p "$INPUTDIR"
mkdir -p "$SYNCDIR"

# init
# look for empty dir
if [ "$(ls -A $INPUTDIR)" ]; then
     echo "No need to add learning files, $DIR is not empty"
else
    echo "/examples directory contains:"
    ls -l /examples
    echo "$INPUTDIR is Empty, going to copy our examples"
    cp /examples/* /fuzzing/inputs/.
    echo "/fuzzing/inputs directory now contains files:"
    ls -l /fuzzing/inputs
fi

if [ "$(ls -A $SYNCDIR)" ]; then
     echo "$SYNCDIR is not empty, going to resume"
     exec afl-fuzz -m 200 -i - -o /fuzzing/syncdir -M openssl-master-fuzzer openssl asn1parse -in @@
else
    echo "$SYNCDIR is empty, going to start new"
    exec  afl-fuzz -m 200 -i /fuzzing/inputs -o /fuzzing/syncdir -M openssl-master-fuzzer openssl asn1parse -in @@
fi

tail -f /dev/null
