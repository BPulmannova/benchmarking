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
OUTFILE=results/$(basename ${BINARY}).${PERIOD}.j${JITTER}.unfiltered.csv
PERF_DATA=data/ldst.perf.data
RAW_LOADS=logs/loads.raw.log
RAW_STORES=logs/stores.raw.log
RAW_LDST=logs/ldst.raw.log
LOAD_DISTRIBUTION=temp/loadDistribution.log
STORE_DISTRIBUTION=temp/storeDistribution.log
ADDRESS_OP=0
TOTAL_INST=0

make

echo "# jitter: ${JITTER}, period: ${PERIOD}, refLoads: 20mil, iter: ${ITER}, binary: ${BINARY}" > ${OUTFILE}
echo "total_loads,load1,load2,load3,load4,load5,total_stores,store1,store2,store3,store4,store5,address_op1,address_op2,address_op3,address_op4,address_op5,total_inst" >> ${OUTFILE}

for (( i=0; i<=${ITER}; i++ ))
    do

    # get perf data
    ${PERF_COMMAND} record -e arm_spe_0/jitter=${JITTER},period=${PERIOD},ts_enable=1/ -o ${PERF_DATA} -- ${BINARY}
    # get raw data
    ${PERF_COMMAND} report -D -i ${PERF_DATA} > ${RAW_LDST}

    # find load/store samples and only store their virtual addresses
    grep -E 'LD GP-REG' -B 2 ${RAW_LDST} | grep -o -E '0x[0-9a-f]+'| sort | uniq -c | sort -bgr | head -5 | sed 's/^[ \t]*//' > ${LOAD_DISTRIBUTION}
    grep -E 'ST GP-REG' -B 2 ${RAW_LDST} | grep -o -E '0x[0-9a-f]+'| sort | uniq -c | sort -bgr | head -5 | sed 's/^[ \t]*//' > ${STORE_DISTRIBUTION}
    ADDRESS_OP=`grep -E 'OTHER INSN-OTHER' -B 2 ${RAW_LDST} | grep -c 'PC 0xaaaaaaaa07dc'`
    ADDRESS_OP=${ADDRESS_OP},`grep -E 'OTHER INSN-OTHER' -B 2 ${RAW_LDST} | grep -c 'PC 0xaaaaaaaa07e8'`
    ADDRESS_OP=${ADDRESS_OP},`grep -E 'OTHER INSN-OTHER' -B 2 ${RAW_LDST} | grep -c 'PC 0xaaaaaaaa07f4'`
    ADDRESS_OP=${ADDRESS_OP},`grep -E 'OTHER INSN-OTHER' -B 2 ${RAW_LDST} | grep -c 'PC 0xaaaaaaaa0800'`
    ADDRESS_OP=${ADDRESS_OP},`grep -E 'OTHER INSN-OTHER' -B 2 ${RAW_LDST} | grep -c 'PC 0xaaaaaaaa080c'`
    TOTAL_INST=`grep -c -E 'PC 0x[0-9a-f]+' -B 2 ${RAW_LDST}`

    #grep -E 'ST GP-REG' -B 2 ${RAW_LDST} | grep -o -E 'PC 0x[0-9a-f]+'

    # sum up the 5 most occuring loads/stores to get total
    LOADS=`awk '{Total=Total+$1} END{print Total}' ${LOAD_DISTRIBUTION}`
    STORES=`awk '{Total=Total+$1} END{print Total}' ${STORE_DISTRIBUTION}`

    # sort based on virtual address
    LOADS_SORTED=`awk '{val="0x" $2; sub("^0x0x","0x",val); print strtonum(val), $0;}' ${LOAD_DISTRIBUTION} | sort -n | awk '{print $2}' | tr '\n' ','`
    STORES_SORTED=`awk '{val="0x" $2; sub("^0x0x","0x",val); print strtonum(val), $0;}' ${STORE_DISTRIBUTION} | sort -n | awk '{print $2}' | tr '\n' ','`

    #LOAD_DISTRIBUTION=`grep -o -E 'VA 0x.*$' ${RAW_STORES} | grep -o -E '0x.*$'| sort | uniq -c | sort -bgr | head -5 | tr '\n' ',' | tr -s ' ' ','`
    #grep -o -E 'VA 0x.*$' ${RAW_STORES} | grep -o -E '0x.*$'| sort | uniq -c | sort -bgr | head -5

    echo "${LOADS},${LOADS_SORTED}${STORES},${STORES_SORTED}${ADDRESS_OP},${TOTAL_INST}" >> ${OUTFILE}
    cp ${OUTFILE} ../plotting/data/

    done
