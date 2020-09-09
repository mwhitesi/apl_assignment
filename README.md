# Laboratory Scientist 2/Data Scientist- Matthew Whiteside Assignment Answers 

## Question 1

* [Git Repository](https://github.com/mwhitesi/apl_assignment)


## Question 2

For workflows involving external tools and multiple steps (such as variant calling), I have used the Smakemake workflow system. Snakemake has a number of 
advantages to help make multi-step analyses easily deployable and reproducible.

The Snakemake syntax is comprised of rules that determine the input/output data file dependencies and order of task execution. Snakemake has a predefined recommended project structure. I have cloned the Snakemake github template for GATK-based variant calling that uses this recommended structure (https://github.com/snakemake-workflows/dna-seq-gatk-variant-calling/).

The structure is as follows:

* envs - conda environment settings
* report - report config for snakemake auto-reports
* rules - auxilariy snakemake files (included in the main Snakefile)
* schemas - JSON schema definitions 

Snakemake will auto-generate the following directories:

* resources - reference files (such as reference genome used in read mapping)
* called - interim variant call files 
* genotyped - final variant output files
* logs - error and progress text files

Parameters and workflow config are defined in one location: `config.yaml`

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

### Part 3b

To validate and tune variant calling procedures parameters, I would begin by targeting the set of lower-confidence variants from the NGS pipeline and using a complementary, higher-accuracy variant calling method such as Sanger sequencing, characterize the variants. The reported variant calls from the complementary would be compared to the NGS calls. Disagreeing variants calls would be used to select appropriate settings.  

## Question 4

The process I would select to get the PCR data from the desktop would be to use a network shared folder as the conduit.  This network folder would be available on the local deskop with the PCR data files and would also be mounted on the server. The technician would be required to save the PCR data to network shared directory (New results would ideally be added to new files). I would create a python script or snakemake file that would be regularly scheduled (using cron for example) to monitor the network shared drive for new sample data across the network folder files. This approach requires minimal intervention from the technican and little configuration on the desktop computer.

## Question 5

To monitor multiple sources of input data is one of the strengths of Snakemake and easily orchestrated within an existing regularly scheduled Snakemake workflow. My approach would maintain lists tracking sample IDs appearing in PCR and genome sequence data as well as their status. Critical to integrating diverse analysis for different samples is to have a consistent sample identifiers. The snakemake task would identify amoung downloaded analysis data, 1) the set of pending unmatched BAM sample IDs and 2) the set of sample IDs with matched PCR / BAM data. The second set would be used to initiate downstream analysis in Snakemake. I made a sample snakemake [file](rules/pending.smk) to demonstrate the proposed workflow.

## Question 6

### Part 6a 

In addition to reporting individual differences between PCR and NGS calls for specific loci, I would also record and report the PCR and NGS agreement on aggregate across all loci in the test for each sample. I would also monitor and summerize the aggreement in variant calls across samples using a reoccuring report. Multiple disagreements between these complementary methods may indicate a systemic problem or error in sample-processing (e.g. mislabelled sample). I would flag samples that have above a certain threshold of mismatches between methods. A immediate notification could be sent when such a case is identified -- at which time further investigation can be undertaken.

### Part 6b

My planned workflow would generate a final HTML report that would summerize per sample aggreement between the NGS and PCR variant calling methods. To notify potential issues, the report could contain conditional a warning section at the top of the report that would highlight problematic cases. If immediate notification 

## Question 7

### Part 7a

Initially, I would deliver routine reports as a static HTML files. A HTML report file could easily be generated using a templating library such as Python's jinja. These static html files could be served from NGINX server which is easily set up to server static files. THe most recent report HTML could then be accessed and viewed in the Laboratory's intranet. This approach is simple to setup, but provides little user interaction cabability. More sophisiticated reporting with for example real-time querying capability would require a more complex web stack that would require more time to setup (e.g. nginx + uwsgi + flask + postgresql)

### Part 7b

Automated QC/QA can be integrated into the snakemake workflow as well as the final report generation. 

### Part 7c

My preferred method is to continue to use the snakemake workflow system with available linux and python tools and libraries. To perform a data transfer through a defined port I would use the `scp -p` file copy tool. Snakemake has built-in error-catching and input/output validation mechanisms. See [rules/transfer.smk](rules/transfer.smk) for an example. 

## Question 8

As a clinically-validated PCR machine, the results should be machine-agnostic (provided the CSV results format does not change). In my prescribed approach. the data will be saved to a network shared folder which could be made available on any machine on the network. Since no software is stored on the desktop computer, there should be no validation required for the software. Snakemake does provide a mechanism to validate input file format called schemas. I have made a sample schema called [schemas/pcr.scema.yaml](schemas/pcr.scema.yaml) as an example. This could be used to validate the CSV format. No software would need to be installed on the desktop computer in this approach. 





