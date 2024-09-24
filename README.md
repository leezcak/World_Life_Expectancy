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
  
### Project Overview
This project aims to analyze world life expectancy trends using SQL-based data processing and exploratory data analysis (EDA). By investigating the global life expectancy and related variables such as GDP, BMI, and adult mortality, the goal is to derive insights into the factors that contribute to variations in life expectancy across countries and over time.

### Data Sources
The data for this project is from [Kaggle](https://www.kaggle.com/datasets/kumarajarshi/life-expectancy-who/data). Some data values have been randomly deleted or nullified to practice data cleaning.

### Tools
SQL: Data cleaning, transformation, and exploratory analysis.
Database Management System: Any system supporting SQL queries (e.g., MySQL, PostgreSQL).
Talbeau: Data visualisation and Dashboarding

### Data Cleaning
The data cleaning phase addressed several issues with the dataset to ensure accuracy and consistency:

**Removing Duplicates**: Checked for duplicate entries by creating a unique entry for each country per year, then deleted duplicate rows using a ROW_NUMBER(), OVER() and PARTITION BY functions.

**Handling Missing Data**: Populated empty Status fields by updating values based on the status of countries from previous or following records. Replaced missing life expectancy values by calculating the average life expectancy of the previous and next years for the same country.
**Final Data Checks**: Ensured that all Status and Lifeexpectancy fields were populated and that no null values remained.

### Exploratory Data Analysis
The EDA explored several key aspects of the dataset:

**Life Expectancy Trends:**
Analyzed the increase in life expectancy over time for each country.
Identified the countries with the highest and lowest average life expectancy, along with the largest increases over 15 years.

**GDP and Life Expectancy:**
Correlated life expectancy with GDP, identifying trends between countries with high GDP and those with low GDP.
Analyzed the average life expectancy and GDP for the top 50% of countries based on GDP.

**Development Status:**
Examined the relationship between a country's development status (Developing vs Developed) and life expectancy.

**Other Factors:**
Investigated the relationship between life expectancy and other variables, such as BMI and adult mortality, particularly for developed countries like the United States.

### Data Visualization
[Tableau dashboard](https://public.tableau.com/app/profile/ireneyejinlee/viz/WorldLifeExpectancyDashboard/Dashboard?publish=yes) helped bring insights to life through various charts and graphs. Below are the visualizations created to answer key questions:

**1. Geographical map**
A world map was used to visualize the average life expectancy by country, clearly differentiating between developed and developing nations. Countries with lower life expectancy were shaded in yellow/red, while those with higher life expectancy were green.

**2. Life Expectancy vs. GDP**
A scatter plot comparing average GDP and life expectancy, color-coded to show the development status (developed in green and developing in red). The trendline shows a moderate positive correlation between GDP and life expectancy, with developing countries generally clustering around lower GDP and life expectancy values.

**3. Average BMI**
A geographical map visualizing the average BMI across countries. The color gradient indicates whether countries are in the healthy, overweight, or obese BMI ranges, allowing for a visual comparison between BMI and regions of the world.

**4. Developed vs. Developing Countries' Life Expectancy**
Two number panels ompare the average life expectancy for developed(79.20) and developing(66.83) countries. This highlights the significant disparity between these two groups, with developed countries generally exhibiting higher life expectancies.

These visualizations derive helpful insights about life expectancy determinants.

### Findings
Countries with higher GDP generally exhibit higher life expectancy, though there are notable exceptions.
Developing countries tend to have lower average life expectancies compared to developed nations.
Certain factors like adult mortality and BMI show a significant correlation with life expectancy in many countries.

### Recommendations
Policy Interventions: For developing countries with low life expectancy, targeted health interventions (such as reducing adult mortality and improving access to nutrition) could help increase life expectancy.
Economic Policies: Improving life expectancy, particularly in lower-income countries, could lead to an increase in GDP.

### Discussions
Data Gaps: Some missing values (e.g., life expectancy) were imputed using the average between surrounding years, which may introduce some bias in the analysis. More robust methods could be employed if more data becomes available.
Currency and Inflation Adjustments: GDP values were not adjusted for inflation or currency differences, which might affect cross-country comparisons of life expectancy.
Outliers: A few countries showed extreme values for life expectancy or GDP, which may need further investigation to confirm the accuracy of the data or address the root causes of these anomalies.

