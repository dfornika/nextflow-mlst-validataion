nextflow.enable.dsl = 2

include { mlst } from '../modules/mlst.nf'

def add_assembly_id(assembly) {
  return new Tuple(assembly.getName().toString().split('\\.')[0], assembly)
}

workflow mlst_on_assembly {
  take:
    ch_assembly

  main:
    
    ch_assembly_with_assembly_id = ch_assembly.map{ add_assembly_id(it) }
    
    mlst(
      ch_assembly_with_assembly_id
    )
}