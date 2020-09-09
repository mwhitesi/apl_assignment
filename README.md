# Laboratory Scientist 2/Data Scientist- Matthew Whiteside Assignment Answers 

## Question 1

* [Git Repository](https://github.com/mwhitesi/apl_assignment)


## Question 2

For workflows involving external tools and multiple steps (such as variant calling), I have used the Smakemake workflow system. Snakemake has a number of 
advantages to help make multi-step analyses easily deployable and reproducible.

The Snakemake syntax is comprised of rules that determine the input/output data file dependencies and order of task execution. Snakemake has a predefined recommended project structure. I have cloned the Snakemake github template for GATK-based variant calling that uses this recommended structure.

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

### Part 3b

To validate and tune variant calling parameters, I would c

## Question 4

The process I would select to get the PCR data from the desktop would be to use a network shared folder as the conduit.  This network folder would be available on the local deskop with the PCR data files and would also be mounted on the server. The technician would be required to save the PCR data to network shared directory (New results would ideally be added to new files). I would create a python script or snakemake file that would be regularly scheduled (using cron for example) to monitor the network shared drive for new sample data across the network folder files. This approach requires minimal intervention from the technican and little configuration on the desktop computer. I have made a sample snakemake file to demonstrate how new data can be downloaded to the server across a network shared folder.

## Question 5

## Question 6 

## Question 7

### Part 7a

Initially, I would deliver routine reports as a static HTML files. A HTML report file could easily be generated using a templating library such as Python's jinja. These static html files could be served from NGINX server which is easily set up to server static files. THe most recent report HTML could then be accessed and viewed in the Laboratory's intranet. This approach is simple to setup, but provides little user interaction cabability. More sophisiticated reporting with for example real-time querying capability would require a more complex web stack that would require more time to setup (e.g. nginx + uwsgi + flask + postgresql)

### Part 7b

Automated QC/QA can be integrated into the snakemake workflow 

### Part 7c

My preferred method is to continue to use the snakemake workflow system with available linux and python tools and libraries. To perform a data transfer through a defined port I would use the `scp -p` file copy tool. Snakemake has built-in error-catching and input/output validation mechanisms. See [rules/transfer.smk](rules/transfer.smk) for an example. 

## Question 8

As a clinically-validated PCR machine, the results should be machine-agnostic (provided the CSV results format does not change). In my prescribed approach. the data will be saved to a network shared folder which could be made available on any machine on the network. Since no software is stored on the desktop computer, there should be no validation required for the software. Snakemake does provide a mechanism to validate input file format called schemas. I have made a sample schema called [schemas/pcr.scema.yaml](schemas/pcr.scema.yaml) as an example. This could be used to validate the CSV format. No software would need to be installed on the desktop computer in this approach. 





