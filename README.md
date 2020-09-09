# Laboratory Scientist 2/Data Scientist- Matthew Whiteside Assignment Answers 

## Question 1

* [Git Repository](https://github.com/mwhitesi/apl_assignment_test)


## Question 2

For workflows involving external tools and multiple steps (such as variant calling), I have used the Smakemake workflow system. Snakemake has a number of 
advantages to help make multi-step analyses easily deployable and reproducible.

The Snakemake syntax is comprised of rules that determine the input/output data file dependencies and order of task execution. Snakemake has a predefined recommended project structure. I have cloned the Snakemake github template for GATK-based variant calling that uses this recommended structure.

I have marked the files involved in the NGS reference assembly that will be not needed if the project is limited to variant calling. 

The structure is as follows:


## Question 3

### Part 3a

For the NGS variant calling I would use the GATK suite of tools. The snakemake file: [rules/calling.smk](rules/calling.smk) defines the individual tools and parameters to generate a combined .vcf variant file. 
(Note: I am not sure if a cohort approach would be suitable in a laboratory workflow. A joint-cohort approach is reported to improve the sensitivity & accuracy of variant calling and is the approach described here)

To be explicit, the [rules/calling.smk](rules/calling.smk) snakemake file performs the following steps in order:  

1. Extract the region of interest using `bedextract` (rule: compose_regions)
1. Identify variants with `haplotypecaller` for each sample (rule: call_variants)
1. Combine sample variants into a single variant file with `combinegvcfs` (rule: combine_calls)
1. Perform joint genotyping using all samples with `genotypegvcfs` (rule: genotype_variants)
1. Merge variants for each region into a single output file using `mergevcfs` (rule: merge_variants)

## Question 7

### a




