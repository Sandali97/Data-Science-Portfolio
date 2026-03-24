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

 ##### Churn vs. Customer Demographics
 <img width="800" height="650" alt="image" src="https://github.com/user-attachments/assets/73bd24c1-d58f-4620-8bf6-c46acc17cdcf" />
 
Above bar charts shows the distribution of customer demographics such as Gender, Partner, Dependent, Senior Citizen with Churn. Although the majority of customers have partners, those without partners contribute a higher proportion to churn (32.9%), indicating that customers without partners are more likely to leave.

From the Dependents vs. Churn analysis, it is evident that customers who churned are less likely to have dependents. This suggests that individuals without family responsibilities may be more flexible in switching service providers.

In terms of age, non-senior customers exhibit a higher churn rate compared to senior citizens. This indicates that older customers tend to be more loyal or stable in their telecom subscriptions.

On the other hand, the churn distribution across gender appears relatively similar, suggesting that gender does not have a significant impact on customer churn in this dataset.

##### Churn Vs. Service Information
<img width="1053" height="788" alt="image" src="https://github.com/user-attachments/assets/59442f57-111e-495c-b0b0-1eace446e6dd" />

The plots show a clear relationship between service usage and customer churn. Customers using fiber optic internet have a higher churn rate compared to DSL or no internet users.

For services like Online Security, Backup, Device Protection, and Tech Support, customers without these features are more likely to churn, while those who subscribe tend to stay longer. This highlights the importance of value-added services in improving retention.

The impact of Streaming TV and Movies is less strong but follows a similar pattern, with slightly higher churn among non-users.

Overall, customers with fewer or no additional services are more likely to leave, suggesting that increased service engagement helps reduce churn.

### Distribution of Numerical Variables
1. **Number of Months with Company**
 <img width="500" height="332" alt="image" src="https://github.com/user-attachments/assets/18f0ea2b-3f7c-4a8e-a90e-29c54f5aee02" />

This histogram shows bimodal distribution. We can observe that high number of short term customers who churn within the first 5 months. Between 10 and 60 months,represents customers who likely survived the initial onboarding and are now in the middle of long-term contracts (like 24-month plans). Churn here can be low because breaking these contracts often involves high fees. The spike at the far right represents "Sticky" customers. These are people who have likely finished their initial contracts and stayed on month-to-month or renewed multiple times.


2. **Monthly Chargers**
<img width="500" height="332" alt="image" src="https://github.com/user-attachments/assets/46f80b09-9916-4d2b-8ea1-a3015124e278" />

The highest spike on the far left represents roughly 1,200 customers paying minimal monthly fees. Looking at the Tenure distribution, these customers are high-risk, as their tenure is less than 5 months.
Around 600 customers pay $80 per month, while fewer than 200 pay the highest fee of $120. Overall, the number of customers increases from $40 to $80 and then starts to decline beyond $80.

3. **Total Chargers**
<img width="500" height="332" alt="image" src="https://github.com/user-attachments/assets/627d906d-e68d-411e-8a1d-64ad207efc6c" />

Histogram of total charges follows a highly right-skewed (positive skew) distribution.The most frequent value is at the far left, with nearly 1,900 customers having very low total charges. As the total charges increase, the number of customers steadily declines, stretching all the way past $8,000.

4. **Relationship between Tenure, Monthly Charges and Total Charges**
<img width="500" height="332" alt="image" src="https://github.com/user-attachments/assets/2afbae15-fd40-428f-b665-cdd9d0ad434a" />

Tenure and Total Charges show a strong positive correlation, indicating that customers with longer tenure tend to incur higher total charges. These customers might have long term contracts with high packages. Total  Charges and Monthly charges shows moderate positive relationship with 0.65 correlation value as Customers paying higher monthly fees tend to accumulate higher total charges over time. However, tenure and Monthly charges have 0.25 correlation suggesting that monthly fees are relatively independent of how long a customer stays.

### Advanced Analysis
1. Encode Object Type Variables using LabelEncoder().
2. Split dataset to train and test handling the imbalance of the dataset.

    **Distribution of Churn**
   
   <img width="400" height="322" alt="image" src="https://github.com/user-attachments/assets/19587cb5-92dd-4572-a26b-d9bbb1375df1" />
   
   **Stratify ensures proportion of each class y is the same in both train and test sets**
   
   <img width="600" height="342" alt="image" src="https://github.com/user-attachments/assets/21956a17-7b54-4948-ab48-5abd68f9dcd5" />

4. Standardize numerical variables.
5. Fit Models.
   
   <img width="615" height="315" alt="image" src="https://github.com/user-attachments/assets/2dc4840b-7c7f-4dcc-ae5e-ff488b4c7a71" />


- The dataset seems imbalanced (class 0 has higher frequency than class 1). However, imbalance has been address by the Stratify.
- Accuracy favors the majority class, so we should focus more on F1-score, precision, and recall for class 1.
- Logistic Regression is currently the best choice for this dataset because it has the highest F1-score for the minority class while maintaining strong performance for the majority class.
   
