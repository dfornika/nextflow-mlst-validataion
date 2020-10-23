process compare_mlst_results {
    executor 'local'
    publishDir "${params.outdir}/summary", pattern: "mlst_comparison.tsv", mode: 'copy'
    input:
    tuple path(ref_mlst), path(assembled_mlst)

    output:
    path("mlst_comparison.tsv")
    
    script:
    """
    compare_mlst_results.py \
      --ref_mlst "${ref_mlst}" \
      --assembled_mlst "${assembled_mlst}" \
      > "mlst_comparison.tsv"
    """
}