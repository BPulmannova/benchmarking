#!/bin/bash

PERIOD=2048
ITER=100
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
objdump -D ${BINARY} > logs/${BASE}.ds

echo "VA,AVG_LAT,SAMPLES" > logs/${BASE}.${PERIOD}.latency.log


for (( i=0; i<${ITER}; i++ ))
    do
    ${PERF_COMMAND} record -e arm_spe_0/jitter=${JITTER},period=${PERIOD},ts_enable=0/ -o data/${BASE}.${PERIOD}.latency.perf.data -- ${BINARY}
    ${PERF_COMMAND} report -D -i data/${BASE}.${PERIOD}.latency.perf.data > logs/${BASE}.${PERIOD}.latency.perf.log
    grep -E 'PC 0x.* ' -A 5  logs/${BASE}.${PERIOD}.latency.perf.log | grep -o -E '0x.*$|LAT [0-9]* TOT' | sed ':begin;$!N;s/ el[0-3] ns=[0-1]\nLAT /,/' \
    | tr -d ' TOT' | awk -F ',' -v OFS=',' '{seen[$1]+=$2; count[$1]++} END{for (x in seen)print x, seen[x]/count[x], count[x]}'\
    | sort -t ',' | head -${HEAD} >> logs/${BASE}.${PERIOD}.latency.log
    done


#awk -F ',' '{print $1}' logs/${BASE}.${PERIOD}.latency.temp.log | sort | uniq -c | sort -nr > logs/${BASE}.${PERIOD}.latency.unique.log