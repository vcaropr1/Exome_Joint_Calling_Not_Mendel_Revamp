#! /bin/bash

PROJECT=$1
SAMPLE_SHEET=$2
PREFIX=$3

##############FIXED DIRECTORIES###############

SCRIPT_DIR="/isilon/sequencing/VITO/NEW_GIT_REPO/Exome_Joint_Calling_Not_Mendel_Revamp/Standard_VQSR/Scripts/"
JAVA_1_7="/isilon/sequencing/Kurt/Programs/Java/jdk1.7.0_25/bin"
JAVA_1_8="/isilon/sequencing/Kurt/Programs/Java/jdk1.8.0_73/bin"
CORE_PATH="/isilon/sequencing/Seq_Proj/"
BEDTOOLS_DIR="/isilon/sequencing/Kurt/Programs/PATH"
GATK_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0"
GATK_3_1_1_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.1-1"
GATK_DIR_NIGHTLY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-nightly-2015-01-15-g92376d3"
GATK_3_6_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.6"
SAMTOOLS_DIR="/isilon/sequencing/Kurt/Programs/samtools/samtools-0.1.18/"
TABIX_DIR="/isilon/sequencing/Kurt/Programs/TABIX/tabix-0.2.6/"
CIDR_SEQSUITE_JAVA_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.7.0_45/bin"
CIDR_SEQSUITE_6_1_1_DIR="/isilon/sequencing/CIDRSeqSuiteSoftware/RELEASES/6.1.1"

##############FIXED FILE PATHS################

KEY="/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_2/lee.watkins_jhmi.edu.key"
HAPMAP_VCF=/isilon/sequencing/GATK_resource_bundle/2.5/b37/hapmap_3.3.b37.vcf
OMNI_VCF=/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_omni2.5.b37.vcf
ONEKG_SNPS_VCF=/isilon/sequencing/GATK_resource_bundle/2.5/b37/1000G_phase1.snps.high_confidence.b37.vcf
DBSNP_138_VCF=/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.vcf
ONEKG_INDELS_VCF=/isilon/sequencing/GATK_resource_bundle/2.2/b37/Mills_and_1000G_gold_standard.indels.b37.vcf
P3_1KG="/isilon/sequencing/1000genomes/Full_Project/Sep_2014/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5.20130502.sites.vcf.gz"
ExAC="/isilon/sequencing/ExAC/Release_0.3/ExAC.r0.3.sites.vep.vcf.gz"
KNOWN_SNPS=/isilon/sequencing/GATK_resource_bundle/2.8/b37/dbsnp_138.b37.excluding_sites_after_129.vcf
VERACODE_CSV=/isilon/sequencing/CIDRSeqSuiteSoftware/resources/Veracode_hg18_hg19.csv


############################################################################
#################Start of Combine Gvcf Functions############################
############################################################################

CREATE_PROJECT_INFO_ARRAY ()
{
PROJECT_INFO_ARRAY=(`sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN{FS=","} NR>1 {print $1,$12,$18,$16}' | sed 's/,/\t/g' | sort -k 1,1 | awk '$1=="'$PROJECT'" {print $1,$2,$3,$4}' | sort | uniq`)

PROJECT_NAME=${PROJECT_INFO_ARRAY[0]}
REF_GENOME=${PROJECT_INFO_ARRAY[1]}
PROJECT_DBSNP=${PROJECT_INFO_ARRAY[2]}
PROJECT_BAIT_BED=${PROJECT_INFO_ARRAY[3]}
}

CREATE_GVCF_LIST(){
TOTAL_SAMPLES=(`awk 'BEGIN{FS=","} NR>1{print $1,$8}' $SAMPLE_SHEET | sort | uniq | wc -l`)
awk 'BEGIN{FS=","} NR>1{print $1,$8}' $SAMPLE_SHEET | sort | uniq | awk 'BEGIN{OFS="/"}{print "'$CORE_PATH'",$1,"GVCF",$2".genome.vcf"}' \
>| $CORE_PATH'/'$PROJECT'/'$TOTAL_SAMPLES'.samples.gvcf.list'
GVCF_LIST=(`echo $CORE_PATH'/'$PROJECT'/'$TOTAL_SAMPLES'.samples.gvcf.list'`)
}

