rule porechop_trim:
    input:
        "raw_data/{sample}.fastq.gz"
    output:
        "results/trimmed/{sample}.fastq.gz"
    threads: config["resources"]["trimming"]["threads"]
    shell:
        "porechop -i {input} "
        "-t {threads} "
        "--format fastq.gz "
        "-o {output}"