set more off
cd "\\Data1\spr\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\"

import excel "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\MONA_QuantitativeConditions_dummy.xlsx", sheet("MainQPCs_rev") cellrange(A4:AH28197) case(lower) firstrow clear

//merge dummies
merge m:1 countryname using dummy.dta

encode status, gen(Status1)

keep if duplicates=="No"

gen ac=1 if status=="AC"
gen can=1 if status=="CAN"
gen m=1 if status=="M"
gen mmod=1 if status=="MMod"
gen mod=1 if status=="Mod"
gen nm=1 if status=="NM"
gen pc=1 if status=="PC"
gen w=1 if status=="W"

collapse(sum) ac can m mmod mod nm pc w, by(arrangementnumber approvalyear arrangementtype code region countrygroup fragile small exportearnings)

egen hsum =rowtotal(ac can m mmod mod nm pc w)

gen ac_pct=ac/hsum
gen can_pct=can/hsum
gen m_pct=m/hsum
gen mmod_pct=mmod/hsum
gen mod_pct=mod/hsum
gen nm_pct=nm/hsum
gen pc_pct=pc/hsum
gen w_pct=w/hsum

cd "\\Data1\spr\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\rangecharts"

ren arrangementtype arrangement

capture rm *.gph

foreach var of varlist ac can m mmod mod nm pc w {
graph hbox  `var' , over(arrangement)  nooutside   title(All: `var') saving(`var')
}

foreach var of varlist ac_pct can_pct m_pct mmod_pct mod_pct nm_pct pc_pct w_pct{
graph hbox  `var' , over(arrangement)  nooutside  title(All: `var') ylabel(0(0.2)1) saving(`var')
}

graph combine m.gph nm.gph m_pct.gph nm_pct.gph
graph export all_combined.emf, replace

//graph combine ac_pct.gph can_pct.gph m_pct.gph mmod_pct.gph mod_pct.gph nm_pct.gph pc_pct.gph w_pct.gph
//graph export allpct_combined.emf, replace

/*
foreach var in others debt expenditure fin_sector macro_structural other_fiscal revenue social {
graph hbox  `var'_met , over(arrangement)  nooutside   title(`var': met) saving(`var'_met)
*graph export `var'_met.emf, replace

graph hbox  `var'_metwithdelay , over(arrangement)  nooutside   title(`var': met with delay) saving(`var'_metwdelay)
*graph export `var'_metwithdelay.emf, replace

graph hbox  `var'_notmet , over(arrangement)  nooutside   title(`var': not met) saving(`var'_notmet)
*graph export `var'_notmet.emf, replace

graph hbox  m`var'_total , over(arrangement)  nooutside   title(`var': met (%)) ylabel(0(0.2)1) saving(`var'_metpct)
*graph export m`var'_total.emf, replace

graph hbox  md`var'_total , over(arrangement)  nooutside   title(`var': met with delay (%)) ylabel(0(0.2)1) saving(`var'_metdelaypct)
*graph export md`var'_total.emf, replace

graph hbox  nm`var'_total , over(arrangement)  nooutside   title(`var': not met (%)) ylabel(0(0.2)1) saving(`var'_notmetpct)
*graph export nm_`var'_total.emf, replace


graph combine `var'_met.gph `var'_metwdelay.gph `var'_notmet.gph `var'_metpct.gph `var'_metdelaypct.gph `var'_notmetpct.gph
graph export `var'_combined.emf, replace

}
*/
