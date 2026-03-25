### 🍽️ Food Expenditure Analysis of Filipino Families
This study aims to evaluate the food expenditure of Filipino families based on monthly income, region, agricultural household status, medical care expenses, family size, and number of children. Outliers were removed to reduce variability, and model complexity was minimized by excluding uncorrelated expenditure categories. The analysis focuses on identifying factors influencing monthly Rice, Bread, and Cereal spending for families earning under 1,500,000 pesos.

### 📊 Dataset Description
🔗: https://www.kaggle.com/datasets/grosvenpaul/family-income-and-expenditure/data

The data set consists of more than 40K observations and 60 variables which explain income and expenditure of households. From those variables, 9 variables have been selected for our study. Variable “Total Food Expenditure” is the response variable.
| **Variable Name**                | **Definition**                                      | **Type**  |
| -------------------------------- | --------------------------------------------------- | --------- |
| Total food expenditure           | Total amount spent on food                          | Response  |
| Total household income           | Total income of a family                            | Predictor |
| Region                           | Origin of the observation                           | Predictor |
| Agricultural household indicator | Whether planting has been carried out               | Predictor |
| Medical care expenditure         | Total expenditure for medical and health conditions | Predictor |
| Total family members             | Number of members in a Filipino family              | Predictor |
| No. of babies in a family        | Number of babies (age 5 and below)                  | Predictor |
| No. of kids in a family          | Number of kids (age 5–17)                           | Predictor |
| No. of adults in a family        | Number of adults (age 18 and above)                 | Predictor |


### 🧹Exploratory Data Analysis (EDA)

**01. Variation of Medical care, Income and Rice Expenditures**

<img width="288" height="213" alt="image" src="https://github.com/user-attachments/assets/b82d833d-288d-419e-94aa-208be0999a09" /><img width="632" height="213" alt="image" src="https://github.com/user-attachments/assets/7c0b2c53-d768-497a-930b-bb81c6a1018f" />

Figures show boxplots of three quantitative variables, income, medical care, and rice expenditure for total observations. All three plots show few families locating outside of many data. These situations may occur due to measurement errors, data recording errors and false information given by respondent. Therefore, those families could be eliminated. It’s plausible that the food expenditure is related with rice expenditure since it’s the main meal of Filipinos.

We know that income and medical care are also highly correlated with monthly expenses of a family. Therefore, above plots are considered for detecting abnormal observations in the dataset.

**02.Variation of Income with Number of Adults in a Family**

<img width="400" height="215" alt="image" src="https://github.com/user-attachments/assets/3219bb85-eb55-4ff9-8540-223288a8dbff" />

The income variable contains extreme values, so a cutoff is needed to limit its range. By examining the income distribution, we identify a point where frequencies drop significantly, indicating large gaps in higher incomes. Including these would overestimate the model, so the cutoff is set at ₱1,500,000.

<img width="400" height="215" alt="image" src="https://github.com/user-attachments/assets/cea3edcf-a234-4292-bf59-b47e0ee9e2a8" />

**Histogram for Excluded observations**

<img width="400" height="215" alt="image" src="https://github.com/user-attachments/assets/29c3e3bf-ff65-405f-b795-ff5dd4f1d032" />


The effect is statistically proven to be minimal if the number of points eliminated from the model is an extremely small proportion of the total.

**03.  Correlation Plot of food expenditures**

<img width="400" height="318" alt="image" src="https://github.com/user-attachments/assets/3b4b54d4-6387-4b7b-b4e2-6c9b8ef523cb" />

To predict family food expenditure, it is important to examine correlations between different food categories. Significant correlations indicate that changes in one category affect another. In this dataset, only Bread, Cereal, and Rice show meaningful correlations. All other variables have correlation coefficients below 0.7, making it difficult to predict one based on another and complicating the modeling process.

**04.Variation of Rice with Bread and Cereals Expenditures**

<img width="400" height="318" alt="image" src="https://github.com/user-attachments/assets/cfd50bd5-bb80-4725-b3d3-59842ea48987" />

The graph shows a weak relationship at lower expenses, but once spending reaches ₱50,000, the relationship becomes stable and nearly linear. Some families spend more on bread & cereal than rice, but at higher expense levels, the straight-line trend indicates a strong linear relationship. Therefore, combining Rice and Bread & Cereal is reasonable to represent total food expenditure, as these are the main components of the family’s diet.

**05.Variation of the Response variable: Food Expenditure**

<img width="400" height="318" alt="image" src="https://github.com/user-attachments/assets/ac1e609f-1c05-4f76-8a3c-13c0eeb6fdef" />

As shown in the figure, the food expenditure distribution is right-skewed and unimodal. Most families spend less than ₱54,886, while a few families spend significantly more. Expenditures range from ₱0 to ₱1,524,190, with a median of ₱39,744. Families with zero expenditure likely meet their food needs through homegrown produce, farm products, donations, or potential data errors.

<img width="400" height="318" alt="image" src="https://github.com/user-attachments/assets/63bf6095-07ff-4bde-8bc0-efaf7074a877" />


**06. Variation of Agricultural Household indicator with Food Expenditure**

<img width="400" height="318" alt="image" src="https://github.com/user-attachments/assets/e2ec1f0e-1508-490e-9987-f6b4765fccde" />

The Agricultural Indicator has three levels:

- 0 – No cultivation
- 1 – Cultivating for personal consumption
- 2 – Cultivating as a source of income

It is important to examine the distributions to see if food expenditure varies across these categories. If not, categories can be combined to simplify the model. From the plot, the third category clearly differs from the first two, so it should not be combined. The first two categories appear similar, but further analysis is needed before merging them into a single variable.

**07.Variation of food expenditure with Total Family Members**

<img width="400" height="318" alt="image" src="https://github.com/user-attachments/assets/18896423-e13a-4efa-b3d8-e04d7f490a4c" />

Since both variables are quantitative, a scatter plot was used. It shows a positive linear relationship with a correlation coefficient of 0.597, indicating a moderately strong relationship. As family size increases, food expenditure generally rises. Most families spend less than ₱1,500,000 for households with fewer than 15 members. A few families allocate a disproportionately large portion of their budget to food, possibly reflecting differences in lifestyle, health priorities, or socio-economic status.

#### 📌Summary of EDA

- Extreme values were observed in Income, Medical Care, and Rice expenditure.
- Income cutoff was applied to avoid overestimation of the model.
- 210 households (0.63% of 33,235) were removed as outliers.
- Rice and Bread & Cereals have a strong correlation (0.88); other categories show low correlation (<0.7).
- Rice and Bread & Cereals were combined into Total Food Expenditure.
- Food expenditure is right-skewed; most households spend less, ranging from 0 to ₱1,524,190; median is ₱39,744.
- Medical care and Income show a weak correlation (0.309).
- Food expenditure moderately increases with family size (correlation 0.507); few families spend disproportionately more.
- A new variable, Number of Adults, was derived from the dataset.

### 🤖 Advanced Analysis / Modeling
**01. Multiple Linear Regression with Ridge Penalty**

<img width="980" height="518" alt="image" src="https://github.com/user-attachments/assets/41d89b5d-de57-4d2f-b45b-9fb1cf2663e5" />

Plot of cross validation MSE values of ridge penalty with Log lambda shows how the coefficients shrink towards zero as the tuning parameter λ increases. Faster the shrinking of the coefficient towards zero, lesser the importance of the variable in the prediction of the response. As shown in above figure, all 23 variables are remained in the ridge model. 

| Minimum MSE | 𝜆 (Min MSE) |Test MSE|R-squared| RMSE |
|-------------|-------------|--------|---------|------|
|0.1743586    |0.02847867   |0.181448|0.46927  |0.4259|

**02.Multiple Linear Regression with Lasso Penalty**

<img width="500" height="318" alt="image" src="https://github.com/user-attachments/assets/aa98874c-b333-4d4e-bbe4-d9fa638d25e3" />

According to the Plot of cross validation MSE values of lasso penalty with Log lambda, lasso regression shrinks some variables exactly to zero as expected, allowing to identify the most important variables to be considered in the model. Out of all 23 variables, the value of the best λ corresponding to minimum MSE results in a lasso model with 22 variables which gave a Training MSE of 0.174049.

