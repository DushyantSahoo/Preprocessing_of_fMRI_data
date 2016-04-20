#! /usr/bin/Rscript
library(oro.nifti)
# change filename in design.fsf
args <- commandArgs(TRUE)
sourcefile <- args[1]
textdata <- readLines("/Users/cyber/Desktop/data/design.fsf")
c <- paste(paste(paste(sourcefile,"func",sep=""),"/",sep=""),"rest.nii.gz",sep="")
for (ii in 1:length(textdata)){
  splitted <- strsplit(textdata[ii]," ")
  if (length(splitted[[1]]) > 2){
  if (all.equal(splitted[[1]][1], "set") == "TRUE"){
    if (all.equal(splitted[[1]][2],"highres_files(1)") == "TRUE"){
      splitted[[1]][3] <- paste(paste(paste(sourcefile,"anat",sep=""),"/",sep=""),"mprage_skullstripped",sep="")
      textdata[ii] <- paste(paste(splitted[[1]][1],splitted[[1]][2],sep = " "),splitted[[1]][3],sep =" ")
    }
    if (all.equal(splitted[[1]][2],"feat_files(1)") == "TRUE"){
      splitted[[1]][3] <- paste(paste(paste(sourcefile,"func",sep=""),"/",sep=""),"rest",sep="")
      textdata[ii] <- paste(paste(splitted[[1]][1],splitted[[1]][2],sep = " "),splitted[[1]][3],sep =" ")
    }
    
    
  }
  }
  
}

unlink("/Users/cyber/Desktop/data/design.fsf", recursive = FALSE)
fileConn<-file("/Users/cyber/Desktop/data/design.fsf")
writeLines(textdata, fileConn)
close(fileConn)