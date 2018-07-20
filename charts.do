
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts"

use "monasb.dta", clear

graph hbar (mean) mtotal  mdtotal  nmtotal, by(arragnement) over(countrygroup)
graph export "met1.emf", replace
graph hbar (mean) mtotal  mdtotal  nmtotal,  over(countrygroup)
graph export "met2.emf", replace
graph hbar (mean) mtotal  mdtotal  nmtotal, by(arragnement) over(region)
graph export "met3.emf", replace


graph hbar (mean) mtotal  mdtotal  nmtotal, by(arragnement) over(region)

***
graph hbar (mean) mothers_total mdothers_total nmothers_total, by(arragnement) over(countrygroup)
graph export "met4.emf", replace
graph hbar (mean) mothers_total mdothers_total nmothers_total,  over(countrygroup)
graph export "met5.emf", replace
graph hbar (mean) mothers_total mdothers_total nmothers_total, by(arragnement) over(region)
graph export "met6.emf", replace

***
graph hbar (mean) mdebt_total mddebt_total nmdebt_total, by(arragnement) over(countrygroup)
graph export "met7.emf", replace
graph hbar (mean) mdebt_total mddebt_total nmdebt_total,  over(countrygroup)
graph export "met8.emf", replace
graph hbar (mean) mdebt_total mddebt_total nmdebt_total, by(arragnement) over(region)
graph export "met9.emf", replace

***
graph hbar (mean) mexpenditure_total mdexpenditure_total nmexpenditure_total, by(arragnement) over(countrygroup)
graph export "met10.emf", replace
graph hbar (mean) mexpenditure_total mdexpenditure_total nmexpenditure_total,  over(countrygroup)
graph export "met11.emf", replace
graph hbar (mean) mexpenditure_total mdexpenditure_total nmexpenditure_total, by(arragnement) over(region)
graph export "met12.emf", replace

***
graph hbar (mean) mfin_sector_total mdfin_sector_total nmfin_sector_total, by(arragnement) over(countrygroup)
graph export "met13.emf", replace
graph hbar (mean) mfin_sector_total mdfin_sector_total nmfin_sector_total,  over(countrygroup)
graph export "met14.emf", replace
graph hbar (mean) mfin_sector_total mdfin_sector_total nmfin_sector_total, by(arragnement) over(region)
graph export "met15.emf", replace

***
graph hbar (mean) mmacro_structural_total mdmacro_structural_total nmmacro_structural_total, by(arragnement) over(countrygroup)
graph export "met16.emf", replace
graph hbar (mean) mmacro_structural_total mdmacro_structural_total nmmacro_structural_total,  over(countrygroup)
graph export "met17.emf", replace
graph hbar (mean) mmacro_structural_total mdmacro_structural_total nmmacro_structural_total, by(arragnement) over(region)
graph export "met18.emf", replace

***
graph hbar (mean) mother_fiscal_total mdother_fiscal_total nmother_fiscal_total, by(arragnement) over(countrygroup)
graph export "met19.emf", replace
graph hbar (mean) mother_fiscal_total mdother_fiscal_total nmother_fiscal_total,  over(countrygroup)
graph export "met20.emf", replace
graph hbar (mean) mother_fiscal_total mdother_fiscal_total nmother_fiscal_total, by(arragnement) over(region)
graph export "met21.emf", replace


***
graph hbar (mean) mrevenue_total mdrevenue_total nmrevenue_total, by(arragnement) over(countrygroup)
graph export "met22.emf", replace
graph hbar (mean) mrevenue_total mdrevenue_total nmrevenue_total,  over(countrygroup)
graph export "met23.emf", replace
graph hbar (mean) mrevenue_total mdrevenue_total nmrevenue_total, by(arragnement) over(region)
graph export "met24.emf", replace


***

graph hbar (mean) msocial_total mdsocial_total nmsocial_total, by(arragnement) over(countrygroup)
graph export "met25.emf", replace
graph hbar (mean) msocial_total mdsocial_total nmsocial_total,  over(countrygroup)
graph export "met26.emf", replace
graph hbar (mean) msocial_total mdsocial_total nmsocial_total, by(arragnement) over(region)
graph export "met27.emf", replace


************for social PPT
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts"

use "monasb.dta", clear
drop if msocial_total==.
drop if year<2006
graph hbar (mean) msocial_total mdsocial_total nmsocial_total,  over(arragnement)
graph hbar (mean) msocial_total mdsocial_total nmsocial_total,  over(countrygroup)

collapse (mean) mtotal mdtotal nmtotal, by ( countrygroup year)
xtline mtotal mdtotal nmtotal, i(countrygroup) t(year)

cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts"

use "monasb.dta", clear
drop if msocial_total==.
drop if year<2006

collapse (mean) mtotal mdtotal nmtotal, by ( arragnement year)
xtline mtotal mdtotal nmtotal, i(arragnement) t(year)
xtline mtotal mdtotal nmtotal, i(arragnement) t(year) recast(scatter)
