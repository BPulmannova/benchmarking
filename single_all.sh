#!/bin/bash

PERIOD=2048
JITTER=1
HEAD=5
BINARY=bin/5-ld-5-st-1-mil

while getopts "p:j:b:h:" flag
do
    case "${flag}" in
        p) PERIOD=${OPTARG};;
        j) JITTER=${OPTARG};;
        b) BINARY=${OPTARG};;
        h) HEAD=${OPTARG};;
    esac
done

make all

BASE=$(basename ${BINARY})
PERF_COMMAND='sudo /home/barbara/arm_spe/linux/tools/perf/perf'

${PERF_COMMAND} record -e arm_spe_0/branch_filter=1,load_filter=1,store_filter=1,event_filter=16,jitter=${JITTER},period=${PERIOD},ts_enable=1/ -o data/${BASE}.${PERIOD}.all.perf.data -- ${BINARY}
${PERF_COMMAND} report -D -i data/${BASE}.${PERIOD}.all.perf.data > logs/${BASE}.${PERIOD}.all.perf.log
echo "loads:"
grep -c 'LD GP-REG' logs/${BASE}.${PERIOD}.all.perf.log
echo "stores:"
grep -c 'ST GP-REG' logs/${BASE}.${PERIOD}.all.perf.log
# grep -o -E 'VA 0x.*$' logs/${BASE}.${PERIOD}.load.perf.log | grep -o -E '0x.*$'| sort | uniq -c | sort -bgr | head -${HEAD} | sed 's/^[ \t]*//' \
# | awk '{val="0x" $2; sub("^0x0x","0x",val); print strtonum(val), $0;}' | sort -n | awk '{print $2, $3}'
# echo "stores:"
# grep -o -E 'VA 0x.*$' logs/${BASE}.${PERIOD}.store.perf.log | grep -o -E '0x.*$'| sort | uniq -c | sort -bgr | head -${HEAD} | sed 's/^[ \t]*//' \
# | awk '{val="0x" $2; sub("^0x0x","0x",val); print strtonum(val), $0;}' | sort -n | awk '{print $2, $3}'