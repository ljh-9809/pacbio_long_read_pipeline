rule pbsv_discover:
    input:
        bam = "results/mapped/{sample}.sorted.bam"
    output:
        svsig = "results/variants/{sample}.svsig.gz"
    shell:
        "pbsv discover --ccs {input.bam} {output.svsig}"

# Germline variant calling
rule pbsv_call:
    input:
        ref = config["reference"],
        svsig = "results/variants/{sample}.svsig.gz"
    output:
        vcf = "results/variants/{sample}.vcf"
    threads: config["resources"]["variant_calling"]["threads"]
    shell:
        "pbsv call --ccs -j {threads} {input.ref} {input.svsig} {output.vcf}"

# Somatic variant calling
rule pbsv_somatic_call:
    input:
        ref = config["reference"],
        normal_svsig = "results/variants/SRR28305182.svsig.gz",
        tumor_svsig = "results/variants/SRR28305185.svsig.gz"
    output:
        vcf = "results/variants/somatic.vcf"
    threads: config["resources"]["variant_calling"]["threads"]
    shell:
        "pbsv call --ccs -j {threads} {input.ref} {input.normal_svsig} {input.tumor_svsig} {output.vcf}"