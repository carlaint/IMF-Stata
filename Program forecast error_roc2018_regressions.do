clear all
set more off
cd "//data1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/Section-Growth/ForecastOptimism/Regressions"
local date: display %td_CCYY_NN_DD date(c(current_date), "DMY")
global date_str = subinstr(trim("`date'"), " " , "-", .)
use "Temp/database_reg.dta", clear

* Define regression sample 
gen g7 = country==111 | country==111 | country==112 | country==158 | country==156 | country==132 | country==136 | country==134
gen non_developing = (roc2018==1 & developing_==0)
gen nondev_pg_error = non_developing*partnergrowth_error

* Exclude Nov and Dec as these two months are too close to year end, hence the release of actual data. 
gen prg_forecast = 1 if years_to_forecast>=0 & (year>=2003 & year <= 2017) & (roc2011==1 | roc2018==1) & (month(action)<=10 | year!=year(action))
* Exclude G7 in surveillance cases
gen sur_forecast = 1 if years_to_forecast>=0 & (year>=2003 & year <= 2017) & (roc2011==0 & roc2018==0) & (month(action)<=10 | year!=year(action)) & g7==0

xtset code years_to_forecast

* Generate outliers
gen outlier = 0
local var "growth_error partnergrowth_error"
foreach v of local var {
egen pct1_`v' = pctile(`v') if roc2018==1, p(1)
egen pct99_`v' = pctile(`v') if roc2018==1, p(99)
replace outlier = 1 if `v' < pct1_`v' | `v' > pct99_`v'
drop pct1_`v' pct99_`v'
}



*********************************************************************************************

* Baseline Specifications - Growth

*********************************************************************************************

* Main Specification (WEO): interactions, country*WEO fixed effects

// Program period forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1, fe
outreg2 using "Results/baseline_main_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", fe 
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", fe 
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if sur_forecast==1, fe 
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// Program period forecasts 2003-2007
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2003 & year<=2007, fe
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2003-2007) 

// Program period forecasts 2011-2016
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2011 & year<=2017, fe
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2011-2016) 

// Surveillance period forecasts 2003-2007
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2003 & year<=2007, fe
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2003-2007) 

// Surveillance period forecasts 2011-2016
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2011 & year<=2017, fe
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2011-2016) 

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1, fe 
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, fe 
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/baseline_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 




* Alternative Specification 1 (WEO): no interactions, country*WEO fixed effects
// Program period forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if sur_forecast==1, fe 

outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// Program period forecasts 2003-2007
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2003 & year<=2007, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2003-2007) 

// Program period forecasts 2011-2016
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2011 & year<=2017, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2011-2016) 

// Surveillance period forecasts 2003-2007
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2003 & year<=2007, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2003-2007) 

// Surveillance period forecasts 2011-2016
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2011 & year<=2017, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2011-2016) 

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/baseline_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 




* Alternative Specification 2 (WEO): interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, r

outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// Program period forecasts 2003-2007
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & year>=2003 & year<=2007, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts 2003-2007) 

// Program period forecasts 2011-2016
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & year>=2011 & year<=2017, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts 2011-2016) 

// Surveillance period forecasts 2003-2007
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast == 1 & year>=2003 & year<=2007, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts 2003-2007) 

// Surveillance period forecasts 2011-2016
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast == 1 & year>=2011 & year<=2017, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts 2011-2016) 

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), r
outreg2 using "Results/baseline_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 




* Alternative Specification 3 (WEO): no interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1, r
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", r
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", r
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, r
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1, r
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, r
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), r 
outreg2 using "Results/baseline_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 






*********************************************************************************************

* Baseline Specifications - Inflation

*********************************************************************************************

* Main Specification (WEO): interactions, country*WEO fixed effects

// Program period forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if sur_forecast==1, fe 

outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// Program period forecasts 2003-2007
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2003 & year<=2007, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2003-2007) 

// Program period forecasts 2011-2016
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2011 & year<=2017, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2011-2016) 

// Surveillance period forecasts 2003-2007
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2003 & year<=2007, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2003-2007) 

// Surveillance period forecasts 2011-2016
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2011 & year<=2017, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2011-2016) 

// ROC2018 Sample
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 




* Alternative Specification 1 (WEO): no interactions, country*WEO fixed effects
// Program period forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if sur_forecast==1, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// Program period forecasts 2003-2007
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2003 & year<=2007, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2003-2007) 

// Program period forecasts 2011-2016
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & year>=2011 & year<=2017, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Program Forecasts 2011-2016) 

