library(targets)
source("1_fetch/src/fetch_data.R")
source("2_process/src/make_eval_data.R")
source("3_visualize/src/create_plot.R")
source("3_visualize/src/save_out.R")

tar_option_set(packages = c("tidyverse", "sbtools", "whisker"))

list(
  # Get the data from ScienceBase
  tar_target(
    model_RMSEs_csv,
    fetch_data(out_filepath = "1_fetch/out/model_RMSEs.csv"),
    format = "file"
  ), 
  # Prepare the data for plotting
  tar_target(
    eval_data,
    process_data(in_filepath = model_RMSEs_csv),
  ),
  # Create a plot
  tar_target(
    figure_1_png,
    create_plot(data = eval_data, out_filepath = "3_visualize/out/figure_1.png"), 
    format = "file"
  ),
  # Save the processed data
  tar_target(
    model_summary_results_csv,
    save_out_processed_data(data = eval_data, out_filepath = "3_visualize/out/model_summary_results.csv"), 
    format = "file"
  ),
  # Save the model diagnostics
  tar_target(
    model_diagnostic_text_txt,
    save_out_model_diagnostics(data = eval_data, out_filepath = "3_visualize/out/model_diagnostic_text.txt"), 
    format = "file"
  )
)
