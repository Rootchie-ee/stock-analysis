# Palantir Stock Price Forecasting (Dec 2024)

## Overview
This project explores **time-series forecasting** of Palantir Technologies' stock during the week of **December 2–6, 2024**. Using an **ARIMA model**, the study evaluates predictive accuracy and profitability, assessing whether historical data can credibly support investment strategies.

---

## Objectives
- Forecast Palantir’s daily closing prices using historical data.
- Compare predictions to actual stock movements.
- Evaluate results in terms of **accuracy** and **profitability**.
- Assess the credibility of ARIMA as a trading decision-support tool.

---

## Motivation
Palantir has recently gained significant attention for its **AI-driven analytics platform** and growing market influence. Its rapid stock appreciation made it an ideal candidate for testing whether statistical forecasting methods could track volatile stock behavior and generate actionable insights.

**Figure 1: Historical closing price of Palantir**  
![Palantir Historical Closing Price](https://github.com/<username>/<repo-name>/blob/main/images/palantir_history.png?raw=true)


---

## Dataset
- **Source**: 5 years of daily Palantir stock data (open, close, high, low, volume).
- **Preprocessing**:
  1. Date-time alignment for sequential analysis.  
  2. Handling non-trading days (weekends/holidays).  
  3. Feature engineering (lag variables: 1-day, 5-day, 10-day).  
  4. Differencing for stationarity.  

---

## Model
- **ARIMA (AutoRegressive Integrated Moving Average)**:
  - **AR**: Uses past lag values.  
  - **I**: Differencing for stationarity.  
  - **MA**: Uses past forecast errors.  
- Trained on historical data until **Nov 29, 2024**.  
- Predictions generated iteratively for **Dec 2–6, 2024**.

---

## Results
- Predictions showed **mixed accuracy**:
  - Some trends were captured (e.g., Dec 4th close within $0.98).  
  - Large errors occurred during **sudden upward shifts** (e.g., Dec 6th underpredicted by $2.39).  
- **Profitability analysis**: The strategy was **not profitable**, as deviations in predictions could lead to missed gains or losses.

**Figure 2: Forecast Journal (Predicted vs Actual Closing Prices)**  
![Forecast Journal](images/forecast_journal.png)

The comparison of actual vs predicted closing prices highlights the model’s strengths and weaknesses:  

**Figure 3: Actual vs Predicted Closing Prices (Dec 2–6, 2024)**  
![Predicted vs Actual](images/predicted_vs_actual.png)

---

## Limitations
1. **High volatility**: ARIMA struggles with stock market randomness.  
2. **No external data**: Market sentiment, macro factors, and news were excluded.  
3. **Short horizon**: Daily predictions amplify noise and reduce reliability.  

---

## Improvements
- Use advanced models (e.g., **LSTM networks**).  
- Incorporate **external signals** (news sentiment, indices, reports).  
- Forecast at **weekly/monthly** intervals to reduce noise.  
- Explore **hybrid models** (ARIMA + machine learning).  

---

## Conclusion
ARIMA provided a **baseline** but failed to deliver consistent, profitable predictions. While it revealed general trends, it lacked robustness against volatility. Future work should focus on deep learning methods and richer datasets to build **credible investment support tools**.

---

## Repository Structure
