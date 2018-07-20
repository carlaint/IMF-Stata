clear all

cd "//DATA1/SPR/DATA/SPRLP/EM/Review of Conditionality/Data/"

*****************************************************************************************************************
* Program completeness database
*****************************************************************************************************************

import excel using "Review completion heat map.xlsx", sheet("Table 1") clear
keep A-H

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[7]'"
  rename `var' `=lower(strtoname(`var'[7]))'
}

drop in 1/7
drop if completion_score=="X"

destring, replace
sort country year 
duplicates drop country year, force

gen pre_year = .
gen pre_completion = .

local N = _N
forvalues i = 1(1)`N' {
	if country[`i'] == country[`i'-1]  {
	replace pre_year=year[`i'-1] in `i'
	replace pre_completion = completion_score[`i'-1] in `i'
	}

	else

}

keep country year pre_year pre_completion
keep if pre_completion!=.
rename country country_name

replace country_name="Côte d'Ivoire" if country_name=="Cote d'Ivoire"
replace country_name="Kosovo" if country_name=="Kosovo, Republic of"
replace country_name="São Tomé and Príncipe" if country_name=="Sao Tome and Principe"


save "Section-Evenhandedness/Regressions/Stata Files/track_record.dta", replace

*****************************************************************************************************************
* Program database
*****************************************************************************************************************
// program initiaiton info for 2002-2017
local fac "gra prgt"
foreach f of local fac {
use "Comparators/Stata Files/`f'_programs_init_roc2011.dta", clear
append using "Comparators/Stata Files/`f'_programs_init_roc2018.dta"
duplicates drop country_code year arrangement_number, force
replace precautionary = 0 if precautionary == .
replace exceptional_access = 0 if exceptional_access == .

* Match approval date with the nearest WEO vintage after the approval date.
gen weo_id = ""
*replace weo_id = "Apr2000" if (app_month>=10 & year==1999) | (app_month<=3 & year==2000)
*replace weo_id = "Oct2000" if (app_month>=4  &  app_month<=9) & year==2000
replace weo_id = "May2001" if (app_month>=10 & year==2000) | (app_month<=4 & year==2001)
replace weo_id = "Oct2001" if (app_month>=5 & app_month<=9) & year==2001
replace weo_id = "Apr2002" if (app_month>=10 & year==2001) | (app_month<=3 & year==2002)
replace weo_id = "Sep2002" if (app_month>=4  &  app_month<=8) & year==2002
replace weo_id = "Apr2003" if (app_month>=9 & year==2002) | (app_month<=3 & year==2003)
replace weo_id = "Oct2003" if (app_month>=4  &  app_month<=9) & year==2003
replace weo_id = "Apr2004" if (app_month>=10 & year==2003) | (app_month<=3 & year==2004)
replace weo_id = "Sep2004" if (app_month>=4  &  app_month<=8) & year==2004
replace weo_id = "Apr2005" if (app_month>=9 & year==2004) | (app_month<=3 & year==2005)
replace weo_id = "Sep2005" if (app_month>=4  &  app_month<=8) & year==2005
replace weo_id = "Apr2006" if (app_month>=9 & year==2005) | (app_month<=3 & year==2006)
replace weo_id = "Sep2006" if (app_month>=4  &  app_month<=8) & year==2006
replace weo_id = "Apr2007" if (app_month>=9 & year==2006) | (app_month<=3 & year==2007)
replace weo_id = "Oct2007" if (app_month>=4  &  app_month<=9) & year==2007
replace weo_id = "Apr2008" if (app_month>=10 & year==2007) | (app_month<=3 & year==2008)
replace weo_id = "Oct2008" if (app_month>=4  &  app_month<=9) & year==2008
replace weo_id = "Apr2009" if (app_month>=10 & year==2008) | (app_month<=3 & year==2009)
replace weo_id = "Oct2009" if (app_month>=4  &  app_month<=9) & year==2009
replace weo_id = "Apr2010" if (app_month>=10 & year==2009) | (app_month<=3 & year==2010)
replace weo_id = "Oct2010" if (app_month>=4  &  app_month<=9) & year==2010
replace weo_id = "Apr2011" if (app_month>=10 & year==2010) | (app_month<=3 & year==2011)
replace weo_id = "Sep2011" if (app_month>=4  &  app_month<=8) & year==2011
replace weo_id = "Apr2012" if (app_month>=9 & year==2011) | (app_month<=3 & year==2012)
replace weo_id = "Oct2012" if (app_month>=4  &  app_month<=9) & year==2012
replace weo_id = "Apr2013" if (app_month>=10 & year==2012) | (app_month<=3 & year==2013)
replace weo_id = "Oct2013" if (app_month>=4  &  app_month<=9) & year==2013
replace weo_id = "Apr2014" if (app_month>=10 & year==2013) | (app_month<=3 & year==2014)
replace weo_id = "Oct2014" if (app_month>=4  &  app_month<=9) & year==2014
replace weo_id = "Apr2015" if (app_month>=10 & year==2014) | (app_month<=3 & year==2015)
replace weo_id = "Oct2015" if (app_month>=4  &  app_month<=9) & year==2015
replace weo_id = "Apr2016" if (app_month>=10 & year==2015) | (app_month<=3 & year==2016)
replace weo_id = "Oct2016" if (app_month>=4  &  app_month<=9) & year==2016
replace weo_id = "Apr2017" if (app_month>=10 & year==2016) | (app_month<=3 & year==2017)
replace weo_id = "Oct2017" if (app_month>=4  &  app_month<=9) & year==2017

gen type = upper("`f'")
save "Section-Evenhandedness/Regressions/Stata Files/`f'_programs_init_2002_2017.dta", replace
}



/*
*****************************************************************************************************************
* Clean the WEO database using WEO Stata files from RES
*****************************************************************************************************************
local month "Apr May Sep Oct"
foreach m of local month {
forvalues y = 2000(1)2009 {
capture {
use "//data1/weo/WEO_Stata_Databases/WEO`m'`y'Pub.dta", clear
keep country ifscode year d ngdpdpc ngdp_r pcpie bca bfra gb_pr ggei ngap ngdpd ngdp
tsset ifscode year
gen d_gdp = d/(ngdpd)*100
*gen ggxofb_gdp = ggxofb/(ngdp_fy)*100
*gen ggxwdg_gdp = ggxwdg/(ngdp_fy)*100
gen ngdp_rpch = (ngdp_r/l.ngdp_r-1)*100
gen pcpie_pch = (pcpie/l.pcpie-1)*100
gen bca_gdp = bca/(ngdpd)*100
gen bfra_gdp = bfra/(ngdpd)*100
drop d ngdp_r pcpie bca bfra
keep if year>=1995 & year<=2023
reshape wide d_gdp ngdpdpc ngdp_rpch pcpie_pch bca_gdp bfra_gdp gb_pr ggei ngap ngdpd ngdp, i(country ifscode) j(year)
gen weo_id = "`m'`y'"
order weo_id

save "Section-Evenhandedness/Regressions/Temp/weo_`m'`y'.dta", replace
}
}
}

local month "Apr May Sep Oct"
foreach m of local month {
forvalues y = 2010(1)2017 {
capture {
use "//data1/weo/WEO_Stata_Databases/WEO`m'`y'Pub.dta", clear
keep country ifscode year d ggxofb ggxwdg ngdpdpc ngdp_r pcpie bca_gdp bfra_gdp gb_pr ggei ngap ngdpd ngdp ngdp_fy
tsset ifscode year
gen d_gdp = d/(ngdpd)*100
gen ggxofb_gdp = ggxofb/(ngdp_fy)*100
gen ggxwdg_gdp = ggxwdg/(ngdp_fy)*100
gen ngdp_rpch = (ngdp_r/l.ngdp_r-1)*100
gen pcpie_pch = (pcpie/l.pcpie-1)*100
drop d ggxofb ggxwdg ngdp_r pcpie ngdp_fy
keep if year>=1995 & year<=2023
reshape wide d_gdp ggxofb_gdp ggxwdg_gdp ngdpdpc ngdp_rpch pcpie_pch bca_gdp bfra_gdp gb_pr ggei ngap ngdpd ngdp ngdp_fy, i(country ifscode) j(year)
gen weo_id = "`m'`y'"
order weo_id

save "Section-Evenhandedness/Regressions/Temp/weo_`m'`y'.dta", replace
}
}
}


clear

local month "Apr May Sep Oct"
foreach m of local month {
forvalues y = 2000(1)2017 {
capture append using "Section-Evenhandedness/Regressions/Temp/weo_`m'`y'.dta"
}
}

rename country country_name
rename ifscode country_code
replace country_name = "Côte d'Ivoire" if country_code==662
replace country_name = "Macedonia, FYR" if country_name=="Macedonia, Former Yugoslav Republic of"
replace country_name = "São Tomé and Príncipe" if country_name=="S�o Tom� and Pr�ncipe"
replace country_name = "Yemen" if country_name=="Yemen, Former P. D. Rep. of"
replace country_name = "Yemen" if country_name=="Yemen, Republic of"

compress
save "Section-Evenhandedness/Regressions/Stata Files/weo_vintages.dta", replace

*/



*****************************************************************************************************************
* Organize the WEO database
*****************************************************************************************************************

use "Comparators/Stata Files/weo_vintages.dta", clear

egen review_id = group(weo_id country_code)
order review_id

tsset review_id year
// generate the varable needed for regressions
replace bca = bca_bp6 if bca==. & bca_bp6!=.
replace bfd = bfd_bp6 if bfd==. & bfd_bp6!=.
replace bfra = bfra_bp6 if bfra==. & bfra_bp6!=.
replace bfp = bfp_bp6 if bfp==. & bfp_bp6!=.
replace ggb = ggxcnl if ggb==. & ggxcnl!=.

gen d_gdp = d/1000000000/ngdpd*100
gen bca_gdp = bca/1000000000/ngdpd*100
gen bfra_gdp = bfra/1000000000/ngdpd*100
gen bfp_gdp = bfp/ngdpd*100
gen ggb_gdp = ggb/1000000000/ngdp*100
gen ngdp_rpch = (ngdp_r/l.ngdp_r-1)*100
gen pcpi_pch = (pcpi/l.pcpi-1)*100

gen amt_gdp = dsp/ngdpd*100 // already in billion of USD
gen gfn_gdp = (bfra-l.bfra)/1000000000/ngdpd*100 + amt_gdp - bca_gdp // Gross financing need = change in reserves + debt amortization and arrears clearance + current account excl grants (deficit +)

keep review_id weo_id country_name country_code country_iso_3_code year ngdp ngdpd ngdpdpc d_gdp bca_gdp bfra_gdp bfp_gdp ggb_gdp ngdp_rpch pcpi_pch gfn_gdp amt_gdp
keep if year>=1995 & year<=2023
reshape wide ngdp ngdpd ngdpdpc d_gdp bca_gdp bfra_gdp bfp_gdp ggb_gdp ngdp_rpch pcpi_pch gfn_gdp amt_gdp, i(review_id) j(year)
order review_id weo_id country_name country_code country_iso_3_code

compress
save "Section-Evenhandedness/Regressions/Stata Files/weo_vintages.dta", replace


*****************************************************************************************************************
* FIN Query (Access)
*****************************************************************************************************************

import excel using "FIN_Query_Database.xlsx", sheet("FIN_Query_Database") clear

keep A-G

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[10]'"
  rename `var' `=lower(strtoname(`var'[10]))'
}

drop in 1/10

rename member country_name
rename __of_quota pc_quota

gen arrangement_type = ""
replace arrangement_type = "ESF" if facility == "Exogenous Shocks Facility"
replace arrangement_type = "ECF" if facility == "Extended Credit Facility"
replace arrangement_type = "EFF" if facility == "Extended Fund Facility"
replace arrangement_type = "FCL" if facility == "Flexible Credit Line"
replace arrangement_type = "PLL" if facility == "Precautionary and Liquidity Line"
replace arrangement_type = "SBA" if facility == "Stand-By Arrangement"
replace arrangement_type = "SCF" if facility == "Standby Credit Facility"
replace arrangement_type = "SAF" if facility == "Structural Adjustment Facility"

gen year = ""
replace year = substr(date_of_arrangement,length(date_of_arrangement)-1,2)
destring, replace
replace year = cond(year<=50, 2000+year, 1900+year)

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

sort country_name year type expiration_date
duplicates drop country_name year type, force
compress
save "Section-Evenhandedness/Regressions/Stata Files/access.dta", replace


*****************************************************************************************************************
* SDR Valuation
*****************************************************************************************************************\
import excel using "Exchange_Rate_Report", sheet("EXCHANGE_RATE_REPORT") clear
keep A F
drop in 1/3
drop if F==""
gen year = substr(A, length(A)-3,length(A))
drop A
destring F year, replace
collapse F, by(year)
rename F usdsdr
save "Section-Evenhandedness/Regressions/Stata Files/usdsdr.dta", replace

*****************************************************************************************************************
* External Wealth of Nations Dataset 19702011
*****************************************************************************************************************

import excel using "External Wealth of Nations Dataset 19702011.xlsx", sheet("1970-2011") clear
keep A-C M-N

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1

rename ifs_id country_code
destring, replace
compress

save "Section-Evenhandedness/Regressions/Stata Files/foreign_position.dta", replace


*****************************************************************************************************************
* Find data unavailable in WEO
*****************************************************************************************************************

import excel using "Section-Evenhandedness/Regressions/Data/debt_indicators.xlsx", clear


// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1

destring, replace
replace dsp = dsp*enda if currency=="EUR" // Data in the Staff Reports are in euros. Convert to dollar.
drop currency unit enda
reshape wide d_gdp dsp, i(country_name year arrangement_type) j(period)

save "Section-Evenhandedness/Regressions/Stata Files/debt_sr.dta", replace



import excel using "Section-Evenhandedness/Regressions/Data/ggb.xlsx", clear


// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  rename `var' `=lower(strtoname(`var'[1]))'
}

drop in 1

destring, replace
reshape wide ggb_gdp, i(country_name year arrangement_type) j(period)

save "Section-Evenhandedness/Regressions/Stata Files/ggb_sr.dta", replace




*****************************************************************************************************************
* Successor Program (two years within the expiry of the previous program)
*****************************************************************************************************************

import excel using "Section-Evenhandedness/Regressions/Data/successor_program.xlsx", sheet("Sheet1") clear
keep B C E L

// Use first row as variable name and label
foreach var of varlist * {
  label variable `var' "`=`var'[3]'"
  rename `var' `=lower(strtoname(`var'[3]))'
}

