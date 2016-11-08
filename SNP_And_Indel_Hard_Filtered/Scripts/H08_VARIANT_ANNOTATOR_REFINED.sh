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

CMD=$JAVA_1_7'/java -jar'
CMD=$CMD' '$GATK_DIR'/GenomeAnalysisTK.jar'
CMD=$CMD' -T VariantAnnotator'
CMD=$CMD' -R '$REF_GENOME
CMD=$CMD' --variant '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.temp.vcf'
CMD=$CMD' --dbsnp '$DBSNP
CMD=$CMD' -L '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.temp.vcf'
CMD=$CMD' -A GenotypeSummaries'
CMD=$CMD' -A GCContent'
CMD=$CMD' -A VariantType'
CMD=$CMD' -A HomopolymerRun'
CMD=$CMD' -A TandemRepeatAnnotator'
CMD=$CMD' --disable_auto_index_creation_and_locking_when_reading_rods'
CMD=$CMD' -et NO_ET'
CMD=$CMD' -K '$KEY
CMD=$CMD' -o '$CORE_PATH'/'$PROJECT'/MULTI_SAMPLE/'$PREFIX'.BEDsuperset.HF.1KG.ExAC3.REFINED.vcf'

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T VariantAnnotator \
# -R $REF_GENOME \
# --variant $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.temp.vcf" \
# --dbsnp $DBSNP \
# -L $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.temp.vcf" \
# -A GenotypeSummaries \
# -A GCContent \
# -A VariantType \
# -A HomopolymerRun \
# -A TandemRepeatAnnotator \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -o $CORE_PATH/$PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf"

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash