params.ref="/home/katerine/Desktop/project/ref_gen/Homo_sapiens_assembly38.fasta"
params.reads='/home/katerine/Desktop/project/raw_reads/*.fastq.gz'
Channel.fromPath(params.reads).set { read_files }
Channel.fromPath(params.ref).set { ref_genome }

process aligment {
input:
 path reads from read_files
 path genome from ref_genome
 
output:
 path '/home/katerine/Desktop/project/aligned/*.bam'
 
script:
"""
bwa mem -R '@RG\tID:foo\tSM:SRR13602621\tPL:illumina' -t 6 $genome $reads | samtools sort --threads 6 -m 2G > al
"""

}
