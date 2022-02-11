library(DESeq2)

#Read in count information. 
countData = read.table("countTable.tsv",header=TRUE,row.names=1,sep = '\t')
#Round to nearest int
countData=round(countData,0)
##Read in expermental design
metadata = read.table("Design.tsv",header=TRUE,row.names=1,sep = '\t')


#Get sample names 
samples=row.names(metadata)


#Should return TRUE
#all(rownames(metadata) == colnames(countData))

##Make DEseq2 object 
dds = DESeqDataSetFromMatrix(countData = countData,colData = metadata,design = ~ Sample.Name)   
dds = DESeq(dds)
#Contrast SARS-CoV-2 vs Mock
result = results(dds, contrast=c("Sample.Name","case","control"))
## Remove rows with NA
result = result[complete.cases(result),]
#Put GeneID as column 
result = cbind(GeneID = rownames(result), result)


write.table(result,"VitaminD3_DGE.tsv" ,sep = '\t',row.names = FALSE)