FORMAT_AND_SCATTER_BAIT_BED() {
BED_FILE_PREFIX=(`echo SPLITTED_BED_FILE`)

awk 1 $PROJECT_BAIT_BED | sed -r 's/\r//g ; s/chr//g ; s/[[:space:]]+/\t/g' >| $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_BED_FILE.bed
(awk '$1~/^[0-9]/' $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_BED_FILE.bed | sort -k1,1n -k2,2n ; \
awk '$1=="X"' $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_BED_FILE.bed | sort -k 2,2n ; \
awk '$1=="Y"' $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_BED_FILE.bed | sort -k 2,2n ; \
awk '$1=="MT"' $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_BED_FILE.bed | sort -k 2,2n) \
>| $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_AND_SORTED_BED_FILE.bed

INTERVALS_DIVIDED=`wc -l $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_AND_SORTED_BED_FILE.bed | awk '{print $1"/100"}' | bc | awk '{print $0+1}'`

split -l $INTERVALS_DIVIDED -d  $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/FORMATTED_AND_SORTED_BED_FILE.bed $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/$BED_FILE_PREFIX

ls $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/$BED_FILE_PREFIX* | awk '{print "mv",$0,$0".bed"}' | bash
}

COMBINE_GVCF(){
echo \
 qsub \
 -N 'A01_COMBINE_GVCF_'$PROJECT'_'$BED_FILE_NAME \
 -j y -o $CORE_PATH/$PROJECT/LOGS/A01_COMBINE_GVCF_$BED_FILE_NAME.log \
 $SCRIPT_DIR/A01_COMBINE_GVCF.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $PROJECT_NAME $GVCF_LIST \
 $PREFIX $BED_FILE_NAME
 }

GENOTYPE_GVCF(){
echo \
 qsub \
 -N B02_GENOTYPE_GVCF_$PROJECT'_'$BED_FILE_NAME \
 -hold_jid A01_COMBINE_GVCF_$PROJECT'_'$BED_FILE_NAME \
 -j y -o $CORE_PATH/$PROJECT/LOGS/B02_GENOTYPE_GVCF_$BED_FILE_NAME.log \
 $SCRIPT_DIR/B02_GENOTYPE_GVCF.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $PROJECT_NAME \
 $PREFIX $BED_FILE_NAME
}

VARIANT_ANNOTATOR(){
echo \
 qsub \
 -N C03_VARIANT_ANNOTATOR_$PROJECT'_'$BED_FILE_NAME \
 -hold_jid B02_GENOTYPE_GVCF_$PROJECT'_'$BED_FILE_NAME \
 -j y -o $CORE_PATH/$PROJECT/LOGS/C03_VARIANT_ANNOTATOR_$BED_FILE_NAME.log \
 $SCRIPT_DIR/C03_VARIANT_ANNOTATOR.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $KEY $CORE_PATH $PROJECT_NAME \
 $PREFIX $BED_FILE_NAME $PROJECT_DBSNP
}

##############################################################################
#####################End of Combine Gvcf Functions############################
##############################################################################

##############################################################################
##################Start of VQSR and Refinement Functions######################
##############################################################################

GENERATE_CAT_VARIANTS_HOLD_ID(){
CAT_VARIANTS_HOLD_ID=$CAT_VARIANTS_HOLD_ID'C03_VARIANT_ANNOTATOR_'$PROJECT'_'$BED_FILE_NAME','
}

CAT_VARIANTS(){
echo \
 qsub \
 -N D04_CAT_VARIANTS_$PROJECT \
 -hold_jid $CAT_VARIANTS_HOLD_ID \
 -j y -o $CORE_PATH/$PROJECT/LOGS/D04_CAT_VARIANTS.log \
 $SCRIPT_DIR/D04_CAT_VARIANTS.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME \
 $CORE_PATH $PROJECT_NAME $PREFIX $BED_FILE_PREFIX
}

