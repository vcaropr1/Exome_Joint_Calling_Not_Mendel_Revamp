#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
CORE_PATH=$5
PROJECT=$6
PREFIX=$7

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T VariantFiltration'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.SNP.vcf'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
CMD=$CMD' --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.00"'
CMD=$CMD' --filterName "SNV_HARD_FILTER"'
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.HardFiltered.SNP.vcf'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantFiltration \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.SNV.vcf" \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# --filterExpression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0"0" \
# --filterName "SNV_HARD_FILTER" \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.HardFiltered.SNV.vcf"
