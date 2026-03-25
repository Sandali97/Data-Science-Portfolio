## 🏦 Bank Loan Prediction – Thera Bank
This project focuses on predicting which customers of Thera Bank are most likely to accept a personal loan offer. The bank has a growing customer base, primarily liability customers (depositors). The goal is to identify potential borrowers among existing depositors to increase loan uptake while minimizing marketing costs.

A previous campaign run by the bank achieved a 9% conversion rate, motivating the bank to improve targeting through predictive modeling.

### ⚙️ Business Objective
Identify depositors with a high probability of accepting a personal loan.

### 📊 Dataset Description

The dataset contains information about customer demographics, financials, and banking behavior. Below is a summary of the columns:

| Column                 | Description                                                                                 |
| ---------------------- | ------------------------------------------------------------------------------------------- |
| **ID**                 | Customer ID                                                                                 |
| **Age**                | Customer's age (in completed years)                                                         |
| **Experience**         | Years of professional experience                                                            |
| **Income**             | Annual income of the customer ($000)                                                        |
| **ZIPCode**            | Home address ZIP code                                                                       |
| **Family**             | Family size of the customer                                                                 |
| **CCAvg**              | Average monthly credit card spending ($000)                                                 |
| **Education**          | Education level: 1 – Undergrad, 2 – Graduate, 3 – Advanced/Professional                     |
| **Mortgage**           | Value of house mortgage if any ($000)                                                       |
| **Personal Loan**      | Target variable: 1 if customer accepted the personal loan in the last campaign, 0 otherwise |
| **Securities Account** | Does the customer have a securities account with the bank? (1 = Yes, 0 = No)                |
| **CD Account**         | Does the customer have a certificate of deposit (CD) account? (1 = Yes, 0 = No)             |
| **Online**             | Does the customer use internet banking facilities? (1 = Yes, 0 = No)                        |
| **CreditCard**         | Does the customer use a bank-issued credit card? (1 = Yes, 0 = No)                          |

### 🔍 Exploratory Data Analysis (EDA)

#### Relationship Between Variables
  
<img width="800" height="600" alt="image" src="https://github.com/user-attachments/assets/3ad54c44-6c62-4ab3-ba4c-23a9094e8d9d" />

  - Personal Loan is Highly Positively correlated with Income, CD_Account and CCAvg.
  - Age and Experience are highly positively correlated (0.99), which suggests strong multicollinearity since experience naturally increases with age.
  - CCAvg has a moderate positive correlation (0.58) with Income, implying that customers with higher income tend to spend more on credit cards.

#### Distribution of Zip Code

<img width="800" height="361" alt="image" src="https://github.com/user-attachments/assets/20b030d6-e8a0-41c7-a54b-0ffaff0a5112" />

ZIP Code value of 9307 seems to be an extreme value and removed from the dataset for more accurate outputs.

#### Distribution of Education

<img width="400" height="350" alt="image" src="https://github.com/user-attachments/assets/63ed6b3a-ef24-45be-b2a5-78c0e2513675" />

Majority of the customers are undergraduates while graduates and professional customers are range between 1200-1500.

#### Customer Account Information

<img width="580" height="387" alt="image" src="https://github.com/user-attachments/assets/e7178a96-25b9-46e4-b4a3-163057eb3846" />

The plots indicate that the majority of customers do not have a Securities Account, Certificate of Deposit (CD Account), or a Credit Card. However, most customers actively use online banking services. Additionally, the number of customers who accepted the personal loan is relatively low, highlighting an imbalanced target distribution.

#### Distribution of Experience

<img width="580" height="387" alt="image" src="https://github.com/user-attachments/assets/de20fc36-3746-4328-a7ae-6c8b22b46e7e" />

Since the Experience distribution shows values below zero, it indicates the presence of negative entries in the data.
As experience cannot be negative in reality, the absolute values were taken to correct this inconsistency.

#### Distribution of Mortgage
<img width="650" height="400" alt="image" src="https://github.com/user-attachments/assets/f1aab9e7-1403-4ae4-93d3-abc0381cd742" />

Outliers in the Mortgage variable were identified using the Z-score method, where values with a Z-score greater than 3 were considered extreme.
These outliers were removed from the dataset to reduce their impact on model performance.
The dataset index was then reset to maintain consistency after dropping the observations.

