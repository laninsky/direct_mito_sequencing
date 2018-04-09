library(data.table)
pileup_files <- list.files(pattern=".pileup")

for (i in pileup_files) {
  temp <- fread(i, select = c(1:4),sep="\t")
  output_name <- paste(gsub(".pileup","_pileup.fasta",i,fixed=TRUE))
  tempseq <- NULL
  x <- 1
  for (j in 1:(dim(temp)[1])) {
    #1A what to do if coverage is above 0
    if (temp[j,4] > 0) {
      #2A what to do for the first row or last row
      if (j == 1 | j == (dim(temp)[1])) {
        # 20A what to do for the first row
        if (j == 1) {
          tempseq <- paste(tempseq,temp[j,3],sep="")
        # 20AB what to do for the last row  
        } else {
          # 200A if the last line in the file belongs with the rest of the contig
          if (temp[j,1]==temp[(j-1),1] & temp[j,2]==(temp[(j-1),2]+1)) {
            tempseq <- paste(tempseq,temp[j,3],sep="")
          } #200B
          # 2000A if tempseq is not null
          if (!(is.null(tempseq))) {
            # 201A if the resulting contig is more than 100 bp in length
            if (nchar(tempseq)>=100) {
              write.table(paste(">",temp[j,1],"_",x,sep=""),output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
             write.table(tempseq,output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
            }  #201B
          } # 2000B  
        }  #20B
      #2AB what to do for the rest of the rows when coverage is above 0
      } else {
        # 3A what to do when from same underlying reference fragment and coverage is above 0
        if (temp[j,1]==temp[(j-1),1]) {
          # 4A what to do when no sequence gap between rows and coverage is above 0
          if (temp[j,2]==(temp[(j-1),2]+1)) {
            tempseq <- paste(tempseq,temp[j,3],sep="")
          # 4AB what to do if not sequential bases (start a new frag) and coverage is above 0 
          } else {
            # 2000A if tempseq is not null
            if (!(is.null(tempseq))) {
              if (nchar(tempseq)>=100) {
                write.table(paste(">",temp[(j-1),1],"_",x,sep=""),output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
                write.table(tempseq,output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
              }
            } #2000B  
            tempseq <- temp[j,3]
            x <- x+1
          } #4B
        # 3AB what to do if from different underlying fragments and coverage is above 0  
        } else {
           # 2000A if tempseq is not null
           if (!(is.null(tempseq))) {
             if (nchar(tempseq)>=100) {
                write.table(paste(">",temp[(j-1),1],"_",x,sep=""),output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
                write.table(tempseq,output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
              }
           } # 2000B               
           tempseq <- temp[j,3]
           x <- 1
        } #3B
      } #2B  
    #1AB what to do if coverage is 0      
    } else {
      # 2000A if tempseq is not null
      if (!(is.null(tempseq))) {
         if (nchar(tempseq)>=100) {
            write.table(paste(">",temp[(j-1),1],"_",x,sep=""),output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
            write.table(tempseq,output_name,append=TRUE,quote=FALSE,row.names=FALSE,col.names=FALSE)
            x <- x + 1
         }
      } #2000B  
      tempseq <- NULL
      if (!(temp[j,1]==temp[(j-1),1])) {
        x <- 1
      }  
    } #1B 
  } # end for loop through rows (j)  
} # end for loop through files (i)         
          
