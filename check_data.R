#! /usr/bin/Rscript
library(oro.nifti)

args <- commandArgs(TRUE)
sourcefile <- args[1]

file.remove("/Users/cyber/Desktop/data/temp.txt")
AA <- readNIfTI("/usr/local/fsl/data/standard/avg152T1_brain.nii.gz", reorient = FALSE)
A <- AA@.Data

c1 <- paste(paste(paste(sourcefile,"/func/rest.feat/reg",sep = ""),"/",sep = ""),"example_func2standard.nii.gz",sep ="")

if (file.exists(c1)) {
  BB <- readNIfTI(c1, reorient = FALSE)
  B <- BB@.Data
  xlength <- dim(B)[1]
  ylength <- dim(B)[2]
  zlength <- dim(B)[3]
  tempa <- 0
  tempa1 <- 0
  tempb <- 0
  tempb1 <- 0
  for (x in 1:xlength) {
    for (y in 1:ylength) {
      for (z in 1:zlength) {
        if (A[x,y,z] > 800) {
          if (B[x,y,z] > 400) {
            tempb <- tempb + 1
          }
          tempa <- tempa + 1
        }
      }
    }
  }
  
  
  for (x in 1:xlength) {
    for (y in 1:ylength) {
      for (z in 1:zlength) {
        if (B[x,y,z] > 800) {
          if (A[x,y,z] > 400) {
            tempa1 <- tempa1 + 1
          }
          tempb1 <- tempb1 + 1
        }
      }
    }
  }

  if ((tempb / tempa) < 0.9 || (tempa1 / tempb1) < 0.9){
    file.remove("/Users/cyber/Desktop/data/temp.txt")
  }
  else{
    file.create("/Users/cyber/Desktop/data/temp.txt")
  }
} else{
  file.remove("/Users/cyber/Desktop/data/temp.txt")
}




