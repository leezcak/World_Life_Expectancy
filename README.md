# World Life Expectancy Analysis

### Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Findings](#findings)
- [Recommendations](#recommendations)
- [Discussions](#discussions)
- [References](#references)
  
### Project Overview
This project aims to analyze world life expectancy trends using SQL-based data processing and exploratory data analysis (EDA). By investigating the global life expectancy and related variables such as GDP, BMI, and adult mortality, the goal is to derive insights into the factors that contribute to variations in life expectancy across countries and over time.

### Data Sources
The data for this project is sourced from a dataset containing information on world life expectancy across multiple countries and years, with fields for GDP, BMI, life expectancy, and country development status (Developing/Developed).

### Tools
SQL: Used for data cleaning, transformation, and exploratory analysis.
Database Management System: Any system supporting SQL queries (e.g., MySQL, PostgreSQL).

### Data Cleaning
The data cleaning phase addressed several issues with the dataset to ensure accuracy and consistency:

Removing Duplicates: Checked for duplicate entries by concatenating Country and Year, then deleted duplicate rows using a ROW_NUMBER() window function.
Handling Missing Data:
Populated empty Status fields by updating values based on the status of countries from previous or following records.
Replaced missing life expectancy values by calculating the average life expectancy of the previous and next years for the same country.
Final Data Checks: Ensured that all Status and Lifeexpectancy fields were populated and that no null values remained.

### Exploratory Data Analysis
The EDA explored several key aspects of the dataset:

Life Expectancy Trends:

Analyzed the increase in life expectancy over time for each country.
Identified the countries with the highest and lowest average life expectancy, along with the largest increases over 15 years.
GDP and Life Expectancy:

Correlated life expectancy with GDP, identifying trends between countries with high GDP and those with low GDP.
Analyzed the average life expectancy and GDP for the top 50% of countries based on GDP.
Development Status:

Examined the relationship between a country's development status (Developing vs Developed) and life expectancy.
Other Factors:

Investigated the relationship between life expectancy and other variables, such as BMI and adult mortality, particularly for developed countries like the United Kingdom.

### Findings
Countries with higher GDP generally exhibit higher life expectancy, though there are notable exceptions.
Developing countries tend to have lower average life expectancies compared to developed nations.
Certain factors like adult mortality and BMI show a significant correlation with life expectancy in many countries.

### Recommendations
Policy Interventions: For developing countries with low life expectancy, targeted health interventions (such as reducing adult mortality and improving access to nutrition) could help increase life expectancy.
Economic Policies: Increasing GDP per capita, especially in lower-income countries, could have a positive effect on life expectancy, suggesting that economic growth and healthcare investment should go hand in hand.

### Discussions
Data Gaps: Some missing values (e.g., life expectancy) were imputed using the average between surrounding years, which may introduce some bias in the analysis. More robust methods could be employed if more data becomes available.
Currency and Inflation Adjustments: GDP values were not adjusted for inflation or currency differences, which might affect cross-country comparisons of life expectancy.
Outliers: A few countries showed extreme values for life expectancy or GDP, which may need further investigation to confirm the accuracy of the data or address the root causes of these anomalies.

### References
Data source or description of where the world life expectancy dataset is located.
Research or articles on the relationship between GDP and life expectancy for further reading.
