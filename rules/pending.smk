import pandas as pd

samples = pd.read_table(config["samples"]).set_index("sample", drop=False)
pcrsamples = pd.read_table(config["pcr"]).set_index("sample", drop=False)

matched_samples = samples['sample'].iloc[ samples['sample'].isin(pcrsamples['sample']) & samples['status'] == 1]

rule match:
    input:
        matched=expand("called/{sample}.g.vcf.gz", sample=matched_samples)
    output:
        "some/output/"
    shell:
        "next command {input.matched}"


