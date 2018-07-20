set more off
use "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\Regressions\Temp\database_reg.dta", clear
//preserve

// To run the do file for programs and post-financial crisis country grouping


//Short term GDP growth forecast errors
//Forecast minus actual, percentage points, 1 year ahead

//OLD ROC
sum growth_error if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),d

egen mean_st0211=mean(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action))

egen p75_st0211=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),p(75)

egen p25_st0211=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),p(25)

//NEW ROC
sum growth_error if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action))

egen mean_st1217=mean(growth_error) if(review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action))
egen p75_st1217=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)),p(75)
egen p25_st1217=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast==1 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)),p(25)


//Medium term GDP growth
//Forecast minus actual, percentage points, two to four years ahead

//OLD ROC
sum growth_error if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)), d

egen mean_mt0211=mean(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action))
egen p75_mt0211=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),p(75)
egen p25_mt0211=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),p(25)

//NEW ROC
sum growth_error if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)), d

egen mean_mt1217=mean(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action))
egen p75_mt1217=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)),p(75)
egen p25_mt1217=pctile(growth_error)if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=2 & years_to_forecast<=4 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)),p(25)

//Medium term GDP growth version 2
//Forecast minus actual, percentage points, one to five years ahead

//OLD ROC
sum growth_error if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)), d

egen mean_mt0211v2=mean(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action))
egen p75_mt0211v2=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),p(75)
egen p25_mt0211v2=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2002 & year <= 2011 & (month(action)<=10 | year !=year(action)),p(25)

//NEW ROC
sum growth_error if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)), d

egen mean_mt1217v2=mean(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action))
egen p75_mt1217v2=pctile(growth_error) if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)),p(75)
egen p25_mt1217v2=pctile(growth_error)if (review=="") & (post_financial_crisis_structural==1) & years_to_forecast>=1 & years_to_forecast<=5 & year>= 2012 & year <= 2017 & (month(action)<=10 | year !=year(action)),p(25)


//Transform to actual minus forecast
replace mean_st0211=mean_st0211*-1
replace p75_st0211=p75_st0211*-1
replace p25_st0211=p25_st0211*-1

replace mean_st1217=mean_st1217*-1
replace p75_st1217=p75_st1217*-1
replace p25_st1217=p25_st1217*-1

replace mean_mt0211=mean_mt0211*-1
replace p75_mt0211=p75_mt0211*-1
replace p25_mt0211=p25_mt0211*-1

replace mean_mt1217=mean_mt1217*-1
replace p75_mt1217=p75_mt1217*-1
replace p25_mt1217=p25_mt1217*-1

replace mean_mt0211v2=mean_mt0211v2*-1
replace p75_mt0211v2=p75_mt0211v2*-1
replace p25_mt0211v2=p25_mt0211v2*-1

replace mean_mt1217v2=mean_mt1217v2*-1
replace p75_mt1217v2=p75_mt1217v2*-1
replace p25_mt1217v2=p25_mt1217v2*-1

//collapse
collapse (mean) mea* p75* p25*

//reshape
gen id = _n
reshape long mean_ p25_ p75_, i(id) j(type) string


