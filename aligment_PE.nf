nextflow.enable.dsl=2

// params.reads=null

workflow {
 reads_ch = Channel.fromFilePairs('/home/katerine/Desktop/project/paired_raw/*ds_{1,2}.fastq.gz')
 alignment(reads_ch)
}

process alignment {
 publishDir('/home/katerine/Desktop/project/aligned', mode:'move')
 
 input:
 tuple val(sample_id), path(reads)

 output:
 path("*.bam")

 script:
 """
 bwa mem -R '@RG\\tID:foo\\tSM:${sample_id}\\tPL:illumina' -t 6 /home/katerine/Desktop/project/ref_gen/Homo_sapiens_assembly38.fasta $reads | samtools sort --threads 6 -m 2G -o ${sample_id}.bam
 """

}
