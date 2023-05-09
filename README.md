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

### classfy
https://github.com/luozhy88/forester/blob/main/classfication_example

## Note

target variable is as.number()+0.0001


