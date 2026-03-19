## 📊Telecom Customer Churn Prediction Using Machine Learning
#### This project focuses on predicting customer churn in the telecom industry using machine learning techniques.

What is Churn? Customer churn refers to the likelihood of customers discontinuing a service, which directly impacts business revenue and growth.

The objective of this project is to build a predictive model that identifies customers at high risk of churn based on their demographic information, service usage patterns, and billing details. By analyzing these factors, telecom companies can take proactive measures to improve customer retention and reduce churn rates.

#### 📁 Dataset Overview
Link to the Dataset: https://www.kaggle.com/datasets/blastchar/telco-customer-churn
<img width="992" height="320" alt="image" src="https://github.com/user-attachments/assets/1b949409-6219-4b1f-9edf-ca54b446169e" />

No of Observations: 7043 || No of Features: 21

##### 🎯 Target Variable
- Churn: Whether customer left (Yes/No)

##### 👤 Customer Demographics
- Gender – Male/Female
- SeniorCitizen – 1 (Yes), 0 (No)
- Partner – Has partner or not
- Dependents – Has dependents or not

##### 📞 Service Information

- PhoneService
- MultipleLines
- InternetService (DSL, Fiber optic, No)
- OnlineSecurity
- OnlineBackup
- DeviceProtection
- TechSupport
- StreamingTV
- StreamingMovies

##### 📄 Account Information

- tenure – Number of months with company
- Contract – Month-to-month / One year / Two year
- PaperlessBilling
- PaymentMethod

##### 💰 Billing Information

- MonthlyCharges
- TotalCharges


#### 🧹 Data Preprocessing
- Dropped Customer ID Column
- Convert TotalCharges to numeric type
- Identified missing values and impute with mean
- Remove rows with tenure value is 0.
- Convert SeniorCitizen variable to an Object type.
- Encoded categorical variables (Label Encoding / One-Hot Encoding)

#### 🔍 Key Insights from EDA

##### Distribution of the Target Variable.
Below is the Distribution of the Target Variable.

<img width="510" height="332" alt="image" src="https://github.com/user-attachments/assets/c8a6ddf9-c3fe-4d56-97c3-c28135d12002" />
 
 The bar chart shows that the majority of customers are still taking the services while 1869 customers have already left.

 ##### Churn vs. Senior Citizen
 <img width="548" height="351" alt="image" src="https://github.com/user-attachments/assets/8818c232-dc65-4eab-961e-216eb54ae7f3" />

The bar chart indicates that senior citizens are more likely to remain customers, while non-senior customers show a higher proportion of churn. This suggests that older customers tend to have more loyalty or stability in their telecom subscriptions.

##### 
