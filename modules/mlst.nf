process mlst {
    tag { sample_id }
    label 'cpu4'

    input:
    tuple val(sample_id), path(assembly)

    output:
    tuple val(sample_id), path("${sample_id}.mlst.tsv"), path("${sample_id}.mlst.json")

    script:
    """
    mlst \
      --threads ${task.cpus} \
      ${assembly} \
      --json ${sample_id}.mlst.json \
      > ${sample_id}.mlst.tsv
    """
}