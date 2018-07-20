clear all
global path "C:\Users\yyang5\Desktop\Comparators"


**********************************************************************************
* Construct comparators using propensity score
**********************************************************************************

use "${path}/Stata Files/master_comparator_data.dta", clear

gen iip_gdp = iip/ngdpd*100
gen lngdppc = ln(ngdpdpc)
gen credit_gdp_prgt = prgt_credit/1000000/ngdpd
replace credit_gdp_prgt=0 if credit_gdp_prgt==.
gen quota_gdp = quota/1000000/ngdpd
replace quota_gdp=0 if quota_gdp==.

* Label outliers
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 exchange_rate iip_gdp trade_openness credit_gdp_prgt quota_gdp"
foreach v of local var {
bysort year:egen phigh_`v'=pctile(`v'), p(95)
bysort year:egen plow_`v'=pctile(`v'), p(5)
}

// Only exclude outliers for the varaibles below.
gen outlier = 0
local var "ngdp_rpch lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 credit_gdp_prgt"
foreach v of local var {
replace outlier = 1 if (`v'> phigh_`v' | `v'<plow_`v') & `v'!=.
}


sort country_code year
tsset country_code year
gen prg_init_prgt = (ecf==1 | scf==1) & arrangement_type!="" // program initiation
gen prg_period = (ecf==1 | scf==1) // program period
gen g7 = country_name=="Canada" | country_name=="France" | country_name=="Germany" | country_name=="Italy" | country_name=="Japan" | country_name=="United Kingdom" | country_name=="United States"

gen pre_prg1 = f.prg_init_prgt==1
gen post_prg1 = prg_period==0 & l.prg_period==1

// Only these country-year pairs can be served as control group
gen control_group_prgt = g7==0 & PRGT==1 & prg_period==0 & pre_prg1==0 & post_prg1==0 & outlier==0

tab (region), gen(d_region)
tab (year), gen(d_year)
egen region_num = group(region)

// Demean all variables
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 exchange_rate iip_gdp trade_openness credit_gdp_prgt quota_gdp"
foreach v of local var {
quietly reg `v' d_region* d_year*
predict `v'_res, resid
gen `v'_orig = `v'
replace `v' = `v'_res
drop `v'_res
}


// Time-series operator is not allowed in psmatch2
gen ngdp_rpch_l1 = l.ngdp_rpch
gen ggxcnl_gdp_l1 = l.ggxcnl_gdp
gen ggxcnl_gdp_l2 = l2.ggxcnl_gdp 
gen lngdppc_l1 = l.lngdppc 
gen pcpie_pch_l1 = l.pcpie_pch 
gen pcpie_pch_l2 = l2.pcpie_pch 
gen bfd_gdp_bp6_l1 = l.bfd_gdp_bp6 
gen d_gdp_l1 = l.d_gdp 
gen bca_gdp_bp6_l1 = l.bca_gdp_bp6
gen bca_gdp_bp6_l2 = l2.bca_gdp_bp6 
gen exchange_rate_l1 = l.exchange_rate
gen iip_gdp_l1 = l.iip_gdp 
gen trade_openness_l1=l.trade_openness 
gen credit_gdp_prgt_l1=l.credit_gdp_prgt
gen quota_gdp_l1=l.quota_gdp


// Label variables for regression output files
label var prg_init_prgt "Program initialization dummy"
label var ngdp_rpch_l1 "Real GDP growth (t-1)"
label var ggxcnl_gdp_l1 "General Gov Debt/GDP (t-1)"
label var lngdppc_l1 "log(GDP per capita) (t-1)"
label var pcpie_pch_l1 "Inflation (t-1)"
label var pcpie_pch_l2 "Inflation (t-2)" 
label var bfd_gdp_bp6_l1 "FDI/GDP (t-1)"
label var d_gdp_l1 "External debt/GDP (t-1)"
label var bca_gdp_bp6_l1 "Current account/GDP (t-1)"
label var exchange_rate_l1 "Exchange rate regime (t-1)"
label var credit_gdp_prgt "GRA credit outstanding/GDP (t-1)"


* Probit regressions for finding comparators
// Include treated units (prg_init_prgt==1) and control units (control_group_prgt==1) in the regressions
eststo clear
eststo: probit prg_init_prgt ngdp_rpch_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 credit_gdp_prgt_l1 if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1)
eststo: probit prg_init_prgt ngdp_rpch_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 credit_gdp_prgt_l1 if year<=2017 & year>=2011 & (prg_init_prgt==1 | control_group_prgt==1)
predict pscore1 if e(sample), pr

/*
// Profit fixed effect model is biased, whereas logit fixed effect model is unbiased.
eststo: xtlogit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 i.region_num  if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1), fe
eststo: xtlogit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 i.region_num  if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1), fe

// ROC 2011 used population average method.
eststo: xtprobit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 d_region* if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1) , pa
eststo: xtprobit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 d_region* if year<=2017 & year>=2011 & (prg_init_prgt==1 | control_group_prgt==1) , pa
predict pscore1 if e(sample), mu
*/

esttab using "${path}/Results/propensity_prgt.csv", b(%9.3f) se(%9.3f) t() star(* 0.10 ** 0.05 *** 0.01) drop(_cons) scalars (N) ar2 nogaps label nodepvar replace



* Propensity Score Matching
pscore prg_init_prgt ngdp_rpch_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 exchange_rate_l1 credit_gdp_prgt_l1 if year<=2017 & year>=2011 & (prg_init_prgt==1 | control_group_prgt==1), pscore(mypscore)
psmatch2 prg_init_prgt, outcome(ngdp_rpch) pscore(mypscore) neighbor(100) // 100 is for selecting 5 countries from the SAME YEAR


* Export programs with comparators
sort _id
gen program = country_name + ", " + string(year) + ", " + arrangement_type if prg_init_prgt==1

forvalues i=1(1)100 {
quietly gen ctry_`i' = country_name[_n`i']
quietly gen year_`i' = year[_n`i']
quietly gen pscore_`i' = _pscore[_n`i']
}

