##AMSA Assignment
#Use of data from US state prison regarding the interning prisoners 

#load packages
install.packages("naniar")
library(naniar)


#set specific environment
setwd("C:/Users/antoi/OneDrive/Documentos/Bioinformatics/M2/M2_Q1/AMSA/")

#load the 
load("cumulative_2006-2020.rda")
load("04572-0002-Data.rda")
data = as.data.frame(da04572.0002)
nrow(data)#14499 prisoners that took the survey
ncol(data)#3374 questions/confirmations drafted during the survey 
View(data)

#replace 'NA' string with NA values
data %>% replace_with_na(replace = list(x = 'NA'))
sum(is.na(data$V0010))#a lot of missing values, 66% is missing
missing_col = sapply(data, function(x) sum(is.na(x))/14499)
missing_col = as.data.frame(missing_col)
colnames(missing_col)[1] = 'MissingPercentage'

#subset only the column having less than 10% missing data
nonmissing_col = subset(missing_col, missing_col[, 1] < 0.1)
nonmissing_col['colName'] = row.names(nonmissing_col)
nrow(nonmissing_col)#735 columns that have less than 10% missing
View(nonmissing_col)

data_sub = data[, nonmissing_col$colName]
View(data_sub)

subset = c("V0004", 'V0013', "V0018", "V0045", "V0046", "V0058", "V0059", "V0269", "V0270", "V0641", "V0642", "V0643", "V0648", "V0671",
           "V0712", "V0739", "V0740", "V0741", "V1056", "V1139", "V1740", "V1987", "V2188", "V2289", "V2409")
data_subset = as.data.frame(data[subset])
View(data_subset)
data_subset = na.omit(data_subset, axis = 1)
View(data_subset)

#explore data
row.names(data)