#### Distribution of Income Vs.Personal Loan

<img width="650" height="400" alt="image" src="https://github.com/user-attachments/assets/7189a3fc-a323-44e1-874d-504754a37b05" />

Customers with high incomes are more likely to purchase a personal loan.

#### Distribution of CCAvg Vs.Personal Loan

<img width="650" height="400" alt="image" src="https://github.com/user-attachments/assets/f1edd063-709c-454c-ad54-6d8de56e54f5" />

Customers who spend more on credit cards are more likely to take out personal loans.
In the dataset, CCAVG represents average monthly credit card spending, but Income represents the amount of annual income.
To make the units of the features equal, we convert average monthly credit card spending to annual.

#### Distribution of the Target Variable

<img width="650" height="400" alt="image" src="https://github.com/user-attachments/assets/5dc21ce9-5a81-4706-8927-17f6a1aded1f" />

Distribution of the Personal Loan shows imbalance as majority of customers did not accept the Personal Loan compared to the ones who accepted the Loan.

**Highlights of EDA**
- The ZIPCode 9307 was removed as it represents an extreme/outlier value.
- Negative values in the Experience feature were corrected by applying the absolute function.
- Outliers in the Mortgage variable were detected using the Z-score method (threshold > 3) and removed.
- The CCAvg feature was converted from monthly to annual values for better consistency with income.
- Due to the high correlation between Age and Experience, the Experience variable was dropped to avoid multicollinearity.

### 📈 Advanced Analysis

1. Apply LabelEncoder to all Object Type Variables

<img width="1106" height="221" alt="image" src="https://github.com/user-attachments/assets/7228eee8-1798-4152-a4e4-c94d419b26aa" />

2. Split Data into Train and Test

<img width="1106" height="300" alt="image" src="https://github.com/user-attachments/assets/448080f6-587a-4a0b-80d9-4158ef6d7269" />

The Samples are randomly divided in a way that proportion of each category remains same in each set.

