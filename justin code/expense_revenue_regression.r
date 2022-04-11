# Multivariate Regression to Predict Average Yearly Growth Rate of Expenses (Staff and Other) for a Top Ranking Team

expenses <- data.frame(read_excel("2022-student-research-case-study-football-soccer-data.xlsx",sheet="Expense"))
expenses_data <- expenses[c(51:66), c(2:4)]
colnames(expenses_data) <- c("AvgPercentile","AvgYearlyGrowthStaffCosts","AvgYearlyGrowthOtherCosts")
expenses_data$AvgPercentile = as.numeric(expenses_data$AvgPercentile)
expenses_data$AvgYearlyGrowthOtherCosts = as.numeric(expenses_data$AvgYearlyGrowthOtherCosts)
expenses_data$AvgYearlyGrowthStaffCosts = as.numeric(expenses_data$AvgYearlyGrowthStaffCosts)

mlm <- lm(cbind(AvgYearlyGrowthStaffCosts,AvgYearlyGrowthOtherCosts) ~ AvgPercentile, data=expenses_data)
summary(mlm)

# Multivariate Regression to Predict Average Yearly Growth Rate of Revenue (Matchday, Broadcast, Commercial) for a Top Ranking Team

revenue <- data.frame(read_excel("2022-student-research-case-study-football-soccer-data.xlsx",sheet="Revenue"))
revenue_data <- revenue[c(36:51), c(1:4)]
colnames(revenue_data) <- c("AvgYearlyGrowthMatchday","AvgYearlyGrowthBroadcast","AvgYearlyGrowthCommercial","AvgPercentile")
revenue_data$AvgPercentile = as.numeric(revenue_data$AvgPercentile)
revenue_data$AvgYearlyGrowthBroadcast = as.numeric(revenue_data$AvgYearlyGrowthBroadcast)
revenue_data$AvgYearlyGrowthCommercial = as.numeric(revenue_data$AvgYearlyGrowthCommercial)
revenue_data$AvgYearlyGrowthMatchday = as.numeric(revenue_data$AvgYearlyGrowthMatchday)

mlm <- lm(cbind(AvgYearlyGrowthBroadcast,AvgYearlyGrowthCommercial,AvgYearlyGrowthMatchday) ~ AvgPercentile, data=revenue_data)
summary(mlm)
