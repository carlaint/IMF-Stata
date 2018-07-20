********************************************************************************************************************

*Charts

********************************************************************************************************************
clear all
set more off
cd "\\data1\SPR\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\Regressions"

use "Temp\database_reg.dta", clear

* Define regression sample 

mdesc growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error /*
*/ pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment time_to_forecast GFC

gen g7 = country==111 | country==111 | country==112 | country==158 | country==156 | country==132 | country==136 | country==134
gen non_developing = (roc2018==1 & developing_==0)

gen prg_forecast = 1 if years_to_forecast>=0 & (year>=2003 & year <= 2017) & (roc2011==1 | roc2018==1)
gen sur_forecast = 1 if years_to_forecast>=0 & (year>=2003 & year <= 2017) & (roc2011==0 & roc2018==0) & g7==0

gen growth_sample_main = growth_error!=. & partnergrowth_error!=. & oil_notexp_error!=. & oil_exp_error!=. & commodity_notexp_error!=. & commodity_exp_error!=. /*
*/ & pb_adjustment!=. & high_pb_adjustment!=. & ca_adjustment!=. & high_ca_adjustment!=. & time_to_forecast!=. & GFC!=.

/*
gen growth_sample_alt1 = growth_error!=. & partnergrowth_error!=. & oil_notexp_error!=. & oil_exp_error!=. & commodity_notexp_error!=. & commodity_exp_error!=. /*
*/ & pb_adjustment!=. & ca_adjustment!=. & time_to_forecast!=. & GFC!=.

gen inflation_sample_main = inflation_error!=. & partnergrowth_error!=. & oil_notexp_error!=. & oil_exp_error!=. & commodity_notexp_error!=. & commodity_exp_error!=. /*
*/ & pb_adjustment!=. & high_pb_adjustment!=. & ca_adjustment!=. & high_ca_adjustment!=. & bm_ngdp_adj & time_to_forecast!=. & GFC!=.

gen inflation_sample_alt1 = inflation_error!=. & partnergrowth_error!=. & oil_notexp_error!=. & oil_exp_error!=. & commodity_notexp_error!=. & commodity_exp_error!=. /*
*/ & pb_adjustment!=. & ca_adjustment!=. & bm_ngdp_adj & time_to_forecast!=. & GFC!=.
*/



*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Distribution charts
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


* Growth forecast
putexcel set "Charts\charts_policy_induced_forecast_errors_baseline_main_growth.xlsx", sheet("WhiskerPlot") modify

// short-term
quiet sum growth_error if prg_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2003 & year<=2007, d
putexcel D4=(r(mean)) G4=(r(p75)) H4=(r(p25))
quiet sum growth_error if sur_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2003 & year<=2007, d
putexcel D5=(r(mean))  G5=(r(p75)) H5=(r(p25))

quiet sum growth_error if prg_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2008 & year<=2010, d
putexcel D6=(r(mean))  G6=(r(p75)) H6=(r(p25))
quiet sum growth_error if sur_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2008 & year<=2010, d
putexcel D7=(r(mean))  G7=(r(p75)) H7=(r(p25))

quiet sum growth_error if prg_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2011 & year<=2017, d
putexcel D8=(r(mean))  G8=(r(p75)) H8=(r(p25))
quiet sum growth_error if sur_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2011 & year<=2017, d
putexcel D9=(r(mean))  G9=(r(p75)) H9=(r(p25))

// medium-term
quiet sum growth_error if prg_forecast == 1 & years_to_forecast==1 & year>=2003 & year<=2007, d
putexcel D13=(r(mean)) G13=(r(p75)) H13=(r(p25))
quiet sum growth_error if sur_forecast == 1 & years_to_forecast==1 & year>=2003 & year<=2007, d
putexcel D14=(r(mean))  G14=(r(p75)) H14=(r(p25))

quiet sum growth_error if prg_forecast == 1 & years_to_forecast==1 & year>=2008 & year<=2010, d
putexcel D15=(r(mean))  G15=(r(p75)) H15=(r(p25))
quiet sum growth_error if sur_forecast == 1 & years_to_forecast==1 & year>=2008 & year<=2010, d
putexcel D16=(r(mean))  G16=(r(p75)) H16=(r(p25))

quiet sum growth_error if prg_forecast == 1 & years_to_forecast==1 & year>=2011 & year<=2017, d
putexcel D17=(r(mean))  G17=(r(p75)) H17=(r(p25))
quiet sum growth_error if sur_forecast == 1 & years_to_forecast==1 & year>=2011 & year<=2017, d
putexcel D18=(r(mean))  G18=(r(p75)) H18=(r(p25))


* Inflation forecast
putexcel set "Charts\charts_policy_induced_forecast_errors_baseline_main_inflation.xlsx", sheet("WhiskerPlot") modify

