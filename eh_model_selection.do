****************************************************************************************************************************************************************************************************************
* Model Selection
****************************************************************************************************************************************************************************************************************
clear all
cd "//DATA1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/"
local date: display %td_CCYY_NN_DD date(c(current_date), "DMY")
global date_str = subinstr(trim("`date'"), " " , "-", .)

global vlist "ngdp ngdpd ngdpdpc d_gdp bca_gdp bfra_gdp bfp_gdp ggb_gdp ngdp_rpch pcpi_pch gfn_gdp amt_gdp floatfx gra_credit_gdp prgt_credit_gdp fund_credit_gdp quota_gdp usdsdr fuel_exporter fragile trade_openness iip_gdp financial_openness logfp acct stab effect qual law corrupt Wave1or2 HIPCdecision HIPCcompletion licdsa macdsa" // variables for regressions

use "Section-Evenhandedness/Regressions/Stata Files/master_data_eh.dta", clear

forvalues i = 1995(1)2022 {
gen floatfx`i' = exchange_rate`i'>7 & exchange_rate`i'!=.
gen iip_gdp`i' = iip`i'/ngdpd`i'*100
gen gra_credit_gdp`i' = gra_credit`i'/1000000/ngdpd`i'
gen prgt_credit_gdp`i' = prgt_credit`i'/1000000/ngdpd`i'
gen fund_credit_gdp`i' = gra_credit_gdp`i' + prgt_credit_gdp`i'
gen quota_gdp`i' = quota`i'/1000000/ngdpd`i'
gen financial_openness`i' = (total_assets`i'+total_liabilities`i')/1000000/ngdpd`i'
gen logfp`i' = log((total_assets`i'+total_liabilities`i')/1000)

gen acct`i' = VoiceandAccountability`i'
gen stab`i' = PoliticalStability`i'
gen effect`i' = GovernmentEffectiveness`i'
gen qual`i' = RegulatoryQuality`i'
gen law`i' = RuleofLaw`i'
gen corrupt`i' = ControlofCorruption`i'

/*
gen acct`i' = log(VoiceandAccountability`i'+4.5) 
gen stab`i' = log(PoliticalStability`i'+4.5) 
gen effect`i' = log(GovernmentEffectiveness`i'+4.5) 
gen qual`i' = log(RegulatoryQuality`i'+4.5) 
gen law`i' = log(RuleofLaw`i'+4.5) 
gen corrupt`i' = log(ControlofCorruption`i'+4.5)
*/
drop iip`i' gra_credit`i' prgt_credit`i' VoiceandAccountability`i' PoliticalStability`i' GovernmentEffectiveness`i' RegulatoryQuality`i' RuleofLaw`i' ControlofCorruption`i'
}

* Generate varibles t-5 to t+5 (t is program initiation year)
sort type country_code year weo_id 

foreach v of global vlist {
	gen `v'0 = .
	gen `v'1 = .
	gen `v'2 = .
	gen `v'3 = .
	gen `v'4 = .
	gen `v'5 = .
	gen `v'6 = .
	gen `v'7 = .
	gen `v'8 = .
	gen `v'9 = .
	gen `v'10 = .
	gen `v'_adj = .
}
	
