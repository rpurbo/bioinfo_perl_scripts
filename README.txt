===================== PROCEDURE FOR PROCESSING METAGENOMICS READS ===================== 

PREPROCESSING:
1. trim the reads using CLC genomics workbench
2. check the quality using FASTQC
3. filter duplicates, length and Ns (filter_length.pl & remove_duplicates.pl)
4. check the quality again using FASTQC

INTERMEDIATE STEP:
1. Convert the FASTQ files to pieces of FASTA (chop_fasta.pl)

BLAST:
1. create a batch file to BLAST the FASTA files
2. collect the result

blastn -query ../reads/processed/2010_11_07_PatrickNg_2-KL_reads_trimmed_nonduplicates.fasta -db /home/rikky/NGS/tools/alignment/blast/16s/16S -out 2010_11_07_PatrickNg_2-KL_reads_trimmed_nonduplicates.blast -num_threads 4 -outfmt 5 -evalue 0.0000000001 -max_target_seqs 1



COMPILATION:
1. Compile the species list
2. Recap the Genus & Species list (species_stats.pl & genus_stats.pl)



===================== PROCEDURE FOR PROCESSING METAGENOMICS READS (BLAST XML) ===================== 

PREPROCESSING:
1. trim the reads using CLC genomics workbench
2. check the quality using FASTQC
3. filter duplicates, length and Ns (filter_length.pl & remove_duplicates.pl)
4. check the quality again using FASTQC

INTERMEDIATE STEP:
1. Convert the FASTQ files to pieces of FASTA (chop_fasta.pl)

BLAST:
1. create a batch file to BLAST the FASTA files (10000 reads per chunk)
2. modify word_size depending on the length of the reads (longer word is faster, choose 64 or 200) 
2. collect the result

blastn -query ../reads/processed/2010_11_07_PatrickNg_2-KL_reads_trimmed_nonduplicates.fasta -db /home/rikky/NGS/tools/alignment/blast/16s/16S -out 2010_11_07_PatrickNg_2-KL_reads_trimmed_nonduplicates.blast -num_threads 4 -outfmt 5 -max_target_seqs 1 -word_size 64


COMPILATION:
1. Compile the blast result (compile_blast_xml.pl)
2. Recap the Genus & Species list (species_stats.pl & genus_stats.pl)




