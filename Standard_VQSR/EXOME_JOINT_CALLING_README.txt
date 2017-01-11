EXOME JOINT CALLING README (NOT MENDEL)

This submitter and it's subscripts are used for joint calling exome projects.

The MASTER_SUBMITTER.sh takes in the following arguements:

PROJECT - The name of the project directory found in Seq_Proj (no / marks)
SAMPLE_SHEET - The sample sheet with the samples to be joint called (fully qualified path)
PREFIX - The prefix of the multi-sample vcf that will be generated
NUMBER_OF_BED_FILES - The number of bed files to split on.  If left blank, the default will be 100

**If these scripts are used you must change the SCRIPT_DIR on line 14 in the MASTER_SUBMITTER.sh to where the SCRIPTS folder lives.**

The setup splits based on bed file as opposed to chromosome.  This allows for each step to run more efficiently and take up less time per job slot.  Utilizing a larger number of job submissions that run faster allows us to use the cluster more efficiently.  
		The bait bed file is found from the sample sheet and is checked for formatting and to ensure it's sorted properly.  Then this bed file is split and stored in the TEMP/BED_FILE_SPLIT directory.

When submitted, a gvcf.list file is generated for all the samples found within the sample sheet.  The sample sheet data is used to avoid any samples found in the GVCF directory that is not being released.  This gvcf list will be stored in the top directory as the ##.samples.gvcf.list