forvalues i=1(1)100 {
quietly gen diff_nbr_prg_`i' = ctry_`i' + ", " + string(year_`i') if prg_init_prgt==1
quietly gen same_nbr_prg_`i' = ctry_`i' + ", " + string(year_`i') if prg_init_prgt==1 & year_`i'==year
}

// Pick 5 most similar countries from the different years
forvalues i=1(1)5 {
gen diff_prg_`i' = diff_nbr_prg_`i'
gen diff_ctry_`i' = ctry_`i'
gen diff_year_`i' = year_`i'
gen diff_pscore_`i' = pscore_`i'
}

forvalues i=1(1)5 {
gen diff_dis_`i' = abs(diff_pscore_`i'-_pscore)
}

// Pick 5 similar countries from the SAME YEAR
forvalues i=1(1)5 {
gen same_prg_`i' = ""
gen same_ctry_`i' = ""
gen same_year_`i' = .
gen same_pscore_`i' = .
}

forvalues j=1(1)5 {
forvalues i=1(1)100 {
quietly replace same_prg_`j' =  same_nbr_prg_`i' if  same_nbr_prg_`i'!="" & same_prg_`j'==""
quietly replace same_ctry_`j' =  ctry_`i' if  same_nbr_prg_`i'!="" & same_ctry_`j'==""
quietly replace same_year_`j' =  year_`i' if  same_nbr_prg_`i'!="" & same_year_`j'==.
quietly replace same_pscore_`j' = pscore_`i' if same_nbr_prg_`i'!="" & same_pscore_`j'==.
quietly replace same_nbr_prg_`i'="" if  same_nbr_prg_`i'!="" & same_prg_`j'==same_nbr_prg_`i'
}
}

forvalues i=1(1)5 {
gen same_dis_`i' = abs(same_pscore_`i'-_pscore)
}

sort year country_code

// A table of comparators
save "${path}/Stata Files/comparator_main_prgt.dta", replace

export excel program diff_prg_* diff_dis_* using "${path}/Results/comparator_res_prgt.xlsx" if prg_init_prgt==1 & year>=2011, sheet("comparator_diff_table", modify) cell(A2) firstrow(variables)
export excel program same_prg_* same_dis_* using "${path}/Results/comparator_res_prgt.xlsx" if prg_init_prgt==1 & year>=2011, sheet("comparator_same_table", modify) cell(A2) firstrow(variables)




************************************************************************************************
* For charts on program outcomes
************************************************************************************************

clear
gen country_name=""
gen country_code=.
gen year=. 

gen ngdp_rpch_orig=. 
gen pcpie_pch_orig=.
gen bca_gdp_bp6_orig=. 
gen d_gdp_orig=. 

save "${path}/Stata Files/graph_res_prgt.dta", replace


