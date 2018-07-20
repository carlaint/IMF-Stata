clear all
global path "Q:/DATA/SPRLP/EM/Review of Conditionality/Data/Comparators"
local date: display %td_CCYY_NN_DD date(c(current_date), "DMY")
global date_str = subinstr(trim("`date'"), " " , "-", .)

**********************************************************************************
* Construct comparators using propensity score
**********************************************************************************

use "${path}/Stata Files/master_data_comparator.dta", clear

gen iip_gdp = iip/ngdpd*100
gen lngdppc = ln(ngdpdpc)
gen credit_gdp_prgt = prgt_credit/1000000/ngdpd
replace credit_gdp_prgt=0 if credit_gdp_prgt==.
gen quota_gdp = quota/1000000/ngdpd
replace quota_gdp=0 if quota_gdp==.
rename iar_gdp_bp6 reserve_gdp
gen float_er = exchange_rate>=9

gen acct = log(VoiceandAccountability+4.5) 
gen stab = log(PoliticalStability+4.5) 
gen effect = log(GovernmentEffectiveness+4.5) 
gen qual = log(RegulatoryQuality+4.5) 
gen law = log(RuleofLaw+4.5) 
gen corrupt = log(ControlofCorruption+4.5)

* Label outliers
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 exchange_rate iip_gdp trade_openness credit_gdp_prgt quota_gdp reserve_gdp"
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
gen prg_init_prgt = (ecf_init==1 | scf_init==1 | esf_init==1) & arrangement_type!="" // program initiation
gen prg_period = (ecf==1 | scf==1 | esf_init==1) // program period
gen g7 = country_name=="Canada" | country_name=="France" | country_name=="Germany" | country_name=="Italy" | country_name=="Japan" | country_name=="United Kingdom" | country_name=="United States"

gen pre_prg1 = f.prg_init_prgt==1
gen post_prg1 = prg_period==0 & l.prg_period==1
gen pre_prg2 = f2.prg_init_prgt==1
gen post_prg2 = prg_period==0 & l2.prg_period==1
gen pre_prg3 = f3.prg_init_prgt==1
gen post_prg3 = prg_period==0 & l3.prg_period==1

// Only these country-year pairs can be served as control group
gen control_group_prgt = g7==0 & PRGT==1 & prg_period==0 & pre_prg1==0 & post_prg1==0 & outlier==0
*gen control_group_prgt = g7==0 & PRGT==1 & prg_period==0 & pre_prg1==0 & post_prg1==0 & pre_prg2==0 & post_prg2==0 & pre_prg3==0 & post_prg3==0 & outlier==0

tab (region), gen(d_region)
tab (country_code), gen(d_country)
tab (year), gen(d_year)
egen region_num = group(region)


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
gen float_er_l1 = l.float_er
gen reserve_gdp_l1 = l.reserve_gdp
gen iip_gdp_l1 = l.iip_gdp 
gen trade_openness_l1=l.trade_openness 
gen credit_gdp_prgt_l1=l.credit_gdp_prgt
gen quota_gdp_l1=l.quota_gdp
gen acct_l1 = l.acct
gen stab_l1 = l.stab
gen effect_l1 = l.effect
gen qual_l1 = l.qual
gen law_l1 = l.law
gen corrupt_l1 = l.corrupt

gen pre_ngdp_rpch = (l.ngdp_rpch+l2.ngdp_rpch)/2
gen pre_pcpie_pch = (l.pcpie_pch+l2.pcpie_pch)/2
gen pre_bca_gdp = (l.bca_gdp_bp6+l2.bca_gdp_bp6)/2
gen pre_ggxcnl_gdp = (l.ggxcnl_gdp+l2.ggxcnl_gdp)/2

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
label var float_er_l1 "Float Exchange Rate (t-1)"
label var credit_gdp_prgt_l1 "Fund credit outstanding/GDP (t-1)"
label var reserve_gdp_l1 "Reserves/GDP (t-1)"
label var acct_l1 "Accountability (t-1)"
label var stab_l1 "Political stability (t-1)"
label var effect_l1 "Government effectiveness (t-1)"
label var qual_l1 "Regulatory quality (t-1)"
label var law_l1 "Rule oflaw (t-1)"
label var corrupt_l1 "Control of corruption (t-1)"


* Probit regressions for finding comparators
// Include treated units (prg_init_prgt==1) and control units (control_group_prgt==1) in the regressions
eststo clear
eststo: probit prg_init_prgt ngdp_rpch_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 ggxcnl_gdp_l1 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 float_er_l1 reserve_gdp_l1 credit_gdp_prgt_l1 stab_l1 d_region* d_year* if year<=2017 & year>=2010 & (prg_init_prgt==1 | control_group_prgt==1)
*eststo: probit prg_init_prgt pre_ngdp_rpch lngdppc_l1 pre_pcpie_pch pre_ggxcnl_gdp bfd_gdp_bp6_l1 d_gdp_l1 pre_bca_gdp float_er_l1 reserve_gdp_l1 credit_gdp_prgt_l1 stab_l1 d_region* d_year* if year<=2017 & year>=2010 & (prg_init_prgt==1 | control_group_prgt==1)
predict pscore1 if e(sample), pr

