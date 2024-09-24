nextflow.enable.dsl=2

params.reads='/home/katerine/Desktop/project/raw_reads/*.fq.gz'

workflow {
 reads_ch = Channel.fromPath(params.reads)
 alignment(reads_ch)
}

process alignment {
 publishDir('/home/katerine/Desktop/project/aligned', mode:'move')

 input:
 path(reads) 
 
 output:
 path("${reads.simpleName}.bam")

 script:
 """
 bwa mem -R '@RG\\tID:foo\\tSM:${reads.simpleName}\\tPL:illumina' -t 6 /home/katerine/Desktop/project/ref_gen/Homo_sapiens_assembly38.fasta $reads | samtools sort --threads 6 -m 2G -o ${reads.simpleName}.bam
 """

}
