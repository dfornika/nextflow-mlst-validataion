process fastp {
    tag { sample_id }
    label 'cpu8'
    publishDir "${params.outdir}/${task.process.replaceAll(":","_")}", pattern: "${sample_id}.fastp.json", mode: 'copy'

    input:
    tuple val(grouping_key), path(fastq)

    output:
    tuple val(sample_id), path("${sample_id}.fastp.json")

    script:
    if (grouping_key =~ '_S[0-9]+_') {
      sample_id = grouping_key.split("_S[0-9]+_")[0]
    } else {
      sample_id = grouping_key.split("_")[0]
    }

    """
    fastp \
      --dont_overwrite \
      -i ${fastq[0]} \
      -I ${fastq[1]} \
      -j ${sample_id}.fastp.json
    """
}