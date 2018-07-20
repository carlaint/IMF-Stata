
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts"

use "monasb.dta", clear

keep if year>=2011
graph hbar (mean) mtotal  mdtotal  nmtotal, over(region)

graph hbar (mean) mtotal  mdtotal  nmtotal,  over(countrygroup)

graph hbar (mean) mtotal  mdtotal  nmtotal, over(arragnement) 
