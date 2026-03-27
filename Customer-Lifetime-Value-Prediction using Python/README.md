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

- Explore Customer Demographics

<img width="500" height="372" alt="image" src="https://github.com/user-attachments/assets/acc3d9bd-c5fc-4fe0-bbfa-94b1ca71018a" /><img width="500" height="372" alt="image" src="https://github.com/user-attachments/assets/3f71c4c1-ac74-4875-9b8c-5657b6e9b1c8" />

  