/*
// Profit fixed effect model is biased, whereas logit fixed effect model is unbiased.
eststo: xtlogit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 reserve_gdp_l1 i.region_num  if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1), fe
eststo: xtlogit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 reserve_gdp_l1 i.region_num  if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1), fe

// ROC 2011 used population average method.
eststo: xtprobit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 reserve_gdp_l1 d_region* if year<=2011 & year>=2002 & (prg_init_prgt==1 | control_group_prgt==1) , pa
eststo: xtprobit prg_init_prgt ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 reserve_gdp_l1 d_region* if year<=2017 & year>=2011 & (prg_init_prgt==1 | control_group_prgt==1) , pa
predict pscore1 if e(sample), mu
*/

esttab using "${path}/Results/propensity_prgt_${date_str}.csv", b(%9.3f) se(%9.3f) t() star(* 0.10 ** 0.05 *** 0.01) drop(_cons) scalars (N) ar2 nogaps label nodepvar replace



* Propensity Score Matching
pscore prg_init_prgt ngdp_rpch_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 ggxcnl_gdp_l1 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 float_er_l1 reserve_gdp_l1 credit_gdp_prgt_l1 stab_l1 d_region* d_year* if year<=2017 & year>=2010 & (prg_init_prgt==1 | control_group_prgt==1), pscore(mypscore)
*pscore prg_init_prgt pre_ngdp_rpch lngdppc_l1 pre_pcpie_pch pre_ggxcnl_gdp bfd_gdp_bp6_l1 d_gdp_l1 pre_bca_gdp float_er_l1 reserve_gdp_l1 credit_gdp_prgt_l1 stab_l1 d_region* d_year* if year<=2017 & year>=2010 & (prg_init_prgt==1 | control_group_prgt==1), pscore(mypscore)
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
save "${path}/Stata Files/comparator_main.dta", replace

export excel program diff_prg_* diff_dis_* using "${path}/Results/comparator_prgt_${date_str}.xlsx" if prg_init_prgt==1 & year>=2008, sheet("comparator_prgt_diff_table", modify) cell(A2) firstrow(variables)
export excel program same_prg_* same_dis_* using "${path}/Results/comparator_prgt_${date_str}.xlsx" if prg_init_prgt==1 & year>=2008, sheet("comparator_prgt_same_table", modify) cell(A2) firstrow(variables)




************************************************************************************************
* For charts on program outcomes
************************************************************************************************

clear
gen country_name=""
gen country_code=.
gen year=. 

gen ngdp_rpch=. 
gen pcpie_pch=.
gen bca_gdp_bp6=. 
gen d_gdp=. 

save "${path}/Stata Files/graph_res.dta", replace


use "${path}/Stata Files/comparator_main.dta", clear
*keep if ctry_1!=""

gen prg_time=.
gen prg_ctry = 0

sort country_code year

preserve
local N = _N
forvalues i = 5(1)`N' {
	if ctry_1[`i']!="" {
		local prg program[`i']
		local c1 diff_ctry_1[`i']
		local c2 diff_ctry_2[`i']
		local c3 diff_ctry_3[`i']
		local c4 diff_ctry_4[`i']
		local c5 diff_ctry_5[`i']
		local y1 diff_year_1[`i']
		local y2 diff_year_2[`i']
		local y3 diff_year_3[`i']
		local y4 diff_year_4[`i']
		local y5 diff_year_5[`i']		
		
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
		
		keep country_code country_name year program prg_time prg_ctry ngdp_rpch pcpie_pch bca_gdp_bp6 d_gdp

		append using "${path}/Stata Files/graph_res.dta"
		save "${path}/Stata Files/graph_res.dta", replace
		restore, preserve
	}
	else
}

restore, not

use "${path}/Stata Files/graph_res.dta", clear

collapse (median) ngdp_rpch pcpie_pch bca_gdp_bp6 d_gdp, by(prg_ctry prg_time)
reshape wide ngdp_rpch pcpie_pch bca_gdp_bp6 d_gdp, i(prg_time) j(prg_ctry)

local var "ngdp_rpch pcpie_pch bca_gdp_bp6 d_gdp"
foreach v of local var {
export excel prg_time `v'0 `v'1 using "${path}/Results/comparator_charts_${date_str}.xlsx", sheet("comparators_prgt_`v'", modify) cell(A22) 
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
