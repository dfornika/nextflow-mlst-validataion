nextflow.enable.dsl = 2

include { compare_mlst_results } from '../modules/compare_mlst_results.nf'

workflow summary {
  take:
    ch_mlst_json_results

  main:
    compare_mlst_results(
      ch_mlst_json_results
    )
}