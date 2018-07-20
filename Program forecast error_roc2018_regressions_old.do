clear all
set more off
cd "//data1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/Section-Growth/ForecastOptimism/Regressions"
local date: display %td_CCYY_NN_DD date(c(current_date), "DMY")
global date_str = subinstr(trim("`date'"), " " , "-", .)
use "Temp/database_reg.dta", clear



*********************************************************************************************

* Baseline Specifications - Growth

*********************************************************************************************

* Main Specification (WEO): interactions, country*WEO fixed effects

// Program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_main_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_main_specification_${date_str}.xls", append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_main_specification_${date_str}.xls", append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using "Results/baselilne_main_specification_${date_str}.xls", append label ctitle(Surveillance Forecasts)
 
// ROC2018 Sample
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_main_specification_${date_str}.xls", append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_main_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_main_specification_${date_str}.xls", append label ctitle(Non-development) 




* Alternative Specification 1 (WEO): no interactions, country*WEO fixed effects
// Program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_alt1_specification_${date_str}.xls", append label ctitle(Non-development) 




* Alternative Specification 2 (WEO): interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r

outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt2_specification_${date_str}.xls", append label ctitle(Non-development) 




* Alternative Specification 3 (WEO): no interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , r 
outreg2 using "Results/baselilne_alt3_specification_${date_str}.xls", append label ctitle(Non-development) 






*********************************************************************************************

* Baseline Specifications - Inflation

*********************************************************************************************

* Main Specification (WEO): interactions, country*WEO fixed effects

// Program period forecasts
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", append label ctitle(Surveillance Forecasts)
 
// ROC2018 Sample
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_main_specification_${date_str}.xls", append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_inflation_main_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_inflation_main_specification_${date_str}.xls", append label ctitle(Non-development) 




* Alternative Specification 1 (WEO): no interactions, country*WEO fixed effects
// Program period forecasts
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment  bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baseline_inflation_alt1_specification_${date_str}.xls", append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_inflation_alt1_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
xtreg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/baselilne_inflation_alt1_specification_${date_str}.xls", append label ctitle(Non-development) 




* Alternative Specification 2 (WEO): interactions, country+WEO fixed effects
// Program period forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_inflation_alt2_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg inflation_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj high_bm_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_inflation_alt2_specification_${date_str}.xls", append label ctitle(Non-development) 





* Alternative Specification 3 (WEO): no interactions, country+WEO fixed effects
// Program period forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baseline_inflation_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(ROC 2018) 

// ROC2018 Sample: Development
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & developing_==1 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/baselilne_inflation_alt3_specification_${date_str}.xls", append label ctitle(Development) 

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg inflation_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj /*
*/ time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & roc2018==1 & year <= 2016 & (post_financial_crisis_structural==1 | political_transformation==1 | commodity_shocks==1) & (month(action)<=10 | year!=year(action)) , r 
outreg2 using "Results/baselilne_inflation_alt3_specification_${date_str}.xls", append label ctitle(Non-development) 






*********************************************************************************************

* Robustness checks

*********************************************************************************************


*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
* Alternative Specifications: with fiscal/CA forecast errors, broad money, oil
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

* Main Specification (WEO): interactions, country*WEO fixed effects

// Program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using "Results/robustness_main_specification_${date_str}.xls", append label ctitle(Surveillance Forecasts)
 
// ROC2018 sample
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & (roc2018==1|year>=2011) & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_main_specification_${date_str}.xls", append label ctitle(Program Forecasts) 


* Alternative Specification 1 (WEO): no interactions, country*WEO fixed effects

// Program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", replace label ctitle(Program Forecasts) 

// GRA program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & (roc2018==1|year>=2011) & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using "Results/robustness_alt1_specification_${date_str}.xls", append label ctitle(Program Forecasts)

* Alternative Specification 2 (WEO): interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r

outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & (roc2018==1|year>=2011) & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt2_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

* Alternative Specification 3 (WEO): no interactions, country+WEO fixed effects
// Program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) replace label ctitle(Program Forecasts) 

// GRA program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(GRA Program Forecasts) 

// PRGT program period forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(PRGT Program Forecasts) 

// Surveillance forecasts
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Surveillance Forecasts)

// ROC2018 Sample
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & (roc2018==1|year>=2011) & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

// ROC2018 Sample: Development
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & (roc2018==1|year>=2011) & year <= 2016 & development_==1 & (month(action)<=10 | year!=year(action)) , r
outreg2 using "Results/robustness_alt3_specification_${date_str}.xls", drop (o.* cty_d* weo_d*) append label ctitle(Program Forecasts)

// ROC2018 Sample: Post-financial crisis/structural, Political transformation, Commodity shocks
reg growth_error partnergrowth_error pb_adjustment ca_adjustment bm_ngdp_adj l.fb_error l.ca_error l.bm_ngdp_error/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC cty_d* weo_d* /*
*/  if (review=="") & (program_is_prgt==1 | program_is_gra==1) & years_to_forecast>=0  & (roc2018==1|year>=2011) & year <= 2016 & development_!=1 & (month(action)<=10 | year!=year(action)) , r
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
*/  if (review=="") & (program_is_gra==0 & program_is_prgt==0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , gmm(L.(partnergrowth_error pb_adjustment ca_adjustment)) iv(weo_d1-weo_d30) robust






