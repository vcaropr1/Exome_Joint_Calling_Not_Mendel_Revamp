#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_3_3_DIR=$2
KEY=$3
REF_GENOME=$4
CORE_PATH=$5
PROJECT=$6
PREFIX=$7 
BED_FILE_PREFIX=$8

START_CAT_VARIANTS=`date '+%s'`

CMD=$JAVA_1_7'/java'
CMD=$CMD' -cp '$GATK_3_3_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' org.broadinstitute.gatk.tools.CatVariants'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' -assumeSorted'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'00.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'01.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'02.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'03.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'04.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'05.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'06.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'07.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'08.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'09.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'10.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'11.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'12.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'13.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'14.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'15.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'16.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'17.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'18.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'19.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'20.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'21.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'22.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'23.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'24.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'25.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'26.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'27.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'28.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'29.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'30.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'31.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'32.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'33.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'34.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'35.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'36.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'37.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'38.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'39.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'40.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'41.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'42.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'43.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'44.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'45.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'46.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'47.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'48.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'49.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'50.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'51.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'52.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'53.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'54.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'55.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'56.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'57.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'58.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'59.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'60.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'61.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'62.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'63.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'64.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'65.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'66.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'67.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'68.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'69.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'70.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'71.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'72.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'73.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'74.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'75.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'76.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'77.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'78.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'79.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'80.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'81.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'82.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'83.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'84.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'85.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'86.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'87.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'88.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'89.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'90.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'91.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'92.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'93.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'94.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'95.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'96.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'97.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'98.normal.vcf'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/TEMP/'$PREFIX'.'$BED_FILE_PREFIX'99.normal.vcf'
CMD=$CMD' -out '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'


# $JAVA_1_7/java -cp $GATK_3_1_1_DIR/GenomeAnalysisTK.jar \
# org.broadinstitute.gatk.tools.CatVariants \
# -R $REF_GENOME \
# -assumeSorted \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".1.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".2.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".3.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".4.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".5.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".6.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".7.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".8.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".9.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".10.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".11.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".12.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".13.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".14.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".15.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".16.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".17.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".18.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".19.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".20.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".21.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".22.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".X.normal.vcf" \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".Y.normal.vcf" \
# -out $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf"

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

END_CAT_VARIANTS=`date '+%s'`

echo $PROJECT",D01,CAT_VARIANTS,"$START_CAT_VARIANTS","$END_CAT_VARIANTS \
>> $CORE_PATH/$PROJECT/REPORTS/$PROJECT".WALL.CLOCK.TIMES.csv"