VARIANT_RECALIBRATOR_SNV() {
echo \
 qsub \
 -N E05A_VARIANT_RECALIBRATOR_SNV_$PROJECT \
 -hold_jid D04_CAT_VARIANTS_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/E05A_VARIANT_RECALIBRATOR_SNV.log \
 $SCRIPT_DIR/E05A_VARIANT_RECALIBRATOR_SNV.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME $HAPMAP_VCF $OMNI_VCF $ONEKG_SNPS_VCF $DBSNP_138_VCF \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

VARIANT_RECALIBRATOR_INDEL() {
echo \
 qsub \
 -N E05B_VARIANT_RECALIBRATOR_INDEL_$PROJECT \
 -hold_jid D04_CAT_VARIANTS_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/E05B_VARIANT_RECALIBRATOR_INDEL.log \
 $SCRIPT_DIR/E05B_VARIANT_RECALIBRATOR_INDEL.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME $ONEKG_INDELS_VCF \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

APPLY_RECALIBRATION_SNV(){
echo \
 qsub \
 -N F06_APPLY_RECALIBRATION_SNV_$PROJECT \
 -hold_jid E05A_VARIANT_RECALIBRATOR_SNV_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/F06_APPLY_RECALIBRATION_SNV.log \
 $SCRIPT_DIR/F06_APPLY_RECALIBRATION_SNV.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

APPLY_RECALIBRATION_INDEL(){
echo \
 qsub \
 -N G07_APPLY_RECALIBRATION_INDEL_$PROJECT \
 -hold_jid F06_APPLY_RECALIBRATION_SNV_$PROJECT','E05B_VARIANT_RECALIBRATOR_INDEL_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/G07_APPLY_RECALIBRATION_INDEL.log \
 $SCRIPT_DIR/G07_APPLY_RECALIBRATION_INDEL.sh \
 $JAVA_1_7 $GATK_DIR $REF_GENOME \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

BGZIP_AND_TABIX_RECAL_VCF(){
echo \
 qsub \
 -N H08A_BGZIP_AND_TABIX_RECAL_VCF_$PROJECT \
 -hold_jid G07_APPLY_RECALIBRATION_INDEL_$PROJECT','F06_APPLY_RECALIBRATION_SNV_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/H08A_BGZIP_AND_TABIX_RECAL_VCF.log \
 $SCRIPT_DIR/H08A_BGZIP_AND_TABIX_RECAL_VCF.sh \
 $TABIX_DIR \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

CALCULATE_GENOTYPE_POSTERIORS(){
echo \
 qsub \
 -N H08B_CALCULATE_GENOTYPE_POSTERIORS_$PROJECT \
 -hold_jid G07_APPLY_RECALIBRATION_INDEL_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/H08B_CALCULATE_GENOTYPE_POSTERIORS.log \
 $SCRIPT_DIR/H08B_CALCULATE_GENOTYPE_POSTERIORS.sh \
 $JAVA_1_7 $GATK_DIR_NIGHTLY $KEY $REF_GENOME $P3_1KG $ExAC \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

VARIANT_ANNOTATOR_REFINED(){
echo \
 qsub \
 -N I09_VARIANT_ANNOTATOR_REFINED_$PROJECT \
 -hold_jid H08B_CALCULATE_GENOTYPE_POSTERIORS_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/I09_VARIANT_ANNOTATOR_REFINED.log \
 $SCRIPT_DIR/I09_VARIANT_ANNOTATOR_REFINED.sh \
 $JAVA_1_7 $GATK_DIR $KEY $REF_GENOME $PROJECT_DBSNP \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

BGZIP_AND_TABIX_REFINED_VCF(){
echo \
 qsub \
 -N J10_BGZIP_AND_TABIX_REFINED_VCF_$PROJECT \
 -hold_jid I09_VARIANT_ANNOTATOR_REFINED_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/J10_BGZIP_AND_TABIX_REFINED_VCF.log \
 $SCRIPT_DIR/J10_BGZIP_AND_TABIX_REFINED_VCF.sh \
 $TABIX_DIR \
 $CORE_PATH $PROJECT_NAME $PREFIX
}

###########################################################################
#################End of VQSR and Refinement Functions######################
###########################################################################
#
###########################################################################
###################Start of Vcf Splitter Functions#########################
###########################################################################

CREATE_SAMPLE_INFO_ARRAY ()
{
SAMPLE_INFO_ARRAY=(`sed 's/\r//g' $SAMPLE_SHEET | awk 'BEGIN{FS=","} NR>1 {print $1,$8,$17,$15,$18,$12}' | sed 's/,/\t/g' | sort -k 8,8 | uniq | awk '$2=="'$SAMPLE'" {print $1,$2,$3,$4,$5,$6}'`)

PROJECT_SAMPLE=${SAMPLE_INFO_ARRAY[0]}
SM_TAG=${SAMPLE_INFO_ARRAY[1]}
TARGET_BED=${SAMPLE_INFO_ARRAY[2]}
TITV_BED=${SAMPLE_INFO_ARRAY[3]}
DBSNP=${SAMPLE_INFO_ARRAY[4]} #Not used unless we implement HC_BAM
SAMPLE_REF_GENOME=${SAMPLE_INFO_ARRAY[5]}

UNIQUE_ID_SM_TAG=$(echo $SM_TAG | sed 's/@/_/g') # If there is an @ in the qsub or holdId name it breaks
}

SELECT_PASSING_VARIANTS_PER_SAMPLE(){
echo \
 qsub \
 -N K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid I09_VARIANT_ANNOTATOR_REFINED_$PROJECT \
 -j y -o $CORE_PATH/$PROJECT/LOGS/K11_SELECT_VARIANTS_FOR_SAMPLE_$SM_TAG.log \
 $SCRIPT_DIR/K11_SELECT_VARIANTS_FOR_SAMPLE.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $PREFIX
}

BGZIP_AND_TABIX_SAMPLE_VCF(){
echo \
 qsub \
 -N L12A_BGZIP_AND_TABIX_SAMPLE_VCF_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12A_BGZIP_AND_TABIX_SAMPLE_VCF_$SAMPLE.log \
 $SCRIPT_DIR/L12A_BGZIP_AND_TABIX_SAMPLE_VCF.sh \
 $TABIX_DIR \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG
}

PASSING_VARIANTS_ON_TARGET_BY_SAMPLE(){
echo \
 qsub \
 -N L12B_PASSING_VARIANTS_ON_TARGET_BY_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12B_PASSING_VARIANTS_ON_TARGET_BY_SAMPLE_$SAMPLE.log \
 $SCRIPT_DIR/L12B_PASSING_VARIANTS_ON_TARGET_BY_SAMPLE.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TARGET_BED
}

PASSING_SNVS_ON_BAIT_BY_SAMPLE(){
echo \
 qsub \
 -N L12C_PASSING_SNVS_ON_BAIT_BY_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12C_PASSING_SNVS_ON_BAIT_BY_SAMPLE_$SAMPLE.log \
 $SCRIPT_DIR/L12C_PASSING_SNVS_ON_BAIT_BY_SAMPLE.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG
}

PASSING_SNVS_ON_TARGET_BY_SAMPLE(){
echo \
 qsub \
 -N L12D_PASSING_SNVS_ON_TARGET_BY_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12D_PASSING_SNVS_ON_TARGET_BY_SAMPLE_$SAMPLE.log \
 $SCRIPT_DIR/L12D_PASSING_SNVS_ON_TARGET_BY_SAMPLE.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TARGET_BED
}

PASSING_INDELS_ON_BAIT_BY_SAMPLE(){
echo \
 qsub \
 -N L12E_PASSING_INDELS_ON_BAIT_BY_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12E_PASSING_INDELS_ON_BAIT_BY_SAMPLE_$SAMPLE.log \
 $SCRIPT_DIR/L12E_PASSING_INDELS_ON_BAIT_BY_SAMPLE.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG
}

PASSING_INDELS_ON_TARGET_BY_SAMPLE(){
echo \
 qsub \
 -N L12F_PASSING_INDELS_ON_TARGET_BY_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12F_PASSING_INDELS_ON_TARGET_BY_SAMPLE_$SAMPLE.log \
 $SCRIPT_DIR/L12F_PASSING_INDELS_ON_TARGET_BY_SAMPLE.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TARGET_BED
}

PASSING_SNVS_TITV_ALL(){
echo \
 qsub \
 -N L12G_PASSING_SNVS_TITV_ALL_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12G_PASSING_SNVS_TITV_ALL_$SAMPLE.log \
 $SCRIPT_DIR/L12G_PASSING_SNVS_TITV_ALL.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TITV_BED
}

TITV_ALL(){
echo \
 qsub \
 -N L12G-1_TITV_ALL_$UNIQUE_ID_SM_TAG \
 -hold_jid L12G_PASSING_SNVS_TITV_ALL_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12G-1_TITV_ALL_$SAMPLE.log \
 $SCRIPT_DIR/L12G-1_TITV_ALL.sh \
 $SAMTOOLS_DIR \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG
}

PASSING_SNVS_TITV_KNOWN(){
echo \
 qsub \
 -N L12H_PASSING_SNVS_TITV_KNOWN_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12H_PASSING_SNVS_TITV_KNOWN_$SAMPLE.log \
 $SCRIPT_DIR/L12H_PASSING_SNVS_TITV_KNOWN.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME $KNOWN_SNPS \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TITV_BED
}

TITV_KNOWN(){
echo \
 qsub \
 -N L12H-1_TITV_KNOWN_$UNIQUE_ID_SM_TAG \
 -hold_jid L12H_PASSING_SNVS_TITV_KNOWN_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12H-1_TITV_KNOWN_$SAMPLE.log \
 $SCRIPT_DIR/L12H-1_TITV_KNOWN.sh \
 $SAMTOOLS_DIR \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG
}

PASSING_SNVS_TITV_NOVEL(){
echo \
 qsub \
 -N L12I_PASSING_SNVS_TITV_NOVEL_$UNIQUE_ID_SM_TAG \
 -hold_jid K11_SELECT_VARIANTS_FOR_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12I_PASSING_SNVS_TITV_NOVEL_$SAMPLE.log \
 $SCRIPT_DIR/L12I_PASSING_SNVS_TITV_NOVEL.sh \
 $JAVA_1_7 $GATK_DIR $KEY $SAMPLE_REF_GENOME $KNOWN_SNPS \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TITV_BED
}

TITV_NOVEL(){
echo \
 qsub \
 -N L12I-1_TITV_NOVEL_$UNIQUE_ID_SM_TAG \
 -hold_jid L12I_PASSING_SNVS_TITV_NOVEL_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/L12I-1_TITV_NOVEL_$SAMPLE.log \
 $SCRIPT_DIR/L12I-1_TITV_NOVEL.sh \
 $SAMTOOLS_DIR \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG
}

CONCORDANCE_ON_TARGET_PER_SAMPLE(){
echo \
 qsub \
 -N M13_CONCORDANCE_ON_TARGET_PER_SAMPLE_$UNIQUE_ID_SM_TAG \
 -hold_jid L12G-1_TITV_ALL_$UNIQUE_ID_SM_TAG,L12H-1_TITV_KNOWN_$UNIQUE_ID_SM_TAG,L12I-1_TITV_NOVEL_$UNIQUE_ID_SM_TAG,L12D_PASSING_SNVS_ON_TARGET_BY_SAMPLE_$UNIQUE_ID_SM_TAG \
 -j y -o $CORE_PATH/$PROJECT/LOGS/M13_CONCORDANCE_ON_TARGET_PER_SAMPLE_$SAMPLE.log \
 $SCRIPT_DIR/M13_CONCORDANCE_ON_TARGET_PER_SAMPLE.sh \
 $CIDR_SEQSUITE_JAVA_DIR $CIDR_SEQSUITE_6_1_1_DIR $VERACODE_CSV \
 $CORE_PATH $PROJECT_SAMPLE $SM_TAG $TARGET_BED
}


##########################################################################
######################End of Functions####################################
##########################################################################

if [ -d $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT ]
then
	rm -rf $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT
fi

mkdir -p $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT

CREATE_PROJECT_INFO_ARRAY
FORMAT_AND_SCATTER_BAIT_BED
CREATE_GVCF_LIST


for BED_FILE in $(ls $CORE_PATH/$PROJECT/TEMP/BED_FILE_SPLIT/SPLITTED_BED_FILE*);
 do
BED_FILE_NAME=$(basename $BED_FILE .bed)
COMBINE_GVCF
GENOTYPE_GVCF
VARIANT_ANNOTATOR
GENERATE_CAT_VARIANTS_HOLD_ID
 done

CAT_VARIANTS
VARIANT_RECALIBRATOR_SNV
VARIANT_RECALIBRATOR_INDEL
APPLY_RECALIBRATION_SNV
APPLY_RECALIBRATION_INDEL
BGZIP_AND_TABIX_RECAL_VCF
CALCULATE_GENOTYPE_POSTERIORS
VARIANT_ANNOTATOR_REFINED
BGZIP_AND_TABIX_REFINED_VCF

for SAMPLE in $(awk 'BEGIN {FS=","} NR>1 {print $8}' $SAMPLE_SHEET | sort | uniq )
do
CREATE_SAMPLE_INFO_ARRAY
SELECT_PASSING_VARIANTS_PER_SAMPLE
BGZIP_AND_TABIX_SAMPLE_VCF
PASSING_VARIANTS_ON_TARGET_BY_SAMPLE
PASSING_SNVS_ON_BAIT_BY_SAMPLE
PASSING_SNVS_ON_TARGET_BY_SAMPLE
PASSING_INDELS_ON_BAIT_BY_SAMPLE
PASSING_INDELS_ON_TARGET_BY_SAMPLE
PASSING_SNVS_TITV_ALL
TITV_ALL
PASSING_SNVS_TITV_KNOWN
TITV_KNOWN
PASSING_SNVS_TITV_NOVEL
TITV_NOVEL
CONCORDANCE_ON_TARGET_PER_SAMPLE
done

# Chromosome loop for the COMBINE_GVCF (REPLACES SUBMITTER_COMBINE_GVCF.sh and COMBINE_GVCF.sh)
# 	Breakout COMBINE GVCF to:
# 			   COMBINE_GVCF
# 			   GENOTYPE_GVCF    (DEPENDENT ON COMBINE_GVCF)
# 			   VARIANT_ANNOTATOR (DEPENDENT ON GENOTYPE_GVCF)
#
# ### Next breakdown VQSR.GATK-3.3-0_CGP_26April2015.sh
# 		CATVARIANTS
# 		VARIANT_RECAL_SNV (DEPENDENT ON CATVARIANTS)
# 		VARIANT_RECAL_INDEL (DEPENDENT ON CATVARIANTS)
# 		APPLY_SNV (DEPENDENT ON VARIANT_RECAL_SNV)
# 		APPLY_INDEL (DEPENDENT ON VARIANT_RECA_INDEL && APPLY_SNV)
# 		BGZIP&TABIX (DEPENDENT ON APPLY_INDEL)
# 		CALCULATE_GENOTYPE_POSTERIORS (DEPENDENT ON APPLY_INDEL)
# 		VARIANT_ANNOTATOR (CALCULATE_GENOTYPE_POSTERIORS)
# 		BGZIP&TABIX (DEPENDENT ON VARIANT_ANNOTATOR)
#
# ### Next breakdown of VCF.Splitter.NEW.PIPELINE.HC.bam.sh (Also to replace the SUBMITTER)
# 		## Note: All these files can either:
# 							# A: Run off of the refined VQSR (big vcf)
# 							# B: Run off the 1st step vcf that has the extracted the passing variants for one sample ( I like this more to try 1st)
# 		SELECT_PASSING_VARIANTS (DEPENDENT ON CALCULATE_GENOTYPE_POSTERIORS)
# 		BGZIP_AND_TABIX (DEPENDENT ON SELECT_PASSING_VARIANTS)
# 		PASSING_VARIANTS_ON_TARGET_BY_SAMPLE (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		PASSING_SNVS_ON_BAIT_BY_SAMPLE (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		PASSING_SNVS_ON_TARGET_BY_SAMPLE (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		PASSING_INDELS_ON_BAIT_BY_SAMPLE (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		PASSING_INDELS_ON_TARGET_BY_SAMPLE (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		PASSING_SNVS_TITV_ALL (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		TITV_ALL (DEPENDENT ON PASSING_SNVS_TITV_ALL)
# 		PASSING_SNVS_TITV_KNOWN (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		TITV_KNOWN (DEPENDENT ON PASSING_SNVS_TITV_KNOWN)
# 		PASSING_SNVS_TITV_NOVEL (DEPENDENT ON COMBINE_VARIANTS OR CALCULATE_GENOTYPE_POSTERIORS)
# 		TITV_NOVEL (DEPENDENT ON PASSING_SNVS_TITV_NOVEL)
# 		CONCORDANCE_ON_TARGET_PER_SAMPLE (DEPENDENT ON TITV_NOVEL,TITV_KNOWN,TITV_ALL)