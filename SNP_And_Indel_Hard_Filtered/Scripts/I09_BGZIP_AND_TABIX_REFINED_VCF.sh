#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

TABIX_DIR=$1

CORE_PATH=$2
PROJECT=$3
PREFIX=$4

$TABIX_DIR/bgzip -c $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.HF.1KG.ExAC3.REFINED.vcf" \
>| $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.HF.1KG.ExAC3.REFINED.vcf.gz"

$TABIX_DIR/tabix -p vcf -f $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.HF.1KG.ExAC3.REFINED.vcf.gz"