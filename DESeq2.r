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
dds = DESeqDataSetFromMatrix(countData = countData,colData = metadata,design = ~ Sample)   
dds = DESeq(dds)
#Contrast case vs control
result = results(dds, contrast=c("Sample","case","control"))
## Remove rows with NA
result = result[complete.cases(result),]
#Put GeneID as column 
result = cbind(miRNA_ID = rownames(result), result)


write.table(result,"CaseVSControl_DGE.tsv" ,sep = '\t',row.names = FALSE)
