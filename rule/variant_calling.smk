rule pbsv_discover:
    input:
        bam = "results/mapped/{sample}.sorted.bam"
    output:
        svsig = "results/variants/{sample}.svsig.gz"
    shell:
        "pbsv discover {input.bam} {output.svsig}"

rule pbsv_call:
    input:
        ref = config["reference"],
        svsig = "results/variants/{sample}.svsig.gz"
    output:
        vcf = "results/variants/{sample}.vcf"
    shell:
        "pbsv call {input.ref} {input.svsig} {output.vcf}"