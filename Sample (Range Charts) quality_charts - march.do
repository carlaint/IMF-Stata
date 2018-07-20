use "\\Data1\spr\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Quality\Stata Datasets\master.dta" , clear
*save "U:\ROC\master.dta", replace
keep if year>=2000


gen programclass=arragementall
replace programclass=" Countries Non-program" if hadprogram==0
replace programclass=" No Program year" if arragementall=="" & hadprogram==1



keep if GRA==0 | arragementall=="PRGF" | arragementall=="PRGF-EFF"


cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Sections\Qaulity\Charts"

histogram per_allsp_cov_pop_tot, by( hadprogram)


twoway (scatter sh_xpd_publ_gx_zs  mortalityinfant)(lfit sh_xpd_publ_gx_zs  mortalityinfant), by(hadprogram)
graph export "PRGTscatter1.emf", replace

twoway (scatter se_xpd_totl_gb_zs  netenrollprimary)(lfit se_xpd_totl_gb_zs  netenrollprimary), by( hadprogram)
graph export "PRGTscatter2.emf", replace

twoway (scatter se_xpd_totl_gb_zs  netenrollsecondary)(lfit se_xpd_totl_gb_zs  netenrollsecondary), by(hadprogram)
graph export "PRGTscatter3.emf", replace

twoway (scatter per_allsp_cov_pop_tot  si_pov_dday)(lfit per_allsp_cov_pop_tot  si_pov_dday), by( hadprogram)
graph export "PRGTscatter4.emf", replace

twoway (scatter per_sa_allsa_cov_pop_tot si_pov_dday)(lfit per_sa_allsa_cov_pop_tot  si_pov_dday), by( hadprogram)
graph export "PRGTscatter5.emf", replace

foreach var of varlist sh_xpd_publ_zs  sh_xpd_publ_gx_zs  se_xpd_totl_gb_zs se_xpd_totl_gd_zs  per_allsp_cov_pop_tot per_lm_alllm_cov_pop_tot per_sa_allsa_cov_pop_tot{
graph hbox  `var' , over(programclass)  nooutside   title(PRGT)
graph export "`var'PRGT.emf", replace

histogram  `var', by( program)  title(PRGT)
graph export "hist`var'PRGT.emf", replace

graph hbar (mean) `var', over(programclass) title(PRGT)
graph export "mean`var'PRGT.emf", replace
}

tab programclass


***GRA
use "\\Data1\spr\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Quality\Stata Datasets\master.dta" , clear

keep if year>=2000

gen programclass=arragementall
replace programclass=" Countries Non-program" if hadprogram==0
replace programclass=" No Program year" if arragementall=="" & hadprogram==1



keep if GRA==1
drop if blend==1

drop if arragementall=="PRGF"
drop if arragementall=="PRGF-EFF"
drop if arragementall=="PCI"
drop if arragementall=="PSI"

cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Sections\Qaulity\Charts"


twoway (scatter sh_xpd_publ_gx_zs  mortalityinfant)(lfit sh_xpd_publ_gx_zs  mortalityinfant), by(hadprogram)
graph export "GRAscatter1.emf", replace

twoway (scatter se_xpd_totl_gb_zs  netenrollprimary)(lfit se_xpd_totl_gb_zs  netenrollprimary), by( hadprogram)
graph export "GRAscatter2.emf", replace

twoway (scatter se_xpd_totl_gb_zs  netenrollsecondary)(lfit se_xpd_totl_gb_zs  netenrollsecondary), by(hadprogram)
graph export "GRAscatter3.emf", replace

twoway (scatter per_allsp_cov_pop_tot  si_pov_dday)(lfit per_allsp_cov_pop_tot  si_pov_dday), by( hadprogram)
graph export "GRAscatter4.emf", replace

twoway (scatter per_sa_allsa_cov_pop_tot si_pov_dday)(lfit per_sa_allsa_cov_pop_tot  si_pov_dday), by( hadprogram)
graph export "GRAscatter5.emf", replace


foreach var of varlist sh_xpd_publ_zs  sh_xpd_publ_gx_zs  se_xpd_totl_gb_zs se_xpd_totl_gd_zs  per_allsp_cov_pop_tot per_lm_alllm_cov_pop_tot per_sa_allsa_cov_pop_tot{
graph hbox  `var' , over(programclass)  nooutside   title(GRA)
graph export `var'GRA.emf, replace

histogram  `var', by( program)  title(GRA)
graph export "hist`var'GRA.emf", replace

graph hbar (mean) `var', over(programclass) title(GRA)
graph export "mean`var'GRA.emf", replace
}

tab programclass


/*


graph hbox  sh_xpd_publ_zs , over(programclass)  nooutside

graph hbox  sh_xpd_publ_zs , over(programclass)  nooutside

graph hbox  
sh_xpd_publ_gx_zs , over(programclass)  nooutside


graph bar (mean) sh_xpd_publ_gx_zs, by(programclassm) 

over( arrangementtype)

/*

graph bar (mean) sh_xpd_publ_gx_zs sh_xpd_publ_zs, over( program) 
graph bar (mean) sh_xpd_publ_gx_zs sh_xpd_publ_zs, by( program) over( arrangementtype)

graph bar (mean) sh_xpd_publ_gx_zs sh_xpd_publ_zs, by( program) over( arrangementtype)


graph bar (mean) sh_xpd_publ_gx_zs sh_xpd_publ_zs, by( program) over( arrangementtype)


graph bar (mean) y1 y2 y3…., by(dummy1  ) over (dummy2)
graph bar (mean) y1 y2 ,  over (dummy2) stack

gen class=1

gen programclass="NONE"
replace programclass=arrangementtype if programclass!=""
twoway (line sh_xpd_publ_gx_zs  year), by( class arrangementtype)
twoway (mband sh_xpd_publ_gx_zs  year), by( arrangementtype)


twoway (line sh_xpd_publ_gx_zs  year), by( programclass)
graph bar (mean) sh_xpd_publ_gx_zs, by( program) over( arrangementtype)


graph hbar (mean) sh_xpd_publ_gx_zs, over( arrangementtype)  by(program)

twoway (line sh_xpd_publ_gx_zs  year), by( program)

graph box per_allsp_cov_pop_tot, over(arrangementtype) 

over( arrangementtype)
