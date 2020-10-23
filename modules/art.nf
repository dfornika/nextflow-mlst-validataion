process art {
    tag { assembly_id }
    label 'cpu4'

    input:
    tuple val(assembly_id), path(assembly), val(fold_coverage)

    output:
    tuple val(assembly_id), path("${assembly_id}_R1.fastq.gz"), path("${assembly_id}_R2.fastq.gz")

    script:
    assembly_id = assembly.toString().split('\\.')[0]
    mean_fragment_length = 300
    stdev_fragment_length = 50
    read_length = 250
    fold_coverage = 5
    """
    echo "${assembly_id}" > assembly_id.txt
    art_illumina \
      --paired \
      --in ${assembly} \
      --fcov ${fold_coverage} \
      --len ${read_length} \
      --mflen ${mean_fragment_length} \
      --sdev ${stdev_fragment_length} \
      --out ${assembly_id}_R
    mv ${assembly_id}_R1.fq ${assembly_id}_R1.fastq
    mv ${assembly_id}_R2.fq ${assembly_id}_R2.fastq
    gzip ${assembly_id}_R1.fastq
    gzip ${assembly_id}_R2.fastq
    """
}