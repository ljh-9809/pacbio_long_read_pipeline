rule minimap2_mapping:
    input:
        ref = config["reference"],
        reads = "results/trimmed/{sample}.fastq.gz"
    output:
        temp("results/mapped/{sample}.bam")
    threads: 16
    shell:
        "minimap2 -ax map-hifi "
        "-t {threads} "
        "{input.ref} {input.reads} | "
        "samtools view -Sb - > {output}"

rule sort_bam:
    input:
        "results/mapped/{sample}.bam"
    output:
        "results/mapped/{sample}.sorted.bam"
    threads: 8
    shell:
        "samtools sort -@ {threads} -o {output} {input}"

rule index_bam:
    input:
        "results/mapped/{sample}.sorted.bam"
    output:
        "results/mapped/{sample}.sorted.bam.bai"
    shell:
        "samtools index {input}"