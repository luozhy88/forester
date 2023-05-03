# forester
## test data

library(forester)
data(lisbon)
check <- check_data(lisbon, 'Price')

lisbon <- select(lisbon,
                 -c('Country', 'District', 'Municipality',
                    'AreaNet', 'PropertyType', 'Id'))


output_2 <- train(data         = lisbon,
                  y            = 'Price',
                  bayes_iter   = 0,
                  random_evals = 1,
                  engine = c('xgboost'),
                  # engine = c('ranger', 'xgboost', 'decision_tree'),
                  advanced_preprocessing = TRUE,
                  verbose      = T,
                  sort_by      = 'mse')

output_2$score_test

## Note

target variable is as.number()+0.0001