| Minimum MSE | 𝜆 (Min MSE) |Test MSE|R-squared| RMSE |
|-------------|-------------|--------|---------|------|
|0.174049     |0.00073902   |0.180773|0.46955  |0.4251|

**03. Multiple Linear Regression with Elastic Net Penalty**
<img width="980" height="518" alt="image" src="https://github.com/user-attachments/assets/6fdfc114-5475-43e3-a81a-3ad11a7bef4d" />

Although lasso models perform variable selection, in the case of having two strongly correlated variables pushed towards zero, lasso may push one fully to zero while the other remains in the model. Thus, making the process unsystematic. In contrast, the ridge regression penalty is a little more effective in systematically handling correlated variables together. Consequently, the advantage of the elastic net penalty is that it blends the effective regularization in the ridge penalty with the variable selection characteristics of the lasso penalty.

| **Alpha (α)** | **RMSE** | **R² (R-squared)** | **MAE** | **RMSE SD** | **R² SD** | **MAE SD** |
| ------------- | -------- | ------------------ | ------- | ----------- | --------- | ---------- |
| 1             | 0.000702 | 0.4252             | 0.4696  | 0.3053      | 0.1808    | 0.0158     |

**04.Linear Regression Model**

Linear regression as the simplest algorithm to predict the response variable with the independent explanatory variables is used here for the purpose of comparing MSE of the models to select the best model. With the use of the most common approach least squares method, coefficients of each associated variable are calculated. 

| **Intercept** | **RMSE** | **MSE** | **R² (R-squared)** |
| ------------- | -------- | ------- | ------------------ |
| 9.676         | 0.4169   | 0.1738  | 0.4683             |

As the above table shows when all other variables are equal to 0, expected value of the log transformed response variable food expenditure is 9.676. which means expected value of food expenditure is 15930.65 pesos when all other variables are set to zero.  

**05.Principal Component Regression**

Principal component analysis is a method of reducing correlated variables into uncorrelated components without loss of information and the resulting components can be used as predictors of linear regression model. Then the main objective of principal components regression is to find out number of components that explains total variability of the model. In this study, analysis consists of 23 variables with all categories. With the use of principal component analysis 23 variables have been reduced to 22 uncorrelated components. 

| **No. of Components** | **RMSE** | **MSE** | **R² (R-squared)** |
| --------------------- | -------- | ------- | ------------------ |
| 22                    | 0.4169   | 0.1738  | 0.4683             |

**06.Partial Least Squares Method**

Under PLS regression it reduces predictors to a smaller number of uncorrelated components which are extremely correlated with response variable and perform least squares regression on those components. 

| **No. of Components** | **RMSE** | **MSE** | **R² (R-squared)** |
| --------------------- | -------- | ------- | ------------------ |
| 7                     | 0.4169   | 0.1738  | 0.4683             |

### 💡Model Evaluation

Among all the models studied in the advanced analysis, Elastic Net model resulted in the lowest training MSE with the highest performance. Further analysis is done on Elastic Net model to check for the suitability.

| **Model**                       | **Minimum MSE** | **λ (Lambda) for Minimum MSE** |
| ------------------------------- | --------------- | ------------------------------ |
| Ridge                           | 0.1744          | 0.02848                        |
| Lasso                           | 0.1740          | 0.000739                       |
| Elastic Net                     | 0.1738          | 0.000702                       |
| Linear Regression               | 0.1738          | —                              |
| Principal Components Regression | 0.1738          | —                              |
| Partial Least Squares           | 0.1738          | —                              |

### 🌟Variable Importance Plot

Variable Importance plots shows top variables contribute more to the model and have high predictive power than the bottom ones. When considering variable importance plot of Elastic Net model, it has given a significant importance to adults, kids and income variables. The importance of the derivation of adults variable from the family members variable was also highlighted in this scenario

<img width="500" height="418" alt="image" src="https://github.com/user-attachments/assets/889e7a98-aad3-4e7e-9717-c4f9985eeb9a" />

