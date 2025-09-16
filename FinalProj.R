# Jake Thompson
# 11/29/2024
# CSCI365 Final Project

setwd("C:/Users/rootc/OneDrive - Colorado Mesa University/CSCI 365/Final Project")

# Load necessary libraries
library(ggplot2)
library(forecast)  # For ARIMA and time series forecasting
library(readr)
library(dplyr)
library(tidyr)

# Import the dataset
palantir_data <- read_csv("PalantirDataFiltered.csv")

# TASK 1.1 ---------------------------------------------------------------------------

# Specify 2 weeks (10 working days) of lags for both Close and High
num_lags <- 10
for (i in 1:num_lags) {
  palantir_data[[paste0("lag_close_", i)]] <- dplyr::lag(palantir_data$`Close/Last`, i)
  palantir_data[[paste0("lag_high_", i)]] <- dplyr::lag(palantir_data$High, i)
}

# Remove leading instances (rows with NA due to lagging)
palantir_data <- palantir_data %>% drop_na()

# Split data into training and test sets (e.g., 80% train, 20% test)
set.seed(123)  # For reproducibility
train_size <- floor(0.8 * nrow(palantir_data))
train_data <- palantir_data[1:train_size, ]
test_data <- palantir_data[(train_size + 1):nrow(palantir_data), ]

# Predict multiple targets: Close and High
# We'll use a simple linear regression model for demonstration
close_model <- lm(`Close/Last` ~ ., data = train_data %>% select(-Date, -High))
high_model <- lm(High ~ ., data = train_data %>% select(-Date, -`Close/Last`))

# Make predictions
train_data$predicted_close <- predict(close_model, newdata = train_data)
test_data$predicted_close <- predict(close_model, newdata = test_data)
train_data$predicted_high <- predict(high_model, newdata = train_data)
test_data$predicted_high <- predict(high_model, newdata = test_data)

# Evaluate predictions (e.g., Mean Squared Error)
mse_close <- mean((test_data$`Close/Last` - test_data$predicted_close)^2, na.rm = TRUE)
mse_high <- mean((test_data$High - test_data$predicted_high)^2, na.rm = TRUE)

# Print results
cat("MSE for Close predictions:", mse_close, "\n")
cat("MSE for High predictions:", mse_high, "\n")

# TASK 1.2 --------------------------------------------------------------------------

# DECEMBER 2nd
# Update the dataset for December 2nd and December 3rd predictions
updated_train_data <- palantir_data %>% filter(Date < "2024-12-04")

# Add columns for previous day's close and current day's open
updated_train_data$prev_close <- lag(updated_train_data$`Close/Last`, 1)
updated_train_data$open_today <- updated_train_data$Open

# Remove the first row due to lagging (since lag(1) creates an NA for the first entry)
updated_train_data <- updated_train_data %>% filter(!is.na(prev_close))

# Fit a linear regression model to predict Close based on previous close and current open
close_model_regression <- lm(`Close/Last` ~ prev_close + open_today, data = updated_train_data)

# Predict the close price for December 2nd (using December 1st close and December 2nd open)
prev_close_dec1 <- 67.08  # Actual close for Nov 29th (or use the last available close in data)
open_dec2 <- 67.44  # Opening price for Dec 2nd
predicted_close_dec2 <- predict(close_model_regression, newdata = data.frame(prev_close = prev_close_dec1, open_today = open_dec2))

# Print the predicted close for December 2nd
cat("Predicted Close price for December 2nd, 2024: $", round(predicted_close_dec2, 2), "\n")

# DECEMBER 3rd
# Update the training data with actual close for December 2nd
updated_train_data_dec3 <- palantir_data %>% filter(Date < "2024-12-03")

# Create a new feature for previous day's close and current day's open
updated_train_data_dec3$prev_close <- lag(updated_train_data_dec3$`Close/Last`, 1)
updated_train_data_dec3$open_today <- updated_train_data_dec3$Open

# Remove the first row due to lagging
updated_train_data_dec3 <- updated_train_data_dec3 %>% filter(!is.na(prev_close))

# Fit a linear regression model to predict Close based on previous close and current open
close_model_regression_dec3 <- lm(`Close/Last` ~ prev_close + open_today, data = updated_train_data_dec3)

