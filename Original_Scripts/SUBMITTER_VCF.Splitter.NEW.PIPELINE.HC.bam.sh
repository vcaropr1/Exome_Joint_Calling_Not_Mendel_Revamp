#!/bin/bash

SAMPLE_SHEET=$1
VCF_FILE=$2 # Replace with Refined_VCF Path in 1st step $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf"

sed 's/\r//g' $SAMPLE_SHEET \
| awk 'BEGIN {FS=","} NR>1 {print $1,$8,$17,$15,$18}' \
|sed 's/,/\t/g' \
| sort -k 2 \
| uniq \
| awk '{split($2,smtag,"@"); print "qsub","-N","VCF_SPLITTER_"smtag[1]"_"smtag[2],\
"-o","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VCF_SPLITTER.log",\
"-e","/isilon/sequencing/Seq_Proj/"$1"/LOGS/"$2".VCF_SPLITTER.log",\
"/isilon/sequencing/Seq_Proj/"$1"/SCRIPTS/VCF.Splitter.NEW.PIPELINE.HC.bam.sh",\
$1,$2,$3,$4,$5,"'$VCF_FILE'",$1"\n""sleep 3s"}'


# OUT_PROJECT=$1
# SM_TAG=$2
# TARGET_BED=$3
# TITV_BED=$4
# DBSNP=$5
# OUTFILE=$6
# IN_PROJECT=$7

# $1 and $7 are the same

