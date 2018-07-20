clear all
global path "//DATA1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data"

*****************************************************************************************************************
* Country Groups
*****************************************************************************************************************
import excel using "${path}/Country_Groups.xlsx", sheet("Data") clear
drop in 1/1

keep A-F

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
destring, replace

rename code country_code
rename iso country_iso_3_code
replace small_state = 0 if small_state ==.
replace fuel_exporter = 0 if fuel_exporter==.

save "${path}/Comparators/Stata Files/country_groups.dta", replace

*****************************************************************************************************************
* Fragile States
*****************************************************************************************************************
import excel using "${path}/IMF_Fragile_State_Lists_2008_2017.xlsx", sheet("IMF_2011") clear
rename A country_code
rename B country_name
rename C fragile
keep if country_code!=.
drop D
gen year = 2011
destring, replace
save "${path}/Comparators/Stata Files/fragile_2011.dta", replace

forvalues i=2012(1)2014 {
use "${path}/Comparators/Stata Files/fragile_2011.dta", clear
replace year = `i'
save "${path}/Comparators/Stata Files/fragile_`i'.dta", replace
}

import excel using "${path}/IMF_Fragile_State_Lists_2008_2017.xlsx", sheet("IMF_2015") clear
rename A country_code
rename B country_name
rename C fragile
keep if country_code!=.
drop D
gen year = 2015
destring, replace
save "${path}/Comparators/Stata Files/fragile_2015.dta", replace

use "${path}/Comparators/Stata Files/fragile_2015.dta", clear
replace year = 2016
save "${path}/Comparators/Stata Files/fragile_2016.dta", replace

import excel using "${path}/IMF_Fragile_State_Lists_2008_2017.xlsx", sheet("IMF_2017") clear
rename A country_code
rename B country_name
rename C fragile
keep if country_code!=.
drop D
gen year = 2017
destring, replace
save "${path}/Comparators/Stata Files/fragile_2017.dta", replace


use "${path}/Comparators/Stata Files/fragile_2011.dta", clear
forvalues i=2012(1)2017 {
append using "${path}/Comparators/Stata Files/fragile_`i'.dta"
}

save "${path}/Comparators/Stata Files/fragile_states.dta", replace

*****************************************************************************************************************
* World Governance Indicators
*****************************************************************************************************************
local ind "VoiceandAccountability PoliticalStability GovernmentEffectiveness RegulatoryQuality RuleofLaw ControlofCorruption"
foreach i of local ind {
import excel using "${path}/WB_GovernanceIndicators.xlsx", sheet("`i'") clear

// Use 15th and 14th rows as variable name
foreach var of varlist * {
  rename `var' `=lower(strtoname(`var'[15]+`var'[14]))'
}

drop in 1/16
keep country_territory wbcode estimate*
rename country_territory country_name
rename wbcode country_iso_3_code

reshape long estimate, i(country_name country_iso_3_code) j(year)
compress 
destring estimate, replace force
rename estimate `i'
save "${path}/Comparators/Temp/WGI_`i'.dta", replace
}

use "${path}/Comparators/Temp/WGI_VoiceandAccountability.dta", clear

local ind "PoliticalStability GovernmentEffectiveness RegulatoryQuality RuleofLaw ControlofCorruption"
foreach i of local ind {
merge 1:1 country_iso_3_code year using "${path}/Comparators/Temp/WGI_`i'.dta", nogen
}


replace country_name="Cabo Verde" if country_name=="Cape Verde"
replace country_name="Congo, Democratic Republic of the" if country_name=="Congo, Dem. Rep."
replace country_name="Congo, Republic of" if country_name=="Congo, Rep."
replace country_name="Egypt" if country_name=="Egypt, Arab Rep."
replace country_name="Hong Kong SAR" if country_name=="Hong Kong SAR, China"
replace country_name="Iran" if country_name=="Iran, Islamic Rep."
replace country_name="Korea" if country_name=="Korea, Rep."
replace country_name="Lao P.D.R." if country_name=="Lao PDR"
replace country_name="Macao SAR" if country_name=="Macao SAR, China"
replace country_name="Micronesia" if country_name=="Micronesia, Fed. Sts."
replace country_name="Montenegro, Rep. of" if country_name=="Montenegro"
replace country_name="Russia" if country_name=="Russian Federation"
replace country_name="Syria" if country_name=="Syrian Arab Republic"
replace country_name="São Tomé and Príncipe" if country_name=="São Tomé and Principe"
replace country_name="Taiwan Province of China" if country_name=="Taiwan, China"
replace country_name="Venezuela" if country_name=="Venezuela, RB"
replace country_name="Yemen" if country_name=="Yemen, Rep."

save "${path}/Comparators/Stata Files/WGI.dta", replace

*****************************************************************************************************************
* Trade Openness
*****************************************************************************************************************
import excel using "${path}/Penn_World_Table_90.xlsx", sheet("Data") firstrow clear
keep countrycode year csh_x csh_m
rename countrycode country_iso_3_code
gen trade_openness = csh_x+(-csh_m)
drop csh_x csh_m
save "${path}/Comparators/Stata Files/trade_openness.dta", replace


*****************************************************************************************************************
* IIP
*****************************************************************************************************************

import excel using "${path}/International_Investment_Position_Net.xlsx", sheet("IIP Standard Presentation") clear
drop in 1/4
drop in 209/213
drop AK-AN AP-AS AU-AX AZ-BB

foreach v of varlist B-AY {
replace `v' = "iip"+`v' in 1
}

replace A = "country_name" in 1

// Use first row as variable name
foreach var of varlist * {
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1

foreach var of varlist iip* {
  replace `var' = subinstr(`var',"K","",.)
  replace `var' = subinstr(`var'," ","",.)
  replace `var' = subinstr(`var',"...","",.)
  replace `var' = subinstr(`var',",","",.)
}

destring, replace

reshape long iip, i(country_name) j(year)

replace country_name="Afghanistan" if country_name=="Afghanistan, Islamic Republic of"
replace country_name="Armenia" if country_name=="Armenia, Republic of"
replace country_name="Azerbaijan" if country_name=="Azerbaijan, Republic of"
replace country_name="Bahrain" if country_name=="Bahrain, Kingdom of"
replace country_name="Hong Kong SAR" if country_name=="China, P.R.: Hong Kong"
replace country_name="Macao SAR" if country_name=="China, P.R.: Macao"
replace country_name="China" if country_name=="China, P.R.: Mainland"
replace country_name="Congo, Democratic Republic of the" if country_name=="Congo, Democratic Republic of"
replace country_name="Côte d'Ivoire" if country_name=="Cote d'Ivoire"
replace country_name="Iran" if country_name=="Iran, Islamic Republic of"
replace country_name="Korea" if country_name=="Korea, Republic of"
replace country_name="Kosovo" if country_name=="Kosovo, Republic of"
replace country_name="Lao P.D.R." if country_name=="Lao People's Democratic Republic"
replace country_name="Marshall Islands" if country_name=="Marshall Islands, Republic of"
replace country_name="Micronesia" if country_name=="Micronesia, Federated States of"
replace country_name="Montenegro, Rep. of" if country_name=="Montenegro"
replace country_name="Russia" if country_name=="Russian Federation"
replace country_name="São Tomé and Príncipe" if country_name=="Sao Tome and Principe"
replace country_name="Serbia" if country_name=="Serbia, Republic of"
replace country_name="Syria" if country_name=="Syrian Arab Republic"
replace country_name="Timor-Leste" if country_name=="Timor-Leste, Dem. Rep. of"
replace country_name="Venezuela" if country_name=="Venezuela, Republica Bolivariana de"
replace country_name="Yemen" if country_name=="Yemen, Republic of"


save "${path}/Comparators/Stata Files/iip.dta", replace



import excel using "${path}/International_Investment_Position_Assets.xlsx", sheet("IIP Standard Presentation") clear
drop in 1/4
drop in 209/213

foreach v of varlist* {
replace `v' = "iip_asset"+`v' in 1
}

replace A = "country_name" in 1

// Use first row as variable name
foreach var of varlist * {
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
drop *q*

foreach var of varlist iip* {
  replace `var' = subinstr(`var',"K","",.)
  replace `var' = subinstr(`var'," ","",.)
  replace `var' = subinstr(`var',"...","",.)
  replace `var' = subinstr(`var',",","",.)
}

destring, replace

reshape long iip_asset, i(country_name) j(year)

replace country_name="Afghanistan" if country_name=="Afghanistan, Islamic Republic of"
replace country_name="Armenia" if country_name=="Armenia, Republic of"
replace country_name="Azerbaijan" if country_name=="Azerbaijan, Republic of"
replace country_name="Bahrain" if country_name=="Bahrain, Kingdom of"
replace country_name="Hong Kong SAR" if country_name=="China, P.R.: Hong Kong"
replace country_name="Macao SAR" if country_name=="China, P.R.: Macao"
replace country_name="China" if country_name=="China, P.R.: Mainland"
replace country_name="Congo, Democratic Republic of the" if country_name=="Congo, Democratic Republic of"
replace country_name="Côte d'Ivoire" if country_name=="Cote d'Ivoire"
replace country_name="Iran" if country_name=="Iran, Islamic Republic of"
replace country_name="Korea" if country_name=="Korea, Republic of"
replace country_name="Kosovo" if country_name=="Kosovo, Republic of"
replace country_name="Lao P.D.R." if country_name=="Lao People's Democratic Republic"
replace country_name="Marshall Islands" if country_name=="Marshall Islands, Republic of"
replace country_name="Micronesia" if country_name=="Micronesia, Federated States of"
replace country_name="Montenegro, Rep. of" if country_name=="Montenegro"
replace country_name="Russia" if country_name=="Russian Federation"
replace country_name="São Tomé and Príncipe" if country_name=="Sao Tome and Principe"
replace country_name="Serbia" if country_name=="Serbia, Republic of"
replace country_name="Syria" if country_name=="Syrian Arab Republic"
replace country_name="Timor-Leste" if country_name=="Timor-Leste, Dem. Rep. of"
replace country_name="Venezuela" if country_name=="Venezuela, Republica Bolivariana de"
replace country_name="Yemen" if country_name=="Yemen, Republic of"


save "${path}/Comparators/Stata Files/iip_asset.dta", replace



import excel using "${path}/International_Investment_Position_Liabilities.xlsx", sheet("IIP Standard Presentation") clear
drop in 1/4
drop in 209/213

foreach v of varlist* {
replace `v' = "iip_liability"+`v' in 1
}

replace A = "country_name" in 1

// Use first row as variable name
foreach var of varlist * {
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
drop *q*

foreach var of varlist iip* {
  replace `var' = subinstr(`var',"K","",.)
  replace `var' = subinstr(`var'," ","",.)
  replace `var' = subinstr(`var',"...","",.)
  replace `var' = subinstr(`var',",","",.)
}

destring, replace

reshape long iip_liability, i(country_name) j(year)

replace country_name="Afghanistan" if country_name=="Afghanistan, Islamic Republic of"
replace country_name="Armenia" if country_name=="Armenia, Republic of"
replace country_name="Azerbaijan" if country_name=="Azerbaijan, Republic of"
replace country_name="Bahrain" if country_name=="Bahrain, Kingdom of"
replace country_name="Hong Kong SAR" if country_name=="China, P.R.: Hong Kong"
replace country_name="Macao SAR" if country_name=="China, P.R.: Macao"
replace country_name="China" if country_name=="China, P.R.: Mainland"
replace country_name="Congo, Democratic Republic of the" if country_name=="Congo, Democratic Republic of"
replace country_name="Côte d'Ivoire" if country_name=="Cote d'Ivoire"
replace country_name="Iran" if country_name=="Iran, Islamic Republic of"
replace country_name="Korea" if country_name=="Korea, Republic of"
replace country_name="Kosovo" if country_name=="Kosovo, Republic of"
replace country_name="Lao P.D.R." if country_name=="Lao People's Democratic Republic"
replace country_name="Marshall Islands" if country_name=="Marshall Islands, Republic of"
replace country_name="Micronesia" if country_name=="Micronesia, Federated States of"
replace country_name="Montenegro, Rep. of" if country_name=="Montenegro"
replace country_name="Russia" if country_name=="Russian Federation"
replace country_name="São Tomé and Príncipe" if country_name=="Sao Tome and Principe"
replace country_name="Serbia" if country_name=="Serbia, Republic of"
replace country_name="Syria" if country_name=="Syrian Arab Republic"
replace country_name="Timor-Leste" if country_name=="Timor-Leste, Dem. Rep. of"
replace country_name="Venezuela" if country_name=="Venezuela, Republica Bolivariana de"
replace country_name="Yemen" if country_name=="Yemen, Republic of"


save "${path}/Comparators/Stata Files/iip_liability.dta", replace


*****************************************************************************************************************
* Clean GRA and PRGT Program databases
*****************************************************************************************************************

* GRA and PRGT program data for ROC 2018
import excel using "${path}/2018ROC List of GRA and PRGT.xlsx", sheet("2018ROC__Groupings") clear
keep C-P T

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[4]'"
  rename `var' `=lower(strtoname(`var'[4]))'
}

drop in 1/5
drop if arrangement_number==""

// approval and expiry year
gen year = substr(date_of_arrangement, length(date_of_arrangement)-3,length(date_of_arrangement))
label var year "Approval Year"
gen orig_expiry = substr(initial_end_date, length(initial_end_date)-3,length(initial_end_date))
label var orig_expiry "Original Expiry Year"
gen actual_expiry = substr(actual_current_expiration_date, length(actual_current_expiration_date)-3,length(actual_current_expiration_date))
label var actual_expiry "Actual Expiry Year"
// approval and expiry month
gen app_month = substr(date_of_arrangement, length(date_of_arrangement)-6,length(date_of_arrangement)-6)
label var app_month "Approval Month"
gen orig_exp_month = substr(initial_end_date, length(initial_end_date)-6,length(initial_end_date)-6)
label var orig_exp_month "Original Expiry Month"
gen act_exp_month = substr(actual_current_expiration_date, length(actual_current_expiration_date)-6,length(actual_current_expiration_date)-6)
label var act_exp_month "Actual Expiry Month"

local exp "app_month orig_exp_month act_exp_month"
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

replace exceptional_access = cond(exceptional_access=="Y", "1","0")
rename precautionary_at_program_approva precautionary
replace precautionary = cond(precautionary=="Y", "1", "0")

replace post_financial_crisis_structural = cond(post_financial_crisis_structural=="x", "1", "0")
replace political_transformation = cond(political_transformation=="x", "1", "0")
replace commodity_shocks = cond(commodity_shocks=="x", "1", "0")
replace developing_ =cond(developing_=="x", "1", "0")
replace succesor_arrangement_ = cond(succesor_arrangement_=="x", "1", "0")

rename country country_name
drop if country_name==""
duplicates drop country_code year, force

destring, replace
keep country_name country_code arrangement_type arrangement_number year orig_expiry actual_expiry exceptional_access precautionary app_month orig_exp_month act_exp_month post_financial_crisis_structural political_transformation commodity_shocks developing_ succesor_arrangement_ gra_prgt

* Program initiation years
gen eff_init = arrangement_type=="EFF"
gen sba_init = arrangement_type=="SBA"
gen pll_init = arrangement_type=="PLL"
gen ecf_init = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf_init = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf_init = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi_init = arrangement_type=="PSI"
gen pci_init = arrangement_type=="PCI"
gen blend_init = strpos(arrangement_type, "-") > 0

gen roc2018=1

compress

preserve
keep if gra_prgt=="GRA"
save "${path}/Comparators/Stata Files/gra_programs_init_roc2018.dta", replace

restore
keep if gra_prgt=="PRGT"
save "${path}/Comparators/Stata Files/prgt_programs_init_roc2018.dta", replace


* GRA Program periods
use "${path}/Comparators/Stata Files/gra_programs_init_roc2018.dta", clear
gen prg_length = actual_expiry - year + 1
label var prg_length "Program Length"
expand prg_length
sort country_name year

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
			replace year = year[`i'-1]+1 in `i'
		}

	else
}

* Program periods
drop *_init

gen eff = arrangement_type=="EFF"
gen sba = arrangement_type=="SBA"
gen pll = arrangement_type=="PLL"
gen ecf = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi = arrangement_type=="PSI"
gen pci = arrangement_type=="PCI"
gen blend = strpos(arrangement_type, "-") > 0

// For two programs in the same year: if the successor was approved in the first half, then keep the successor program for that year. Otherwise, keep the previous program.
gsort country_name year -app_1sthalf arrangement_number 
duplicates drop country_name year arrangement_type, force

//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

collapse (first) arrangement_number (mean) precautionary (max) exceptional_access eff sba pll ecf esf scf psi pci blend, by(country_name country_code year)

foreach v of var * {
	label var `v' "`l`v''"
}

save "${path}/Comparators/Stata Files/gra_programs_periods_roc2018.dta", replace


* PRGT Program periods
use "${path}/Comparators/Stata Files/prgt_programs_init_roc2018.dta", clear
gen prg_length = actual_expiry - year + 1
label var prg_length "Program Length"
expand prg_length
sort country_name year

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
			replace year = year[`i'-1]+1 in `i'
		}

	else
}

* Program periods
drop *_init
gen eff = arrangement_type=="EFF"
gen sba = arrangement_type=="SBA"
gen pll = arrangement_type=="PLL"
gen ecf = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi = arrangement_type=="PSI"
gen pci = arrangement_type=="PCI"
gen blend = strpos(arrangement_type, "-") > 0

// For two programs in the same year: if the successor was approved in the first half, then keep the successor program for that year. Otherwise, keep the previous program.
gsort country_name year -app_1sthalf arrangement_number 
duplicates drop country_name year arrangement_type, force

//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

collapse (first) arrangement_number (mean) precautionary (max) exceptional_access eff sba pll ecf esf scf psi pci blend, by(country_name country_code year)

foreach v of var * {
	label var `v' "`l`v''"
}

save "${path}/Comparators/Stata Files/prgt_programs_periods_roc2018.dta", replace


* GRA program data for ROC 2011
import excel using "${path}/2018ROC List of GRA and PRGT.xlsx", sheet("2011ROC_GRA") clear
keep A-J
// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[4]'"
  rename `var' `=lower(strtoname(`var'[4]))'
}

drop in 1/4
drop if country_name==""
gen year = substr(approval_date, length(approval_date)-3,length(approval_date))
label var year "Approval Year"
gen orig_expiry = substr(initial_end_date, length(initial_end_date)-3,length(initial_end_date))
label var orig_expiry "Original Expiry Year"
gen actual_expiry = substr(end_date, length(end_date)-3,length(end_date))
label var actual_expiry "Actual Expiry Year"

replace exceptional_access = cond(exceptional_access=="Y", "1","0")
replace precautionary = cond(precautionary=="Y", "1", "0")

duplicates drop country_code year, force

// approval and expiry month
gen app_month = lower(substr(approval_date, length(approval_date)-6,length(approval_date)-6))
label var app_month "Approval Month"
gen orig_exp_month = substr(initial_end_date, length(initial_end_date)-6,length(initial_end_date)-6)
label var orig_exp_month "Original Expiry Month"
gen act_exp_month = substr(end_date, length(end_date)-6,length(end_date)-6)
label var act_exp_month "Actual Expiry Month"
gen app_1sthalf = app_month=="jan" | app_month=="feb" | app_month=="mar" | app_month=="apr" | app_month=="may" | app_month=="jun"
gen exp_1sthalf = act_exp_month=="jan" | act_exp_month=="feb" | act_exp_month=="mar" | act_exp_month=="apr" | act_exp_month=="may" | act_exp_month=="jun"

local exp "app_month orig_exp_month act_exp_month"
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

keep country_name country_code arrangement_type arrangement_number year orig_expiry actual_expiry exceptional_access precautionary app_month orig_exp_month act_exp_month app_1sthalf exp_1sthalf
destring, replace

* Program initiation years
gen eff_init = arrangement_type=="EFF"
gen sba_init = arrangement_type=="SBA"
gen pll_init = arrangement_type=="PLL"
gen ecf_init = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf_init = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf_init = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi_init = arrangement_type=="PSI"
gen pci_init = arrangement_type=="PCI"
gen blend_init = strpos(arrangement_type, "-") > 0

gen roc2011=1

compress
save "${path}/Comparators/Stata Files/gra_programs_init_roc2011.dta", replace

* Program periods
gen prg_length = actual_expiry - year + 1
label var prg_length "Program Length"
expand prg_length
sort country_name year

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
			replace year = year[`i'-1]+1 in `i'
		}

	else
}

* Program periods
drop *_init
gen eff = arrangement_type=="EFF"
gen sba = arrangement_type=="SBA"
gen pll = arrangement_type=="PLL"
gen ecf = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi = arrangement_type=="PSI"
gen pci = arrangement_type=="PCI"
gen blend = strpos(arrangement_type, "-") > 0

// For two programs in the same year: if the successor was approved in the first half, then keep the successor program for that year. Otherwise, keep the previous program.
gsort country_name year -app_1sthalf arrangement_number 
duplicates drop country_name year arrangement_type, force

//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

collapse (mean) precautionary (max) exceptional_access eff sba pll ecf esf scf psi pci blend, by(country_name country_code year)

foreach v of var * {
	label var `v' "`l`v''"
}

save "${path}/Comparators/Stata Files/gra_programs_periods_roc2011.dta", replace


* PRGT program data for ROC 2011
import excel using "${path}/2018ROC List of GRA and PRGT.xlsx", sheet("2011ROC_PRGT") clear
keep A-G

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
drop if country_name==""
gen year = substr(approval_date, length(approval_date)-3,length(approval_date))
label var year "Approval Year"
gen orig_expiry = substr(initial_end_date, length(initial_end_date)-3,length(initial_end_date))
label var orig_expiry "Original Expiry Year"
gen actual_expiry = substr(end_date, length(end_date)-3,length(end_date))
label var actual_expiry "Actual Expiry Year"

gen exceptional_access = .
gen precautionary = .

drop if country_name==""
duplicates drop country_code year, force

// approval and expiry month
gen app_month = lower(substr(approval_date, length(approval_date)-6,length(approval_date)-6))
label var app_month "Approval Month"
gen orig_exp_month = substr(initial_end_date, length(initial_end_date)-6,length(initial_end_date)-6)
label var orig_exp_month "Original Expiry Month"
gen act_exp_month = substr(end_date, length(end_date)-6,length(end_date)-6)
label var act_exp_month "Actual Expiry Month"
gen app_1sthalf = app_month=="jan" | app_month=="feb" | app_month=="mar" | app_month=="apr" | app_month=="may" | app_month=="jun"
gen exp_1sthalf = act_exp_month=="jan" | act_exp_month=="feb" | act_exp_month=="mar" | act_exp_month=="apr" | act_exp_month=="may" | act_exp_month=="jun"

local exp "app_month orig_exp_month act_exp_month"
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

keep country_name country_code arrangement_type arrangement_number year orig_expiry actual_expiry exceptional_access precautionary app_month orig_exp_month act_exp_month app_1sthalf exp_1sthalf
destring, replace

* Program initiation years
gen eff_init = arrangement_type=="EFF"
gen sba_init = arrangement_type=="SBA"
gen pll_init = arrangement_type=="PLL"
gen ecf_init = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf_init = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf_init = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi_init = arrangement_type=="PSI"
gen pci_init = arrangement_type=="PCI"
gen blend_init = strpos(arrangement_type, "-") > 0

gen roc2011=1

compress
save "${path}/Comparators/Stata Files/prgt_programs_init_roc2011.dta", replace

* Program periods
gen prg_length = actual_expiry - year + 1
label var prg_length "Program Length"
expand prg_length
sort country_name year

local N = _N
forvalues i = 2(1)`N' {
	if arrangement_number[`i'] == arrangement_number[`i'-1] {
			replace year = year[`i'-1]+1 in `i'
		}

	else
}

* Program periods
drop *_init
gen eff = arrangement_type=="EFF"
gen sba = arrangement_type=="SBA"
gen pll = arrangement_type=="PLL"
gen ecf = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf = arrangement_type=="SBA-ESF" | arrangement_type=="ESF"
gen scf = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi = arrangement_type=="PSI"
gen pci = arrangement_type=="PCI"
gen blend = strpos(arrangement_type, "-") > 0

// For two programs in the same year: if the successor was approved in the first half, then keep the successor program for that year. Otherwise, keep the previous program.
gsort country_name year -app_1sthalf arrangement_number 
duplicates drop country_name year arrangement_type, force

//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

collapse (first) arrangement_number (mean) precautionary (max) exceptional_access eff sba pll ecf esf scf psi pci blend, by(country_name country_code year)

foreach v of var * {
	label var `v' "`l`v''"
}

save "${path}/Comparators/Stata Files/prgt_programs_periods_roc2011.dta", replace


*****************************************************************************************************************
* Clean MONA structural benchmarks database
*****************************************************************************************************************

* Number of SBs at the approval of programs
import excel using "${path}/MONA_StructuralConditions.xlsx", sheet("SPCPASB_design_PrgApproval") clear
drop in 1
keep A-Q

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
destring, replace
drop duration_of_annual_arrangement_f duration_of_annual_arrangement_t

gen sb_count=1
label var sb_count "Number of SBs"

//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

collapse (sum) sb_count (first) approval_year initial_end_year revised_end_date program_type review_type review_status, by(country_name country_code arrangement_number)

foreach v of var * {
	label var `v' "`l`v''"
}

rename approval_year year

save "${path}/Comparators/Stata Files/sb_approval.dta", replace


* Number of SBs at the expiry of programs
import excel using "${path}/MONA_StructuralConditions.xlsx", sheet("SPCPASB_design_END") clear
drop in 1
keep A-Q

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1
destring, replace
drop duration_of_annual_arrangement_f duration_of_annual_arrangement_t

gen sb_count=1
label var sb_count "Number of SBs"

//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

collapse (sum) sb_count (first) approval_year initial_end_year revised_end_date program_type review_type review_status, by(country_name country_code arrangement_number)

foreach v of var * {
	label var `v' "`l`v''"
}

rename approval_year year

save "${path}/Comparators/Stata Files/sb_expiry.dta", replace



*****************************************************************************************************************
* Exchange rate regimes from The Annual Report on Exchange Arrangements and Exchange Restrictions (AREAER) by MCM
*****************************************************************************************************************

import excel using "${path}/Exchange_Rate_Regime_Apr_2017.xlsx", sheet("Raw Data") clear
drop in 1/3
keep A B C
rename A year
rename B country_name
rename C exchange_rate
destring, replace

// Mistakes in the data file
drop if country_name == "Zimbabwe" & exchange_rate == 5
drop if country_name == "Serbia" & exchange_rate == 1

reshape wide exchange_rate, i(country_name) j(year)
gen exchange_rate2016 = exchange_rate2015
gen exchange_rate2017 = exchange_rate2015
reshape long exchange_rate, i(country_name) j(year)

replace country_name = "Antigua and Barbuda" if country_name == "Antigua"
replace country_name = "Bahamas, The" if country_name == "Bahamas"
replace country_name = "Bosnia and Herzegovina" if country_name == "Bosnia"
replace country_name = "Brunei Darussalam" if country_name == "Brunei"
replace country_name = "Cabo Verde" if country_name == "Cape Verde"
replace country_name = "Congo, Democratic Republic of the" if country_name == "Congo, DR"
replace country_name = "Congo, Republic of" if country_name == "Congo, Republic"
replace country_name = "Côte d'Ivoire" if country_name == "Cote d'Ivoire"
replace country_name = "Gambia, The" if country_name == "Gambia"
replace country_name = "Hong Kong SAR" if country_name == "Hong Kong"
replace country_name = "Lao P.D.R." if country_name == "Lao"
replace country_name = "Macedonia, FYR" if country_name == "Macedonia"
replace country_name = "Montenegro, Rep. of" if country_name == "Montenegro"
replace country_name = "St. Kitts and Nevis" if country_name == "Saint Kitts and Nevis"
replace country_name = "St. Lucia" if country_name == "Saint Lucia"
replace country_name = "St. Vincent and the Grenadines" if country_name == "Saint Vincent and the Grenadines"
replace country_name = "São Tomé and Príncipe" if country_name == "Sao Tome and Principe"

save "${path}/Comparators/Stata Files/exchange_rate.dta", replace


*****************************************************************************************************************
* Clean IMF credit and quota data (FIN Query database)
*****************************************************************************************************************
clear
import excel using "${path}/IMF_position.xlsx", firstrow
rename Member country_name
rename GRACreditOutstanding gra_credit
rename PRGTCreditOutstanding prgt_credit
rename Quota quota

keep country_name year gra_credit prgt_credit quota

// For consistency with WEO
replace country_name="Afghanistan" if country_name=="Afghanistan, Islamic Republic of"
replace country_name="Armenia" if country_name=="Armenia, Republic of"
replace country_name="Bahrain" if country_name=="Bahrain, Kingdom of"
replace country_name="Belarus" if country_name=="Belarus, Republic of"
replace country_name="Congo, Democratic Republic of the" if country_name=="Congo, Democratic Republic of"
replace country_name="Côte d'Ivoire" if country_name=="Cote d'Ivoire"
replace country_name="Croatia" if country_name=="Croatia, Republic of"
replace country_name="Estonia" if country_name=="Estonia, Republic of"
replace country_name="Iran" if country_name=="Iran, Islamic Republic of"
replace country_name="Kazakhstan" if country_name=="Kazakhstan, Republic of"
replace country_name="Lao P.D.R." if country_name=="Lao People's Democratic Republic"
replace country_name="Latvia" if country_name=="Latvia, Republic of"
replace country_name="Lithuania" if country_name=="Lithuania, Republic of"
replace country_name="Macedonia, FYR" if country_name=="Macedonia, former Yugoslav Republic of"
replace country_name="Micronesia" if country_name=="Micronesia, Federated States of"
replace country_name="Moldova" if country_name=="Moldova, Republic of"
replace country_name="Montenegro, Rep. of" if country_name=="Montenegro, Republic of"
replace country_name="Poland" if country_name=="Poland, Republic of"
replace country_name="Russia" if country_name=="Russian Federation"
replace country_name="San Marino" if country_name=="San Marino, Republic of"
replace country_name="São Tomé and Príncipe" if country_name=="Sao Tome & Principe"
replace country_name="Serbia" if country_name=="Serbia, Republic of"
replace country_name="Slovenia" if country_name=="Slovenia, Republic of"
replace country_name="Syria" if country_name=="Syrian Arab Republic"
replace country_name="Tajikistan" if country_name=="Tajikistan, Republic of"
replace country_name="Timor-Leste" if country_name=="Timor-Leste, The Democratic Republic of"
replace country_name="Turkmenistan" if country_name=="Turkmenistan, Republic of"
replace country_name="Uzbekistan" if country_name=="Uzbekistan, Republic of"
replace country_name="Yemen" if country_name=="Yemen, Republic of"


save "${path}/Comparators/Stata Files/IMFPosition.dta", replace

*****************************************************************************************************************
* Debt variables
*****************************************************************************************************************

import excel using "${path}/Debt_Variables.xlsx", sheet("Dummies") firstrow clear
keep country_name country_code country_iso_3_code year Wave1or2 HIPCdecision HIPCcompletion LICDSA MACDSA

replace LICDSA = "" if LICDSA == "N.A." | LICDSA == "No rating"
encode LICDSA, gen(licdsa)
encode MACDSA, gen(macdsa)

label define licdsa 1 "Low" 2 "Moderate" 3 "High" 4 "In debt distress", replace
label define macdsa 1 "Lower" 2 "Higher", replace

drop LICDSA MACDSA
save "${path}/Comparators/Stata Files/debt_indicators.dta", replace


*****************************************************************************************************************
* Clean the WEO database
*****************************************************************************************************************

* Clean all WEO vintage versions
set excelxlsxlargefile on

local sheets "May2001 Apr2002 Apr2003 Apr2004 Apr2005 Apr2006 Apr2007 Apr2008 Apr2009 Apr2010 Apr2011 Apr2012 Apr2013 Apr2014 Apr2015 Apr2016 Apr2017 Oct2001 Sep2002 Oct2003 Sep2004 Sep2005 Sep2006 Sep2006 Oct2007 Oct2008 Oct2009 Oct2010 Sep2011 Oct2012 Oct2013 Oct2014 Oct2015 Oct2016 Oct2017 Live"

foreach s of local sheets {
import excel using "${path}/WEO_data.xlsx", sheet("`s'") firstrow clear

drop indcode ifscode CountryISO3code EcDatabase Series_code Indicator Frequency Scale Display_scale

foreach var of varlist* {
        local label : variable label `var'
        local new_name = lower(strtoname("`label'"))
        rename `var' `new_name'
}

rename iso country_iso_3_code 

rename (_*) (value*)

destring country_code value*, replace force

drop if country_code==.

reshape long value, i(country_name country_code country_iso_3_code indicator_code indicator_name indicator_unit) j(year)


* Transformation of WEO data format
tab indicator_code, gen(ind_du)

foreach var of varlist ind_du* {
		replace `var' =. if `var' == 0
		replace `var' = value if `var' == 1
}

foreach var of varlist ind_du* {
        local label : variable label `var'
		local new_label = substr("`label'", strpos("`label'", "==") + 2, .)
        local new_name = lower(substr("`label'", strpos("`label'", "==") + 2, .))
        rename `var' `new_name' 
		label var `new_name' `new_label'
}


//Preserve the labels after collapse
foreach v of var * {
	 local l`v' : variable label `v'
	 if `"`l`v''"' == "" {
		local l`v' "`v'"
	 }
}

// create a list of variables before the collapse command
local except "country_name country_code country_iso_3_code year indicator_code indicator_name indicator_unit value" 
ds
local varlist `r(varlist)' 
local newlist: list varlist - except
di "`newlist'"

collapse (firstnm) "`newlist'", by(country_name country_code country_iso_3_code year)

foreach v of var * {
	label var `v' "`l`v''"
}

gen weo_id = "`s'"

save "${path}/Comparators/Temp/weo_data_`s'.dta", replace

}


use "${path}/Comparators/Temp/weo_data_Live.dta", clear

local sheets "May2001 Apr2002 Apr2003 Apr2004 Apr2005 Apr2006 Apr2007 Apr2008 Apr2009 Apr2010 Apr2011 Apr2012 Apr2013 Apr2014 Apr2015 Apr2016 Apr2017 Oct2001 Sep2002 Oct2003 Sep2004 Sep2005 Sep2006 Sep2006 Oct2007 Oct2008 Oct2009 Oct2010 Sep2011 Oct2012 Oct2013 Oct2014 Oct2015 Oct2016 Oct2017"
foreach s of local sheets {
append using "${path}/Comparators/Temp/weo_data_`s'.dta"
}
order weo_id
duplicates drop weo_id country_code year ngdp ngdpd ngdp_r pcpi bca bfd bfra ggb, force //need to check why there are duplicates

replace country_name="Cabo Verde" if country_name=="Cape Verde"
replace country_name="Congo, Democratic Republic of the" if country_name=="Congo, Democratic Republic of"
replace country_name="Iran" if country_name=="Iran, Islamic Republic of"
replace country_name="Lao P.D.R." if country_name=="Lao People's Democratic Republic"
replace country_name="Macedonia, FYR" if country_name=="Macedonia, Former Yugoslav Republic of"
replace country_name="Micronesia" if country_name=="Micronesia, Fed. States of"
replace country_name="Syria" if country_name=="Syrian Arab Republic"
replace country_name="Timor-Leste" if country_name=="Timor-Leste, Dem. Rep. of"
replace country_name="Yemen" if country_name=="Yemen, Republic of"


save "${path}/Comparators/Stata Files/weo_vintages.dta", replace


******************************************************
* Combine WEO with other data (program info, WDI etc.)
******************************************************

use "${path}/Comparators/Stata Files/weo_data_Live.dta", clear

merge 1:1 country_code year using "${path}/Comparators/Stata Files/PRGTDummy.dta"
replace PRGT = 0 if PRGT==. & year>=1986 & year<=2017
drop _m iso3 region

merge 1:1 country_name year using "${path}/Comparators/Stata Files/IMFPosition.dta"
drop if _m==2
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/gra_programs_init_roc2018.dta"
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/prgt_programs_init_roc2018.dta", update // need to update arrangement_type for PRGT programs
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/gra_programs_periods_roc2018.dta", update
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/prgt_programs_periods_roc2018.dta", update // need to update arrangement_type for PRGT programs
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/gra_programs_init_roc2011.dta"
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/prgt_programs_init_roc2011.dta", update // need to update arrangement_type for PRGT programs
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/gra_programs_periods_roc2011.dta", update
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/prgt_programs_periods_roc2011.dta", update // need to update arrangement_type for PRGT programs
drop _m

merge m:1 country_code using "${path}/Comparators/Stata Files/country_groups.dta"
drop _m

merge 1:1 country_code year using "${path}/Comparators/Stata Files/fragile_states.dta"
drop if _m==2
drop _m
replace fragile = 0 if fragile==. & year>=2011

// Exchange rate regime
merge 1:1 country_name year using "${path}/Comparators/Stata Files/exchange_rate.dta"
drop if _m==2
drop _m

// Trade openness
merge 1:1 country_iso_3_code year using "${path}/Comparators/Stata Files/trade_openness.dta"
drop if _m==2
drop _m

// International Investment Position
merge 1:1 country_name year using "${path}/Comparators/Stata Files/iip.dta"
drop if _m==2
drop _m

//World Governance Indicators
merge 1:1 country_name year using "${path}/Comparators/Stata Files/WGI.dta"
drop if _m==2
drop _m

//Debt Related Indicators
merge 1:1 country_code year using "${path}/Comparators/Stata Files/debt_indicators.dta"
drop if _m==2
drop _m

/*
merge 1:1 country_code year using "${path}/Comparators/Stata Files/sb_approval.dta"
drop if _m==2
drop _m
*/


/*
// Create program dummy (1 if a country had a program for a certain year)
gen prg_length = actual_expiry - year
label var prg_length "Program Length"

* Program initiation years
gen eff_init = arrangement_type=="EFF" | arrangement_type=="ECF-EFF" | arrangement_type=="PRGF-EFF"
gen sba_init = arrangement_type=="SBA" | arrangement_type=="SBA-ESF" | arrangement_type=="SBA-SCF"
gen pll_init = arrangement_type=="PLL"
gen ecf_init = arrangement_type=="ECF-EFF" | arrangement_type=="ECF" | arrangement_type=="PRGF" | arrangement_type=="PRGF-EFF"
gen esf_init = arrangement_type=="SBA-ESF"
gen scf_init = arrangement_type=="SBA-SCF" | arrangement_type=="SCF"
gen psi_init = arrangement_type=="PSI"
gen pci_init = arrangement_type=="PCI"
gen blend_init = strpos(arrangement_type, "-") > 0

* Program periods
sort country_code year
local prg "eff sba pll ecf esf scf psi pci blend"
foreach p of local prg {
gen `p'=0
replace `p' = 1 if `p'_init == 1
forvalues i = 1(1)10 {
replace `p' =`p'_init[_n-`i'] if (`p'_init[_n-`i']==1) & `i'<=prg_length[_n-`i']
}
}
*/


****************************************************
*Interpolation (at most two consecutive missing obs)
****************************************************

*ipolate
ssc install tsspell // install tsspell if necessary
tsset country_code year

mdesc bca_gdp_bp6-quota exchange_rate-ControlofCorruption

foreach x of varlist bca_gdp_bp6-quota exchange_rate-ControlofCorruption {
by country_code: ipolate `x' year, gen(ipolate_`x') 
tsspell, cond(missing(`x'))	
egen length_`x' = max(_seq), by(country_code _spell)
replace ipolate_`x' = . if length_`x' > 2
replace `x' = ipolate_`x' if `x'==. & ipolate_`x'!=.
drop _seq _spell _end length_`x' ipolate_`x'
}


save "${path}/Comparators/Stata Files/master_data_comparator.dta", replace


**********************************************************************************
* Data cleaning for regressions
**********************************************************************************
