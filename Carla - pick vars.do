/* This file will take the following variables:
 
•	Growth forecast error (plotting actual and projected growth) - ngdp_rpch
•	Fiscal adjustment (realized versus planned)—you can get this from the QPC table to see if targets were revised (MONA has this too) - ggb_gdp
•	Current account adjustment (realized versus planned) - bca_gdp
•	International reserves path (realized versus planned) - bfra_gdp
•	Public debt and composition domestic and external public debt (realized versus planned) -none

Note that 5 is t; 4 is t-1; 3 is t-2 etc..

For Ukraine (2014 SBA, #711) and Mozambique (2015 SCF, #733) over the period t-2, t-1, t, t+1, t+2, t+3, t+4, t+5 
*/
 
set more off
  
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Evenhandedness\Regressions\Stata Files\"
use "data_eh_reg.dta"

//first, select the countries
keep if inlist(arrangement_number, 711,733)  

keep review_id weo_id arrangement_number type arrangement_type country_name country_code country_iso_3_code region year orig_expiry actual_expiry bca_gdp3 bca_gdp4 bca_gdp5 bca_gdp6 bca_gdp7 bca_gdp8 bca_gdp9 bca_gdp10 bfra_gdp3 bfra_gdp4 bfra_gdp5 bfra_gdp6 bfra_gdp7 bfra_gdp8 bfra_gdp9 bfra_gdp10 ggb_gdp3 ggb_gdp4 ggb_gdp5 ggb_gdp6 ggb_gdp7 ggb_gdp8 ggb_gdp9 ggb_gdp10 ngdp_rpch3 ngdp_rpch4 ngdp_rpch5 ngdp_rpch6 ngdp_rpch7 ngdp_rpch8 ngdp_rpch9 ngdp_rpch10



 
 