set more off

cd "\\DATA1\SPR\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\"

/*
***NGDP
use intal_carla_ngdp.dta, clear

drop country action
drop if ctyname=="."
destring ngdp_*, force replace
reshape long ngdp_, i(review_id) j(year)

merge 1:1 review_id year using database.dta
capture drop _merge
save ci_temp.dta, replace
*/

***FMB
use intal_carla_fmb.dta

drop country action
drop if ctyname=="."
destring fmb_*, force replace
reshape long fmb_, i(review_id) j(year)

merge 1:1 review_id year using ci_temp.dta

save ci_database2.dta





