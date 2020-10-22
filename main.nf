#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { simulate_reads } from './workflows/simulate_reads.nf'
include { assemble_and_mlst } from './workflows/assemble_and_mlst.nf'
include { mlst_on_assembly } from './workflows/mlst_on_assembly.nf'
include { align_reads_to_assembly } from './workflows/align_reads_to_assembly.nf'

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}

workflow {
  ch_assembly = Channel.fromPath( "${params.assembly}", type: 'file')

  main:

  mlst_on_assembly(
    ch_assembly,
  )

  simulate_reads(
    ch_assembly,
  )

  align_reads_to_assembly(
    simulate_reads.out,
    ch_assembly,
  )

  assemble_and_mlst(
    simulate_reads.out
  )
}