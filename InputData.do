clear
set more off
capture log close
capture graph drop all


cd "\\DATA1\SPR\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\Data"

*** change the below variables to 1 to run certain part of the codes
scalar do_MONA = 0
scalar do_WEO = 1
scalar do_actual = 1
scalar do_other = 0
scalar do_merge = 1


**************************************
*** import WEO data
**************************************
if do_WEO {

	clear

	set excelxlsxlargefile on
	
	*** WEO variables since Apr2003 vintages for all countries
	local varlist growth partnergrowth ggdebt fb interest ca ngdp fmb nfi_r ni_r nfig ggx

	foreach var in `varlist' {

		import excel WEO.xlsx, sheet("`var'") cellrange(AX2) firstrow clear

		drop if action==.

		destring *, replace

		reshape long `var'_, i(review_id country action) j(year)

		save `var'_, replace

	}
	
	clear
	
	local varlist2 oil commodity
	
	foreach var in `varlist2' {
		
		import excel  WEO.xlsx, sheet("`var'") cellrange(E2) firstrow clear
		
		destring *, replace
		
		reshape long `var'_, i(WEO) j(year)

		save `var'_, replace
	
	}
	
	*** corresponding WEO for program approvals
	clear
	
	set excelxlsxlargefile on
	
	import excel WEO.xlsx, sheet("weo_program") cellrange(A1) firstrow clear
	
	save weo_program, replace
	
}

**************************************
*** import actual data
**************************************
if do_actual {

	clear
	
	import excel Actual.xlsx, sheet("STACK") firstrow clear

	destring *, replace
	
	save actual.dta, replace


}

if do_other {

	**************************************
	*** import program dates & sb
	**************************************
	clear
		
	import excel MONA.xlsx, sheet("program") firstrow clear

	destring *, replace

	drop review_id

	reshape wide app end, i(country ctyname) j(program)

	save program_dates, replace
	
	import excel MONA.xlsx, sheet("sb") firstrow clear

	destring *, replace

	save sb, replace

	**************************************
	*** import exporters, exceptional access, region, Europe, and exchange rate regime 
	**************************************
	
	*** exporter
	clear
		
	import excel Groups.xlsx, sheet("exporter") cellrange (B1) firstrow clear
	
	keep country oilexporter commexporter

	destring *, replace
	
	save exporter.dta, replace
	
	*** exceptional access
	clear
		
	import excel Groups.xlsx, sheet("EA") cellrange (C1) firstrow clear
	
	keep review_id country appyear exceptional_access

	destring *, replace
	
	save exceptional_access.dta, replace
	
	rename exceptional_access exceptional_access_weo
	
	save exceptional_access_weo.dta, replace
	
	*** region
	clear

	import excel Groups.xlsx, sheet("region") firstrow clear

	destring *, replace

	save region, replace
	
	*** Europe
	clear

	import excel Groups.xlsx, sheet("Europe") cellrange(F1) firstrow clear
	
	keep country Europe

	destring *, replace

	save Europe, replace	

	*** exchange regimes
	clear

	import excel Groups.xlsx, sheet("exregime") firstrow clear

	destring *, replace

	label var fxregime2 "0: fixed, 0-7 from fxregime; 1: floating, 8-10 from fxregime"
	
	*** change EA countries to fixed regime
	local ctylist 122 124 423 939 172 132 134 174 178 136 137 181 138 182 936 961 184 941 946

	foreach var in `ctylist' {

		replace fxregime2=0 if country==`var'

	}

	save exregime, replace

}

if do_merge {

	*** merge surveillance data
	clear
	
	use growth_.dta
	
	local varlist partnergrowth ggdebt fb interest ca ngdp fmb nfi_r ni_r nfig ggx
	
	foreach var in `varlist' {
	
		capture drop _merge
		merge 1:1 review_id year using `var'_.dta, keep(match master) keepusing (`var'_) nogen
	
	}
	
	
	local varlist2 oil commodity
	
	foreach var in `varlist2' {
	
		capture drop _merge
		merge m:1 WEO year using `var'_.dta, keep(match master) keepusing (`var'_) nogen
	
	}
	
	sort country action year
	
	save surveillance.dta, replace
	
	*** merge program and surveillance data
	clear 
	
	use mona.dta
	
	append using surveillance.dta
	
	save database.dta, replace
	
	*** merge actual data
	capture drop _merge
	merge m:1 country year using actual.dta, keep(match master) nogen
	
	*** merge program dates
	capture drop _merge
	merge m:1 country gra using program_dates.dta, keep(match master) keepusing (app* end*) nogen
	
	*** merge program approval IDs to corresponding WEO
	capture drop _merge
	merge m:m review_id using weo_program.dta, keep(match master) keepusing (program_id) nogen
	
	*** merge sb
	capture drop _merge
	merge 1:1 review_id year using sb.dta, keep(match master) keepusing (sb*) nogen
	
	*** merger exporter
	capture drop _merge
	merge m:1 country using exporter.dta, keep(match master) keepusing (oilexporter commexporter) nogen
	
	*** merge exceptional access for programs
	gen appyear = year(approval)

	capture drop _merge
	merge m:m country appyear using exceptional_access.dta, keep(match master) keepusing (exceptional_access) nogen

	*** add exceptional access to WEO vintages
	capture drop _merge
	merge m:m review_id using exceptional_access_weo.dta, keep(match master) keepusing (exceptional_access_weo) nogen

	*** merge exceptional access for MONA GRA programs and WEO vintages
	replace exceptional_access = exceptional_access_weo if exceptional_access=="" & exceptional_access_weo!=""

	drop exceptional_access_weo
	
	*** merge region
	capture drop _merge
	merge m:1 country using region.dta, keep(match master) keepusing (region) nogen
	
	*** merge Europe
	capture drop _merge
	merge m:1 country using Europe.dta, keep(match master) keepusing (Europe) nogen
	
	*** merge fx regimes
	capture drop _merge
	merge m:1 country year using exregime.dta, keep(match master) keepusing (fxregime fxregime2) nogen

	*** change EA countries to fixed regime
	local ctylist 122 124 423 939 172 132 134 174 178 136 137 181 138 182 936 961 184 941 946

	foreach var in `ctylist' {

		replace fxregime2=0 if country==`var'

	}
	
	sort country action year

	
	save "\\DATA1\SPR\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\Regressions\Stata Files\ci_database2.dta", replace
	

}


