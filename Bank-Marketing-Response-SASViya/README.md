### 📊 Bank Marketing Response Analysis

#### 📌Project Overview

This project predicts customer responses to a bank’s direct marketing campaign using SAS Model Studio. The goal is to identify customers most likely to subscribe to a term deposit, enabling targeted marketing and improved ROI.

- **Objective:** Predict whether a customer will respond (`deposit = yes`) to a marketing campaign.
- **Type:** Binary Classification / Campaign Response Modeling
- **Tools:** SAS Model Studio (Viya), CSV Dataset

#### 🗂️ Dataset
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


#### ⚙️ SAS Model Studio Workflow

<img width="1443" height="693" alt="image" src="https://github.com/user-attachments/assets/5df05544-b5fd-4275-9df1-7f2a82b5fb9e" />

#### 1. Data Node
- Load the CSV dataset into the pipeline.

#### 2. Preprocessing
- **Imputation Node:** Handles missing values and `unknown` categories.
- **Data Exploration Node:** Generates summary statistics, distributions, and visualizations for numeric and categorical features.

#### 3. Variable Selection
- Applied Fast Supervised Selection to automatically identify predictive features.
- Reduces noise and avoids overfitting.

<img width="640" height="747" alt="image" src="https://github.com/user-attachments/assets/cecd71c4-2803-4cff-a015-1123fccd398c" />

#### 4. Partitioning (Optional)
- SAS automatically partitions data (70% train, 15% validation, 15% test).

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


#### 🚀 Model Comparison Results

After running all models, the following results were obtained on the test set:

| Model | Accuracy | ROC AUC | F1 Score | KS | Notes |
|-------|---------|---------|----------|----|------|
| Gradient Boosting | 0.8477 | 0.6981 | 0.8449 | 0.7201 | Best performance overall. |
| Random Forest | 0.8423 | 0.6858 | 0.8370 | 0.7211 | Strong performance, useful for feature importance. |
| Forward Logistic Regression | 0.8100 | 0.6151 | 0.7913 | 0.6751 | Interpretable baseline, slightly lower performance. |
| Stepwise Logistic Regression | 0.8100 | 0.6151 | 0.7913 | 0.6751 | Same as Forward Logistic, feature selection improves interpretability. |

**Recommendation:** Use **Gradient Boosting** for scoring new customers, and **Random Forest** for understanding feature importance and insights.

### 🧪 Insights and Key Factors
The project not only predicts customer responses but also **identifies key factors influencing deposit subscriptions**:

<img width="239" height="303" alt="image" src="https://github.com/user-attachments/assets/96c1b7dd-d28b-4d7c-b2c4-f8c47f538da3" />

#### ✅ Key Drivers: duration, month, poutcome, age, contact

| Rank | Variable      | Relative Importance | Interpretation                                                            |
| ---- | ------------- | ------------------- | ------------------------------------------------------------------------- |
| 1    | **duration**  | 1.0000              | Most important factor; longer call duration increases deposit likelihood. |
| 2    | **month**     | 0.3389              | Campaign month affects response (seasonality).                            |
| 3    | **poutcome**  | 0.2021              | Outcome of previous campaigns predicts response.                          |
| 4    | **age**       | 0.1464              | Certain age groups respond better.                                        |
| 5    | **contact**   | 0.1288              | Communication method (cell, telephone) matters.                           |
| 6    | **job**       | 0.1141              | Some occupations are more responsive.                                     |
| 7    | **balance**   | 0.0963              | Higher average balance increases probability.                             |
| 8    | **housing**   | 0.0596              | Housing loan status has moderate effect.                                  |
| 9    | **previous**  | 0.0524              | Previous contacts slightly influence response.                            |
| 10   | **pdays**     | 0.0437              | Days since last contact has minor effect.                                 |
| 11   | **campaign**  | 0.0422              | Number of contacts in current campaign is less influential.               |
| 12   | **education** | 0.0342              | Education level has small impact.                                         |
| 13   | **marital**   | 0.0211              | Marital status has minor effect.                                          |
| 14   | **loan**      | 0.0155              | Personal loan has little effect.                                          |
| 15   | **default**   | 0.0036              | Credit default status negligible.                                         |

Actionable Insight: Focus marketing efforts on customers with long call durations, favorable previous campaign outcomes, in the right months, and the right age/contact segments.
