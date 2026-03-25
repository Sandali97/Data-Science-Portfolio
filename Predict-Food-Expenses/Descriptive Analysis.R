library(dplyr)
library(ggplot2)
library(corrplot)
library(tidyverse)
library(readr)
setwd("F:/New Volume/3rd Year_ii/Statistical Learning/Family Income and Expenditure")
Family_Income_and_Expenditure <- read_csv("Family Income and Expenditure.csv")
View(Family_Income_and_Expenditure)
attach(Family_Income_and_Expenditure)
#creating sub-data set 
df=data.frame(`Bread and Cereals Expenditure`,`Total Rice Expenditure`,
              `Meat Expenditure`,`Total Fish and  marine products Expenditure`,
              `Fruit Expenditure`,`Vegetables Expenditure`,`Total Household Income`,
              Region,`Agricultural Household indicator`,`Medical Care Expenditure`,
              `Total Number of Family members`,`Members with age less than 5 year old`,
              `Members with age 5 - 17 years old`)

View(df)
colnames(df) <- c('brd_cer','rice','meat','fish','fruit','veg','income','region',
                  'agri_ind','med','t_mem','babies','kids')
View(df)
detach(Family_Income_and_Expenditure)
#finding missing values
sum(is.na(df))
#No missing value in the dataset
#splitting dataset into test and train
set.seed(111)
sample_size = round(nrow(df)*.80) # setting what is 80%
index = sample(seq_len(nrow(df)), size = sample_size)
train =df[index, ]
test = df[-index, ]
attach(train)
#checking for outlier and distribution of expentitures
library(ggplot2)
#box plots of income
ggplot(train,aes(x="", y=income))+
  geom_boxplot(outlier.colour="red",outlier.shape=10,outlier.size=3)
#box plots of medical care expenditure
ggplot(train,aes(x="", y=med))+
  geom_boxplot(outlier.colour="red",outlier.shape=10,outlier.size=3)
#box plots of rice expenditure
ggplot(train,aes(x="", y=rice))+
  geom_boxplot(outlier.colour="red",outlier.shape=10,outlier.size=3)
#histogram for income
qplot(data = train, x = income) + ylab("Number of Families")
qplot(data = train, x = income) + ylab("Number of Families")+xlim(c(0,2.5*10^6))
#justifying after cutting from 1.5*10^5
#histogram of abnormal dataset
qplot(data = train, x = income) + ylab("Number of houses")+
  xlim(c(1.5*10^6, 1.2*10^7))

#excluding some outliers 
df2<-subset(train, income<=1.5*10^6)
View(df2)
detach(train)
attach(df2)
#checking correalations between expenditures
expnd=df2[,1:6]
expnd
install.packages("corrplot")
library(corrplot)
col <- colorRampPalette(c( "#e32510", "#83ff36","#faf570", "#bee5f7", "#bef7cd"))
corrplot(cor(expnd),method="color", type="lower", order="hclust",
         col=col(200),addCoef.col = "black",)
#has the realtionship between brd_cer and rice is strong correlatioin coefficient
#scatter plot between brd_cer vs rice
library(tidyverse)
#theme_set(theme_bw())
ggplot(train,aes(x=rice,y=brd_cer)) +geom_point(alpha=0.3) + labs(x="rice", 
  y= "brd_cer",title="rice vs brd_cer")+xlim(c(0,3*10^5))+ylim(c(0,4*10^5))+
  geom_smooth(method=lm,se=FALSE)
#total food expenditure
food_exp=brd_cer+rice
df3=data.frame(food_exp,income,region,agri_ind,med,t_mem,babies,kids)
detach(df2)
attach(df3)
View(df3)
#normal food expenditure cure
ggplot(df3, aes(x=food_exp)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666")

summary(food_exp)

#logged transformed curve
ggplot(df3, aes(x=food_exp)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666")+
  scale_x_log10()
#food expenditure variation with region
c(unique(region))
#shows 16 regions
library(dplyr)
#violin plots for region
df3$reg=recode(region,"Caraga"=1,"III - Central Luzon" =2,"ARMM"=3,
"II - Cagayan Valley"=4,"NCR"=5,"IVA - CALABARZON"=6,"VIII - Eastern Visayas"=7,
"IVB - MIMAROPA"=8,"V - Bicol Region"=9,"VII - Central Visayas"=10,
"X - Northern Mindanao"=11,"IX - Zasmboanga Peninsula"=12,
"CAR"=13,"I - Ilocos Region"=14,"XII - SOCCSKSARGEN"=15,"XI - Davao Region"=16,
               "VI - Western Visayas"=17)
ggplot(df3, aes(x=as.character(reg), y=food_exp,fill=as.character(reg))) +
  geom_violin(trim=FALSE)+
  ylim(c(0,1.4*10^5))+geom_boxplot(width=0.2)+scale_fill_manual(values=c(
    "#26ed26","#f525c8","#f525c8","#26ed26","#fffb24","#26ed26","#26ed26","#26ed26"
    ,"#6f26ed","#fc311e","#fffb24","#fc311e","#6f26ed","#26ed26","#26ed26",
    "#fc311e"))+labs(x="Region", 
                     y= "food expenditure",title="food expenditure based on Region")+
  scale_x_discrete(limits=c("1","13", "17", "7","8","15","16","14","4","10","12","2"
                            ,"6","5","3","9"))
#food expenditure variation with agriculture
ggplot(df3, aes(x=as.character(agri_ind), y=food_exp,fill=as.character(agri_ind))) +
  geom_violin(trim=FALSE)+ylim(c(0,1.4*10^5))+geom_boxplot(width=0.2)+
  scale_fill_manual(values=c("#999999","#E69F00", "#56B4E9"))+
  labs(x="Agricultural Indicator",y= "food expenditure",
       title="food expenditure based on Agricultural Indicator")

#scatter plot income vs medical care expenditure
ggplot(df3,aes(x=income,y=med)) +geom_point(alpha=0.3) + labs(x="income",
 y= "medical care expenditure",title="income vs medical care expenditure")+
  xlim(c(0,3*10^5))+ylim(c(0,4*10^5))+geom_smooth(method=lm,se=FALSE)
cor(income,med)
#scatter plot for food expenditure & number of family members
ggplot(df3,aes(x=food_exp,y=t_mem)) +geom_point(alpha=0.3) + labs(x="Food Expenditure",
y= "Number of members in a family",title="food expenditure vs No of family members")+
  xlim(c(0,3*10^5))+ylim(c(0,30))+geom_smooth(method=lm,se=FALSE)
cor(food_exp,t_mem)

