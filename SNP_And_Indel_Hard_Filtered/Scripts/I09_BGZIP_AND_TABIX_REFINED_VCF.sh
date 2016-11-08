#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

TABIX_DIR=$1

CORE_PATH=$2
PROJECT=$3
PREFIX=$4

CMD1=$TABIX_DIR'/bgzip -c '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.vcf'
CMD1=$CMD1' >| '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.vcf.gz'

CMD2=$TABIX_DIR'/tabix -p vcf -f '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.vcf.gz'

# $TABIX_DIR/bgzip -c $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf" \
# >| $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf.gz"
#
# $TABIX_DIR/tabix -p vcf -f $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf.gz"

echo $CMD1 >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD1 | bash

echo $CMD2 >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD2 | bash