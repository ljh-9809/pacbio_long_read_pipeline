rule initial_qc:
    input:
        "raw_data/{sample}.fastq.gz"
    output:
        directory("results/qc/nanoplot/{sample}/")
    threads: 4
    shell:
        "NanoPlot --fastq {input} "
        "--outdir {output} "
        "--threads {threads} "
        "--plots hex dot "
        "--format png "
        "--N50"

rule post_trim_qc:
    input:
        "results/trimmed/{sample}.fastq.gz"
    output:
        directory("results/qc/nanoplot_post_trim/{sample}/")
    threads: 4
    shell:
        "NanoPlot --fastq {input} "
        "--outdir {output} "
        "--threads {threads} "
        "--plots hex dot "
        "--format png "
        "--N50"