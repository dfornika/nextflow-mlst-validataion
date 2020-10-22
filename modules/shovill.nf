process shovill {
    tag { sample_id }
    label 'cpu16'

    input:
    tuple val(sample_id), path(reads_1), val(reads_2)

    output:
    tuple val(sample_id), path("${sample_id}.contigs.fa")

    script:
    """
    shovill \
      --cpus ${task.cpus} \
      --R1 ${reads_1} \
      --R2 ${reads_2} \
      --outdir '.' \
      --force
    mv contigs.fa ${sample_id}.contigs.fa
    """
}