local N = _N
forvalues i = 1(1)`N' {
	if weo_id[`i'] !="" {
		local y0 = year[`i'] - 5	
		local y1 = year[`i'] - 4
		local y2 = year[`i'] - 3	
		local y3 = year[`i'] - 2
		local y4 = year[`i'] - 1
		local y5 = year[`i']
		local y6 = year[`i'] + 1
		local y7 = year[`i'] + 2
		local y8 = year[`i'] + 3
		local y9 = year[`i'] + 4
		local y10 = year[`i'] + 5
		local end_y = orig_expiry[`i']-year[`i']+5
		
	foreach v of global vlist {
	replace `v'0 = `v'`y0' in `i'
	replace `v'1 = `v'`y1' in `i'
	replace `v'2 = `v'`y2' in `i'
	replace `v'3 = `v'`y3' in `i'
	replace `v'4 = `v'`y4' in `i'
	replace `v'5 = `v'`y5' in `i'
	replace `v'6 = `v'`y6' in `i'
	replace `v'7 = `v'`y7' in `i'
	replace `v'8 = `v'`y8' in `i'
	replace `v'9 = `v'`y9' in `i'
	replace `v'10 = `v'`y10' in `i'
	}
	}

	else

}


drop *19* *20* // only keep t-5 to t+5

* Find external debt data from staff reports (why unavailable in WEO?)
// Greece 2010 SBA, Greece 2012 EFF, Iceland 
merge 1:1 country_name arrangement_type year using "Section-Evenhandedness/Regressions/Stata Files/debt_sr.dta", update
drop _m


merge 1:1 country_name arrangement_type year using "Section-Evenhandedness/Regressions/Stata Files/ggb_sr.dta", update
drop _m

local N = _N
forvalues i = 1(1)`N' {
	if weo_id[`i'] !="" {
		local end_y = orig_expiry[`i']-year[`i']+5
		
		foreach v of global vlist {
		replace `v'_adj = `v'`end_y' - `v'5 in `i'
		}
	}

	else

}


forvalues i = 2(1)10 {
replace amt_gdp`i' = dsp`i'/ngdpd`i'*100 if amt_gdp`i'==. // already in billion of USD
local m = `i'-1
gen chg_bfra_gdp`i' = (bfra_gdp`i'*ngdpd`i'-bfra_gdp`m'*ngdpd`i-1')/ngdpd`i'
replace gfn_gdp`i' = chg_bfra_gdp`i' + amt_gdp`i' - bca_gdp`i' if gfn_gdp`i'==.
}

*****************************************
* Iceland 
* 	2002	2003	2004	2005	2006	2007
*Gross external financing need 4/ (in billions of US dollars) 3.5	5.6	8.5	11.0	15.0	18.6
*in percent of GDP	39	51	64	68	92	97
* 4/ Defined as current account deficit, plus amortization on medium- and long-term debt, plus short-term debt at end of previous period.
*****************************************
replace chg_bfra_gdp4 = (bfra_gdp4*ngdpd4-bfra_gdp3*ngdpd3)/ngdpd4 if country_name=="Iceland"
replace chg_bfra_gdp3 = (bfra_gdp3*ngdpd3-bfra_gdp3*ngdpd3)/ngdpd3 if country_name=="Iceland"
replace chg_bfra_gdp2 = (bfra_gdp2*ngdpd2-bfra_gdp3*ngdpd3)/ngdpd2 if country_name=="Iceland"

replace gfn_gdp4 = 97 + chg_bfra_gdp4 if country_name=="Iceland"
replace gfn_gdp3 = 92 + chg_bfra_gdp3 if country_name=="Iceland"
replace gfn_gdp2 = 68 + chg_bfra_gdp2 if country_name=="Iceland"



gen prg_length = (orig_expiry-year)*12+(orig_exp_month-app_month)
gen post_hipc_decision = year>HIPCdecision5
gen post_hipc_completion = year>HIPCcompletion5 
gen wave1 = Wave1or25==1
gen wave2 = Wave1or25==2
drop HIPCdecision* HIPCcompletion* Wave1or2*

gen prior2006 = year<2006
gen post2008 = year>2008
gen gfc = year>=2008 & year<=2012

replace precautionary = 1 if precautionary__using_mona_==1
replace precautionary = 0 if precautionary==.

gen prg = country_name+", "+string(year)+", "+arrangement_type

*gen capital_crisis = bfp_gdp5-bfp_gdp4<-3
gen capital_crisis = bfp_gdp5-bfp_gdp4<-3 /* & type=="GRA" */ // Cheating?
gen outflow_gdp = bfp_gdp5-bfp_gdp4<-3

gen gfn_gdp = gfn_gdp5+gfn_gdp6+gfn_gdp7
gen amt_gdp = amt_gdp5+amt_gdp6+amt_gdp7
replace gfn_gdp = 0 if gfn_gdp < 0


gen lnaccess = ln(pc_quota)
gen access_gdp = amount_agreed/usdsdr5/1000000000/ngdpd4*100
gen lnaccess_gdp = ln(access_gdp)

/*
gen fis_adj = 
gen ca_adj =
gen inf_adj = 
gen res_adj = 
*/

tab(region), gen(region_d)
tab (year), gen(year_d)
gen gra_d = type=="GRA"


save "Section-Evenhandedness/Regressions/Stata Files/data_eh_reg.dta", replace

* GRA and PRGT
use "Section-Evenhandedness/Regressions/Stata Files/data_eh_reg.dta", clear

sort country_code year
gen lngdpdpc4 = ln(ngdpdpc4)

merge 1:1 country_code year using "Section-Evenhandedness/Regressions/Stata Files/successor_program.dta"
drop if _m==2
drop _m

global bop_need "amt_gdp capital_crisis ngdp_rpch4 pcpi_pch4 bca_gdp4 bfra_gdp4 d_gdp4"
global strength_prg "bca_gdp_adj ggb_gdp_adj d_gdp_adj"
global capacity_repay "fund_credit_gdp4 quota_gdp4 acct4 stab4 effect4 qual4 law4"
global program_type "successor precautionary"
global systemic "exceptional_access financial_openness4"
global track_record "pre_com pre_inc"
global other_factors "lngdpdpc4 floatfx4 gfc"
global region "region_d1 region_d3 region_d4 region_d5"

label var successor "Successor program"
label var precautionary "Precautionary"
label var gfn_gdp "Gross financing need"
label var amt_gdp "Amortization need"
label var ngdp_rpch4 "GDP growth (t-1)"
label var pcpi_pch4 "Inflation (t-1)"
label var bca_gdp4 "CA balance/GDP (t-1)"
label var bfra_gdp4 "FDI/GDP (t-1)"
label var d_gdp4 "External debt/GDP (t-1)"
label var capital_crisis "Capital account crisis"
label var bca_gdp_adj "Planned CA adjustment"
label var ggb_gdp_adj "Planned fiscal adjustment"
label var d_gdp_adj "Planned debt adjustment"
label var fund_credit_gdp4 "IMF credit outstanding/GDP (t-1)"
label var quota_gdp4 "Quota/GDP (t-1)"
label var acct4 "Voice and accountability"
label var stab4 "Political stability"
label var effect4 "Government effectiveness"
label var qual4 "Regulatory quality"
label var law4 "Rule of law"
label var logfp4 "Foreign assets+liabilities (t-1)"
label var pre_com "Previous program completed"
label var pre_inc "Previous program incomplete"
label var lngdpdpc4 "log GDP per capita (t-1)"
label var floatfx4 "Flexible exchange regime (t-1)"
label var post2008 "Post 2008"
label var gra_d "GRA program dummy"
label var exceptional_access "Exceptional access"
label var region_d1 "AFR"
label var region_d3 "EUR"
label var region_d4 "MCD"
label var region_d5 "WHD"


* Interpoloate missing data

local var "bfra_gdp d_gdp"
foreach v of local var {
replace `v'4 = `v'3 if `v'4==.
replace `v'4 = `v'5 if `v'4==.
}

local var "logfp financial_openness"
foreach v of local var {
replace `v'4 = `v'3 if `v'4==.
replace `v'4 = `v'5 if `v'4==.

reg `v'4 ngdpd4 lngdpdpc4 year region_d*
predict `v'4_fit
replace `v'4 = `v'4_fit if `v'4==.
drop `v'4_fit
}


* Generate outliers
gen outlier = 0
local var "gfn_gdp ngdp_rpch4 pcpi_pch4 bca_gdp4 bfra_gdp4 d_gdp4 bca_gdp_adj ggb_gdp_adj d_gdp_adj logfp4 lngdpdpc4"
foreach v of local var {
egen pct1_`v' = pctile(`v'), p(1)
egen pct99_`v' = pctile(`v'), p(99)
gen outlier_`v'=0
replace outlier_`v' = 1 if `v' < pct1_`v' | `v' > pct99_`v'
replace outlier = 1 if `v' < pct1_`v' | `v' > pct99_`v'
}




// Check missing values
mdesc access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} ${region}
sum access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} ${region}

// Check missing values
kdensity access_gdp, normal
kdensity access_gdp if outlier==0, normal

kdensity lnaccess_gdp, normal
kdensity lnaccess_gdp if outlier==0, normal




// Consolidated regressions

reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} gra_d if outlier==0, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", replace label ctitle(All)
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if type=="GRA" & outlier==0, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(GRA)
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if type=="PRGT" & outlier==0, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(PRGT)

reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} gra_d, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(All)
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if type=="GRA", robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(GRA)
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if type=="PRGT", robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(PRGT)


// For contributions chart
export excel country_name country_code year type arrangement_number arrangement_type access_gdp ${program} ${bop_need} ${strength_prg} ${capacity_repay} ${systemic} ${other_factors} ${fund_policy} ${region} using "Section-Evenhandedness/Regressions/Results/For Charts_${date_str}.xlsx", firstrow(variables) sheet("Contribution_data", replace) cell(B5)

// For residuals charts
sort type year country_code
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors}, robust
predict access_cri_res, res
export excel country_name country_code year type arrangement_number arrangement_type access_gdp access_cri_res using "Section-Evenhandedness/Regressions/Results/For Charts_${date_str}.xlsx", firstrow(variables) sheet("Residual", replace) cell(B2)

reg access_gdp ${program} ${bop_need} ${strength_prg} ${capacity_repay} ${systemic} ${other_factors} exceptional_access, robust
predict access_ea_res, res
export excel country_name country_code year type arrangement_number arrangement_type access_gdp access_ea_res using "Section-Evenhandedness/Regressions/Results/For Charts_${date_str}.xlsx", firstrow(variables) sheet("Residual", modify) cell(L2)








*********************************************************************************************************************************************
* Robustness: outliers

*********************************************************************************************************************************************


reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors}, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/robust1_all_reg_${date_str}.xls", replace label stats(pval) ctitle(All obs)

* Exlude extreme values
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors}, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/robust1_all_reg_${date_str}.xls", append label stats(pval) ctitle(Excl. outliers) 

* Exlude exceptional access cases
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors}, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/robust1_all_reg_${date_str}.xls", append label stats(pval) ctitle(Excl. EA)

* Exclude one program at a time
levelsof arrangement_number, local(prg)
foreach p of local prg {
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors}, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/robust1_all_reg_${date_str}.xls", append label stats(pval) ctitle(`p')
}







*********************************************************************************************************************************************
* Robustness: GRA vs. PRGT

*********************************************************************************************************************************************

reg access_gdp gfn_gdp4 if outlier==0 & type=="GRA"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", replace label ctitle(GRA)
reg access_gdp gfn_gdp4 quota_gdp4 if outlier==0 & type=="GRA"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(GRA)
reg access_gdp gfn_gdp4 quota_gdp4 exceptional_access if outlier==0 & type=="GRA"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(GRA)
reg access_gdp gfn_gdp4 quota_gdp4 exceptional_access precautionary if outlier==0 & type=="GRA"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(GRA)
reg access_gdp gfn_gdp4 quota_gdp4 exceptional_access precautionary capital_crisis if outlier==0 & type=="GRA"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(GRA)


reg access_gdp gfn_gdp4 if outlier==0 & type=="PRGT"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(PRGT)
reg access_gdp gfn_gdp4 quota_gdp4 if outlier==0 & type=="PRGT"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(PRGT)
reg access_gdp gfn_gdp4 quota_gdp4 exceptional_access if outlier==0 & type=="PRGT"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(PRGT)
reg access_gdp gfn_gdp4 quota_gdp4 exceptional_access precautionary if outlier==0 & type=="PRGT"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(PRGT)
reg access_gdp gfn_gdp4 quota_gdp4 exceptional_access precautionary capital_crisis if outlier==0 & type=="PRGT"
outreg2 using "Section-Evenhandedness/Regressions/Results/robust2_all_reg_${date_str}.xls", append label ctitle(PRGT)



*********************************************************************************************************************************************
* Robustness: BMA

*********************************************************************************************************************************************

wals access_gdp if outlier==0, aux(${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors})
wals access_gdp if year>2008 & outlier==0, aux(${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors})
bma access_gdp if outlier==0, aux(${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors})
bma access_gdp if year>2008 & outlier==0, aux(${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors})

* Regressors that have high pip from BMA:
/*
precautionary
ngdp_rpch4
capital_crisis
ggb_gdp_adj
d_gdp_adj
quota_gdp4
exceptional_access
gra_d
*/

// Only include significant regressors from BMA

global bop_need "capital_crisis ngdp_rpch4"
global strength_prg "bca_gdp_adj ggb_gdp_adj d_gdp_adj"
global capacity_repay "quota_gdp4 acct4 stab4 effect4 qual4 law4"
global program_type "successor precautionary"
global systemic "exceptional_access"
global track_record ""
global other_factors "lngdpdpc4 gfc"


reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} gra_d if outlier==0, robust
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if outlier==0 & type=="GRA", robust
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if outlier==0 & type=="PRGT", robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_bma_${date_str}.xls", replace ctitle()

sort type exceptional_access year country_code
export excel country_name country_code year type arrangement_number arrangement_type access_gdp *res exceptional_access using "Section-Evenhandedness/Regressions/Results/For Charts.xlsx", firstrow(variables) sheet("Data", modify) cell(B2)




* Winsorize outliers
local var "gfn_gdp ngdp_rpch4 pcpi_pch4 bca_gdp4 bfra_gdp4 d_gdp4 bca_gdp_adj ggb_gdp_adj d_gdp_adj logfp4 lngdpdpc4"
foreach v of local var {
replace `v' = pct1_`v' if `v'<pct1_`v'
replace `v' = pct99_`v' if `v'>pct99_`v'
drop pct1_`v' pct99_`v'
}

reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors}, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(All)
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if type=="GRA" & outlier==0, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(GRA)
reg access_gdp ${bop_need} ${strength_prg} ${capacity_repay} ${program_type} ${systemic} ${track_record} ${other_factors} if type=="PRGT" & outlier==0, robust
outreg2 using "Section-Evenhandedness/Regressions/Results/all_reg_${date_str}.xls", append label ctitle(PRGT)

* Model selection

gsreg ngdp_rpch4 lngdpdpc4 pcpi_pch4 floatfx4 bca_gdp4 bfra_gdp4 fund_credit_gdp4 quota_gdp4 gra_d capital_crisis post_hipc_decision post_hipc_completion wave1 wave2 region_d*, ncomb(2,2) fixvar(bca_gdp_adj ggb_gdp_adj d_gdp4) resultsdta(model_all) aicbic replace
export excel *_t obs nvar r_sqr_a rmse_in aic bic using "Section-Evenhandedness/Regressions/Results/model_all_t.xlsx" if _n<=15, firstrow(varlabels) replace



local facility "GRA PRGT"
foreach f of local facility {
gsreg access_gdp pcpi_pch4 floatfx4 bca_gdp4 bfra_gdp4 prgt_credit_gdp4 quota_gdp4 post_hipc_decision post_hipc_completion wave1 wave2 region_d* if type=="`f'", ncomb(2,5) fixvar(bca_gdp_adj ngdp_rpch4 lngdpdpc4 d_gdp4) resultsdta(model_`f') aicbic replace
export excel *_t obs nvar r_sqr_a rmse_in aic bic using "Section-Evenhandedness/Regressions/Results/model_`f'_t.xlsx" if _n<=9, firstrow(varlabels) replace
export excel *_b obs nvar r_sqr_a rmse_in aic bic using "Section-Evenhandedness/Regressions/Results/model_`f'_b.xlsx" if _n<=9, firstrow(varlabels) replace
}
