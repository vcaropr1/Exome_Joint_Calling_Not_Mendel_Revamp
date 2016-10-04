#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V

set

CORE_PATH="/isilon/sequencing/Seq_Proj/"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0"
REF_GENOME="/isilon/sequencing/GATK_resource_bundle/1.5/b37/human_g1k_v37_decoy.fasta"
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
KEY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_2/lee.watkins_jhmi.edu.key"

OUT_PROJECT=$1
SM_TAG=$2
TARGET_BED=$3
TITV_BED=$4
DBSNP=$5
OUTFILE=$6
IN_PROJECT=$7

mkdir -p $CORE_PATH/$OUT_PROJECT/INDEL/RELEASE/{FILTERED_ON_BAIT,FILTERED_ON_TARGET}
mkdir -p $CORE_PATH/$OUT_PROJECT/SNV/RELEASE/{FILTERED_ON_BAIT,FILTERED_ON_TARGET}
mkdir -p $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/{FILTERED_ON_BAIT,FILTERED_ON_TARGET}
mkdir -p $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/TABIX
mkdir -p $CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE_MS
mkdir -p $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS

# Extract out sample, remove non-passing, non-variant

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
# --variant $CORE_PATH/$IN_PROJECT/MULTI_SAMPLE/$OUTFILE \
# -o $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf"

# bgzip-0.2.6 -c $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
# >| $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/TABIX/$SM_TAG"_MS_OnBait.vcf.gz"
#
# tabix-0.2.6 -f -p vcf $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/TABIX/$SM_TAG"_MS_OnBait.vcf.gz"

# Filter above file on target

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
# -L $TARGET_BED \
# --variant $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_TARGET/$SM_TAG"_MS_OnTarget.vcf"

# Filter on bait vcf to snv only

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
# -selectType SNP \
# --variant $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/SNV/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait_SNV.vcf"

# filter above vcf to on target only

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
# -L $TARGET_BED \
# -selectType SNP \
# --variant $CORE_PATH/$OUT_PROJECT/SNV/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait_SNV.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/SNV/RELEASE/FILTERED_ON_TARGET/$SM_TAG"_MS_OnTarget_SNV.vcf"

# filter on bait to indels only

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
# -selectType INDEL \
# --variant $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/INDEL/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait_INDEL.vcf"

# filter above file to on target

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
# -selectType INDEL \
# -L $TARGET_BED \
# --variant $CORE_PATH/$OUT_PROJECT/INDEL/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait_INDEL.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/INDEL/RELEASE/FILTERED_ON_TARGET/$SM_TAG"_MS_OnTarget_INDEL.vcf"

# filter the on bait SNV file to TiTv

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
# -L $TITV_BED \
# -selectType SNP \
# --variant $CORE_PATH/$OUT_PROJECT/SNV/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait_SNV.vcf" \
# -o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.OnExon.FILTERED.vcf"

## so now you write out the TiTv ratio for all of those jokes;

# vcfutils-0.1.18.pl qstats $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.OnExon.FILTERED.vcf" >| \
# $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS/$SM_TAG"_All_.titv.txt"

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -R $REF_GENOME \
# --variant $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.OnExon.FILTERED.vcf" \
# --excludeFiltered \
# -L $TITV_BED \
# --concordance /isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf \
# -o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Known.TiTv.vcf"

# Now TiTv on those

# vcfutils-0.1.18.pl qstats $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Known.TiTv.vcf" >| \
# $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS/$SM_TAG"_Known_.titv.txt"

## Below is writing out a vcf file of "novel" variants (as defined by dbsnp_137.b37.vcf).

# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T SelectVariants \
# --disable_auto_index_creation_and_locking_when_reading_rods \
# -et NO_ET \
# -K $KEY \
# -R $REF_GENOME \
# --variant $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.OnExon.FILTERED.vcf" \
# --excludeFiltered \
# -L $TITV_BED \
# --discordance /isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf \
# -o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Novel.TiTv.vcf"

# Now TiTv on those

# vcfutils-0.1.18.pl qstats $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".Release.Novel.TiTv.vcf" >| \
# $CORE_PATH/$OUT_PROJECT/REPORTS/TI_TV_MS/$SM_TAG"_Novel_.titv.txt"

# Do concordance on target

# mkdir -p $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG
#
# cp $CORE_PATH/$OUT_PROJECT/SNV/RELEASE/FILTERED_ON_TARGET/$SM_TAG"_MS_OnTarget_SNV.vcf" \
# $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/$SM_TAG"_MS_OnTarget_SNV.vcf"
#
# /isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.7.0_45/bin/java -jar \
# /isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/6.1.1/CIDRSeqSuite.jar \
# -pipeline -concordance \
# $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG \
# /isilon/sequencing/Seq_Proj/$OUT_PROJECT/Pretesting/Final_Genotyping_Reports/ \
# $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG \
# $TARGET_BED \
# /isilon/sequencing/CIDRSeqSuiteSoftware/resources/Veracode_hg18_hg19.csv
#
# mv $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/$SM_TAG"_concordance.csv" \
# $CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE_MS/$SM_TAG"_concordance.csv"
#
# mv $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/missing_data.csv \
# $CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE_MS/$SM_TAG"_missing_data.csv"
#
# mv $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/discordant_data.csv \
# $CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE_MS/$SM_TAG"_discordant_calls.csv"

###################################################################
##################NOT IMPLEMENTED BELOW############################
###################################################################


# ## Create a bed file for the HC calls with a 150bp pad from the leftmost coordinate.
#
# grep -v "^#" $CORE_PATH/$OUT_PROJECT/VCF/RELEASE/FILTERED_ON_BAIT/$SM_TAG"_MS_OnBait.vcf" \
# | awk 'BEGIN {OFS="\t"} {print $1,$2-150,$2+150}' \
# >| $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG"_MS_OnBait.vcf.bed"
#
# ## Use the above bed file to write a HC bam file
#
# $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
# -T HaplotypeCaller \
# -R $REF_GENOME \
# --input_file $CORE_PATH/$OUT_PROJECT/BAM/AGGREGATE/$SM_TAG".bam" \
# --dbsnp $DBSNP \
# -L $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG"_MS_OnBait.vcf.bed" \
# -stand_call_conf 0 \
# -stand_emit_conf 0 \
# --bamOutput $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.bam" \
# -pairHMM VECTOR_LOGLESS_CACHING \
# -o $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf"
#
# bgzip-0.2.6 -c $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf" \
# >| $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf.gz"
#
# tabix-0.2.6 -f -p vcf $CORE_PATH/$OUT_PROJECT/HC_BAM/$SM_TAG"_MS_OnBait.HC.vcf.gz"
