library(RPostgreSQL)
library(data.table)
#collect all ACS files into one folder
setwd("/home/aijing/Downloads/aff_download (3)")
#get file list
file_list <- list.files()
temp = grep("with_ann", file_list)
file_list = file_list[temp]
final = fread(file_list[1], skip = 1)
final$Id2<-as.character(final$Id2)
final = final[grep("Durham", final$Geography),]
final = as.data.frame(final)
final = final[, -grep("Margin of Error", colnames(final))]
final = final[,-c(1,3)]
i = 1

#merge all the files and remove all duplicates
for (file in file_list[-1]){
    i = i+1
    print(i)
    print(file)
    dataset <- fread(file, skip = 1)
    dataset$Id2<-as.character(dataset$Id2)
    dataset = dataset[grep("Durham", dataset$Geography),]
    dataset <- as.data.frame(dataset)
    dataset = dataset[, -grep("Margin of Error", colnames(dataset))]
    dataset = dataset[,-c(1,3)]
    final = merge(dataset[, c("Id2", setdiff(colnames(dataset),colnames(final)))], final, by = "Id2", all = TRUE)
  
}

#PostgreSQL has a limit in the number of fields (less than 1500), to store the data, 
#I transpose it and then write it in the database. Please transpose it back when you use ACS data table.
Id2 = final$Id2
final = t(final)
final = as.data.frame(final)
colnames(final) = Id2

#write it to the database ses
conn <- dbConnect(PostgreSQL(), user= "postgres", password="123456", dbname="ses")
dbWriteTable(conn, "ACS_2015_durham", final)