set more off
cd "\\Data1\spr\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\"
use "monasb.dta", clear

ren arragnement arrangement
ren financialsector* fin_sector*
ren macrostructural* macro_structural*
ren otherfiscal* other_fiscal*

cd "\\Data1\spr\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\rangecharts"
/*
capture rm *.gph

foreach var of varlist met metwithdelay notmet{
graph hbox  `var' , over(arrangement)  nooutside   title(All: `var') saving(`var')
*graph export `var'_arrangements.emf, replace
}

foreach var of varlist mtotal mdtotal nmtotal{
graph hbox  `var' , over(arrangement)  nooutside  title(All: `var') ylabel(0(0.2)1) saving(`var')
*graph export `var'_arrangements.emf, replace
}

graph combine met.gph metwithdelay.gph notmet.gph mtotal.gph mdtotal.gph nmtotal.gph
graph export all_combined.emf, replace


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

drop if year<2009

foreach var of varlist met metwithdelay notmet{
graph hbox  `var' , over(arrangement)  nooutside   title(All: `var') saving(`var'2008)
*graph export `var'2008_arrangements.emf, replace
}

foreach var of varlist mtotal mdtotal nmtotal{
graph hbox  `var' , over(arrangement)  nooutside  title(All: `var') ylabel(0(0.2)1) saving(`var'2008)
*graph export `var'2008_arrangements.emf, replace
}

graph combine met2008.gph metwithdelay2008.gph notmet2008.gph mtotal2008.gph mdtotal2008.gph nmtotal2008.gph, title(Year>=2009)
graph export all2008_combined.emf, replace


foreach var in others debt expenditure fin_sector macro_structural other_fiscal revenue social {
graph hbox  `var'_met , over(arrangement)  nooutside   title(`var': met) saving(`var'2008_met)
*graph export `var'2008_met.emf, replace

graph hbox  `var'_metwithdelay , over(arrangement)  nooutside   title(`var': met with delay) saving(`var'2008_metwdelay)
*graph export `var'2008_metwithdelay.emf, replace

graph hbox  `var'_notmet , over(arrangement)  nooutside   title(`var': not met) saving(`var'2008_notmet)
*graph export `var'2008_notmet.emf, replace

graph hbox  m`var'_total , over(arrangement)  nooutside   title(`var': met (%)) ylabel(0(0.2)1) saving(`var'2008_metpct)
*graph export m`var'2008_total.emf, replace

graph hbox  md`var'_total , over(arrangement)  nooutside   title(`var': met with delay (%)) ylabel(0(0.2)1) saving(`var'2008_metdelaypct)
*graph export md`var'2008_total.emf, replace

graph hbox  nm`var'_total , over(arrangement)  nooutside   title(`var': not met (%)) ylabel(0(0.2)1) saving(`var'2008_notmetpct)
*graph export nm_`var'2008_total.emf, replace


graph combine `var'2008_met.gph `var'2008_metwdelay.gph `var'2008_notmet.gph `var'2008_metpct.gph `var'2008_metdelaypct.gph `var'2008_notmetpct.gph, title(Year>=2009)
graph export `var'2008_combined.emf, replace

}


