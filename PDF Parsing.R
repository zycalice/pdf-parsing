library(tidyverse)
library(readxl)
library(pdftools)
library(tm)
library(writexl)

readClipboard()
setwd("")

files<-list.files(pattern = "pdf$")

corp <- Corpus(URISource(files),
               readerControl = list(reader = readPDF))

corp <- tm_map(corp, removePunctuation, ucp = TRUE)

opinions.tdm <- TermDocumentMatrix(corp, 
                                   control = 
                                     list(stopwords = F,
                                          tolower = TRUE,
                                          stemming = TRUE,
                                          removeNumbers = TRUE,
                                          bounds = list(global = c(3, Inf)))) 

inspect(opinions.tdm[1:10,]) 

ft=findFreqTerms(opinions.tdm, lowfreq = 100, highfreq = Inf)
as.matrix(opinions.tdm[ft,]) 

ft.tdm <- as.matrix(opinions.tdm[ft,])
df.ft=data.frame(ft.tdm)