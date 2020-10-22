process bwa_mem {
    tag { sample_id }
    label 'cpu8'

    input:
    tuple val(sample_id), path(read_1), path(read_2), path(reference)

    output:
    tuple val(sample_id), path("${sample_id}.sorted.bam"), path("${sample_id}.sorted.bam.bai")

    script:
    """
    bwa index ${reference}
    bwa mem \
      -t ${task.cpus} \
      ${reference} \
      ${read_1} \
      ${read_2} \
      | samtools sort \
        -@ ${task.cpus} \
        -T "temp" \
        -O BAM \
        -o ${sample_id}.sorted.bam \
        -
    samtools index ${sample_id}.sorted.bam
    """
}