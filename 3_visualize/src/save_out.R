# Save the processed data
save_out_processed_data <- function(data, out_filepath="3_visualize/out/model_summary_results.csv"){
  readr::write_csv(data, file = out_filepath)
  return(out_filepath)
}

# Save the model diagnostics
save_out_model_diagnostics <- function(data, out_filepath="3_visualize/out/model_diagnostic_text.txt"){
  render_data <- list(pgdl_980mean = filter(data, model_type == 'pgdl', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
                      dl_980mean = filter(data, model_type == 'dl', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
                      pb_980mean = filter(data, model_type == 'pb', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
                      dl_500mean = filter(data, model_type == 'dl', exper_id == "similar_500") %>% pull(rmse) %>% mean %>% round(2),
                      pb_500mean = filter(data, model_type == 'pb', exper_id == "similar_500") %>% pull(rmse) %>% mean %>% round(2),
                      dl_100mean = filter(data, model_type == 'dl', exper_id == "similar_100") %>% pull(rmse) %>% mean %>% round(2),
                      pb_100mean = filter(data, model_type == 'pb', exper_id == "similar_100") %>% pull(rmse) %>% mean %>% round(2),
                      pgdl_2mean = filter(data, model_type == 'pgdl', exper_id == "similar_2") %>% pull(rmse) %>% mean %>% round(2),
                      pb_2mean = filter(data, model_type == 'pb', exper_id == "similar_2") %>% pull(rmse) %>% mean %>% round(2))
  
  template_1 <- 'resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
    The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
    ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
    The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '
  
  whisker.render(template_1 %>% str_remove_all('\n') %>% str_replace_all('  ', ' '), render_data ) %>% cat(file = out_filepath)
  return(out_filepath)
}