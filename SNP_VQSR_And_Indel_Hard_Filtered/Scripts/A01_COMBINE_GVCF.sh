#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
REF_GENOME=$3
KEY=$4

CORE_PATH=$5
PROJECT=$6
GVCF_LIST=$7
PREFIX=$8
CHROMOSOME=$9

mkdir -p $CORE_PATH/$PROJECT/GVCF/AGGREGATE
mkdir -p $CORE_PATH/$PROJECT/MULTI_SAMPLE

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T CombineGVCFs \
-R $REF_GENOME \
--variant $GVCF_LIST \
-L $CHROMOSOME \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/GVCF/AGGREGATE/$PREFIX"."$CHROMOSOME".genome.vcf"