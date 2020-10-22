nextflow.enable.dsl = 2

include { bwa_mem } from '../modules/bwa_mem.nf'

workflow align_reads_to_assembly {
  take:
    ch_simulated_reads
    ch_assembly

  main:

    bwa_mem(
      ch_simulated_reads
        .combine(ch_assembly)
    )

}