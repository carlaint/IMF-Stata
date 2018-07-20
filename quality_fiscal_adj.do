clear all

cd "\\data1\SPR\DATA\SPRLP\EM\Review of Conditionality\Data\"

*****************************************************************************************************************
* Capital Expenditure Adjustment
*****************************************************************************************************************
import excel using "Section-Quality\Fiscal Adjustment\fiscal\gg exp - capital spending.xlsx", sheet("projection error GRA") clear
keep A-H AD-AL
// Use 15th and 14th rows as variable name
foreach var of varlist A-H {
  rename `var' `=lower(strtoname(`var'[1]+`var'[2]))'
}

rename AD k_error0
rename AE k_error1
rename AF k_error2
rename AG k_error3
rename AH k_error4
rename AI k_error5
rename AJ k_error6
rename AK k_error7
rename AL k_error8

drop in 1/2
drop if arrangement_number==""
destring, replace

reshape long k_error, i(arrangement_number country country_code arrangement_type date_of_arrangement actual_current_expiration_date program_year end_year) j(period)

gen year = program_year + period - 3

save "Section-Growth\ForecastOptimism\Regressions\Stata Files\k_error_gra.dta", replace


import excel using "Section-Quality\Fiscal Adjustment\fiscal\gg exp - capital spending.xlsx", sheet("projection error PRGT") clear
keep A-H AD-AL
// Use 15th and 14th rows as variable name
foreach var of varlist A-H {
  rename `var' `=lower(strtoname(`var'[1]+`var'[2]))'
}

rename AD k_error0
rename AE k_error1
rename AF k_error2
rename AG k_error3
rename AH k_error4
rename AI k_error5
rename AJ k_error6
rename AK k_error7
rename AL k_error8

drop in 1/2
drop if arrangement_number==""
destring, replace

reshape long k_error, i(arrangement_number country country_code arrangement_type date_of_arrangement actual_current_expiration_date program_year end_year) j(period)

gen year = program_year + period - 3

save "Section-Growth\ForecastOptimism\Regressions\Stata Files\k_error_prgt.dta", replace




*****************************************************************************************************************
* Total Expenditure Adjustment
*****************************************************************************************************************
import excel using "Section-Quality\Fiscal Adjustment\fiscal\gg exp.xlsx", sheet("projection error GRA") clear
keep A-H AD-AL
// Use 15th and 14th rows as variable name
foreach var of varlist A-H {
  rename `var' `=lower(strtoname(`var'[1]+`var'[2]))'
}

rename AD tt_error0
rename AE tt_error1
rename AF tt_error2
rename AG tt_error3
rename AH tt_error4
rename AI tt_error5
rename AJ tt_error6
rename AK tt_error7
rename AL tt_error8

drop in 1/2
drop if arrangement_number==""
destring, replace

reshape long tt_error, i(arrangement_number country country_code arrangement_type date_of_arrangement actual_current_expiration_date program_year end_year) j(period)

gen year = program_year + period - 3

save "Section-Growth\ForecastOptimism\Regressions\Stata Files\tt_error_gra.dta", replace


import excel using "Section-Quality\Fiscal Adjustment\fiscal\gg exp - capital spending.xlsx", sheet("projection error PRGT") clear
keep A-H AD-AL
// Use 15th and 14th rows as variable name
foreach var of varlist A-H {
  rename `var' `=lower(strtoname(`var'[1]+`var'[2]))'
}

rename AD tt_error0
rename AE tt_error1
rename AF tt_error2
rename AG tt_error3
rename AH tt_error4
rename AI tt_error5
rename AJ tt_error6
rename AK tt_error7
rename AL tt_error8

drop in 1/2
drop if arrangement_number==""
destring, replace

reshape long tt_error, i(arrangement_number country country_code arrangement_type date_of_arrangement actual_current_expiration_date program_year end_year) j(period)

gen year = program_year + period - 3

save "Section-Growth\ForecastOptimism\Regressions\Stata Files\tt_error_prgt.dta", replace

