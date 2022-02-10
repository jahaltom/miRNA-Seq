# miRNA-Seq

**Create and activate conda enviroment:**
```
conda env create -f environment.yaml
conda activate miRNA-Seq
```

**Download required fasta files from miRBase**
```
wget https://www.mirbase.org/ftp/CURRENT/mature.fa.gz
wget https://www.mirbase.org/ftp/CURRENT/hairpin.fa.gz
```

**Create RAids.txt**
```
SRR9157691
SRR9157693
SRR9157695
SRR9157690
SRR9157692
SRR9157694
```


**Run miRNA-Seq quantification analysis**
```
snakemake -j 6 -s miRNA-Seq.py --cluster "sbatch -t 02:00:00  -c 30 -p RM-shared"
```

