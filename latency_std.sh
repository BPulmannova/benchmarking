#!/bin/bash

PERIOD=150001
ITER=100
JITTER=1
HEAD=5
BINARY=bin/5-ld-5-st-1-mil
STORE_FILTER=0
LOAD_FILTER=0
BRANCH_FILTER=0

while getopts "p:j:b:i:h:s:l:f:" flag
do
    case "${flag}" in
        p) PERIOD=${OPTARG};;
        j) JITTER=${OPTARG};;
        b) BINARY=${OPTARG};;
        h) HEAD=${OPTARG};;
        i) ITER=${OPTARG};;
        s) STORE_FILTER=${OPTARG};;
        l) LOAD_FILTER=${OPTARG};;
        f) BRANCH_FILTER=${OPTARG};;
    esac
done

make all

BASE=$(basename ${BINARY})
PERF_COMMAND='sudo /home/barbara/arm_spe/linux/tools/perf/perf'
PERF_FILE=data/${BASE}.${PERIOD}.j${JITTER}.latency.perf.data
LOG_FILE=logs/${BASE}.${PERIOD}.j${JITTER}.latency.perf.log
RESULT_FILE=results/${BASE}.${PERIOD}.j${JITTER}.s${STORE_FILTER}.l${LOAD_FILTER}.f${BRANCH_FILTER}.latency.csv
TEMP_FILE=temp/${BASE}.${PERIOD}.j${JITTER}.latency.temp.log
STORE_NUMBER=temp/${BASE}.${PERIOD}.j${JITTER}.latency.stores.log
RAW_FILE=temp/${BASE}.${PERIOD}.j${JITTER}.raw.temp.log

# dump disassembly of the executable
objdump -D ${BINARY} > logs/${BASE}.ds

echo "# period=${PERIOD}, jitter=${JITTER}, iter=${ITER}, head=${HEAD}" > ${RESULT_FILE}
echo "# store_filter=${STORE_FILTER}, load_filter=${LOAD_FILTER}, branch_filter=${BRANCH_FILTER}" >> ${RESULT_FILE}
echo "VA,AVG_LAT,SAMPLES" >> ${RESULT_FILE}

echo "VA,LAT" > ${TEMP_FILE}
echo "STORES" > ${STORE_NUMBER}
echo "#raw file" > ${TEMP_FILE}

for (( i=0; i<${ITER}; i++ ))
    do
    # run perf command
    ${PERF_COMMAND} record -e arm_spe_0/jitter=${JITTER},period=${PERIOD},ts_enable=0,store_filter=${STORE_FILTER},load_filter=${LOAD_FILTER},branch_filter=${BRANCH_FILTER}/ -o ${PERF_FILE} -- ${BINARY}
    # get raw data
    ${PERF_COMMAND} report -D -i ${PERF_FILE} > ${LOG_FILE}
    # count samples by PC and report associated average total latency
    grep -E 'PC 0x[0-9a-f]+' -A 5  ${LOG_FILE} | grep -o -E 'PC 0x[0-9a-f]+|LD GP-REG|ST GP-REG|B COND|B IND|OTHER INSN-OTHER|LAT [0-9]* ISSUE|LAT [0-9]* TOT' >> ${RAW_FILE}
    done
