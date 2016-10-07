#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -V
#$ -p -1000

JAVA_1_7=$1
GATK_DIR=$2
KEY=$3
REF_GENOME=$4
DBSNP=$5

CORE_PATH=$6
PROJECT=$7
PREFIX=$8



$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T VariantAnnotator \
-R $REF_GENOME \
--variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.HF.1KG.ExAC3.REFINED.temp.vcf" \
--dbsnp $DBSNP \
-L $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.HF.1KG.ExAC3.REFINED.temp.vcf" \
-A GenotypeSummaries \
-A GCContent \
-A VariantType \
-A HomopolymerRun \
-A TandemRepeatAnnotator \
--disable_auto_index_creation_and_locking_when_reading_rods \
-et NO_ET \
-K $KEY \
-o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.HF.1KG.ExAC3.REFINED.vcf"
