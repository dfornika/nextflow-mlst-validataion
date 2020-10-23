nextflow.enable.dsl = 2

include { art } from '../modules/art.nf'

def add_assembly_id(assembly) {
  return new Tuple(assembly.getName().toString().split('\\.')[0] + "-ref", assembly)
}

workflow simulate_reads {
  take:
    ch_assembly

  main:

    ch_fold_coverage = Channel.from(5)
    ch_assembly_with_id = ch_assembly.map{ add_assembly_id(it) }
    
    art(
      ch_assembly_with_id
        .combine(ch_fold_coverage)
    )

  emit:
    art.out
}