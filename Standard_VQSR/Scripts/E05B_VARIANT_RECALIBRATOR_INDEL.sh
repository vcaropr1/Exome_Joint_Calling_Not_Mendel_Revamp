#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
ONEKG_INDELS_VCF=$5

CORE_PATH=$6
PROJECT=$7
PREFIX=$8

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T VariantRecalibrator'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --input:VCF '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.raw.HC.vcf'
CMD=$CMD' -resource:mills,known=true,training=true,truth=true,prior=12.0 '$ONEKG_INDELS_VCF
CMD=$CMD' --maxGaussians 4'
CMD=$CMD' -an MQRankSum'
CMD=$CMD' -an SOR'
CMD=$CMD' -an ReadPosRankSum'
CMD=$CMD' -an QD'
CMD=$CMD' -an FS'
CMD=$CMD' -mode INDEL'
CMD=$CMD' -tranche 100.0'
CMD=$CMD' -tranche 99.9'
CMD=$CMD' -tranche 99.8'
CMD=$CMD' -tranche 99.7'
CMD=$CMD' -tranche 99.6'
CMD=$CMD' -tranche 99.5'
CMD=$CMD' -tranche 99.4'
CMD=$CMD' -tranche 99.3'
CMD=$CMD' -tranche 99.2'
CMD=$CMD' -tranche 99.1'
CMD=$CMD' -tranche 99.0'
CMD=$CMD' -tranche 98.0'
CMD=$CMD' -tranche 97.0'
CMD=$CMD' -tranche 96.0'
CMD=$CMD' -tranche 95.0'
CMD=$CMD' -tranche 90.0'
CMD=$CMD' -recalFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.INDEL.recal'
CMD=$CMD' -tranchesFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.INDEL.tranches'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -rscriptFile '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.HC.INDEL.R'

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantRecalibrator \
# -R $REF_GENOME \
# --input:VCF $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".raw.HC.vcf" \
# -resource:mills,known=true,training=true,truth=true,prior=12.0 $ONEKG_INDELS_VCF \
# --maxGaussians 4 \
# -an MQRankSum \
# -an SOR \
# -an ReadPosRankSum \
# -an QD \
# -an FS \
# -mode INDEL \
# -tranche 100.0 \
# -tranche 99.9 \
# -tranche 99.8 \
# -tranche 99.7 \
# -tranche 99.6 \
# -tranche 99.5 \
# -tranche 99.4 \
# -tranche 99.3 \
# -tranche 99.2 \
# -tranche 99.1 \
# -tranche 99.0 \
# -tranche 98.0 \
# -tranche 97.0 \
# -tranche 96.0 \
# -tranche 95.0 \
# -tranche 90.0 \
# -recalFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.recal" \
# -tranchesFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.tranches" \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -rscriptFile $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.INDEL.R"

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash
