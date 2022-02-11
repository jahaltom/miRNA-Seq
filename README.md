# miRNA-Seq 

Taking run accession IDs as input (RAids.txt) and an experimental design (Design.tsv), this pipeline quantifies miRNA-Seq data using miRDeep2 and then conducts differential expression analysis with DESeq2.

The quantification step in this pipeline is set up to allow for parallelization with each run accession ID being done separately. Since a mature miRNA can come from more than 1 precursor miRNA, these particular mature miRNA's are averaged across precursor miRNA's. The resulting average is then rounded to the nearest integer.

This analysis is for BioProject PRJNA545400 and the species is Rattus norvegicus.


**Create and activate conda enviroment:**
```
conda env create -f environment.yaml
conda activate miRNA-Seq
```

**Download required fasta files from miRBase and unzip**
```
wget https://www.mirbase.org/ftp/CURRENT/mature.fa.gz
wget https://www.mirbase.org/ftp/CURRENT/hairpin.fa.gz
gunzip *gz*
```


**Run miRNA-Seq quantification analysis**
This generates "countTable.tsv" which is used as count input for DESeq2.

```
snakemake -j 6 -s miRNA-Seq.py --cluster "sbatch -t 02:00:00  -c 30 -p RM-shared"
```


**Run DE analysis**
This generates a tsv file for the DESeq2 results, in this case its "VitaminD3_DGE.tsv". 

```
rscript DESeq2.r
```


