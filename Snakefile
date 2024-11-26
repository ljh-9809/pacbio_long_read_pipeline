configfile: "config.yaml"

rule all:
    input:
        # Initial QC
        expand("results/qc/nanoplot/{sample}/", sample=config["samples"]),
        # Trimming 결과
        expand("results/trimmed/{sample}.fastq.gz", sample=config["samples"]),
        # Post-trim QC
        expand("results/qc/nanoplot_post_trim/{sample}/", sample=config["samples"]),
        # Mapping 결과
        expand("results/mapped/{sample}.sorted.bam.bai", sample=config["samples"]),
        # Variant calling 결과
        expand("results/variants/{sample}.vcf", sample=config["samples"])

include: "rule/qc.smk"
include: "rule/trimming.smk"
include: "rule/mapping.smk"
include: "rule/variant_calling.smk"
