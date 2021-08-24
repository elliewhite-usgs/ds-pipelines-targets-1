library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)


# Get the data from ScienceBase
fetch_data <- function(){
  out_dir="personal/training/pipelines/ds-pipelines-targets-1/1_fetch/out/"
  mendota_file <- file.path(out_dir, 'model_RMSEs.csv')
  item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
  return(mendota_file)
}