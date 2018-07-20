***RES structual
use "\\data1\res\DATA\RESwebSP\Structural_Indicators\Structural_Indicators_v2018.dta" , clear

keep if year>=2000
drop if ifs_code==0
drop if ifs_code==9999

save "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\RESstructual.dta", replace


**** ROC comparator
use "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Comparators\Stata Files\master_data_comparator.dta", clear
save "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\master_data_comparator.dta", replace

*****compliance data SB
use "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\compliance_ke1.dta", clear
collapse (sum) low medium high met metdelay notmet (first) arrangementtype, by (countryname countrycode year ifs_code)
gen totalsb=  met + metdelay + notmet
replace totalsb=. if totalsb==0
gen metr=met/totalsb
gen metdelayr=metdelay/totalsb
gen notmetr=notmet/totalsb
gen depthavg= (low+ medium*2 + high*3)/(low+ medium+ high )
save "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\compliance_ke2.dta", replace


****Offtrack
use "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\offtrackness.dta", clear
gen offtrackness=0
replace offtrackness=1 if offtrack==3
drop  offtrack
collapse (max)  offtrackness, by ( countryname countrycode year)
drop if year==.
rename countrycode ifs_code

save "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\offtrackness1.dta", replace



**********merge
use "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\master_data_comparator.dta", clear
gen ifs_code=country_code
merge 1:1 ifs_code year using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\RESstructual.dta"
drop if _merge==2
drop _merge

merge 1:1 ifs_code year using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\compliance_ke2.dta"
drop if _merge==2
drop _merge

merge 1:1 ifs_code year using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\ITs.dta"
drop if _merge==2
drop _merge

merge 1:1 ifs_code year using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\QPCs.dta"
drop if _merge==2
drop _merge

merge 1:1 ifs_code year using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts\SBs.dta"
drop if _merge==2
drop _merge

merge 1:1 ifs_code year using "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\offtrackness1.dta"
drop if _merge==2
drop _merge

keep if year>=2002 & year<2018
save "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\master_reg.dta", replace



**************************************************
********chart
***met ratio as y
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\"
use "master_reg.dta", clear
drop if  arrangementtype==""
 xtline SBstotal totalsb, recast(line) cmissing(n) i(country_name) t(year)
 
twoway (scatter SBsmetr depthavg) (lfit SBsmetr depthavg)


graph bar (mean) SBsmetr, over(year) by(PRGT) title("SBs implementation")

graph bar (mean) QPCsmetr, over(year) by(PRGT) title("QPCs implementation")
**************************************************
********regression
***met ratio as y
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\"
use "master_reg.dta", clear

xtset ifs_code year

gen period=0
replace period=1 if year>=2009

replace gdp_pc=ln(gdp_pc)

xtreg offtrackness  gdp_pc  i.year, fe

xtreg metr  totalsb  PRGT   i.year , fe
outreg2 using "compliance_reg.xls", replace 

xtreg metr  totalsb  PRGT  period  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg metr  totalsb  PRGT  period gdp_pc  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg metr  totalsb  PRGT  period gdp_pc  RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append

xtreg metr  totalsb depthavg PRGT period eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append

heckman metr  totalsb depthavg PRGT period i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append

heckman metr  totalsb  PRGT  period gdp_pc  RegulatoryQuality trade_openness i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append

foreach x in SBs QPCs  ITs {


***the file above is a direct paste of MONA_QPC and SB with_dummy.xlsx***

xtreg `x'metr  `x'total  PRGT  i.year  , fe
outreg2 using "compliance_reg.xls", append

xtreg `x'metr  `x'total  PRGT  period  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg `x'metr  `x'total   PRGT  period gdp_pc  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg `x'metr  `x'total   PRGT  period gdp_pc  RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append

xtreg `x'metr  `x'total  depthavg PRGT period eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append

heckman `x'metr  `x'total depthavg PRGT period i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append

heckman `x'metr  `x'total  PRGT  period gdp_pc  RegulatoryQuality trade_openness i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append

}