// short-term
quiet sum inflation_error if prg_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2003 & year<=2007, d
putexcel D4=(r(mean)) G4=(r(p75)) H4=(r(p25))
quiet sum inflation_error if sur_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2003 & year<=2007, d
putexcel D5=(r(mean))  G5=(r(p75)) H5=(r(p25))

quiet sum inflation_error if prg_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2008 & year<=2010, d
putexcel D6=(r(mean))  G6=(r(p75)) H6=(r(p25))
quiet sum inflation_error if sur_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2008 & year<=2010, d
putexcel D7=(r(mean))  G7=(r(p75)) H7=(r(p25))

quiet sum inflation_error if prg_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2011 & year<=2017, d
putexcel D8=(r(mean))  G8=(r(p75)) H8=(r(p25))
quiet sum inflation_error if sur_forecast == 1 & (years_to_forecast>=1 & years_to_forecast<=5) & year>=2011 & year<=2017, d
putexcel D9=(r(mean))  G9=(r(p75)) H9=(r(p25))

// medium-term
quiet sum inflation_error if prg_forecast == 1 & years_to_forecast==1 & year>=2003 & year<=2007, d
putexcel D13=(r(mean)) G13=(r(p75)) H13=(r(p25))
quiet sum inflation_error if sur_forecast == 1 & years_to_forecast==1 & year>=2003 & year<=2007, d
putexcel D14=(r(mean))  G14=(r(p75)) H14=(r(p25))

quiet sum inflation_error if prg_forecast == 1 & years_to_forecast==1 & year>=2008 & year<=2010, d
putexcel D15=(r(mean))  G15=(r(p75)) H15=(r(p25))
quiet sum inflation_error if sur_forecast == 1 & years_to_forecast==1 & year>=2008 & year<=2010, d
putexcel D16=(r(mean))  G16=(r(p75)) H16=(r(p25))

quiet sum inflation_error if prg_forecast == 1 & years_to_forecast==1 & year>=2011 & year<=2017, d
putexcel D17=(r(mean))  G17=(r(p75)) H17=(r(p25))
quiet sum inflation_error if sur_forecast == 1 & years_to_forecast==1 & year>=2011 & year<=2017, d
putexcel D18=(r(mean))  G18=(r(p75)) H18=(r(p25))





*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Contribution charts
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

* Baseline main
sort country ctyname weo year
export excel country ctyname weo_year year prg_forecast sur_forecast roc2011 roc2018 gra_prgt developing_ non_developing growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj fb_error ca_error /*
*/ bm_ngdp_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC using /*
*/ "Charts\charts_policy_induced_forecast_errors_baseline_main_growth.xlsx" if years_to_forecast>=0 & (year>=2003 & year <= 2017) & growth_sample_main==1/*
*/ , firstrow(variables) sheet("Contribution_data", modify) cell(A26) 


export excel country ctyname weo_year year prg_forecast sur_forecast roc2011 roc2018 gra_prgt developing_ non_developing inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj fb_error ca_error /*
*/ bm_ngdp_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC using /*
*/ "Charts\charts_policy_induced_forecast_errors_baseline_main_inflation.xlsx" if years_to_forecast>=0 & (year>=2003 & year <= 2017) & inflation_sample_main==1/*
*/ , firstrow(variables) sheet("Contribution_data", modify) cell(A26) 


* Baseline alt1
sort country ctyname weo year
export excel country ctyname weo_year year prg_forecast sur_forecast roc2011 roc2018 gra_prgt developing_ non_developing growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj fb_error ca_error /*
*/ bm_ngdp_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC using /*
*/ "Charts\charts_policy_induced_forecast_errors_baseline_alt1_growth.xlsx" if years_to_forecast>=0 & (year>=2003 & year <= 2017) & growth_sample_alt1==1/*
*/ , firstrow(variables) sheet("Contribution_data", modify) cell(A26) 


export excel country ctyname weo_year year prg_forecast sur_forecast roc2011 roc2018 gra_prgt developing_ non_developing inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj fb_error ca_error /*
*/ bm_ngdp_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC using /*
*/ "Charts\charts_policy_induced_forecast_errors_baseline_alt1_inflation.xlsx" if years_to_forecast>=0 & (year>=2003 & year <= 2017) & inflation_sample_alt1==1/*
*/ , firstrow(variables) sheet("Contribution_data", modify) cell(A26) 







* Robustness 3 main
sort country ctyname weo year
export excel country ctyname weo_year year prg_forecast sur_forecast roc2011 roc2018 gra_prgt developing_ non_developing growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj fb_error ca_error /*
*/ bm_ngdp_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC oil_g_error commodity_g_error_ using /*
*/ "Charts\charts_policy_induced_forecast_errors_robust3_main_growth.xlsx" if years_to_forecast>=0 & (year>=2003 & year <= 2017) & growth_sample_main==1/*
*/ , firstrow(variables) sheet("Contribution_data", modify) cell(A26) 
