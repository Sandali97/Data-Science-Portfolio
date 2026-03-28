## 📊 Customer Support Sentiment Analysis (Twitter Data)

### 🚀 Project Overview

This project performs **sentiment analysis on customer support interactions from Twitter**. The goal is to understand customer emotions (Positive, Negative, Neutral) based on their messages and derive insights that can improve customer experience and support strategies.

---

## 📁 Dataset

The dataset is taken from kaggle : https://www.kaggle.com/datasets/thoughtvector/customer-support-on-twitter

The Customer Support on Twitter dataset is a large, modern corpus of tweets and replies to aid innovation in natural language understanding and conversational models, and for study of modern customer support practices and impact.

### Columns used:

* `text` → Raw customer tweet

<img width="311" height="322" alt="image" src="https://github.com/user-attachments/assets/237d0211-593a-4cf3-a538-d03e6ce22dc4" />

---

## 🧹 Data Preprocessing

Text data is cleaned and normalized before analysis:

### Steps:

* Convert text to lowercase
* Remove punctuation and special characters
* Tokenize text into words
* Remove stopwords (common words like *the, is, and*)
* Apply lemmatization (convert words to base form)

### Example:

**Input:**

```
@AppleSupport causing the reply to be disregarded!!!
```

**Output:**

```
applesupport causing reply disregarded
```

---

## ⚙️ Sentiment Analysis Method

This project uses **VADER (Valence Aware Dictionary and sEntiment Reasoner)**, a rule-based sentiment analysis tool optimized for social media text.

### Why VADER?

* No labeled data required
* Handles emojis, punctuation, and informal text
* Fast and efficient for large datasets

---

## 📊 Sentiment Classification Logic

Each text is assigned a **compound sentiment score** ranging from -1 to +1.

| Score Range | Sentiment |
| ----------- | --------- |
| > 0.05      | Positive  |
| < -0.05     | Negative  |
| Otherwise   | Neutral   |

---

## 🧪 Implementation

### 1. Load Data

```python
import pandas as pd

df = pd.read_csv("Feedback Analysis.csv")
df = df[['text']]
```

---

### 2. Text Preprocessing

```python
import re
from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords

def preprocess_text(text):
    lemmatizer = WordNetLemmatizer()
    stop_words = set(stopwords.words('english'))

    text = re.sub(r'[^a-z\s]', '', text.lower())
    words = text.split()
    words = [lemmatizer.lemmatize(w) for w in words if w not in stop_words]

    return " ".join(words)

df["Cleaned_Text"] = df["text"].apply(preprocess_text)
```

---

### 3. Sentiment Analysis using VADER

```python
from nltk.sentiment import SentimentIntensityAnalyzer
import nltk

nltk.download('vader_lexicon')

sia = SentimentIntensityAnalyzer()

def get_sentiment(text):
    score = sia.polarity_scores(text)["compound"]

    if score > 0.05:
        return "Positive"
    elif score < -0.05:
        return "Negative"
    else:
        return "Neutral"

df["sentiment"] = df["Cleaned_Text"].apply(get_sentiment)
```

---

## 📈 Output

The final dataset includes:

* `text` → Original tweet
* `Cleaned_Text` → Processed text
* `sentiment` → Predicted sentiment

---

## 💡 Use Cases

* Identify dissatisfied customers
* Improve customer support responses
* Monitor brand reputation
* Prioritize high-risk (negative sentiment) customers

---

## ⚠️ Limitations

* Rule-based (may miss sarcasm or complex context)
* Less accurate than deep learning models like BERT
* Depends on predefined lexicon

---

## 🔮 Future Improvements

* Fine-tune transformer models (e.g., BERT) for higher accuracy
* Combine sentiment with churn prediction models
* Build dashboards for real-time monitoring (Power BI / Tableau)
* Add multilingual support

---

## 🛠️ Requirements

```bash
pip install pandas nltk
```

---

## 👩‍💻 Author

**Sandali Prathibhani**
Data Scientist | Machine Learning Enthusiast

---

## ⭐ Summary

This project demonstrates how to perform **end-to-end sentiment analysis without labeled data**, using NLP preprocessing and VADER to extract meaningful insights from customer support conversations.