# Get the previous day's close (Dec 2nd) and current day's open (Dec 3rd)
prev_close_dec2 <- 66.39  # Actual close for Dec 2nd
open_dec3 <- 71.13  # Opening price for Dec 3rd

# Predict the close price for December 3rd
predicted_close_dec3 <- predict(close_model_regression_dec3, newdata = data.frame(prev_close = prev_close_dec2, open_today = open_dec3))

# Print the predicted close for December 3rd
cat("Predicted Close price for December 3rd, 2024: $", round(predicted_close_dec3, 2), "\n")

# DECEMBER 4th
# Update the training data with actual close for December 3rd
updated_train_data_dec4 <- palantir_data %>% filter(Date < "2024-12-04")

# Create a new feature for previous day's close and current day's open
updated_train_data_dec4$prev_close <- lag(updated_train_data_dec4$`Close/Last`, 1)
updated_train_data_dec4$open_today <- updated_train_data_dec4$Open

# Remove the first row due to lagging
updated_train_data_dec4 <- updated_train_data_dec4 %>% filter(!is.na(prev_close))

# Fit a linear regression model to predict Close based on previous close and current open
close_model_regression <- lm(`Close/Last` ~ prev_close + open_today, data = updated_train_data_dec4)

# Get the previous day's close (Dec 3rd) and current day's open (Dec 4th)
prev_close_dec3 <- 70.96  # Actual close for Dec 3rd
open_dec4 <- 71.13  # Opening price for Dec 4th

# Predict the close price for December 4th
predicted_close_dec4 <- predict(close_model_regression, newdata = data.frame(prev_close = prev_close_dec3, open_today = open_dec4))

# Print the predicted close for December 4th
cat("Predicted Close price for December 4th, 2024: $", round(predicted_close_dec4, 2), "\n")

# DECEMBER 5th
# Update the training data with actual close for December 4th
updated_train_data_dec5 <- palantir_data %>% filter(Date < "2024-12-05")

# Create a new feature for previous day's close and current day's open
updated_train_data_dec5$prev_close <- lag(updated_train_data_dec5$`Close/Last`, 1)
updated_train_data_dec5$open_today <- updated_train_data_dec5$Open

# Remove the first row due to lagging
updated_train_data_dec5 <- updated_train_data_dec5 %>% filter(!is.na(prev_close))

# Fit a linear regression model to predict Close based on previous close and current open
close_model_regression_dec5 <- lm(`Close/Last` ~ prev_close + open_today, data = updated_train_data_dec5)

# Get the previous day's close (Dec 4th) and current day's open (Dec 5th)
prev_close_dec4 <- 69.85  # Actual close for Dec 4th
open_dec5 <- 70.11  # Opening price for Dec 5th

# Predict the close price for December 5th
predicted_close_dec5 <- predict(close_model_regression_dec5, newdata = data.frame(prev_close = prev_close_dec4, open_today = open_dec5))

# Print the predicted close for December 5th
cat("Predicted Close price for December 5th, 2024: $", round(predicted_close_dec5, 2), "\n")

# DECEMBER 6th
# Update the training data with actual close for December 5th
updated_train_data_dec6 <- palantir_data %>% filter(Date < "2024-12-06")

# Create a new feature for previous day's close and current day's open
updated_train_data_dec6$prev_close <- lag(updated_train_data_dec6$`Close/Last`, 1)
updated_train_data_dec6$open_today <- updated_train_data_dec6$Open

# Remove the first row due to lagging
updated_train_data_dec6 <- updated_train_data_dec6 %>% filter(!is.na(prev_close))

# Fit a linear regression model to predict Close based on previous close and current open
close_model_regression_dec6 <- lm(`Close/Last` ~ prev_close + open_today, data = updated_train_data_dec6)

# Get the previous day's close (Dec 5th) and current day's open (Dec 6th)
prev_close_dec5 <- 71.87  # Actual close for Dec 5th
open_dec6 <- 72.95  # Opening price for Dec 6th

# Predict the close price for December 6th
predicted_close_dec6 <- predict(close_model_regression_dec6, newdata = data.frame(prev_close = prev_close_dec5, open_today = open_dec6))

# Print the predicted close for December 6th
cat("Predicted Close price for December 6th, 2024: $", round(predicted_close_dec6, 2), "\n")
