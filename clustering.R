#installing libraries
library(tidyverse)
library(corrplot)
library(ggplot2)
library(gridExtra)
library(grid)
library(caret)
library(plyr)

#Importing Data
adv_data<-marketing_campaign
head(adv_data)

#data cleaning

#checking fro missing values
sapply(adv_data, function(x) sum(is.na(x)))

#removing missing values
adv_data<-adv_data%>%na.omit()

#calculating and creating a column for years
adv_data["Age"]<-2022-adv_data$Year_Birth

#removing the Year_Birth column
adv_data<-adv_data[,-2]

#removing the ID column
adv_data<-adv_data[,-1]

#creating children column
adv_data["children"]<-adv_data$Kidhome + adv_data$Kidhome

#removing kidhome and teenhome variables
adv_data<-adv_data[,-4:-5]

#creating a total spent coulumn
adv_data["totalspent"]<-adv_data$MntWines + adv_data$MntFruits + adv_data$MntMeatProducts + adv_data$MntFishProducts + adv_data$MntSweetProducts+ adv_data$MntGoldProds

#creating a total purchases coulum
adv_data["totalpurchases"]<-adv_data$NumDealsPurchases + adv_data$NumWebPurchases + adv_data$NumCatalogPurchases + adv_data$NumStorePurchases

#creating a total accepted column
adv_data["totalaccepted"]<-adv_data$AcceptedCmp3 + adv_data$AcceptedCmp4 + adv_data$AcceptedCmp5 + adv_data$AcceptedCmp1 + adv_data$AcceptedCmp2

#removing amounts spent columns
adv_data<-adv_data[,-6:-11]

#removing accepted camps columns
adv_data<-adv_data[,-11:-15]

#removing cost contact and revenue columns
adv_data<-adv_data[,-12:-13]

#removing cost contact and revenue columns
adv_data<-adv_data[,-4]


#changing Education to 1 for graduation, 2 for Master and 3 for PhD
adv_data$Education[adv_data$Education=="Basic"]<- 1
adv_data$Education[adv_data$Education=="2n Cycle"]<- 2
adv_data$Education[adv_data$Education=="Graduation"]<- 3
adv_data$Education[adv_data$Education=="Master"]<- 4
adv_data$Education[adv_data$Education=="PhD"]<- 5

#changing Marital_Status to 1 for single, 2 for together and married
adv_data$Marital_Status[adv_data$Marital_Status=="Single"]<- 1
adv_data$Marital_Status[adv_data$Marital_Status=="Together"]<- 2
adv_data$Marital_Status[adv_data$Marital_Status=="Married"]<- 2
adv_data$Marital_Status[adv_data$Marital_Status=="Divorced"]<- 1
adv_data$Marital_Status[adv_data$Marital_Status=="Widow"]<- 1
adv_data$Marital_Status[adv_data$Marital_Status=="YOLO"]<- 1
adv_data$Marital_Status[adv_data$Marital_Status=="Alone"]<- 1
adv_data$Marital_Status[adv_data$Marital_Status=="Absurd"]<- 1

#changing to factor variables
names <- c(1:2,10:11)
adv_data[,names] <- lapply(adv_data[,names] , factor)
str(adv_data)

#removing outliers on total spent
Q <- quantile(adv_data$totalspent, probs=c(.25, .75), na.rm = FALSE)
IQR <- IQR(adv_data$totalspent)
adv_data<- subset(adv_data, adv_data$totalspent > (Q[1] - 1.5*IQR) & adv_data$totalspent < (Q[2]+1.5*IQR))

#removing outliers on total purchases
Q1 <- quantile(adv_data$Income, probs=c(.25, .75), na.rm = FALSE)
IQR1 <- IQR(adv_data$Income)
adv_data<- subset(adv_data, adv_data$Income > (Q1[1] - 1.5*IQR1) & adv_data$Income < (Q1[2]+1.5*IQR1))

