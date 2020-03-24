#!/bin/sh

name=$1
fasta=$2
gff=$3


perl /scratch/admin/pipelines/package/apps/rrna/0.1/extract_ITSv2.pl $fasta $gff > ${name}.ITS.fasta
perl /scratch/admin/pipelines/package/apps/rrna/0.1/extract_18S.pl $fasta $gff > ${name}.18S.fasta

/apps/uclustv1.2.22/uclust --sort ${name}.ITS.fasta --output ${name}.ITS.sorted.fasta
/apps/uclustv1.2.22/uclust --input ${name}.ITS.sorted.fasta --uc ${name}.ITS.uc --id 0.97 --rev
/apps/uclustv1.2.22/uclust --uc2fasta ${name}.ITS.uc --input ${name}.ITS.sorted.fasta --output ${name}.ITS.clust.fasta
perl /scratch/admin/pipelines/package/apps/rrna/0.1/extract_rep.pl ${name}.ITS.clust.fasta > ${name}.ITS.reps.fasta


/apps/uclustv1.2.22/uclust --sort ${name}.18S.fasta --output ${name}.18S.sorted.fasta
/apps/uclustv1.2.22/uclust --input ${name}.18S.sorted.fasta --uc ${name}.18S.uc --id 0.97 --rev
/apps/uclustv1.2.22/uclust --uc2fasta ${name}.18S.uc --input ${name}.18S.sorted.fasta --output ${name}.18S.clust.fasta
perl /scratch/admin/pipelines/package/apps/rrna/0.1/extract_rep.pl ${name}.18S.clust.fasta > ${name}.18S.reps.fasta

