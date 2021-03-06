#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V


JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4

CORE_PATH=$5
PROJECT=$6
SM_TAG=$7
PREFIX=$8

mkdir -p $CORE_PATH/$PROJECT/INDEL/RELEASE/{FILTERED_ON_BAIT,FILTERED_ON_TARGET}
mkdir -p $CORE_PATH/$PROJECT/SNV/RELEASE/{FILTERED_ON_BAIT,FILTERED_ON_TARGET}
mkdir -p $CORE_PATH/$PROJECT/VCF/RELEASE/{FILTERED_ON_BAIT,FILTERED_ON_TARGET}
mkdir -p $CORE_PATH/$PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/TABIX
mkdir -p $CORE_PATH/$PROJECT/REPORTS/CONCORDANCE_MS
mkdir -p $CORE_PATH/$PROJECT/REPORTS/TI_TV_MS

# Extract out sample, remove non-passing, non-variant

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T SelectVariants'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' -sn '$SM_TAG
CMD=$CMD' -ef'
CMD=$CMD' -env'
CMD=$CMD' --keepOriginalAC'
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.vcf'
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/VCF/RELEASE/FILTERED_ON_BAIT/'$SM_TAG'_MS_OnBait.vcf'

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -R $REF_GENOME \
# -sn $SM_TAG \
# -ef \
# -env \
# --keepOriginalAC \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf" \
# -o $CORE_PATH/$PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf"

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash
