clear all
set more off
cd "//data1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/Section-Growth/ForecastOptimism/Regressions"

*****************************************************************************************************************
* Create groupings for 2018 and 2011 ROC sample
*****************************************************************************************************************

* ROC 2018 programs
import excel using "//data1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/2018ROC List of GRA and PRGT.xlsx", sheet("2018ROC__Groupings")

keep C-P T M

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[4]'"
  rename `var' `=lower(strtoname(`var'[4]))'
}

drop in 1/5
drop if arrangement_number==""

// approval and expiry year
gen year = substr(date_of_arrangement, length(date_of_arrangement)-3,length(date_of_arrangement))
label var year "Year"
gen app_year = substr(date_of_arrangement, length(date_of_arrangement)-3,length(date_of_arrangement))
label var year "Approval Year"
gen orig_expiry = substr(initial_end_date, length(initial_end_date)-3,length(initial_end_date))
label var orig_expiry "Original Expiry Year"
gen actual_expiry = substr(actual_current_expiration_date, length(actual_current_expiration_date)-3,length(actual_current_expiration_date))
label var actual_expiry "Actual Expiry Year"
// approval and expiry month
gen month = substr(date_of_arrangement, length(date_of_arrangement)-6,length(date_of_arrangement)-6)
label var month "Month"
gen app_month = substr(date_of_arrangement, length(date_of_arrangement)-6,length(date_of_arrangement)-6)
label var app_month "Approval Month"
gen orig_exp_month = substr(initial_end_date, length(initial_end_date)-6,length(initial_end_date)-6)
label var orig_exp_month "Original Expiry Month"
gen act_exp_month = substr(actual_current_expiration_date, length(actual_current_expiration_date)-6,length(actual_current_expiration_date)-6)
label var act_exp_month "Actual Expiry Month"

local exp "month app_month orig_exp_month act_exp_month"
foreach v of local exp {
replace `v'="1" if `v'=="jan"
replace `v'="2" if `v'=="feb"
replace `v'="3" if `v'=="mar"
replace `v'="4" if `v'=="apr"
replace `v'="5" if `v'=="may"
replace `v'="6" if `v'=="jun"
replace `v'="7" if `v'=="jul"
replace `v'="8" if `v'=="aug"
replace `v'="9" if `v'=="sep"
replace `v'="10" if `v'=="oct"
replace `v'="11" if `v'=="nov"
replace `v'="12" if `v'=="dec"
}

rename country country_name
rename country_code country

replace post_financial_crisis_structural = cond(post_financial_crisis_structural=="x", "1", "0")
replace political_transformation = cond(political_transformation=="x", "1", "0")
replace commodity_shocks = cond(commodity_shocks=="x", "1", "0")
replace developing_ =cond(developing_=="x", "1", "0")

replace exceptional_access = cond(exceptional_access=="Y", "1","0")
rename precautionary_at_program_approva precautionary
replace precautionary = cond(precautionary=="Y", "1", "0")

destring, replace

gen roc2018=1
compress

keep arrangement_number country_name country post_financial_crisis_structural political_transformation commodity_shocks developing_ precautionary exceptional_access year month app_year orig_expiry actual_expiry app_month act_exp_month gra_prgt roc2018
save "Stata Files/program_init_roc2018.dta", replace


use "Stata Files/program_init_roc2018.dta", clear
gen prg_length = (actual_expiry - year)*12+act_exp_month-app_month+1
label var prg_length "Program Length"
expand prg_length
sort country_name year month

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
		if month[`i'-1] < 12 {
			replace year = year[`i'-1] in `i'
			replace month = month[`i'-1]+1 in `i'
		}
		else {
		replace year = year[`i'-1]+1 in `i'
		replace month = 1 in `i'
		}
		}
	else
}

gsort country year -actual_expiry -act_exp_month
duplicates drop country year month, force

rename year weo_year
rename month weo_month
save "Stata Files/program_periods_roc2018.dta", replace



* GRA program data for ROC 2011
import excel using "//data1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/2018ROC List of GRA and PRGT.xlsx", sheet("2011ROC_GRA") clear
keep A-J
// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[4]'"
  rename `var' `=lower(strtoname(`var'[4]))'
}

drop in 1/4
drop if country_name==""
gen year = substr(approval_date, length(approval_date)-3,length(approval_date))
label var year "Year"
gen app_year = substr(approval_date, length(approval_date)-3,length(approval_date))
label var app_year "Approval Year"
gen orig_expiry = substr(initial_end_date, length(initial_end_date)-3,length(initial_end_date))
label var orig_expiry "Original Expiry Year"
gen actual_expiry = substr(end_date, length(end_date)-3,length(end_date))
label var actual_expiry "Actual Expiry Year"

replace exceptional_access = cond(exceptional_access=="Y", "1","0")
rename precautionary__using_mona_ precautionary
replace precautionary = cond(precautionary=="Y", "1", "0")

duplicates drop country_code year, force

// approval and expiry month
gen month = lower(substr(approval_date, length(approval_date)-6,length(approval_date)-6))
label var month "Month"
gen app_month = lower(substr(approval_date, length(approval_date)-6,length(approval_date)-6))
label var app_month "Approval Month"
gen orig_exp_month = substr(initial_end_date, length(initial_end_date)-6,length(initial_end_date)-6)
label var orig_exp_month "Original Expiry Month"
gen act_exp_month = substr(end_date, length(end_date)-6,length(end_date)-6)
label var act_exp_month "Actual Expiry Month"
gen app_1sthalf = app_month=="jan" | app_month=="feb" | app_month=="mar" | app_month=="apr" | app_month=="may" | app_month=="jun"
gen exp_1sthalf = act_exp_month=="jan" | act_exp_month=="feb" | act_exp_month=="mar" | act_exp_month=="apr" | act_exp_month=="may" | act_exp_month=="jun"

local exp "month app_month orig_exp_month act_exp_month"
foreach v of local exp {
replace `v'="1" if `v'=="jan"
replace `v'="2" if `v'=="feb"
replace `v'="3" if `v'=="mar"
replace `v'="4" if `v'=="apr"
replace `v'="5" if `v'=="may"
replace `v'="6" if `v'=="jun"
replace `v'="7" if `v'=="jul"
replace `v'="8" if `v'=="aug"
replace `v'="9" if `v'=="sep"
replace `v'="10" if `v'=="oct"
replace `v'="11" if `v'=="nov"
replace `v'="12" if `v'=="dec"
}

rename country_code country

keep country_name country arrangement_type arrangement_number orig_expiry actual_expiry precautionary exceptional_access year month app_year app_month orig_exp_month act_exp_month
destring, replace

gen gra_prgt = "GRA"
gen roc2011=1

compress
save "Stata Files/gra_program_init_roc2011.dta", replace

* 2011 GRA Program periods
gen prg_length = (actual_expiry - year)*12+act_exp_month-app_month+1
label var prg_length "Program Length"
expand prg_length
sort country_name year month

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
		if month[`i'-1] < 12 {
			replace year = year[`i'-1] in `i'
			replace month = month[`i'-1]+1 in `i'
		}
		else {
		replace year = year[`i'-1]+1 in `i'
		replace month = 1 in `i'
		}
		}
	else
}

gsort country year -actual_expiry -act_exp_month
duplicates drop country year month, force

rename year weo_year
rename month weo_month
save "Stata Files/gra_program_periods_roc2011.dta", replace


* PRGT program data for ROC 2011
import excel using "//data1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/2018ROC List of GRA and PRGT.xlsx", sheet("2011ROC_PRGT") clear
keep A-G

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
drop if country_name==""
gen year = substr(approval_date, length(approval_date)-3,length(approval_date))
label var year "Year"
gen app_year = substr(approval_date, length(approval_date)-3,length(approval_date))
label var app_year "Approval Year"
gen orig_expiry = substr(initial_end_date, length(initial_end_date)-3,length(initial_end_date))
label var orig_expiry "Original Expiry Year"
gen actual_expiry = substr(end_date, length(end_date)-3,length(end_date))
label var actual_expiry "Actual Expiry Year"

gen exceptional_access = .
gen precautionary = .

drop if country_name==""
duplicates drop country_code year, force

// approval and expiry month
gen month = lower(substr(approval_date, length(approval_date)-6,length(approval_date)-6))
label var month "Month"
gen app_month = lower(substr(approval_date, length(approval_date)-6,length(approval_date)-6))
label var app_month "Approval Month"
gen orig_exp_month = substr(initial_end_date, length(initial_end_date)-6,length(initial_end_date)-6)
label var orig_exp_month "Original Expiry Month"
gen act_exp_month = substr(end_date, length(end_date)-6,length(end_date)-6)
label var act_exp_month "Actual Expiry Month"
gen app_1sthalf = app_month=="jan" | app_month=="feb" | app_month=="mar" | app_month=="apr" | app_month=="may" | app_month=="jun"
gen exp_1sthalf = act_exp_month=="jan" | act_exp_month=="feb" | act_exp_month=="mar" | act_exp_month=="apr" | act_exp_month=="may" | act_exp_month=="jun"

local exp "month app_month orig_exp_month act_exp_month"
foreach v of local exp {
replace `v'="1" if `v'=="jan"
replace `v'="2" if `v'=="feb"
replace `v'="3" if `v'=="mar"
replace `v'="4" if `v'=="apr"
replace `v'="5" if `v'=="may"
replace `v'="6" if `v'=="jun"
replace `v'="7" if `v'=="jul"
replace `v'="8" if `v'=="aug"
replace `v'="9" if `v'=="sep"
replace `v'="10" if `v'=="oct"
replace `v'="11" if `v'=="nov"
replace `v'="12" if `v'=="dec"
}

rename country_code country

keep country_name country arrangement_type arrangement_number orig_expiry actual_expiry precautionary exceptional_access year month app_year app_month orig_exp_month act_exp_month
destring, replace

gen gra_prgt = "PRGT"
gen roc2011=1

compress
save "Stata Files/prgt_program_init_roc2011.dta", replace

* 2011 PRGT Program periods
gen prg_length = (actual_expiry - year)*12+act_exp_month-app_month+1
label var prg_length "Program Length"
expand prg_length
sort country_name year month

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
		if month[`i'-1] < 12 {
			replace year = year[`i'-1] in `i'
			replace month = month[`i'-1]+1 in `i'
		}
		else {
		replace year = year[`i'-1]+1 in `i'
		replace month = 1 in `i'
		}
		}
	else
}

gsort country year -actual_expiry -act_exp_month
duplicates drop country year month, force

rename year weo_year
rename month weo_month

save "Stata Files/prgt_program_periods_roc2011.dta", replace

use "Stata Files/gra_program_periods_roc2011.dta", clear
append using "Stata Files/prgt_program_periods_roc2011.dta"

gsort country weo_year weo_month -gra_prgt
duplicates drop country weo_year weo_month, force

save "Stata Files/program_periods_roc2011.dta", replace


********************************************************************************************************************
* WEO data
********************************************************************************************************************


use "Stata Files/Database.dta", clear

*set years as time variable
gen years_to_forecast=year-year(action)


encode review_id, generate(code)
xtset code years_to_forecast

* Generate growth for invesment variables

gen expcomp_ = nfig_/ggx_*100
gen expcomp_actual_ = nfig_actual_/ggx_actual_*100
gen ni_rpch_ = ni_r_/l.ni_r_*100-100
gen nfi_rpch_ = nfi_r_/l.nfi_r_*100-100
replace nfi_rpch_ = ni_rpch_ if nfi_rpch_==.

replace nfi_r_actual_ = ni_r_actual_ if nfi_r_actual_==.
gen nfi_rpch_actual_ = nfi_r_actual_/l.nfi_r_actual_*100-100

gen ngdp_pch_ = ngdp_/l.ngdp_*100-100
gen ngdp_pch_actual_ = ngdp_actual_/l.ngdp_actual_*100-100

gen inflation_ = ngdp_pch_ - growth_ 
gen inflation_actual_ = ngdp_pch_actual_ - growth_actual_

*REMOVE OUTLIERS!!!

*JY: not use interest if interest == 0
replace interest_ = . if interest_ <= 0
replace interest_ = . if interest_ > 60

replace fb_ = . if fb_ < -60 | fb_ > 60

replace expcomp_ = . if expcomp_<-100 | expcomp_>100
replace nfi_rpch_ = . if nfi_rpch_<-200 | nfi_rpch_>200
replace ni_rpch_ = . if ni_rpch_<-200 | ni_rpch_>200

replace inflation_ = . if inflation_<-100 | inflation_>500
replace inflation_actual = . if inflation_actual<-100 | inflation_actual>500

*replace bankcrisis = 0  if bankcrisis==. & bankcrisis!=1

*replace ggdebt_ = 0 if ggdebt_ > 250

*Broad Money as a share of GDP

gen bm_ngdp=.
replace bm_ngdp=100*fmb_/ngdp_ if  fmb_!=. & ngdp_!=. 
replace bm_ngdp=0 if fmb_==.

gen bm_ngdp_adj=0
replace bm_ngdp_adj= bm_ngdp-l.bm_ngdp if bm_ngdp!=0 & l.bm_ngdp!=0
replace bm_ngdp_adj= . if bm_ngdp_adj<-40 | bm_ngdp_adj>40

gen bm_ngdp_actual_= .
replace bm_ngdp_actual_=100*fmb_actual_/ngdp_actual_ if  fmb_actual_!=. & ngdp_actual_!=. 
replace bm_ngdp_actual_=0 if fmb_actual_==.

*primary balance

gen pb_ = .
replace pb_ = fb_ + interest_ if(fb_!=. & interest_!=.)


* JY: using calculated pb_mona for MONA part
*replace pb_ = pb_mona if review!="" & pb_mona!=.

*replace pb_ = . if pb_ < -60 | pb_ > 60

*define adjustment

gen fb_adjustment = .
gen ca_adjustment = .
gen pb_adjustment = .
gen sb_adjustment = .
gen nfi_adjustment = .
gen pvt_adjustment = .

replace fb_adjustment = fb_ - L.fb_ if(fb_!=. & l.fb_!=0)
replace ca_adjustment = ca_ - L.ca_ if(ca_!=. & l.ca_!=0)
replace pb_adjustment = pb_ - L.pb_ if(pb_!=. & l.pb_!=0)
replace sb_adjustment = sb_ - L.sb_ if(sb_!=. & l.sb_!=0)
replace nfi_adjustment = nfi_rpch_ - L.nfi_rpch_ if(nfi_rpch_!=. & l.nfi_rpch_!=0)
replace pvt_adjustment = ca_adjustment - fb_adjustment

*define oil and commodity price log growth
gen oil_g_ = ln(oil_)-ln(L.oil_)
gen commodity_g_ = ln(commodity_)-ln(L.commodity_)

gen oil_g_actual_ = ln(oil_actual_)-ln(L.oil_actual_)
gen commodity_g_actual_ = ln(commodity_actual_)-ln(L.commodity_actual_)


*define forecast error

gen growth_error = .
gen fb_error = .
gen ca_error = .
gen partnergrowth_error = .
gen oil_g_error = .
gen commodity_g_error_ = .
gen bm_ngdp_error = .

gen nfi_error = .
gen expcomp_error = .
gen inflation_error = .
gen ngdp_pch_error = .

replace growth_error = growth_ - growth_actual_ if(growth_!=. & growth_actual_!=.)
replace fb_error = fb_ - fb_actual_ if(fb_!=. & fb_actual_!=.)
replace ca_error = ca_ - ca_actual_ if(ca_!=. & ca_actual_!=.)
replace partnergrowth_error = partnergrowth_ - partnergrowth_actual_ if(partnergrowth_!=. & partnergrowth_actual_!=.)
replace oil_g_error = oil_g_ - oil_g_actual_ if(oil_g_!=. & oil_g_actual_!=.)
replace commodity_g_error_ = commodity_g_ - commodity_g_actual_ if(commodity_g_!=. & commodity_g_actual_!=.)
replace bm_ngdp_error = bm_ngdp - bm_ngdp_actual_ if(bm_ngdp!=. & bm_ngdp_actual_!=.)
replace nfi_error = nfi_rpch_ - nfi_rpch_actual_ if(nfi_rpch_!=. & nfi_rpch_actual_!=.)
replace expcomp_error = expcomp_ - expcomp_actual_ if(expcomp_!=. & expcomp_actual_!=.)
replace inflation_error = inflation_ - inflation_actual_ if(inflation_!=. & inflation_actual_!=.)
replace ngdp_pch_error = ngdp_pch_ - ngdp_pch_actual_ if(ngdp_pch_!=. & ngdp_pch_actual_!=.)

*time to forecast
gen month = 1
gen day = 1
gen forecast_date = mdy(month, day, year)
gen time_to_forecast = (forecast_date - action)/365

*time and country/time interaction dummies
gen year_of_vintage = year(action)
*xi: gen countryXtime=i.country*i.year_of_vintage

*program dummies
gen program_d = 0
replace program_d = 1 if review !=""

gen request_d = 0
replace request_d = 1 if review == "R0"

gen review_d = 0
replace review_d = 1 if program_d == 1 & request_d == 0

gen review1_d = 0
replace review1_d = 1 if review == "R1"

gen review2_d = 0
replace review2_d = 1 if review == "R2"

gen review3_d = 0
replace review3_d = 1 if review == "R3"

gen reviewlater_d = 0
replace reviewlater_d = 1 if review_d == 1 & review1_d == 0 & review2_d == 0 & review3_d == 0

* JY: using app* end* for the begin/end of a program
/*
gen program_ongoing = 0
replace program_ongoing = 1 if review == "" & ((action > xxx11 & action < xxx12) | (action > xxx21 & action < xxx22) | (action > xxx31 & action < xxx32) | (action > xxx41 & action < xxx42) | (action > xxx51 & action < xxx52)) 

gen program_country = 0
replace program_country = 1 if ((action >= xxx11 & action <= xxx12) | (action >= xxx21 & action <= xxx22) | (action >= xxx31 & action <= xxx32) | (action >= xxx41 & action <= xxx42) | (action >= xxx51 & action <= xxx52))  
*/
gen program_ongoing = 0
replace program_ongoing = 1 if (review == "" & (((action > graapp1 & action < graend1) | (action > graapp2 & action < graend2) | (action > graapp3 & action < graend3) | (action > graapp4 & action < graend4) | (action > graapp5 & action < graend5)) | ((action > prgtapp1 & action < prgtend1) | (action > prgtapp2 & action <prgtend2) | (action > prgtapp3 & action < prgtend3) | (action > prgtapp4 & action < prgtend4) | (action > prgtapp5 & action < prgtend5)|(action > prgtapp6 & action < prgtend6))))

* JY: add the conditon of review!="" to make sure that all MONA data are part of program_country
gen program_country = 0
replace program_country = 1 if review !="" | (((action >= graapp1 & action <= graend1) | (action >= graapp2 & action <= graend2) | (action >= graapp3 & action <= graend3) | (action >= graapp4 & action <= graend4) | (action >= graapp5 & action <= graend5)) | ((action >= prgtapp1 & action <= prgtend1) | (action >= prgtapp2 & action <=prgtend2) | (action >= prgtapp3 & action <= prgtend3) | (action >= prgtapp4 & action <= prgtend4) | (action >= prgtapp5 & action <= prgtend5)|(action >= prgtapp6 & action <= prgtend6)))

gen program_is_prgt=0
replace program_is_prgt=1 if ((action >= prgtapp1 & action <= prgtend1) | (action >= prgtapp2 & action <=prgtend2) | (action >= prgtapp3 & action <= prgtend3) | (action >= prgtapp4 & action <= prgtend4) | (action >= prgtapp5 & action <= prgtend5)|(action >= prgtapp6 & action <= prgtend6))

gen program_is_gra=0
replace program_is_gra=1 if ((action >= graapp1 & action <= graend1) | (action >= graapp2 & action <= graend2) | (action >= graapp3 & action <= graend3) | (action >= graapp4 & action <= graend4) | (action >= graapp5 & action <= graend5))

gen surv=0
replace surv=1 if program_country==0

replace sb = 0 if sb == .

gen time_sb = sb * time_to_forecast

replace sb1 = 0 if sb1 == .
replace sb2 = 0 if sb2 == .
replace sb3 = 0 if sb3 == .
replace sb4 = 0 if sb4 == .
replace sb5 = 0 if sb5 == .

gen SBA = 0
replace SBA = 1 if program_type == "SBA"

gen exceptional_d=0
replace exceptional_d=1 if exceptional_access=="Y"



gen pb_adjustment_actual_get_average = .
gen ca_adjustment_actual_get_average = .
gen bm_adjustment_actual_get_average = .

replace pb_adjustment_actual_get_average = pb_adjustment if (years_to_forecast < 0 & year(action)==2017)
replace ca_adjustment_actual_get_average = ca_adjustment if (years_to_forecast < 0 & year(action)==2017)
replace bm_adjustment_actual_get_average = bm_ngdp_adj if (years_to_forecast < 0 & year(action)==2017)


egen pb_adjustment_actual_average= mean(pb_adjustment_actual_get_average), by(country)
egen ca_adjustment_actual_average= mean(ca_adjustment_actual_get_average), by(country)
egen bm_adjustment_actual_average= mean(bm_adjustment_actual_get_average), by (country)

egen pb_adjustment_actual_std= sd(pb_adjustment_actual_get_average), by(country)
egen ca_adjustment_actual_std= sd(ca_adjustment_actual_get_average), by(country)
egen bm_adjustment_actual_std = sd(bm_adjustment_actual_average)

gen pb_adjustment_actual = .
gen ca_adjustment_actual = .
gen bm_adjustment_actual= .

local ycode 1990
local year_r 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
foreach m of local year_r{

egen pb_adjustment_actual_`ycode'= mean(pb_adjustment_actual_get_average) if(year == `ycode'), by(country) 
egen ca_adjustment_actual_`ycode'= mean(pb_adjustment_actual_get_average) if(year == `ycode'), by(country)
egen bm_adjustment_actual_`ycode'= mean(bm_adjustment_actual_get_average) if(year == `ycode'), by(country)
replace pb_adjustment_actual = pb_adjustment_actual_`ycode' if (year == `ycode')
replace ca_adjustment_actual = ca_adjustment_actual_`ycode' if (year == `ycode')
replace bm_adjustment_actual = bm_adjustment_actual_`ycode' if (year == `ycode')


drop pb_adjustment_actual_`ycode'
drop ca_adjustment_actual_`ycode'
drop bm_adjustment_actual_`ycode'

local ycode = `ycode'+1
}

gen cumulative_pb_adj = .
gen cumulative_sb_adj = .
gen cumulative_ca_adj = .

replace cumulative_pb_adj = pb_adjustment+f.pb_adjustment+f2.pb_adjustment
replace cumulative_sb_adj = sb_adjustment+f.sb_adjustment+f2.sb_adjustment
replace cumulative_ca_adj = ca_adjustment+f.ca_adjustment+f2.ca_adjustment

gen cumulative_pb_adj_actual= .
replace cumulative_pb_adj_actual = cumulative_pb_adj if (years_to_forecast < -2 & year(action)==2017)

gen cumulative_sb_adj_actual= .
replace cumulative_sb_adj_actual = cumulative_sb_adj if (years_to_forecast < -2 & year(action)==2017)

gen cumulative_ca_adj_actual= .
replace cumulative_ca_adj_actual = cumulative_ca_adj if (years_to_forecast < -2 & year(action)==2017)

egen cumulative_pb_adj_average = mean(cumulative_pb_adj_actual), by(country) 
egen cumulative_pb_adj_std =  sd(cumulative_pb_adj_actual), by(country) 

egen cumulative_sb_adj_average = mean(cumulative_sb_adj_actual), by(country) 
egen cumulative_sb_adj_std =  sd(cumulative_sb_adj_actual), by(country) 

egen cumulative_ca_adj_average = mean(cumulative_ca_adj_actual), by(country)
egen cumulative_ca_adj_std =  sd(cumulative_ca_adj_actual), by(country)

gen prog_growth_error = program_country*growth_error

*Capturing high fiscal adjustment

gen high_fiscal_adj=0

*replace high_fiscal_adj=1 if cumulative_pb_adj!=. & (cumulative_pb_adj>5 | l.cumulative_pb_adj>5 | l2.cumulative_pb_adj>5)
*replace high_fiscal_adj=1 if cumulative_pb_adj!=. & (cumulative_pb_adj>cumulative_pb_adj_average+cumulative_pb_adj_std | l.cumulative_pb_adj>cumulative_pb_adj_average+cumulative_pb_adj_std | l2.cumulative_pb_adj>cumulative_pb_adj_average+cumulative_pb_adj_std)
replace high_fiscal_adj=1 if pb_adjustment!=. & (pb_adjustment>pb_adjustment_actual_average+0.5*pb_adjustment_actual_std)

gen low_fiscal_adj=0
replace low_fiscal_adj=1 if high_fiscal_adj==0

gen fiscal_expansion=0
replace fiscal_expansion=1 if pb_adjustment<0

gen high_sb_fiscal_adj=0
*replace high_sb_fiscal_adj=1 if cumulative_sb_adj!=. & (cumulative_sb_adj>cumulative_sb_adj_average+cumulative_sb_adj_std | l.cumulative_sb_adj>cumulative_sb_adj_average+cumulative_sb_adj_std | l2.cumulative_sb_adj>cumulative_sb_adj_average+cumulative_sb_adj_std)

gen high_ca_adj=0
*replace high_ca_adj=1 if cumulative_ca_adj!=. & (cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l2.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std)
replace high_ca_adj=1 if ca_adjustment!=. & (ca_adjustment>ca_adjustment_actual_average+0.5*ca_adjustment_actual_std)
gen low_ca_adj=0
replace low_ca_adj=1 if high_ca_adj==0

gen high_bm_adj=0
*replace high_ca_adj=1 if cumulative_ca_adj!=. & (cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l2.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std)
replace high_bm_adj=1 if bm_ngdp_adj !=. & (bm_ngdp_adj < bm_adjustment_actual_average-0.5*bm_adjustment_actual_std)
gen low_bm_adj=0
replace low_bm_adj=1 if high_bm_adj==0

**********************************
**Multipliers
**********************************

gen growth_delta=.
replace growth_delta=growth_-l.growth_ if (growth_!=. & l.growth_!=.)
gen pb_adjustment_m=.
replace pb_adjustment_m = pb_adjustment-l.pb_adjustment if (growth_delta!=.)
gen ca_adjustment_m=.
replace ca_adjustment_m = ca_adjustment-l.ca_adjustment if (growth_delta!=.)
*egen pb_adjustment_planned_average=mean(pb_adjustment_m), by(review_id)
*egen ca_adjustment_planned_average=mean(ca_adjustment_m), by(review_id)
*egen growth_delta_planned_average=mean(growth_delta), by(review_id)
gen fiscal_multiplier_sr= .
gen external_multiplier_sr=.

replace fiscal_multiplier_sr= -growth_delta/pb_adjustment_m if(pb_adjustment_m!=. & growth_delta!=. & years_to_forecast>=0)
replace external_multiplier_sr= -growth_delta/ca_adjustment_m if(ca_adjustment_m!=. & growth_delta!=. & years_to_forecast>=0)
*replace fiscal_multiplier_sr= growth_delta_planned_average/pb_adjustment_planned_average if(pb_adjustment_planned_average!=. & growth_delta_planned_average!=.)
*replace external_multiplier_sr= growth_delta_planned_average/ca_adjustment_planned_average if(ca_adjustment_planned_average!=. & growth_delta_planned_average!=.)
egen fm_average_sr= mean(fiscal_multiplier_sr), by(review_id)
egen em_average_sr= mean(external_multiplier_sr), by(review_id)


*drop pb_adjustment_planned_average
*drop ca_adjustment_planned_average
*drop growth_delta_planned_average
drop pb_adjustment_m
drop ca_adjustment_m
drop growth_delta

gen growth_delta_high_fiscal=.
replace growth_delta_high_fiscal=growth_-l.growth_ if (growth_!=. & l.growth_!=. & high_fiscal_adj==1)
gen growth_delta_high_ca=.
replace growth_delta_high_ca=growth_-l.growth_ if (growth_!=. & l.growth_!=. & high_ca_adj==1)
gen pb_adjustment_m=.
replace pb_adjustment_m = pb_adjustment-l.pb_adjustment if (growth_delta_high_fiscal!=. & high_fiscal_adj==1)
gen ca_adjustment_m=.
replace ca_adjustment_m = ca_adjustment-l.ca_adjustment if (growth_delta_high_ca!=. & high_ca_adj==1)
*egen pb_adjustment_planned_average=mean(pb_adjustment_m), by(review_id)
*egen ca_adjustment_planned_average=mean(ca_adjustment_m), by(review_id)
*egen growth_delta_planned_average_f=mean(growth_delta_high_fiscal), by(review_id)
*egen growth_delta_planned_average_ca=mean(growth_delta_high_ca), by(review_id)
gen fiscal_multiplier_sr_high= .
gen external_multiplier_sr_high= .
replace fiscal_multiplier_sr_high= -growth_delta_high_fiscal/pb_adjustment_m if(pb_adjustment_m!=. & growth_delta_high_fiscal!=. & years_to_forecast>=0)
replace external_multiplier_sr_high= -growth_delta_high_ca/ca_adjustment_m if(ca_adjustment_m!=. & growth_delta_high_ca!=. & years_to_forecast>=0)
egen fm_average_sr_high= mean(fiscal_multiplier_sr_high), by(review_id)
egen em_average_sr_high= mean(external_multiplier_sr_high), by(review_id)

*replace fiscal_multiplier_sr_high= growth_delta_planned_average_f/pb_adjustment_planned_average if(pb_adjustment_planned_average!=. & growth_delta_planned_average_f!=.)
*replace external_multiplier_sr_high= growth_delta_planned_average_ca/ca_adjustment_planned_average if(ca_adjustment_planned_average!=. & growth_delta_planned_average_ca!=.)

*drop pb_adjustment_planned_average
*drop ca_adjustment_planned_average
*drop growth_delta_planned_average_f
*drop growth_delta_planned_average_ca
drop pb_adjustment_m
drop ca_adjustment_m
drop growth_delta_high_fiscal
drop growth_delta_high_ca


gen fb_m_adjustment=.
replace fb_m_adjustment= f5.pb_ - l.pb_ 
replace fb_m_adjustment= f4.pb_ - l.pb_ if (f5.pb_==.)
replace fb_m_adjustment= f3.pb_ - l.pb_ if (f5.pb_==. & f4.pb_==.)
replace fb_m_adjustment= f2.pb_ - l.pb_ if (f5.pb_==. & f4.pb_==. & f3.pb_==.)
replace fb_m_adjustment= f.pb_ - l.pb_ if (f5.pb_==. & f4.pb_==. & f3.pb_==. & f2.pb_==.)
replace fb_m_adjustment= pb_ - l.pb_ if (f5.pb_==. & f4.pb_==. & f3.pb_==. & f2.pb_==. & f.pb_==.)

gen ca_m_adjustment=.
replace ca_m_adjustment= f5.ca_ - l.ca_ 
replace ca_m_adjustment= f4.ca_ - l.ca_ if (f5.ca_==.)
replace ca_m_adjustment= f3.ca_ - l.ca_ if (f5.ca_==. & f4.ca_==.)
replace ca_m_adjustment= f2.ca_ - l.ca_ if (f5.ca_==. & f4.ca_==. & f3.ca_==.)
replace ca_m_adjustment= f.ca_ - l.ca_ if (f5.ca_==. & f4.ca_==. & f3.ca_==. & f2.ca_==.)
replace ca_m_adjustment= ca_ - l.ca_ if (f5.ca_==. & f4.ca_==. & f3.ca_==. & f2.ca_==. & f.ca_==.)

gen growth_m_adjustment=.
replace growth_m_adjustment= f5.growth_+f4.growth_+f3.growth_+f2.growth_+f.growth_+growth_ 
replace growth_m_adjustment= f4.growth_+f3.growth_+f2.growth_+f.growth_+growth_ if (f5.growth_==.)
replace growth_m_adjustment= f3.growth_+f2.growth_+f.growth_+growth_ if (f5.growth_==. & f4.growth_==.)
replace growth_m_adjustment= f2.growth_+f.growth_+growth_ if (f5.growth_==. & f4.growth_==. & f3.growth_==.)
replace growth_m_adjustment= f.growth_+growth_ if (f5.growth_==. & f4.growth_==. & f3.growth_==. & f2.growth_==.)
replace growth_m_adjustment= growth_ if (f5.growth_==. & f4.growth_==. & f3.growth_==. & f2.growth_==. & f.growth_==.)

gen fm_average_lr=.
gen em_average_lr=.
replace fm_average_lr=-growth_m_adjustment/fb_m_adjustment if (growth_m_adjustment!=. & fb_m_adjustment!=. & years_to_forecast==0)
replace em_average_lr=-growth_m_adjustment/ca_m_adjustment if (growth_m_adjustment!=. & ca_m_adjustment!=. & years_to_forecast==0)



*********************************************

*Interaction with dummies
gen oil_exp_error = oil_g_error * oilexporter
gen oil_notexp_error= oil_g_error * !oilexporter
gen oil_g_exp= oil_g_ * oilexporter
gen oil_g_notexp= oil_g_ * !oilexporter
gen oil_g_exp_actual = oil_g_actual * oilexporter


gen commodity_exp_error = commodity_g_error * commexporter
gen commodity_notexp_error = commodity_g_error * !commexporter
gen commodity_g_exp=commodity_g_* commexporter
gen commodity_g_notexp= commodity_g_ * !commexporter
gen commodity_g_exp_actual= commodity_g_actual * commexporter

gen prog_partnergrowth_error = program_country * partnergrowth_error
gen prog_fb_adjustment = program_country * fb_adjustment
gen prog_pb_adjustment = program_country * pb_adjustment
gen prog_sb_adjustment = program_country * sb_adjustment
gen prog_bm_adjustment = program_country * bm_ngdp_adj
gen surv_pb_adjustment = surv * pb_adjustment

gen high_pb_adjustment = high_fiscal_adj * pb_adjustment
gen prog_high_pb_adjustment = program_country * high_fiscal_adj * pb_adjustment
gen surv_high_pb_adjustment = surv * high_fiscal_adj * pb_adjustment
gen surv_fiscal_expansion = surv * fiscal_expansion * pb_adjustment
gen prog_low_pb_adjustment = program_country * low_fiscal_adj * pb_adjustment
gen surv_low_pb_adjustment = surv * low_fiscal_adj * pb_adjustment
gen prog_fiscal_expansion = program_country * fiscal_expansion * pb_adjustment

gen high_sb_adjustment = high_fiscal_adj * sb_adjustment
gen prog_high_sb_adjustment = program_country * high_fiscal_adj * sb_adjustment

gen high_ca_adjustment = high_ca_adj * ca_adjustment
gen prog_high_ca_adjustment = program_country * high_ca_adj * ca_adjustment
gen prog_low_ca_adjustment = program_country * low_ca_adj * ca_adjustment
gen surv_low_ca_adjustment = surv* low_ca_adj * ca_adjustment
gen surv_high_ca_adjustment = surv* high_ca_adj * ca_adjustment

gen high_bm_adjustment = high_bm_adj * bm_ngdp_adj
gen prog_high_bm_adjustment = program_country * high_bm_adj * bm_ngdp_adj
gen prog_low_bm_adjustment = program_country * low_bm_adj * bm_ngdp_adj
gen surv_low_bm_adjustment = surv* low_bm_adj * bm_ngdp_adj
gen surv_high_bm_adjustment = surv* high_bm_adj * bm_ngdp_adj

gen prog_ca_adjustment  = program_country * ca_adjustment
gen prog_oil_g_error  = program_country * oil_g_error
gen prog_commodity_g_error  = program_country * commodity_g_error
gen prog_time_to_forecast = program_country * time_to_forecast

gen req_time_to_forecast = request_d * time_to_forecast

gen prog_ca_ = program_country * ca_
gen prog_fb_ = program_country * fb_
gen prog_pb_ = program_country * pb_
gen prog_sb_ = program_country * sb_
gen prog_ggdebt_ = program_country * ggdebt_

gen sb_time_to_forecast = sb * time_to_forecast

*Generating past program controls

gen PastProgram_d=0
replace PastProgram_d= 1 if (action> graapp1)
replace PastProgram_d= 2 if (action> graapp2)
replace PastProgram_d= 3 if (action> graapp3)
replace PastProgram_d= 4 if (action> graapp4)
replace PastProgram_d= 5 if (action> graapp5)

egen PastProgram = min(PastProgram_d), by(review_id)
drop PastProgram_d

gen time_PastProgram = PastProgram* time_to_forecast
*Controlling for GFC

gen GFC=0
replace GFC=1 if year==2008 | year== 2009

*Last Commodity and oil shock before forecats year

gen commodity_shock_at_forecast=.
replace commodity_shock_at_forecast=commodity_g_actual_ if year==year(action)
egen commodity_shock = mean(commodity_shock_at_forecast), by(code)
gen commodity_shock_exp=commodity_shock*commexporter
drop commodity_shock_at_forecast

gen oil_shock_at_forecast=.
replace oil_shock_at_forecast=oil_g_actual_ if year==year(action)
egen oil_shock = mean(oil_shock_at_forecast), by(code)
gen oil_shock_exp=oil_shock*oilexporter
drop oil_shock_at_forecast

*gen oil/commodity actual price interaction with dummies

gen oil_exp_actual_g=oil_g_actual*oilexporter
gen commodity_exp_actual_g=commodity_g_actual*commexporter

*Area Dept Dummies

gen isWHD=0
replace isWHD=1 if region=="WHD"
gen isAFR=0
replace isAFR=1 if region=="AFR"
gen isEUR=0
replace isEUR=1 if region=="EUR"
gen isMCD=0
replace isMCD=1 if region=="MCD"
gen isAPD=0
replace isAPD=1 if region=="APD"

tab (weo), gen(weo_d)
tab (cty), gen(cty_d)

*Clean Up before regressions

*drop if years_to_forecast < 0
*drop if years_to_forecast > 5
*Auxillary code
*by review_id, sort: gen nvals = _n == 1
*drop if (growth_error==. | partnergrowth_error==. | pb_adjustment==. | prog_pb_adjustment==. | high_pb_adjustment==. | ca_adjustment==. | prog_ca_adjustment==. | high_ca_adjustment==. | oil_g_error==. | oil_exp_error==. | commodity_g_error==. | commodity_exp_error==. | time_to_forecast==.)
*count if !(growth_error==. | partnergrowth_error==. | pb_adjustment==. | prog_pb_adjustment==. | high_pb_adjustment==. | ca_adjustment==. | prog_ca_adjustment==. | high_ca_adjustment==. | oil_g_error==. | oil_exp_error==. | commodity_g_error==. | commodity_exp_error==. | time_to_forecast==.) & (program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)))


label var growth_error "Growth forecast error"
label var partnergrowth_error "Trading partner growth forecast error"
label var pb_adjustment "Forecast of Fiscal adjustment"
label var high_pb_adjustment "Forecast of Fiscal adjustment under high adj"
label var bm_ngdp_adj "Forecast of Broad money adjustment"
label var high_bm_adjustment "Forecast of monetary adjustment under high adj"
label var ca_adjustment "Forecast of CA adjustment"
label var high_ca_adjustment "Forecast of CA adjustment under high adj"
label var oil_notexp_error "Non-oil exporter x oil price forecast error"
label var oil_exp_error "Oil exporter x oil price forecast error"
label var commodity_notexp_error "Non-commodity exporter x commodity price forecast error"
label var commodity_exp_error "Commodity exporter x commodity price forecast error"
label var time_to_forecast "Time to forecast"
label var GFC "Global financial crisis dummy"
label var fb_error "Fiscal balance forecast error"
label var ca_error "Current account balance forecast error"
label var inflation_error "Inflation forecast error"
label var ngdp_pch_error "NGDP forecast error"

gen weo_year = substr(weo, 4, 4)
gen weo_month = substr(weo, 1, 3)

replace weo_month="1" if weo_month=="Jan"
replace weo_month="2" if weo_month=="Feb"
replace weo_month="3" if weo_month=="Mar"
replace weo_month="4" if weo_month=="Apr"
replace weo_month="5" if weo_month=="May"
replace weo_month="6" if weo_month=="Jun"
replace weo_month="7" if weo_month=="Jul"
replace weo_month="8" if weo_month=="Aug"
replace weo_month="9" if weo_month=="Sep"
replace weo_month="10" if weo_month=="Oct"
replace weo_month="11" if weo_month=="Nov"
replace weo_month="12" if weo_month=="Dec"

replace exceptional_access = cond(exceptional_access=="Y", "1","0")

destring weo_year weo_month exceptional_access, replace

drop if weo==""

merge m:1 country weo_year weo_month using "Stata Files/program_periods_roc2018.dta"
drop if _m==2
drop _m
replace roc2018=0 if roc2018==.

merge m:1 country weo_year weo_month using "Stata Files/program_periods_roc2011.dta", update
drop if _m==2
drop _m
replace roc2011=0 if roc2011==.


save "Temp/database_reg.dta", replace
