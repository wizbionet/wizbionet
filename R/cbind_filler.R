#' @export

cbind_filler<-function(input){ #1
input<-input

  for (a in 1:length(input)) {#2
    print(paste("data ", a))
    if(a==1)  {
      temp<-as.data.frame(input[[a]])
      output<- temp
      output<-as.data.frame(output)
    }


    if(a>1)  {
      temp0<- as.data.frame(input[[a]])
      temp1<-as.numeric(nrow(output)-nrow(temp0))
      temp2<-as.numeric(nrow(temp0)- nrow(output))


      if(temp1>temp2){ #nrow(output) > nrow(temp0)
        temp0[nrow(temp0)+temp1,] <- NA
        output<-cbind(output,temp0)
      }

      if(temp1<temp2){ #nrow(output) > nrow(temp0)
        output[nrow(output)+temp2,] <- NA
        output<-cbind(output,temp0)
      }

      if(temp1==temp2){#nrow(output) == nrow(temp0)
        output<-cbind(output,temp0)
      }


    }
  }
  names(output)<- gsub("input\\[\\[a\\]\\]", "", names(output))
  return(output)
}

