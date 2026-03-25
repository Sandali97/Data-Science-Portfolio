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





