nextflow.enable.dsl = 2

include { art } from '../modules/art.nf'

workflow simulate_reads {
  take:
    ch_assembly

  main:

    art(
      ch_assembly
    )

  emit:
    art.out
}