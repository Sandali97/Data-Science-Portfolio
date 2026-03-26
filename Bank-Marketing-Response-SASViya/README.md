### 📊 Bank Marketing Response Analysis

#### 📌Project Overview

This project predicts customer responses to a bank’s direct marketing campaign using SAS Model Studio. The goal is to identify customers most likely to subscribe to a term deposit, enabling targeted marketing and improved ROI.

- **Objective:** Predict whether a customer will respond (`deposit = yes`) to a marketing campaign.
- **Type:** Binary Classification / Campaign Response Modeling
- **Tools:** SAS Model Studio (Viya), CSV Dataset

## 🗂️ Dataset
The dataset contains real data from a Portuguese bank’s marketing campaigns.

**🔑Key Features:**

| Variable | Type | Description |
|----------|------|-------------|
| age | Numeric | Customer age |
| job | Categorical | Job type (admin., technician, management, etc.) |
| marital | Categorical | Marital status (single, married, divorced) |
| education | Categorical | Education level (primary, secondary, tertiary) |
| default | Categorical | Has credit in default (yes/no) |
| balance | Numeric | Average yearly balance in euros |
| housing | Categorical | Has housing loan (yes/no) |
| loan | Categorical | Has personal loan (yes/no) |
| contact | Categorical | Contact communication type (unknown, telephone, cell) |
| day | Numeric | Last contact day of the month |
| month | Categorical | Last contact month of year |
| duration | Numeric | Last contact duration in seconds |
| campaign | Numeric | Number of contacts performed during this campaign |
| pdays | Numeric | Days since last contact (-1 means not contacted previously) |
| previous | Numeric | Number of contacts before this campaign |
| poutcome | Categorical | Outcome of previous campaign (unknown, success, failure) |
| deposit | Target | Customer subscribed to term deposit (yes/no) |


**🧾Source:** [Kaggle Bank Marketing Dataset](https://www.kaggle.com/datasets/dvaser/bank-marketing)


## ⚙️ SAS Model Studio Workflow

<img width="1443" height="693" alt="image" src="https://github.com/user-attachments/assets/5df05544-b5fd-4275-9df1-7f2a82b5fb9e" />

#### 1. Data Node
- Load the CSV dataset into the pipeline.

#### 2. Preprocessing
- **Imputation Node:** Handles missing values and `unknown` categories.
- **Data Exploration Node:** Generates summary statistics, distributions, and visualizations for numeric and categorical features.

#### 3. Variable Selection
- Selects most predictive features for Logistic Regression models.
- Reduces noise and avoids overfitting.

#### 4. Partitioning (Optional)
- SAS automatically partitions data (70% train, 15% validation, 15% test) if no explicit Partition Node is added.
- Can manually add Partition Node for custom splits or stratified sampling.

#### 5. Modeling Nodes
- **Stepwise Logistic Regression** – interpretable baseline model.
- **Forward Logistic Regression** – adds features one at a time to maximize predictive power.
- **Decision Tree** – interpretable tree-based model.
- **Random Forest** – robust ensemble tree-based model.
- **Gradient Boosting** – powerful for non-linear relationships.

#### 6. Ensemble Node
- Combines predictions from multiple models to improve accuracy.

#### 7. Model Comparison Node
- Compares all models using metrics:
  - Accuracy
  - ROC-AUC
  - Precision / Recall
  - F1-score
- Identifies the best performing model.

#### 8. Scoring
- Score new customer data using the best model.
- Predict probability of subscription (`deposit = yes`) and rank customers for targeted campaigns.
