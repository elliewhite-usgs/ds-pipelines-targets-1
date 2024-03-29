library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)


# Get the data from ScienceBase
fetch_data <- function(out_filepath="1_fetch/out/model_RMSEs.csv"){
  mendota_file <- item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = out_filepath, overwrite_file = TRUE)
  return(mendota_file)
}