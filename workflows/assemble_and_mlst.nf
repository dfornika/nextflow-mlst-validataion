nextflow.enable.dsl = 2

include { shovill } from '../modules/shovill.nf'
include { mlst } from '../modules/mlst.nf'

workflow assemble_and_mlst {
  take:
    ch_simulated_reads

  main:

    shovill(
      ch_simulated_reads
    )

    mlst(
      shovill.out
    )
}