use "${path}/Stata Files/comparator_main_prgt.dta", clear
*keep if ctry_1!=""

gen prg_time=.
gen prg_ctry = 0

sort country_code year

preserve
local N = _N
forvalues i = 5(1)`N' {
	if ctry_1[`i']!="" {
		local prg program[`i']
		local c1 same_ctry_1[`i']
		local c2 same_ctry_2[`i']
		local c3 same_ctry_3[`i']
		local c4 same_ctry_4[`i']
		local c5 same_ctry_5[`i']
		local y1 same_year_1[`i']
		local y2 same_year_2[`i']
		local y3 same_year_3[`i']
		local y4 same_year_4[`i']
		local y5 same_year_5[`i']		
		
		// program country before and after
		replace program = `prg' if _n>`i'-5 & _n<`i'+5
		replace prg_ctry = 1 if _n>`i'-5 & _n<`i'+5
		// comparators before and after
		replace program = `prg' if (country_name==`c1' & year<=`y1'+4 & year>=`y1'-4) | (country_name==`c2' & year<=`y2'+4 & year>=`y2'-4) | (country_name==`c3' & year<=`y3'+4 & year>=`y3'-4) | (country_name==`c4' & year>=`y4'+4 & year>=`y4'-4) | (country_name==`c5' & year<=`y5'+4 & year>=`y5'-4)
		keep if program==`prg'
	
		sort country_code year
		
		forvalues j = 1(1)9 {
		replace prg_time = mod(_n,9)-5
		replace prg_time = 4 if prg_time==-5
		}
		
		keep country_code country_name year program prg_time prg_ctry ngdp_rpch_orig pcpie_pch_orig bca_gdp_bp6_orig d_gdp_orig

		append using "${path}/Stata Files/graph_res_prgt.dta"
		save "${path}/Stata Files/graph_res_prgt.dta", replace
		restore, preserve
	}
	else
}

restore, not

use "${path}/Stata Files/graph_res_prgt.dta", clear

collapse (median) ngdp_rpch_orig pcpie_pch_orig bca_gdp_bp6_orig d_gdp_orig, by(prg_ctry prg_time)
reshape wide ngdp_rpch_orig pcpie_pch_orig bca_gdp_bp6_orig d_gdp_orig, i(prg_time) j(prg_ctry)

local var "ngdp_rpch pcpie_pch bca_gdp_bp6 d_gdp"
foreach v of local var {
export excel prg_time `v'_orig0 `v'_orig1 using "${path}/Results/comparator_res_charts.xlsx", sheet("res_prgt_`v'", modify) cell(A22) 
}

*xtprobit prg_init_prgt l.ngdp_rpch l.loggdppc l.pcpie_pch l2.pcpie_pch l.bfd_gdp_bp6 l.chg_d l.bca_gdp_bp6 d_region* if year<=2011 & year>=2002 & PRGT==0 & g7!=1 & prg_period==0, pa
*predict pscore  if e(sample), mu

/* PSM: Average treatment effect
gen l_ggxcnl_gdp = l.ggxcnl_gdp
gen l_loggdppc=l.loggdppc 
gen l_pcpie_pch=l.pcpie_pch 
gen l2_pcpie_pch=l2.pcpie_pch
gen l_bfd_gdp_bp6 = l.bfd_gdp_bp6 
gen l_chg_d = l.chg_d 
gen l_bca_gdp_bp6 = l.bca_gdp_bp6


teffects psmatch (ngdp_rpch_l1) (program l_ggxcnl_gdp l_loggdppc l_pcpie_pch l2_pcpie_pch l_bfd_gdp_bp6 l_chg_d l_bca_gdp_bp6, probit) if year<=2011 & year>=2002, atet vce(iid) nneighbor(5)
*/



**********************************************************************************
* Construct comparators using synthetic control
**********************************************************************************

use "${path}/Stata Files/master_comparator_data.dta", clear
keep if year>=2006
gen loggdppc = log(ngdpdpc)

drop if country_name=="Somalia" | country_name=="South Sudan" | country_name=="Syria" | country_name=="Puerto Rico"

local var "ngdp_rpch bca_gdp_bp6 d_gdp loggdppc"
foreach v of local var {
drop if `v'==.
}

tsset country_code year

synth ngdp_rpch bca_gdp_bp6 d_gdp loggdppc, trunit(182) trperiod(2011) xperiod(2009(1)2010) fig resultsperiod(2007(1)2016)

save graph "${path}/Results/`i'_chart", replace
