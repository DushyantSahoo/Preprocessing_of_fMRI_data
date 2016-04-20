#! /usr/bin/Rscript
library(oro.nifti)
# change variable name in design.fsf
args <- commandArgs(TRUE)
sourcefile <- args[1]
BB<-readNIfTI(sourcefile, reorient = FALSE)
B<-BB@.Data
B1 <- BB@pixdim
totallength <- length(B)
timelength <- dim(B)[4]
reptime <- B1[5]

textdata <- readLines("/Users/cyber/Desktop/data/design.fsf")
for (ii in 1:length(textdata)){
  splitted <- strsplit(textdata[ii]," ")
  
  if (all.equal(splitted[[1]][1], "set") == "TRUE"){
    if (all.equal(splitted[[1]][2],"fmri(tr)")== "TRUE"){
      splitted[[1]][3] <- toString(reptime)
      textdata[ii] <- paste(paste(splitted[[1]][1],splitted[[1]][2],sep = " "),splitted[[1]][3],sep =" ")
    }
    if (all.equal(splitted[[1]][2],"fmri(npts)") == "TRUE"){
      splitted[[1]][3] <- toString(timelength)
      textdata[ii] <- paste(paste(splitted[[1]][1],splitted[[1]][2],sep = " "),splitted[[1]][3],sep =" ")
    }
    if (all.equal(splitted[[1]][2],"fmri(totalVoxels)") == "TRUE"){
      splitted[[1]][3] <- toString(totallength)
      textdata[ii] <- paste(paste(splitted[[1]][1],splitted[[1]][2],sep = " "),splitted[[1]][3],sep =" ")
    }
  }
  
}
unlink("/Users/cyber/Desktop/data/design.fsf", recursive = FALSE)
fileConn<-file("/Users/cyber/Desktop/data/design.fsf")
writeLines(textdata, fileConn)
close(fileConn)
