#!/bin/bash

PROJECT=$1
REF_GENOME=$2
DBSNP=$3
GVCF_LIST=$4
PREFIX=$5

CORE_PATH="/isilon/sequencing/Seq_Proj/"

qsub -N "Combine_GVCF_"$PREFIX"_test" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_test.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_test.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
1 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_2" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_2.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_2.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
2 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_3" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_3.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_3.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
3 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_4" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_4.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_4.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
4 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_5" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_5.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_5.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
5 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_6" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_6.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_6.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
6 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_7" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_7.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_7.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
7 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_8" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_8.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_8.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
8 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_9" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_9.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_9.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
9 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_10" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_10.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_10.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
10 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_11" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_11.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_11.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
11 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_12" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_12.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_12.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
12 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_13" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_13.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_13.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
13 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_14" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_14.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_14.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
14 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_15" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_15.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_15.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
15 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_16" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_16.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_16.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
16 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_17" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_17.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_17.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
17 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_18" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_18.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_18.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
18 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_19" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_19.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_19.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
19 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_20" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_20.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_20.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
20 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_21" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_21.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_21.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
21 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_22" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_22.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_22.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
22 \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_X" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_X.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_X.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
X \
$PREFIX

sleep 3s

qsub -N "Combine_GVCF_"$PREFIX"_Y" \
-o $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_Y.log" \
-e $CORE_PATH/$PROJECT/LOGS/"Combine_GVCF_"$PREFIX"_Y.log" \
COMBINE_GVCF.sh \
$PROJECT \
$REF_GENOME \
$DBSNP \
$GVCF_LIST \
Y \
$PREFIX
