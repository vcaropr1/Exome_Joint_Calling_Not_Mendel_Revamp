#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
shift
GATK_3_3_DIR=$1
shift
REF_GENOME=$1
shift
CORE_PATH=$1
shift
PROJECT=$1
shift
PREFIX=$1
shift

START_CAT_VARIANTS=`date '+%s'`

CMD=$JAVA_1_7'/java'
CMD=$CMD' -cp '$GATK_3_3_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' org.broadinstitute.gatk.tools.CatVariants'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' -assumeSorted'
while [ $# -gt 0 ]
do
  CMD=$CMD' --variant '$1
  shift
done
CMD=$CMD' -out '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

END_CAT_VARIANTS=`date '+%s'`

echo $PROJECT",D01,CAT_VARIANTS,"$START_CAT_VARIANTS","$END_CAT_VARIANTS \
>> $CORE_PATH/$PROJECT/REPORTS/$PROJECT".WALL.CLOCK.TIMES.csv"
