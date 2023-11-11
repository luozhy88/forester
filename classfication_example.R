# install.packages('DALEX')
# install.packages('devtools')
# install_github('ModelOriented/forester')
library(devtools)
library(DALEX)
library(forester)
library(dplyr)
library(tibble)

source("function.R")

project_name=""
### classfy
iris5<-iris %>% dplyr::filter(Species != "virginica")
output2 <- forester::train(data = iris5,
                           y = 'Species',
                           bayes_iter = 0,
                           engine = c('ranger', 'xgboost', 'decision_tree'),
                           # advanced_preprocessing = TRUE,
                           verbose = TRUE,
                           random_evals = 3)


output2$score_test


# exp_list <- forester::explain(models = output2$best_models[[1]],
#                               test_data = output2$test_data,
#                               y = output2$y)

best_model_name=output2$score_test$engine[1]
# exp <- exp_list[[1]]
# p1 <- DALEX::model_parts(exp)
# plot(p1)



draw_Roc_plot=draw_roc_plot(best_models=output2$models_list,test_data=output2$test_data,observed=output2$test_observed)
draw_Confusion_matrix=forester::draw_confusion_matrix(best_models=output2$models_list,test_data=output2$test_data,observed=output2$test_observed)
# forester::draw_radar_plot(score_frame=output2$score_test,type="classification")

####Mean variable-importance calculated by using 10 permutations and the 1-AUC loss-function for the random forest model for the data.

pdf(glue::glue(project_name,"best.model_draw_feature_importance_plot.pdf"),width = 6,height = 3)
draw_feature_importance=draw_feature_importance3(best_models=output2$models_list,test_data=output2$test_data,y=output2$y)
dev.off() 

pdf(glue::glue(project_name,"best.model_draw_Roc_plot.pdf"))
draw_Roc_plot
dev.off() 
pdf(glue::glue(project_name,"best.draw_Confusion_matrix.pdf"))
draw_Confusion_matrix
dev.off() 


saveRDS(output2,glue::glue(project_name,"best.model_",best_model_name,".rds"))
write.csv(output2$score_test,glue::glue(project_name,"different.models.scores.csv"),row.names = F)
