#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR_NIGHTLY=$2
KEY=$3
REF_GENOME=$4
P3_1KG=$5
ExAC=$6

CORE_PATH=$7
PROJECT=$8
PREFIX=$9

$JAVA_1_7/java -jar $GATK_DIR_NIGHTLY/GenomeAnalysisTK.jar \
-T CalculateGenotypePosteriors \
-R $REF_GENOME \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".HC.SNP.INDEL.VQSR.vcf" \
--supporting $P3_1KG \
--supporting $ExAC \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.temp.vcf"
