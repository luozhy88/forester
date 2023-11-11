
draw_feature_importance2=function (best_models, test_data, y) {
  explainer <- explain(best_models[[1]], test_data, y)
  feature_important = DALEX::model_parts(explainer = explainer)
  feature_important =feature_important %>% dplyr::filter(variable!=y)
  plt <- graphics::plot(feature_important,  max_vars = 10, show_boxplots = FALSE)
  # 过滤不包含"Species"的行
  plt <- plt + ggplot2::scale_color_manual(values = forester_palette()[[3]]) + 
    ggplot2::theme(plot.title = ggplot2::element_text(face = "bold", 
                                                      colour = forester_palette()[[1]], size = 20), line = ggplot2::element_line(color = forester_palette()[[2]]), 
                   plot.subtitle = ggplot2::element_text(colour = forester_palette()[[1]], 
                                                         size = 12), strip.text = ggplot2::element_text(colour = forester_palette()[[1]], 
                                                                                                        size = 12, hjust = 0), axis.title = ggplot2::element_text(face = "bold", 
                                                                                                                                                                  colour = forester_palette()[[1]], size = 14), 
                   axis.text = ggplot2::element_text(colour = forester_palette()[[5]], 
                                                     size = 10), legend.title = ggplot2::element_text(face = "bold", 
                                                                                                      colour = forester_palette()[[5]], size = 16), 
                   legend.text = ggplot2::element_text(colour = forester_palette()[[1]], 
                                                       size = 10))
  # plt$layers[[3]]$aes_params$fill <- forester_palette()[[1]]
  # plt$layers[[3]]$aes_params$colour <- forester_palette()[[1]]
  return(plt)
}




draw_feature_importance3=function (best_models, test_data, y) {
  explainer <- explain(best_models[[1]], test_data, y)
  feature_important = DALEX::model_parts(explainer = explainer,type = "variable_importance")
  feature_important =feature_important %>% dplyr::filter(variable!=y) %>% data.frame()
  results <- feature_important %>% group_by(variable,label) %>% summarise(mean_dropout_loss = mean(dropout_loss)) %>% data.frame() %>% dplyr::filter(variable!="_full_model_"& variable!="_baseline_")
  
  plt <-ggbarplot(results, "variable", "mean_dropout_loss", fill = "green", 
            orientation = "horiz",sort.val = "asc",
            xlab = "",ylab = "One minus AUC loss after permutations",
            title = results$label %>% unique() %>% Hmisc::capitalize()
            )
  show(plt)
  return(results)
}
