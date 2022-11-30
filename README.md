# An-Advertising-campaign-customer-clustering-analysis.

This model determines the clusters of cistomers based thier purchasing and activities patterns.
It employs KNN classifier using R. This is and unsupervised learning method 

#Exploratory data analysis
 correlation plot
 It is quiete clear that there is a moderate to semi strong relationship between income and purchases.
 There also seems to be a relationship between total expenditure and income, also number of children is moderately related to income.
 
 #visualization
 
 Income
 The histogram of income shows that there are more customers who did not respond to the last campaign than those who did.
 The data is bi-modal with slightly more customers with income of less than 6000
 
 Total purchases
 The data for total purchases is right skewed still with more customers not responding to the last campaign.
 Most customers have purchases of less than 15.
 
 Total spent
 The data for this variable is also right skewed with significantly small number of customers responding to the last campaign
 
 Recency
 The distribution of the data does not look normal.
 Most customers did not respond to the last campaign and these customers who did not respond are most customers who were long last seen making a purchase in store.
 
 #Modeling
 
 #KNN model
 The KNN model output
  ######################################################################################################
  
 Within cluster sum of squares by cluster:
[1] 36898591203   48529483983   49813555293
     (between_SS / total_SS =  85.6 %)
 
 ######################################################################################################
 
 #Scatterplots analysis
 
 Total purchases
 
 The second cluster of customers has the highest total purchases and these customers have the highest income, while the first cluster has the least total purchases with the least income.
 
 Recency
 
 There are fairly equal number of customer under the 3 clusters with the second clsuter having the most income, however recency and income do not have a relationship.
 
 Total spent
 There seems to be more customers who spend much money on prodcuts who have a high income. These are customers from the second cluster.
 
 Number of web vists
 Customers from the first cluster with the least income have the most montly web visists followed by the second cluster.
 
 #You can edit the code and do further analysis, you can create scatterplots to check the distribution of the data with clusters#
 
 *End*
