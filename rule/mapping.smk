rule minimap2_mapping:
    input:
        ref = config["reference"],
        reads = "results/trimmed/{sample}.fastq.gz"
    output:
        temp("results/mapped/{sample}.bam")
    threads: 16
    log:
        "logs/minimap2/{sample}.log"
    shell:
        "minimap2 -ax map-hifi "
        "-t {threads} "
        "-R '@RG\\tID:{wildcards.sample}\\tSM:{wildcards.sample}' "
        "--MD --eqx "
        "-K 500M "
        "-Y "  # soft clipping 사용 (hard clipping 대신)
        "{input.ref} {input.reads} 2> {log} | "
        "samtools view -h -F 0x904 -Sb - | "  # 0x1104에서 0x904로 변경 (hard clip 필터 제거)
        "samtools sort -@ 8 - > {output}"

# 나머지 규칙들은 그대로 유지

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