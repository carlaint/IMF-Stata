set more off
clear

cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Evenhandedness\Python Text Search\download_documents\Documents\reports_excel\"
import excel "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Evenhandedness\Python Text Search\download_documents\Documents\reports_excel\Combined Results.xlsx", sheet("Data") firstrow case(lower)

encode term, gen(term2)

preserve

//full set
collapse (count) term2, by (code prog year2 terms tag)
gen granularity="full"
save full.dta, replace
restore

//one by one

foreach var of varlist code prog year2 region countrygroup confidential fragile small exportearnings act{
	preserve
	collapse(count) term2, by(`var' terms tag)
	gen granularity="`var'"
	save temp.dta, replace
	append using full temp
	save full.dta, replace
	restore
	}

//dual granularity	
foreach var of varlist code prog year2 region countrygroup confidential fragile small exportearnings act{

	foreach x in prog year2 region countrygroup confidential fragile small exportearnings act{
	preserve
	collapse(count) term2, by(`var' `x' terms tag)
	gen granularity="`var'_`x'"
	save temp.dta, replace
	append using full temp
	save full.dta, replace
	restore
	}
	}
