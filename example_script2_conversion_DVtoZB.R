
library(tibble)
library(data.table)
library(stringr)

input_folder<-"/path/to/script1/output/"
input_date<-"211126" # put experimental data here - need to change TWICE BELOW!!

dir <- (input_folder)
files <- list.files(path= dir, pattern = "x*") # rename depending on what files are called
files=paste0(input_folder, files)
exp_date = input_date
dir.create(paste0(input_folder, '211126_01')) # change the date here to create new directory

for (i in 1:length(files)) {
  dat <- read.csv(file = files[i], header = FALSE, sep="\t")
  colnames(dat) = c("time", "data1", "location") # give names to columns
  dat$location <- str_pad(dat$location, 3, pad = "0") # add zeros to have the same number of digits from 1 to 96
  dat = dat[ -c(1) ]
  colnames(dat) = c("data1", "location", "time") # rename 
  dat = dat[,c(3,2,1)] # reorder
  dat <- dat %>%
    add_column(abstime=dat$time, .before='time') %>% # add other columns needed by Zebrabox 
    add_column(channel=0, .after='time') %>%
    add_column(type=101, .after='channel')
  dat$location <- paste("C", dat$location, sep = "") # adds a C before the larvae IDs
  dat$data1 <- round(dat$data1)
  fname <- paste0(file.path(file.path(input_folder, '211126_01', fsep=''), # change the date here again 
                            paste0(exp_date, '_01_raw_', i, '.xls')))
  fwrite(dat, file=fname, sep='\t', row.names=FALSE, quote=FALSE)
}
