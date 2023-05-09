# forester

https://github.com/ModelOriented/forester
## test data
### regression
library(forester)
data(lisbon)
check <- check_data(lisbon, 'Price')

lisbon <- select(lisbon,
                 -c('Country', 'District', 'Municipality',
                    'AreaNet', 'PropertyType', 'Id'))



## Note

target variable is as.number()+0.0001


