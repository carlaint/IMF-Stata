**********************************************************************************
* Construct comparators using synthetic control
**********************************************************************************

use "${path}/Stata Files/master_comparator_data.dta", clear

gen iip_gdp = iip/ngdpd*100
gen lngdppc = ln(ngdpdpc)
gen credit_gdp_gra = gra_credit/1000000/ngdpd
replace credit_gdp_gra=0 if credit_gdp_gra==.
gen quota_gdp = quota/1000000/ngdpd
replace quota_gdp=0 if quota_gdp==.

* Label outliers
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 exchange_rate iip_gdp trade_openness credit_gdp_gra quota_gdp"
foreach v of local var {
bysort year:egen phigh_`v'=pctile(`v'), p(95)
bysort year:egen plow_`v'=pctile(`v'), p(5)
}

// Only exclude outliers for the varaibles below.
gen outlier = 0
local var "ngdp_rpch lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 credit_gdp_gra"
foreach v of local var {
replace outlier = 1 if (`v'> phigh_`v' | `v'<plow_`v') & `v'!=.
}


sort country_code year
tsset country_code year
gen prg_init_gra = (eff==1 | sba==1 | pll==1) & arrangement_type!="" // program initiation
gen prg_period = (eff==1 | sba==1 | pll==1) // program period
gen g7 = country_name=="Canada" | country_name=="France" | country_name=="Germany" | country_name=="Italy" | country_name=="Japan" | country_name=="United Kingdom" | country_name=="United States"

gen pre_prg1 = f.prg_init_gra==1
gen post_prg1 = prg_period==0 & l.prg_period==1

// Only these country-year pairs can be served as control group
gen control_group_gra = g7==0 & PRGT==0 & prg_period==0 & pre_prg1==0 & post_prg1==0 & outlier==0
gen control_group_prgt = g7==0 & PRGT==1 & prg_period==0 & pre_prg1==0 & post_prg1==0 & outlier==0

tab (region), gen(d_region)
tab (year), gen(d_year)
egen region_num = group(region)


local var "ngdp_rpch bca_gdp_bp6 d_gdp"
foreach v of local var {
drop if `v'==.
}

keep if year>=2006

drop if country_name=="Syria" | country_name=="Nauru" | country_name=="Samoa" | country_name=="Germany"

gen prg_code = country_code*10000+year

tsset country_code year

levelsof prg_code if prg_init_gra==1 & post2011==1, local(prg)

foreach p of local prg {
local tr = trunc(`p'/10000)
local trp = `p'-trunc(`p'/10000)*10000
local pre = `p'-trunc(`p'/10000)*10000-4
local after = `p'-trunc(`p'/10000)*10000+4
synth ngdp_rpch ngdp_rpch bca_gdp_bp6, trunit(`tr') trperiod(`trp') fig resultsperiod(`pre'(1)`after')
graph save Graph "${path}/Results/`p'.gph", replace
graph export "${path}/Results/`p'.png", replace
}