// Surveillance period forecasts 2003-2007
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2003 & year<=2007, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2003-2007) 

// Surveillance period forecasts 2011-2016
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if sur_forecast == 1 & year>=2011 & year<=2017, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.*) append label ctitle(Surveillance Forecasts 2011-2016) 

// ROC2018 Sample
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg inflation_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 




* Alternative Specification 2 (WEO): interactions, country+WEO fixed effects
// Program period forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1, r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1, r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj  /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 





* Alternative Specification 3 (WEO): no interactions, country+WEO fixed effects
// Program period forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1, r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1, r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), r 
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 






*********************************************************************************************

* Robustness checks

*********************************************************************************************


*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Excluding one country at a time to exclude outliers
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



* Main specification_${date_str} (WEO): interactions, country*WEO fixed effects


// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1, fe 
outreg2 using "Results/robust1_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) replace label ctitle(ROC 2018) 

levelsof country if prg_forecast == 1 & roc2018==1, local(ctry)
foreach c of local ctry {
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & country!=`c', fe 
outreg2 using "Results/robust1_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) append label ctitle(`c') 
}


levelsof year if prg_forecast == 1 & roc2018==1, local(yr)
foreach y of local yr {
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & year!=`y', fe 
outreg2 using "Results/robust1_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) append label ctitle(`y') 
}

* Results: Djibouti is found to drive the insignificance of trading partner forecast errors in the ROC 2018 sample.



*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Exclude ten observations to find out what drives the nonsignificance for trading parterner forecast error
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1, fe 
outreg2 using "Results/robust2_exc_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) replace label ctitle(ROC 2018)
outreg2 using "Results/robust2_inc_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) replace label ctitle(ROC 2018)


levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_1)
foreach c_1 of local ctry_1 {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_2)
foreach c_2 of local ctry_2 {
if ("`c_1'" < "`c_2'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_3)
foreach c_3 of local ctry_3 {
if ("`c_2'" < "`c_3'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_4)
foreach c_4 of local ctry_4 {
if ("`c_3'" < "`c_4'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_5)
foreach c_5 of local ctry_5 {
if ("`c_4'" < "`c_5'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_6)
foreach c_6 of local ctry_6 {
if ("`c_5'" < "`c_6'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_7)
foreach c_7 of local ctry_7 {
if ("`c_6'" < "`c_7'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_8)
foreach c_8 of local ctry_8 {
if ("`c_7'" < "`c_8'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_9)
foreach c_9 of local ctry_9 {
if ("`c_8'" < "`c_9'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_10)
foreach c_10 of local ctry_10 {
if ("`c_9'" < "`c_10'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_11)
foreach c_11 of local ctry_11 {
if ("`c_10'" < "`c_11'") {
levelsof country if prg_forecast == 1 & roc2018==1, local(ctry_12)
foreach c_12 of local ctry_12 {
if ("`c_11'" < "`c_12'") {


// ROC2018 Sample

xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (country != `c_1' & country != `c_2' & country != `c_3' & country != `c_4' & country != `c_5' & country != `c_6' & country != `c_7' & country != `c_8' & country != `c_9' & country != `c_10' & country != `c_11' & country != `c_12'), fe 
outreg2 using "Results/robust2_exc_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) append label ctitle(`c_1'_`c_2'_`c_3'_`c_4'_`c_5'_`c_6'_`c_7'_`c_8'_`c_9'_`c_10'_`c_11'_`c_12')

xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_to_forecast GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (country == `c_1' | country == `c_2' | country == `c_3' | country == `c_4' | country == `c_5' | country == `c_6' | country == `c_7' | country == `c_8' | country == `c_9' | country == `c_10' | country == `c_11' | country == `c_12'), fe
outreg2 using "Results/robust2_inc_main_specification_${date_str}_roc2018_${date_str}.xls", drop (o.* cty_d* weo_d*) stats(pval) append label ctitle(`c_1'_`c_2'_`c_3'_`c_4'_`c_5'_`c_6'_`c_7'_`c_8'_`c_9'_`c_10'_`c_11'_`c_12')
}
else
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}




*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Exclude time to forecast
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 , fe 
outreg2 using "Results/robust3_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & developing_==1, fe 
outreg2 using "Results/robust3_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/robust3_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 



*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Exclude Djibouti (611)
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & country!=611, fe 
outreg2 using "Results/robust4_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & country!=611 & developing_==1, fe 
outreg2 using "Results/robust4_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & country!=611 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/robust4_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development)

* Check whether Djibouti is indeed an outlier, and which variable for Djibouti is an outlier. 
sum growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment if prg_forecast==1 & roc2018==1
sum growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment if prg_forecast==1 & roc2018==1 & country==611






*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Use private flows instead of CA adjustment
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment pvt_adjustment GFC if prg_forecast == 1 & roc2018==1 , fe 
outreg2 using "Results/robust5_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment pvt_adjustment GFC if prg_forecast == 1 & roc2018==1 & developing_==1, fe 
outreg2 using "Results/robust5_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment pvt_adjustment GFC if prg_forecast == 1 & roc2018==1 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/robust5_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 




*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Exchange rate regime
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 , fe 
outreg2 using "Results/robust6_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(ROC 2018) 

xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & (fxregime==9|fxregime==10), fe 
outreg2 using "Results/robust6_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Float) 

xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ GFC /*
*/  if prg_forecast == 1 & roc2018==1 & fxregime<=8, fe 
outreg2 using "Results/robust6_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Managed) 






*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Forecast years after the GFC
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// ROC2018 Sample
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment GFC /*
*/  if prg_forecast == 1 & roc2018==1 & year>=2011 , fe 
outreg2 using "Results/robust7_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment GFC /*
*/  if prg_forecast == 1 & roc2018==1 & year>=2011 & developing_==1, fe 
outreg2 using "Results/robust7_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment GFC /*
*/  if prg_forecast == 1 & roc2018==1 & year>=2011 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1), fe 
outreg2 using "Results/robust7_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Non-development) 

















*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Alternative Specifications: with fiscal/CA forecast errors, broad money, oil
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

* Main Specification (WEO): interactions, country*WEO fixed effects

// Program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1, fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 0, fe 

outreg2 using "Results/robustness_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)
 
// ROC2018 sample
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1 & (roc2018==1|year>=2011), fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts) 


* Alternative Specification 1 (WEO): no interactions, country*WEO fixed effects

// Program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1, fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 0, fe 

outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if prg_forecast == 1 & (roc2018==1|year>=2011), fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

* Alternative Specification 2 (WEO): interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1, r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, r

outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & (roc2018==1|year>=2011), r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

* Alternative Specification 3 (WEO): no interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1, r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "GRA", r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & gra_prgt == "PRGT", r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & (roc2018==1|year>=2011), r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

// ROC2018 Sample: Development
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & (roc2018==1|year>=2011) & development_==1, r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if prg_forecast == 1 & (roc2018==1|year>=2011) & development_!=1, r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)




*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Dynamic panel data method (Arellano–Bond) to include lagged variables
* ssc install xtabond2
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gen weo_n = .
replace weo_n = 1 if weo=="Apr2003"
replace weo_n = 2 if weo=="Oct2003"
replace weo_n = 3 if weo=="Apr2004"
replace weo_n = 4 if weo=="Sep2004"
replace weo_n = 5 if weo=="Apr2005"
replace weo_n = 6 if weo=="Sep2005"
replace weo_n = 7 if weo=="Apr2006"
replace weo_n = 8 if weo=="Sep2006"
replace weo_n = 9 if weo=="Apr2007"
replace weo_n = 10 if weo=="Oct2007"
replace weo_n = 11 if weo=="Apr2008"
replace weo_n = 12 if weo=="Oct2008"
replace weo_n = 13 if weo=="Apr2009"
replace weo_n = 14 if weo=="Oct2009"
replace weo_n = 15 if weo=="Apr2010"
replace weo_n = 16 if weo=="Oct2010"
replace weo_n = 17 if weo=="Apr2011"
replace weo_n = 18 if weo=="Sep2011"
replace weo_n = 19 if weo=="Apr2012"
replace weo_n = 20 if weo=="Oct2012"
replace weo_n = 21 if weo=="Apr2013"
replace weo_n = 22 if weo=="Oct2013"
replace weo_n = 23 if weo=="Apr2014"
replace weo_n = 24 if weo=="Oct2014"
replace weo_n = 25 if weo=="Apr2015"
replace weo_n = 26 if weo=="Oct2015"
replace weo_n = 27 if weo=="Apr2016"
replace weo_n = 28 if weo=="Oct2016"
replace weo_n = 29 if weo=="Apr2017"
replace weo_n = 30 if weo=="Oct2017"

gen id = year*1000+country
tsset id weo_n

xtabond2 growth_error l.growth_error L(0/1).(partnergrowth_error pb_adjustment ca_adjustment)/*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if sur_forecast==1, gmm(L.(partnergrowth_error pb_adjustment ca_adjustment)) iv(weo_d1-weo_d30) robust


