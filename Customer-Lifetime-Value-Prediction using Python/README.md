## 📊 FinTech (Digital Wallet)Customer Lifetime Value Prediction 

#### 📝Project Overview

This project demonstrates how to predict Customer Lifetime Value (CLV) using Random Forest Regression. The workflow includes:

- Data Preprocessing – Handling missing values, encoding categorical variables, and scaling if necessary.
- Feature Selection – Selecting the most important features using Random Forest feature importance, RFE, or Lasso.
- Model Training – Training a Random Forest Regressor to predict CLV.
- Hyperparameter Tuning – Optimizing model performance using RandomizedSearchCV.
- Model Evaluation – Calculating R², MAE, MSE, RMSE, and MAPE to assess accuracy.

#### 📁Dataset 

Kaggle: https://www.kaggle.com/datasets/harunrai/fintech-customer-life-time-value-ltv-dataset
The dataset contains  7,000 observations with 20 features, capturing customer demographics, transaction history, engagement metrics, app usage patterns, and support interactions. 
It is designed to help predict Customer Lifetime Value (LTV) for users of digital wallets, such as PayTM and Khalti.

| Feature                       | Description                                                 |
| ----------------------------- | ----------------------------------------------------------- |
| `Customer_ID`                 | Unique identifier for each customer                         |
| `Age`                         | Age of the customer (18-70 years)                           |
| `Location`                    | Geographical location: Urban, Suburban, Rural               |
| `Income_Level`                | Income classification: Low, Middle, High                    |
| `Total_Transactions`          | Total number of transactions made by the customer           |
| `Avg_Transaction_Value`       | Average value of each transaction (in Rupees)               |
| `Total_Spent`                 | Total amount spent by the customer (in Rupees)              |
| `Max_Transaction_Value`       | Highest single transaction value (in Rupees)                |
| `Min_Transaction_Value`       | Lowest single transaction value (in Rupees)                 |
| `Active_Days`                 | Number of days the customer has been active on the platform |
| `Last_Transaction_Days_Ago`   | Days since the customer’s last transaction                  |
| `Loyalty_Points_Earned`       | Total loyalty points earned by the customer                 |
| `Referral_Count`              | Number of new customers referred by the user                |
| `Cashback_Received`           | Total cashback received by the customer                     |
| `App_Usage_Frequency`         | Frequency of app usage: Daily, Weekly, Monthly              |
| `Preferred_Payment_Method`    | Most frequently used payment method                         |
| `Support_Tickets_Raised`      | Number of support tickets raised by the customer            |
| `Issue_Resolution_Time`       | Average time taken to resolve issues (hours)                |
| `Customer_Satisfaction_Score` | Customer satisfaction score (1-10)                          |
| **`LTV`**                     | **Target variable: estimated Lifetime Value of the customer**|


#### ✅Objectives of the Study

- Predict Customer Lifetime Value (LTV): Build a regression model to accurately estimate future value.
- Explore customer demographics, transaction history, and engagement metrics.
- Identify key factors associated with LTV
- Segment Customers based on behavior and engagement metrics to support targeted marketing and retention strategies.


#### 🛠️Technologies & Tools
- Python 3.x
- Libraries: pandas, numpy, matplotlib, seaborn, scikit-learn
- Models: Random Forest Regressor, Lasso Regression (for feature selection)
- Evaluation Metrics: R², MAE, MSE, RMSE, MAPE

#### Project Workflow
##### 01. Data Preprocessing

- Identify Outliers
- Check Missing Values
- Check Duplicates
- Check Multicollinearity
    
##### 02. 🔍 Exploratory Data Analysis 
- Identify the relationship between features

  <img width="800" height="529" alt="image" src="https://github.com/user-attachments/assets/b190d690-de75-4e58-9b63-df11b3521bd2" />

  ###### 1️⃣Strongest correlations with LTV:
  ###### 01. Total_Transactions → 0.65 ✅
  ###### 02. Avg_Transaction_Value → 0.66 ✅
  ###### 03. Total_Spent → 1.0 (perfectly correlated, probably derived from transactions × avg value)
  ###### 04. Max_Transaction_Value / Min_Transaction_Value → 0.54-0.54

  ###### 2️⃣Weak correlation with:
  ###### Active_Days, Referral_Count, Cashback_Received, Issue_Resolution_Time → near 0 Customer_Satisfaction_Score → near 0
  ###### These may have non-linear effects or contribute little directly to LTV.

  ###### 3️⃣High multicollinearity:

  ###### Total_Spent, Avg_Transaction_Value, Total_Transactions, Max/Min_Transaction_Value are highly correlated.
  ###### Using all in a linear regression could cause instability.

##### Explore Customer Demographics

<img width="500" height="372" alt="image" src="https://github.com/user-attachments/assets/acc3d9bd-c5fc-4fe0-bbfa-94b1ca71018a" /><img width="500" height="372" alt="image" src="https://github.com/user-attachments/assets/3f71c4c1-ac74-4875-9b8c-5657b6e9b1c8" />

 Age of customers distributed from 10 -70 and the histogram shows a multimodal distribution, indicating that there are multiple distinct age groups among customers.
 This suggests that the digital wallet platform is used by different segments. 
 
 In the distribution of Income Level by Location,The data shows a relatively even spread, with most counts falling between 730 and 830. Notably:
 - Urban areas have the highest count of Low income individuals.
 - Rural areas have the highest count of High income individuals.
 - Middle income counts are very similar across all three locations, each hovering around 800.

##### Explore Transaction Indicators

  <img width="1115" height="323" alt="image" src="https://github.com/user-attachments/assets/b2b2cdd1-ecd4-494b-b452-afa3cab34df0" />
Total Transactions and Avg Transaction value plots highlights an uniform distribution showcasing the even spread of customers.

When analyzing Max transaction value and min transaction value, it's noticable that the customers with high maximum transaction values also tend to have high minimum transaction values, indicating that their transaction range is consistently high.This pattern suggests that high-spending customers maintain consistently larger transaction amounts, which could be a strong indicator of higher Customer Lifetime Value (CLV).

##### Relationship b/w Transactions and Expenditures
<img width="1111" height="319" alt="image" src="https://github.com/user-attachments/assets/8e7eda26-f736-463e-9e59-c8d08c478cd5" />

As shown in above plots:  When "Total Spent" increases, the minimum possible value for your features (Transactions, Avg, Max, Min) also has to increase.

Max & Min Transaction Value vs. Total Spent: A high one-time purchase (Max) or a high starting price (Min) doesn't automatically guarantee a high CLV. Frequency (Total Transactions) seems to be a more reliable indicator of total value in this dataset.

##### Customer Behavior Analysis with RFM Style

<img width="1105" height="315" alt="image" src="https://github.com/user-attachments/assets/a0e5927a-6820-4624-99b0-79620c54fda6" />

Above scatter plots represent a classic RFM (Recency, Frequency, Monetary) framework to analyze Lifetime Value (LTV).

**Recency:** No Correlation. High-value customers (LTV) are just as likely to have shopped 300 days ago as yesterday. Recency isn't a strong predictor of value here.

**Frequency:** Positive Correlation. As transaction counts increase, the "floor" for LTV rises. More frequent shoppers generally result in higher lifetime value, though the spread (variance) is wide.

**Monetary:** Perfect Correlation. This is a straight line because "Total Spent" is likely how you calculated LTV. It’s your most powerful (and perhaps redundant) feature for this specific calculation.
