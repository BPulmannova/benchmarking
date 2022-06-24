#!/bin/bash

PERIOD=2048
JITTER=1
BINARY=bin/5-ld-5-st-1-mil
ITER=100

while getopts "p:j:b:i:h" flag
do
    case "${flag}" in
        p) PERIOD=${OPTARG};;
        j) JITTER=${OPTARG};;
        b) BINARY=${OPTARG};;
        i) ITER=${OPTARG};;
        h) echo "Usage: -p PERIOD -j JITTER -b BINARY -i ITER"
           echo "default: PERIOD=2048 JITTER=1 BINARY=bin/5-ld-5-st-1-mil ITER=100"
           exit;;
    esac
done

PERF_COMMAND='sudo /home/barbara/arm_spe/linux/tools/perf/perf'
OUTFILE=results/$(basename ${BINARY}).${PERIOD}.filtered.csv
RAW_LOADS=logs/loads.raw.log
RAW_STORES=logs/stores.raw.log
LOAD_DISTRIBUTION=logs/loadDistribution.log
STORE_DISTRIBUTION=logs/storeDistribution.log

make clean
make

echo "# jitter: ${JITTER}, period: ${PERIOD}, iter: ${ITER}, binary: ${BINARY}" > ${OUTFILE}
echo "total_loads,load5,load4,load3,load2,load1,total_stores,store5,store4,store3,store2,store1," >> ${OUTFILE}

for (( i=0; i<=${ITER}; i++ ))
    do

    # get raw data
    ${PERF_COMMAND} record -e arm_spe_0/load_filter=1,store_filter=0,jitter=${JITTER},period=${PERIOD},ts_enable=1/ -o data/loads.perf.data -- ${BINARY}
    ${PERF_COMMAND} record -e arm_spe_0/load_filter=0,store_filter=1,jitter=${JITTER},period=${PERIOD},ts_enable=1/ -o data/stores.perf.data -- ${BINARY}
    ${PERF_COMMAND} report -D -i data/loads.perf.data > ${RAW_LOADS}
    ${PERF_COMMAND} report -D -i data/stores.perf.data > ${RAW_STORES}

    # find load/store samples and only store their virtual addresses
    grep -E -B 2 'LD GP-REG' ${RAW_LOADS} | grep -o -E '0x[0-9a-f]+'| sort | uniq -c | sort -bgr | head -5 | sed 's/^[ \t]*//' > ${LOAD_DISTRIBUTION}
    grep -E -B 2 'ST GP-REG' ${RAW_STORES} | grep -o -E '0x[0-9a-f]+'| sort | uniq -c | sort -bgr | head -5 | sed 's/^[ \t]*//' > ${STORE_DISTRIBUTION}

    # sum up the 5 most occuring loads/stores to get total
    LOADS=`awk '{Total=Total+$1} END{print Total}' ${LOAD_DISTRIBUTION}`
    STORES=`awk '{Total=Total+$1} END{print Total}' ${STORE_DISTRIBUTION}`

    # sort based on virtual address
    LOADS_SORTED=`awk '{val="0x" $2; sub("^0x0x","0x",val); print strtonum(val), $0;}' ${LOAD_DISTRIBUTION} | sort -n | awk '{print $2}' | tr '\n' ','`
    STORES_SORTED=`awk '{val="0x" $2; sub("^0x0x","0x",val); print strtonum(val), $0;}' ${STORE_DISTRIBUTION} | sort -n | awk '{print $2}' | tr '\n' ','`


    #LOAD_DISTRIBUTION=`grep -o -E 'VA 0x.*$' ${RAW_STORES} | grep -o -E '0x.*$'| sort | uniq -c | sort -bgr | head -5 | tr '\n' ',' | tr -s ' ' ','`
    #grep -o -E 'VA 0x.*$' ${RAW_STORES} | grep -o -E '0x.*$'| sort | uniq -c | sort -bgr | head -5

    echo "${LOADS},${LOADS_SORTED}${STORES},${STORES_SORTED}" >> ${OUTFILE}
    cp ${OUTFILE} ../plotting/data/

    done
