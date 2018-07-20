cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism"
set more off
clear

foreach x in BM RM BMGDP RMGDP BMGDP_ch RMGDP_ch NDA_est NDAGDP NDAGDP_ch{

clear
import excel "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\Reserve vs Broad Money.xlsx", sheet(`x') firstrow case(lower)
reshape long a, i(ifsc) j(year)
ren a `x'
capture drop if year>2017
winsor `x', gen(`x'_w) p(0.01)
save `x'.dta
}

merge 1:1 ifsc year using bm.dta
capture drop _merge
merge 1:1 ifsc year using rm.dta
capture drop _merge
merge 1:1 ifsc year using bmgdp.dta
capture drop _merge
merge 1:1 ifsc year using rmgdp.dta
capture drop _merge
merge 1:1 ifsc year using bmgdp_ch.dta
capture drop _merge
merge 1:1 ifsc year using NDA_est.dta
capture drop _merge
merge 1:1 ifsc year using NDAGDP.dta
capture drop _merge
merge 1:1 ifsc year using NDAGDP_ch.dta
capture drop _merge

drop ecdatabase series_code country indicatorname indicator frequency display_scale comment a*
save bmrm.dta, replace

log using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\regressions.log", replace

// Regression on level
*simple regression
*reg BM RM
reg BM NDA_est
*winsorized
*reg BM_w RM_w
reg BM_w NDA_est_w


*panel regression
xtset ifsc year
*xtreg BM RM
*xtreg BM RM, fe
xtreg BM NDA_est
xtreg BM NDA_est,fe
*xtreg BM_w RM_w
*xtreg BM_w RM_w, fe
xtreg BM_w NDA_est_w
xtreg BM_w NDA_est_w,fe

// Regression on %GDP (level)
*simple regression
*reg BMGDP RMGDP
*reg BMGDP_w RMGDP_w
reg BMGDP NDAGDP
reg BMGDP_w NDAGDP_w

*panel regression
xtset ifsc year
*xtreg BMGDP RMGDP
*xtreg BMGDP RMGDP, fe
*xtreg BMGDP_w RMGDP_w
*xtreg BMGDP_w RMGDP_w, fe
xtreg BMGDP NDAGDP
xtreg BMGDP NDAGDP, fe
xtreg BMGDP_w NDAGDP_w
xtreg BMGDP_w NDAGDP_w, fe


// Regression on changes (% GDP)
*simple regression
*reg BMGDP_ch RMGDP_ch
*reg BMGDP_ch_w RMGDP_ch_w
reg BMGDP_ch NDAGDP_ch
reg BMGDP_ch_w NDAGDP_ch_w


*panel regression
xtset ifsc year
*xtreg BMGDP_ch RMGDP_ch
*xtreg BMGDP_ch RMGDP_ch, fe
*xtreg BMGDP_ch_w RMGDP_ch_w
*xtreg BMGDP_ch_w RMGDP_ch_w, fe
xtreg BMGDP_ch NDAGDP_ch
xtreg BMGDP_ch NDAGDP_ch, fe
xtreg BMGDP_ch_w NDAGDP_ch_w
xtreg BMGDP_ch_w NDAGDP_ch_w, fe



log close