*********************************************************************
***not met as y
xtreg notmetr  totalsb  PRGT  i.year  , fe
outreg2 using "compliance_reg.xls", append

xtreg notmetr  totalsb PRGT  period  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg notmetr  totalsb  PRGT  gdp_pc  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg notmetr  totalsb  PRGT  gdp_pc  RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append

xtreg notmetr  totalsb depthavg PRGT eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append


heckman  notmetr  totalsb depthavg PRGT period i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append

heckman  notmetr totalsb  PRGT  period gdp_pc  RegulatoryQuality trade_openness i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append


foreach x in  SBs QPCs ITs {


***the file above is a direct paste of MONA_QPC and SB with_dummy.xlsx***

xtreg `x'nmr  `x'total  PRGT  i.year  , fe
outreg2 using "compliance_reg.xls", append

xtreg `x'nmr  `x'total  PRGT  period  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg `x'nmr  `x'total   PRGT  gdp_pc  i.year, fe
outreg2 using "compliance_reg.xls",append

xtreg `x'nmr  `x'total   PRGT  gdp_pc  RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append

xtreg `x'nmr  `x'total  depthavg PRGT eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness i.year, fe
outreg2 using "compliance_reg.xls", append



heckman  `x'nmr  `x'total depthavg PRGT period i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append

heckman  `x'nmr  `x'total  PRGT  period gdp_pc  RegulatoryQuality trade_openness i.year , select (gdp_pc RegulatoryQuality )  twostep
outreg2 using "compliance_reg.xls", append


}


***************************
************************reg SC level
cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Structural Conditionality\STATA\"
*use "SC_dataraw_depth.dta", clear
use "SC_dataraw.dta", clear

keep insample_2018roc insample assessed countryname countrycode newtestdateyear core shared noncore governance sectors duplicated identifications approvalyear programtype pcstatus 
drop if newtestdateyear=="#N/A"
drop if newtestdateyear=="#VALUE!"
destring newtestdateyear, generate(year)
 
 gen scmet=0
 replace scmet=1 if pcstatus=="M"
 
  gen scnotmet=0
 replace scnotmet=1 if pcstatus=="NM"
  replace scnotmet=1 if pcstatus=="PM"
replace scnotmet=1 if pcstatus=="W"

merge m:m countrycode year using  "master_reg.dta"
drop if _merge==2

gen period=0
replace period=1 if year>=2009

xtreg scmet core PRGT gdp_pc  i.countrycode i.year, fe
outreg2 using "compliance_reg1.xls", replace


xtreg scmet core totalsb  PRGT  gdp_pc i.countrycode  i.year, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb  PRGT  gdp_pc period i.countrycode  i.year, fe
outreg2 using "compliance_reg1.xls", append



xtreg scmet core totalsb depthavg PRGT period eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness i.countrycode i.year, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core  gdp_pc  i.countrycode i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb   gdp_pc period  i.countrycode  i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb   gdp_pc i.countrycode  i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb depthavg PRGT eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness i.countrycode i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append


****
xtreg scmet core PRGT gdp_pc     i.year, fe
outreg2 using "compliance_reg1.xls", append


xtreg scmet core totalsb  PRGT  gdp_pc     i.year, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb  PRGT  gdp_pc period     i.year, fe
outreg2 using "compliance_reg1.xls", append



xtreg scmet core totalsb depthavg PRGT period eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness    i.year, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core  gdp_pc     i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb   gdp_pc period      i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb   gdp_pc     i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append

xtreg scmet core totalsb depthavg PRGT eff sba pll ecf esf scf psi pci blend  gdp_pc exceptional_access RegulatoryQuality trade_openness    i.year  if PRGT==1, fe
outreg2 using "compliance_reg1.xls", append


**RuleofLaw ControlofCorruption GovernmentEffectiveness PoliticalStability VoiceandAccountability 
