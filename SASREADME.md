### 💳 Bank Transaction Fraud Detection using SAS
##### 📌 Project Overview

This project focuses on detecting fraudulent bank transactions using Exploratory Data Analysis (EDA) and Unsupervised Learning techniques in SAS.

The approach combines:

- Rule-based anomaly detection
- Behavioral pattern analysis
- Clustering techniques

to identify high-risk accounts and suspicious transactions.

##### 🎯 Objective

- Detect anomalous and potentially fraudulent transactions
- Identify high-risk accounts based on transaction behavior
- Use unsupervised learning to segment customers by fraud risk

##### 📊 Dataset
<img width="800" height="430" alt="image" src="https://github.com/user-attachments/assets/d4794f9c-b37f-4119-9593-6a622a083080" />

The dataset contains transaction-level information, including:

- Transaction ID
- Transaction Date & Time
- Transaction Amount
- Transaction Type (Debit/Credit)
- Channel (ATM, Online, etc.)
- Location
- Account ID
- Customer details (Age, Occupation, Balance)
- Login Attempts
- Account Balance

##### 🧰 Tools & Technologies
- SAS (Base SAS, PROC SQL, PROC SGPLOT)
- Data Step Processing
- Statistical Analysis
- Clustering (PROC FASTCLUS)

##### 🧹 Data Pre-Processing
- Extract Year and Month into New Columns

##### 🔍 Exploratory Data Analysis (EDA)
###### Check Structure of the Dataset
  
  <img width="620" height="245" alt="image" src="https://github.com/user-attachments/assets/f28bcb9e-995a-4184-92e6-0b83d70a7c30" />

The dataset is stored in the SAS library `Bank` under the table name `Transactions`.
- Total Observations: 50,000  
- Total Variables: 21
  
<img width="377" height="458" alt="image" src="https://github.com/user-attachments/assets/4ad99a1f-9353-4a0f-a619-aaf57074ca10" />


  ###### Summary Statistics

   <img width="590" height="215" alt="image" src="https://github.com/user-attachments/assets/0af93852-a4c3-45f6-8c71-49a8c63a4884" />
   
 - No missing values were identified
 - Transaction amounts vary widely, with some extreme values (outliers)
 - Customer ages range from 18 to 80, mostly centered around 45
 - Transaction dates span from 2020 to 2025
 - LoginAttempts are mostly 1, indicating low repeated logins

 ###### Visualizations
 - Check transactions by transaction type

   <img width="400" height="700" alt="image" src="https://github.com/user-attachments/assets/1e3d7b81-0cbf-43fd-b6d9-d3c367ae8547" />

   As shown in the plot above, the majority of transactions are debit transactions, indicating that most activity involves money leaving accounts.

- Transactions by Channel

  <img width="400" height="700" alt="image" src="https://github.com/user-attachments/assets/979114e6-e9b4-4a8a-adbe-3e92e93fb34f" />

  There's no clear variation among transaction channels.

- Transactions by Customer Occupation
  
  <img width="400" height="700" alt="image" src="https://github.com/user-attachments/assets/29d1bbc9-0892-4496-97e7-5c20af80a2a3" />

  The dataset indicates that students represent the largest customer group in terms of transaction count. In contrast, retired senior citizens show lower         transaction activity.
  
  - Check occupation consistency of Accounts by Transactions
     
  <img width="400" height="700" alt="image" src="https://github.com/user-attachments/assets/f4a06583-5628-45af-ac52-9fa99bdde375" />

  Out of all 495 distinct AccountIDs, only 34 accounts shows consistency in the customer occupation, suggesting potential anomalies or data entry inconsistencies    that could be relevant for fraud detection.
  
   - Check occupation inconsistency of Accounts by Year
 
  <img width="400" height="700" alt="image" src="https://github.com/user-attachments/assets/5a627665-d37c-4b3d-ae00-c614d2d93392" />
     
  #### 461 AccountIDs have inconsistent occupation status. Further Analysis will be conducted for those suspicious accounts.

  ##### Distribution of the Transaction Amount

  <img width="500" height="400" alt="image" src="https://github.com/user-attachments/assets/4b7faef4-6c45-4553-9f65-0bb9f066fd3e" /> <img width="500" height="400" alt="image" src="https://github.com/user-attachments/assets/9040d597-1048-4ef8-ad02-39f8bcf00499" />

 - Many transactions go above the upper bound, meaning these are unusually high transaction amounts
 - These can be potential fraudulent transactions, especially since they are for inconsistent accounts

 ##### Identify Outliers
 - Check Outliers per Account per Year
   
  Outliers were detected per AccountID per year to account for differences in transaction behavior across accounts and time. For each account-year combination, the interquartile range (IQR) method was used, and transactions above or below 1.5×IQR were flagged as potential anomalies. 

  This approach ensures that unusually high or low transactions are identified in the context of an account’s normal behavior.
  
  <img width="500" height="450" alt="image" src="https://github.com/user-attachments/assets/cd48c8b4-5bfb-46e7-92be-36f2f05db220" />

  The above plot shows the number of distinct AccountIDs with outliers flagged per year. Each bar represents accounts that had at least one transaction exceeding the calculated upper or lower bounds for that year. This visualization helps identify years with higher occurrences of anomalous transactions and highlights accounts that may require further investigation for potential fraud.

- Check Accounts with Number of Login Attempts higher than 3 and Flagged those transactions.
- Check Accounts with Rapid Transactions: If no of transactions per Day per Account is Greater than 5
- Calculate Fraud Score as sum of Outlier_Flagged, Login_Flagged and Transaction Freq_Flagged
  
 <img width="800" height="650" alt="image" src="https://github.com/user-attachments/assets/05133aaf-3f47-4eae-a193-39366a25530a" />

329 AccountIDs are high risk as it is identified as fraud accounts in multiple transactions.


#### Unsupervised Learning - Clustering--------------------------------------------------------------------------------------------------------------

- Standardized Transaction Data
      Variables are standardized using **PROC STDIZE** with range normalization.
- K-means clustering is applied using **PROC FASTCLUS** with 3 clusters.
- Risk Categorization: Clusters are mapped to fraud risk levels:
    Cluster 2 → Low Risk
    Cluster 1 → Medium Risk
    Cluster 3 → High Risk
  
<img width="1143" height="691" alt="image" src="https://github.com/user-attachments/assets/5368089b-119d-41e5-9c4c-020b45f44476" />

### Fraud Analysis Results

The following chart shows the number of accounts identified as fraud using different approaches:

<img width="1156" height="696" alt="image" src="https://github.com/user-attachments/assets/5660c140-feab-4b8d-a9cf-b377aea19464" />

  