drop in 1/3
destring, replace

rename country country_name
rename ifs_code country_code
gsort country_code year -successor
duplicates drop country_code year, force

save "Section-Evenhandedness/Regressions/Stata Files/successor_program.dta", replace



*****************************************************************************************************************
* Master database for Evenhandedness
*****************************************************************************************************************

// Merge program info with WEO vintages
local facility "gra prgt"

foreach f of local facility {
use "Section-Evenhandedness/Regressions/Stata Files/`f'_programs_init_2002_2017.dta", clear

merge 1:1 country_code weo_id using "Section-Evenhandedness/Regressions/Stata Files/weo_vintages.dta", update replace
keep if _m>2
drop _m
rename year approval_year

reshape long ngdp ngdpd ngdpdpc d_gdp bca_gdp bfra_gdp bfp_gdp ggb_gdp ngdp_rpch pcpi_pch amt_gdp gfn_gdp, i(arrangement_number) j(year) // for merging with other variables

// IMF credit outstanding
merge m:1 country_name year using "Comparators/Stata Files/IMFPosition.dta"
drop if _m==2
drop _m

// Country characteristics
merge m:1 country_code using "Comparators/Stata Files/country_groups.dta"
drop if _m==2
drop _m

// Fragile states
merge m:1 country_code year using "Comparators/Stata Files/fragile_states.dta"
drop if _m==2
drop _m
replace fragile = 0 if fragile==. & year>=2011

// Exchange rate regime
merge m:1 country_name year using "Comparators/Stata Files/exchange_rate.dta"
drop if _m==2
drop _m

// Trade openness
merge m:1 country_iso_3_code year using "Comparators/Stata Files/trade_openness.dta"
drop if _m==2
drop _m

// International Investment Position
merge m:1 country_name year using "Comparators/Stata Files/iip.dta"
drop if _m==2
drop _m

merge m:1 country_name year using "Comparators/Stata Files/iip_asset.dta"
drop if _m==2
drop _m

merge m:1 country_name year using "Comparators/Stata Files/iip_liability.dta"
drop if _m==2
drop _m

//World Governance Indicators
merge m:1 country_name year using "Comparators/Stata Files/WGI.dta"
drop if _m==2
drop _m

//Debt Related Indicators
merge m:1 country_code year using "Comparators/Stata Files/debt_indicators.dta"
drop if _m==2
drop _m

//Foreign assets and liabilities
merge m:1 country_code year using "Section-Evenhandedness/Regressions/Stata Files/foreign_position.dta"
drop if _m==2
drop _m


// USD SDR Exchange rate
merge m:1 year using "Section-Evenhandedness/Regressions/Stata Files/usdsdr.dta"
drop if _m==2
drop _m

*Interpolation (at most two consecutive missing obs)
*ssc install tsspell // install tsspell if necessary
tsset arrangement_number year
order country_iso_3_code country_code region

foreach x of varlist ngdpd-macdsa {
by arrangement_number: ipolate `x' year, gen(ipolate_`x') 
tsspell, cond(missing(`x'))	
egen length_`x' = max(_seq), by(arrangement_number _spell)
replace ipolate_`x' = . if length_`x' > 2
replace `x' = ipolate_`x' if `x'==. & ipolate_`x'!=.
drop _seq _spell _end length_`x' ipolate_`x'
}

* Replace missing values in total assets and liabilities by corresponding IIP assets and liabilities.

replace total_assets = iip_asset if total_assets==.
replace total_liabilities = iip_liability if total_liabilities==.

reshape wide ngdp ngdpd ngdpdpc d_gdp bca_gdp bfra_gdp bfp_gdp ggb_gdp ngdp_rpch pcpi_pch amt_gdp gfn_gdp gra_credit prgt_credit quota usdsdr fuel_exporter fragile exchange_rate trade_openness iip iip_asset iip_liability total_assets total_liabilities VoiceandAccountability PoliticalStability GovernmentEffectiveness RegulatoryQuality RuleofLaw ControlofCorruption Wave1or2 HIPCdecision HIPCcompletion licdsa macdsa, i(arrangement_number) j(year)

// Merge with access
rename approval_year year
merge 1:1 country_name year type using "Section-Evenhandedness/Regressions/Stata Files/access.dta"
drop if _m==2
drop _m

save "Section-Evenhandedness/Regressions/Temp/master_data_eh_`f'.dta", replace
}


use "Section-Evenhandedness/Regressions/Temp/master_data_eh_gra.dta"
append using "Section-Evenhandedness/Regressions/Temp/master_data_eh_prgt.dta"
merge 1:1 country_name year using "Section-Evenhandedness/Regressions/Stata Files/track_record.dta"
drop if _m==2
drop _m

gen pre_com = pre_completion!=. & pre_completion>=0.8
gen pre_inc = pre_completion!=. & pre_completion<0.8

order review_id weo_id arrangement_number type arrangement_type country_name country_code country_iso_3_code region
compress
save "Section-Evenhandedness/Regressions/Stata Files/master_data_eh.dta", replace




