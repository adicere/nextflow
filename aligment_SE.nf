nextflow.enable.dsl=2

params.reads=null 

workflow {
 reads_ch = Channel.fromPath(params.reads)
 aligned_ch=alignment(reads_ch)
 alignment.out.aligned_ch.view()
 indexing(aligned_ch)
 
}

process alignment {
 publishDir('/home/katerine/Desktop/project', mode:'move')
 maxForks 1
 input:
 path reads 
 
 output:
 path("${reads.simpleName}.bam"), emit: aligned_ch

 script:
 """
 bwa mem -R '@RG\\tID:foo\\tSM:${reads.simpleName}\\tPL:illumina' -t 6 /home/katerine/Desktop/project/ref_gen/Homo_sapiens_assembly38.fasta \
$reads | samtools sort --threads 6 -m 2G -o ${reads.simpleName}.bam
 """

}

process indexing {
 publishDir('/home/katerine/Desktop/project/indexed', mode:'move')
 input:
 path bam

 output:
 path("*.bai")

 script:
 """
 samtools index  $bam
 """

}