#removing outliers on Income
Q2 <- quantile(adv_data$totalpurchases, probs=c(.25, .75), na.rm = FALSE)
IQR2 <- IQR(adv_data$totalpurchases)
adv_data<- subset(adv_data, adv_data$totalpurchases > (Q2[1] - 1.5*IQR2) & adv_data$totalpurchases < (Q2[2]+1.5*IQR2))


#exploratory analysis
#correlation matrix#
cor1 = cor(data.matrix(adv_data))
corrplot.mixed(cor1, lower.col = "black", number.cex = 0.5)

#Income

mu <- ddplyr(adv_data, "Response", summarise, grp.mean=mean(Income))
head(mu)

p1<-ggplot(adv_data, aes(x=Income, color=Response)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Response),
             linetype="dashed")
# Continuous colors
p1 + scale_color_brewer(palette="Paired") +
  theme_classic()+theme(legend.position="top")
# Discrete colors
p1 + scale_color_brewer(palette="Dark2") +
  theme_minimal()+theme_classic()+theme(legend.position="top")
# Gradient colors
p1 + scale_color_brewer(palette="Accent") +
  theme_minimal()+theme(legend.position="top")

#total purchases

mu <- ddply(adv_data, "Response", summarise, grp.mean=mean(totalpurchases))
head(mu)

p2<-ggplot(adv_data, aes(x=totalpurchases, color=Response)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Response),
             linetype="dashed")
# Continuous colors
p2 + scale_color_brewer(palette="Paired") +
  theme_classic()+theme(legend.position="top")
# Discrete colors
p2 + scale_color_brewer(palette="Dark2") +
  theme_minimal()+theme_classic()+theme(legend.position="top")
# Gradient colors
p2 + scale_color_brewer(palette="Accent") +
  theme_minimal()+theme(legend.position="top")

#totalspent

mu <- ddply(adv_data, "Response", summarise, grp.mean=mean(totalspent))
head(mu)

p3<-ggplot(adv_data, aes(x=totalspent, color=Response)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Response),
             linetype="dashed")
# Continuous colors
p3 + scale_color_brewer(palette="Paired") +
  theme_classic()+theme(legend.position="top")
# Discrete colors
p3 + scale_color_brewer(palette="Dark2") +
  theme_minimal()+theme_classic()+theme(legend.position="top")
# Gradient colors
p3 + scale_color_brewer(palette="Accent") +
  theme_minimal()+theme(legend.position="top")


#Recency

mu <- ddply(adv_data, "Response", summarise, grp.mean=mean(Recency))
head(mu)

p4<-ggplot(adv_data, aes(x=Recency, color=Response)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=Response),
             linetype="dashed")
# Continuous colors
p4 + scale_color_brewer(palette="Paired") +
  theme_classic()+theme(legend.position="top")
# Discrete colors
p4 + scale_color_brewer(palette="Dark2") +
  theme_minimal()+theme_classic()+theme(legend.position="top")
# Gradient colors
p4 + scale_color_brewer(palette="Accent") +
  theme_minimal()+theme(legend.position="top")

#creating a visual grid of bar plots
grid.arrange(p1, p2, p3, p4, ncol=2)


#Model Building

#KNN Model

km.out=kmeans(adv_data,3,nstart=20)
km.out

#cretaing a cluster column
adv_data['cluster']=as.factor(km.out$cluster)

#creating scatterplots with the clusters
#income and total purchases scatterplot
p5<-ggplot(adv_data, aes(x=Income,y=totalpurchases, color=cluster)) +
  geom_point() + labs(title="Total purcahses")


#income and recency scatterplot
p6<-ggplot(adv_data, aes(x=Income,y=Recency, color=cluster)) +
  geom_point() + labs(title="Recency")

#income and total expenditure scatterplot
p7<-ggplot(adv_data, aes(x=Income,y=totalspent, color=cluster)) +
  geom_point() + labs(title="Total expenditure")

#income and number of monthly visits scatterplot
p8<-ggplot(adv_data, aes(x=Income,y=NumWebVisitsMonth, color=cluster)) +
  geom_point() + labs(title="Number of monthly visits")

#creating a grid of scatterplots
grid.arrange(p5, p6, p7, p8, ncol=2)



