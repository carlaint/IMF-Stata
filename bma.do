clear all
global path "Q:/DATA/SPRLP/EM/Review of Conditionality/Data/Comparators"
local date: display %td_CCYY_NN_DD date(c(current_date), "DMY")
global date_str = subinstr(trim("`date'"), " " , "-", .)

**********************************************************************************
* Bayesian Model Averaging
**********************************************************************************

use "${path}/Stata Files/master_data_comparator.dta", clear

gen iip_gdp = iip/ngdpd*100
gen lngdppc = ln(ngdpdpc)
gen credit_gdp = gra_credit/1000000/ngdpd
replace credit_gdp=0 if credit_gdp==.
gen quota_gdp = quota/1000000/ngdpd
replace quota_gdp=0 if quota_gdp==.
rename iar_gdp_bp6 reserve_gdp
gen float_er = exchange_rate>=9

gen acct = log(VoiceandAccountability) 
gen stab = log(PoliticalStability) 
gen effect = log(GovernmentEffectiveness) 
gen qual = log(RegulatoryQuality) 
gen law = log(RuleofLaw) 
gen corrupt = log(ControlofCorruption)

* Label outliers
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 float_er iip_gdp trade_openness credit_gdp quota_gdp reserve_gdp"
foreach v of local var {
bysort year:egen phigh_`v'=pctile(`v'), p(95)
bysort year:egen plow_`v'=pctile(`v'), p(5)
}

// Only exclude outliers for the varaibles below.
gen outlier = 0
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 credit_gdp reserve_gdp"
foreach v of local var {
replace outlier = 1 if (`v'> phigh_`v' | `v'<plow_`v') & `v'!=.
}


sort country_code year
tsset country_code year
gen prg_init_gra = (eff_init==1 | sba_init==1 | pll_init==1) // program initiation
gen prg_period = (eff==1 | sba==1 | pll==1) // program period
gen g7 = country_name=="Canada" | country_name=="France" | country_name=="Germany" | country_name=="Italy" | country_name=="Japan" | country_name=="United Kingdom" | country_name=="United States"

gen pre_prg1 = f.prg_init_gra==1
gen post_prg1 = prg_period==0 & l.prg_period==1
gen pre_prg2 = f2.prg_init_gra==1
gen post_prg2 = prg_period==0 & l2.prg_period==1
gen pre_prg3 = f3.prg_init_gra==1
gen post_prg3 = prg_period==0 & l3.prg_period==1

// Only these country-year pairs can be served as control group
gen control_group_gra = g7==0 & PRGT==0 & prg_period==0 & pre_prg1==0 & post_prg1==0 & outlier==0
gen control_group_prgt = g7==0 & PRGT==1 & prg_period==0 & pre_prg1==0 & post_prg1==0 & outlier==0

*gen control_group_gra = g7==0 & PRGT==0 & prg_period==0 & pre_prg1==0 & post_prg1==0 & pre_prg2==0 & post_prg2==0 & pre_prg3==0 & post_prg3==0 & outlier==0
*gen control_group_prgt = g7==0 & PRGT==1 & prg_period==0 & pre_prg1==0 & post_prg1==0 & pre_prg2==0 & post_prg2==0 & pre_prg3==0 & post_prg3==0 & outlier==0

tab (region), gen(d_region)
tab (country_code), gen(d_country)
tab (year), gen(d_year)
egen region_num = group(region)

// Demean all variables
local var "ngdp_rpch ggxcnl_gdp lngdppc pcpie_pch bfd_gdp_bp6 d_gdp bca_gdp_bp6 float_er iip_gdp trade_openness credit_gdp quota_gdp reserve_gdp acct stab effect qual law corrupt"
foreach v of local var {
quietly reg `v' d_country* d_year*
predict `v'_res, resid
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
gen float_er_l1 = l.float_er
gen iip_gdp_l1 = l.iip_gdp 
gen trade_openness_l1 = l.trade_openness 
gen credit_gdp_l1 = l.credit_gdp
gen quota_gdp_l1 = l.quota_gdp
gen reserve_gdp_l1 = l.reserve_gdp
gen acct_l1 = l.acct
gen stab_l1 = l.stab
gen effect_l1 = l.effect
gen qual_l1 = l.qual
gen law_l1 = l.law
gen corrupt_l1 = l.corrupt

// Label variables for regression output files
label var prg_init_gra "Program initialization dummy"
label var ngdp_rpch_l1 "Real GDP growth (t-1)"
label var ggxcnl_gdp_l1 "General Gov Debt/GDP (t-1)"
label var lngdppc_l1 "log(GDP per capita) (t-1)"
label var pcpie_pch_l1 "Inflation (t-1)"
label var pcpie_pch_l2 "Inflation (t-2)" 
label var bfd_gdp_bp6_l1 "FDI/GDP (t-1)"
label var d_gdp_l1 "External debt/GDP (t-1)"
label var bca_gdp_bp6_l1 "Current account/GDP (t-1)"
label var float_er_l1 "Float ER (t-1)"
label var credit_gdp_l1 "Fund credit outstanding/GDP (t-1)"
label var reserve_gdp_l1 "Reserves/GDP (t-1)"
label var acct_l1 "Accountability (t-1)"
label var stab_l1 "Political stability (t-1)"
label var effect_l1 "Government effectiveness (t-1)"
label var qual_l1 "Regulatory quality (t-1)"
label var law_l1 "Rule oflaw (t-1)"
label var corrupt_l1 "Control of corruption (t-1)"

* Bayesian Model Averaging (BMA)

mdesc ngdp_rpch_l1 ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 float_er_l1 reserve_gdp_l1 iip_gdp_l1 trade_openness_l1 credit_gdp_l1 quota_gdp_l1 if year>=2010

wals prg_init_gra if year<=2017 & year>=2010 & (prg_init_gra==1 | control_group_gra==1), aux(ngdp_rpch_l1 ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 float_er_l1 reserve_gdp_l1 credit_gdp_l1 quota_gdp_l1 acct_l1 stab_l1 effect_l1 qual_l1 law_l1 corrupt_l1)
esttab using "${path}/Results/wals_${date_str}.csv", b(%9.3f) se(%9.3f) t() star(* 0.10 ** 0.05 *** 0.01) drop(_cons) scalars (N) ar2 nogaps label nodepvar replace

bma prg_init_gra if year<=2017 & year>=2010 & (prg_init_gra==1 | control_group_gra==1), aux(ngdp_rpch_l1 ggxcnl_gdp_l1 lngdppc_l1 pcpie_pch_l1 pcpie_pch_l2 bfd_gdp_bp6_l1 d_gdp_l1 bca_gdp_bp6_l1 float_er_l1 reserve_gdp_l1 credit_gdp_l1 quota_gdp_l1 acct_l1 stab_l1 effect_l1 qual_l1 law_l1 corrupt_l1)
esttab using "${path}/Results/bma_${date_str}.csv", b(%9.3f) se(%9.3f) star(* 0.10 ** 0.05 *** 0.01) drop(_cons) scalars (N) ar2 nogaps label nodepvar replace