3. Standardize Numerical Features: 'Age','Income','Family'	,'CCAvg','Mortgage'
4. Fit Models
   - **Logistic Regression**
     
     #### Baseline Model (No Tuning, No Feature Selection) - 95% Accuracy
      | Class       | Precision | Recall | F1-Score | 
      | ----------- | --------- | ------ | -------- | 
      | 0 (No Loan) | 0.96      | 0.98   | 0.97     | 
      | 1 (Loan)    | 0.75      | 0.59   | 0.66     |
     
      The baseline Logistic Regression model achieved good overall accuracy (95%) but showed moderate ability to identify potential loan customers (class 1) with an F1-score of 0.66.

     #### After Hyperparameter Tuning ✅ - 95% Accuracy
      | Class       | Precision | Recall | F1-Score | 
      | ----------- | --------- | ------ | -------- | 
      | 0 (No Loan) | 0.96      | 0.98   | 0.97     | 
      | 1 (Loan)    | 0.74      | 0.60   | 0.66     |
     
      slightly improved recall and F1-score for class 1, increasing the model’s effectiveness in identifying potential borrowers without impacting majority class performance.

     #### After Tuning + Feature Selection ⚠️ - 94% Accuracy
      | Class       | Precision | Recall | F1-Score | 
      | ----------- | --------- | ------ | -------- | 
      | 0 (No Loan) | 0.96      | 0.98   | 0.97     | 
      | 1 (Loan)    | 0.73      | 0.56   | 0.64     |

     Feature selection led to a minor drop in performance, suggesting that all features contributed useful information for predicting loan customers.

    **Key Insight:** The F1-score for class 1 is the most important metric, as it balances correctly identifying potential loan customers (recall) while minimizing false positives (precision), which is critical for improving conversion rates and reducing marketing costs. 


 - **Random Forest Classifer**
   
     #### Baseline Model (No Tuning, No Feature Selection) - 99% Accuracy
      | Class       | Precision | Recall | F1-Score | 
      | ----------- | --------- | ------ | -------- | 
      | 0 (No Loan) | 0.99      | 1.0    | 0.99     | 
      | 1 (Loan)    | 0.99      | 0.87   | 0.93     |

     The baseline Random Forest model already performs very well, achieving near-perfect classification for the majority class (No Loan) and strong performance for the minority class (Loan) with an F1-score of 0.93.

    #### After Hyperparameter Tuning ✅ - 99% Accuracy
      | Class       | Precision | Recall | F1-Score | 
      | ----------- | --------- | ------ | -------- | 
      | 0 (No Loan) | 0.99      | 1.0    | 0.99     | 
      | 1 (Loan)    | 0.97      | 0.90   | 0.93     |

   Hyperparameter tuning slightly improved recall for class 1 (from 0.87 → 0.90) while maintaining high precision, resulting in the same overall F1-score for loan customers. This shows that tuning helps the model better identify potential borrowers.
    
    #### After Tuning + Feature Selection ⚠️ - 99% Accuracy
      | Class       | Precision | Recall | F1-Score | 
      | ----------- | --------- | ------ | -------- | 
      | 0 (No Loan) | 0.99      | 1.00   | 0.99     | 
      | 1 (Loan)    | 0.98      | 0.92   | 0.95     |


     Applying feature selection further improved recall for class 1 (0.92) and slightly increased precision, raising the F1-score to 0.95. This indicates that Random Forest can still perform well even with fewer, more relevant features.

 - **KNN Model**   
    
    #### Baseline Model (No Tuning, No Feature Selection) - 91% Accuracy

   | Class       | Precision | Recall | F1-Score | 
   | ----------- | --------- | ------ | -------- | 
   | 0 (No Loan) | 0.91      | 1.0    | 0.95     | 
   | 1 (Loan)    | 0.50      | 0.03   | 0.06     |

     The baseline KNN model achieves good performance for the majority class (No Loan) but struggles significantly with the minority class (Loan), with very low recall (0.03) and F1-score (0.06), indicating it fails to identify most potential borrowers.
    
   #### After Hyperparameter Tuning ✅ - 92% Accuracy
   | Class       | Precision | Recall | F1-Score | 
   | ----------- | --------- | ------ | -------- | 
   | 0 (No Loan) | 0.93      | 0.99   | 0.96     | 
   | 1 (Loan)    | 0.72      | 0.21   | 0.32     |

     Hyperparameter tuning improves KNN’s ability to detect loan customers, increasing recall from 0.03 → 0.21 and F1-score from 0.06 → 0.32, while maintaining strong performance for the majority class.
    
        
   #### After Tuning + Feature Selection ⚠️ - 98% Accuracy
   | Class       | Precision | Recall | F1-Score | 
   | ----------- | --------- | ------ | -------- | 
   | 0 (No Loan) | 0.98      | 1.00   | 0.99     | 
   | 1 (Loan)    | 0.94      | 0.77   | 0.85     |

    Applying feature selection significantly boosts performance for the minority class (Loan), with recall improving to 0.77 and F1-score to 0.85. This shows that KNN benefits greatly from relevant features and proper tuning.

### ✅ Conclusion
| Model                    | Accuracy | Precision (Class 1) | Recall (Class 1) | F1-Score (Class 1) | Key Insight                                                                            |
| ------------------------ | -------- | ------------------- | ---------------- | ------------------ | -------------------------------------------------------------------------------------- |
| Logistic Regression      | 94–95%   | 0.73–0.75           | 0.56–0.60        | 0.64–0.66          | Moderate ability to detect loan customers; baseline and interpretable model.           |
| Random Forest Classifier | 99%      | 0.97–0.98           | 0.90–0.92        | 0.93–0.95          | Best for identifying potential loan customers; handles imbalance and generalizes well. |
| KNN                      | 91–98%   | 0.72–0.94           | 0.21–0.77        | 0.32–0.85          | Sensitive to features; improves with tuning and selection but still slightly below RF. |

**For this scenario** — targeting potential loan customers in an imbalanced dataset — the Random Forest Classifier is the best choice:

- It achieves the highest F1-score for class 1 (0.95), balancing recall and precision effectively.
- Maintains excellent overall accuracy (99%) while correctly identifying most potential borrowers.
- Less sensitive to irrelevant features, robust to overfitting, and easily interpretable in terms of feature importance.
   
