cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Quality\Stata Datasets\"
use "SocialBenefits.dta" , clear

merge m:1 country using "ifscode", force
order ifscode, a(country)
drop  if _merge==2
drop _merge


merge 1:1 country year using "AvgYrsPrimarySchooling"
drop  if _merge==2
drop _merge

merge 1:1 country year using "AvgYrsSecondarySchooling"
drop  if _merge==2
drop _merge
 
merge 1:1 country year using "AvgYrsTertiarySchooling"
drop  if _merge==2
drop _merge

merge 1:1 country year using "EducationExpenditure"
drop  if _merge==2
drop _merge
 
merge 1:1 country year using "EmpToPopRatio15+FemaleILO"
drop  if _merge==2
drop _merge
 
merge 1:1 country year using "EmpToPopRatio15+FemaleNE"
drop  if _merge==2
drop _merge
 
merge 1:1 country year using "EmpToPopRatio15+MaleILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "EmpToPopRatio15+MaleNE"
drop  if _merge==2
drop _merge
 
merge 1:1 country year using "EmpToPopRatio15+TotalLO"
drop  if _merge==2
drop _merge
  
merge 1:1 country year using "EmpToPopRatio15+TotalNE"
drop  if _merge==2
drop _merge
   

merge 1:1 country year using "FertilityRate"
drop  if _merge==2
drop _merge 

drop countrycode
 
merge 1:1 country year using "Gini"
drop  if _merge==2
drop _merge 
 
merge 1:1 country year using "HealthExpenditure"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LaborForcePpationFem15+ILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LaborForcePpationFem15+NE"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LaborForcePpationMale15+ILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LaborForcePpationMale15+NE"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LaborForcePpationTot15+ILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LaborForcePpationTot15+NE"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LifeExptFemale"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LifeExptMale"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LifeExptTotal"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LiteracyRateFemale"
drop  if _merge==2
drop _merge

merge 1:1 country year using "LiteracyRateMale"
drop  if _merge==2
drop _merge

merge 1:1 country year using "MortalityRateFemale"
drop  if _merge==2
drop _merge

merge 1:1 country year using "MortalityRateMale"
drop  if _merge==2
drop _merge

merge 1:1 country year using "MortalityRateInfant"
drop  if _merge==2
drop _merge

merge 1:1 country year using "NetEnrollLowerSecondary"
drop  if _merge==2
drop _merge

merge 1:1 country year using "NetEnrollPrimary"
drop  if _merge==2
drop _merge

merge 1:1 country year using "NetEnrollSecondary"
drop  if _merge==2
drop _merge

merge 1:1 country year using "PovHCRatio1"
drop  if _merge==2
drop _merge

merge 1:1 country year using "PovHCRatio3"
drop  if _merge==2
drop _merge

merge 1:1 country year using "PovHCRatio5"
drop  if _merge==2
drop _merge

merge 1:1 country year using "UnemFemILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "UnemFemNE"
drop  if _merge==2
drop _merge

merge 1:1 country year using "UnemMaleILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "UnemMaleNE"
drop  if _merge==2
drop _merge

merge 1:1 country year using "UnemTotILO"
drop  if _merge==2
drop _merge

merge 1:1 country year using "UnemTotNE"
drop  if _merge==2
drop _merge

merge 1:1 country year using "SocialSB"
drop  if _merge==2
drop _merge

merge 1:1 country year using "ITs"
drop  if _merge==2
drop _merge

drop if ifscode==.

merge 1:1 ifscode year using "consolidationprog"
drop  if _merge==2
drop _merge

merge 1:1 ifscode year using "consolidationactual"
drop  if _merge==2
drop _merge

keep if year>=1980 & year<=2017
drop if ifscode == .
drop if country == "Macao SAR, China"
drop if country == "Hong Kong SAR, China"
drop if country == "Puerto Rico"
drop if country == "Euro area"
 

gen program = 0
label var program "Dummy that takes the value 1 if the country had a program in that year"
replace program = 1 if country == "Albania" & year>=2014 & year<=2017
replace program = 1 if country == "Angola" & year>=2009 & year<=2012
replace program = 1 if country == "Antigua and Barbuda" & year>=2010 & year<=2013
replace program = 1 if country == "Armenia" & year>=2010 & year<=2017
replace program = 1 if country == "Bosnia and Herzegovina" & year>=2009 & year<=2020
replace program = 1 if country == "Cote d'Ivoire" & year>=2011 & year<=2019
replace program = 1 if country == "Cyprus" & year>=2013 & year<=2016
replace program = 1 if country == "Dominican Republic" & year>=2009 & year<=2012
replace program = 1 if country == "Egypt, Arab Rep." & year>=2016 & year<=2019
replace program = 1 if country == "El Salvador" & year>=2010 & year<=2013
replace program = 1 if country == "Gabon" & year>=2017 & year<=2020
replace program = 1 if country == "Georgia" & year>=2012 & year<=2020
replace program = 1 if country == "Greece" & year>=2010 & year<=2016
replace program = 1 if country == "Honduras" & year>=2010 & year<=2017
replace program = 0 if country == "Honduras" & year==2013 
replace program = 1 if country == "Iraq" & year>=2010 & year<=2013
replace program = 1 if country == "Iraq" & year>=2016 & year<=2019
replace program = 1 if country == "Ireland" & year>=2010 & year<=2013
replace program = 1 if country == "Jamaica" & year>=2010 & year<=2019
replace program = 1 if country == "Jordan" & year>=2012 & year<=2019
replace program = 1 if country == "Kenya" & year>=2011 & year<=2018
replace program = 1 if country == "Kosovo" & year>=2010 & year<=2017
replace program = 0 if country == "Kosovo" & year==2014
replace program = 1 if country == "Latvia" & year>=2008 & year<=2011
replace program = 1 if country == "Maldives" & year>=2009 & year<=2012
replace program = 1 if country == "Moldova" & year>=2010 & year<=2013
replace program = 1 if country == "Moldova" & year>=2016 & year<=2019
replace program = 1 if country == "Mongolia" & year>=2017 & year<=2020
replace program = 1 if country == "Pakistan" & year>=2013 & year<=2016
replace program = 1 if country == "Portugal" & year>=2011 & year<=2014
replace program = 1 if country == "Romania" & year>=2011 & year<=2015
replace program = 1 if country == "Serbia" & year>=2011 & year<=2013
replace program = 1 if country == "Serbia" & year>=2015 & year<=2018
replace program = 1 if country == "Seychelles" & year>=2009 & year<=2020
replace program = 1 if country == "Sri Lanka" & year>=2009 & year<=2012
replace program = 1 if country == "Sri Lanka" & year>=2016 & year<=2019
replace program = 1 if country == "St. Kitts and Nevis" & year>=2011 & year<=2014
replace program = 1 if country == "Suriname" & year>=2016 & year<=2017
replace program = 1 if country == "Tunisia" & year>=2013 & year<=2020
replace program = 1 if country == "Ukraine" & year>=2010 & year<=2012
replace program = 1 if country == "Ukraine" & year>=2014 & year<=2019
replace program = 1 if country == "Morocco" & year>=2012 & year<=2018
replace program = 1 if country == "Afghanistan" & year>=2011 & year<=2014
replace program = 1 if country == "Afghanistan" & year>=2016 & year<=2019
replace program = 1 if country == "Bangladesh" & year>=2012 & year<=2015
replace program = 1 if country == "Benin" & year>=2010 & year<=2014
replace program = 1 if country == "Benin" & year>=2017 & year<=2020
replace program = 1 if country == "Burkina Faso" & year>=2010 & year<=2017
replace program = 1 if country == "Burundi" & year>=2008 & year<=2016
replace program = 1 if country == "Cameroon" & year>=2017 
replace program = 1 if country == "Cabo Verde" & year>=2010 & year<=2012
replace program = 1 if country == "Central African Republic" & year>=2012 & year<=2014
replace program = 1 if country == "Central African Republic" & year>=2016 & year<=2019
replace program = 1 if country == "Chad" & year>=2014 & year<=2020
replace program = 1 if country == "Comoros" & year>=2009 & year<=2013
replace program = 1 if country == "Congo, Dem. Rep." & year>=2009 & year<=2012
replace program = 1 if country == "Djibouti" & year>=2008 & year<=2012
replace program = 1 if country == "Gambia, The" & year>=2012 & year<=2015
replace program = 1 if country == "Ghana" & year>=2009 & year<=2012
replace program = 1 if country == "Ghana" & year>=2015 & year<=2019
replace program = 1 if country == "Grenada" & year>=2010 & year<=2013
replace program = 1 if country == "Grenada" & year>=2014 & year<=2017
replace program = 1 if country == "Guinea" & year>=2012 & year<=2020
replace program = 1 if country == "Guinea-Bissau" & year>=2010 & year<=2013
replace program = 1 if country == "Guinea-Bissau" & year>=2015 & year<=2018
replace program = 1 if country == "Haiti" & year>=2010 & year<=2016
replace program = 1 if country == "Kyrgyz Republic" & year>=2011 & year<=2018
replace program = 1 if country == "Lesotho" & year>=2010 & year<=2013
replace program = 1 if country == "Liberia" & year>=2008 & year<=2017
replace program = 1 if country == "Madagascar" & year>=2016 & year<=2019
replace program = 1 if country == "Malawi" & year>=2010 & year<=2017
replace program = 1 if country == "Mali" & year>=2008 & year<=2018
replace program = 1 if country == "Mauritania" & year>=2010 & year<=2013
replace program = 1 if country == "Mauritania" & year>=2017 & year<=2020
replace program = 1 if country == "Mozambique" & year>=2010 & year<=2017
replace program = 1 if country == "Niger" & year>=2012 & year<=2020
replace program = 1 if country == "Rwanda" & year>=2010 & year<=2018
replace program = 1 if country == "Sao Tome and Principe" & year>=2009 & year<=2018
replace program = 1 if country == "Senegal" & year>=2010 & year<=2019
replace program = 1 if country == "Sierra Leone" & year>=2010 & year<=2020
replace program = 1 if country == "Solomon Islands" & year>=2010 & year<=2016
replace program = 1 if country == "Tajikistan" & year>=2009 & year<=2012
replace program = 1 if country == "Tanzania" & year>=2010 & year<=2018
replace program = 1 if country == "Togo" & year>=2017 & year<=2020
replace program = 1 if country == "Uganda" & year>=2010 & year<=2017
replace program = 1 if country == "Yemen, Rep." & year>=2010 & year<=2012
replace program = 1 if country == "Yemen, Rep." & year>=2014 & year<=2016

merge 1:1 ifscode year using "programinfo"
sort country year
drop  if _merge==2
drop _merge

replace arrangementtype = "SBA" if country == "Latvia" & year>=2008 & year<=2011
replace arrangementtype = "SBA" if country == "Bosnia and Herzegovina" & year>=2009 & year<=2015
replace arrangementtype = "EFF" if country == "Bosnia and Herzegovina" & year>=2016 & year<=2020
replace arrangementtype = "SBA" if country == "Sri Lanka" & year>=2009 & year<=2012
replace arrangementtype = "EFF" if country == "Sri Lanka" & year>=2016 & year<=2019
replace arrangementtype = "SBA" if country == "Dominican Republic" & year>=2009 & year<=2012
replace arrangementtype = "SBA" if country == "Angola" & year>=2009 & year<=2012
replace arrangementtype = "SBA-ESF" if country == "Maldives" & year>=2009 & year<=2012
replace blend = 1 if country == "Maldives" & year>=2009 & year<=2012
replace arrangementtype = "EFF" if country == "Seychelles" & year>=2009 & year<=2016
replace arrangementtype = "PCI" if country == "Seychelles" & year==2017
replace arrangementtype = "ECF-EFF" if country == "Moldova" & year>=2010 & year<=2013
replace arrangementtype = "ECF-EFF" if country == "Moldova" & year>=2016 & year<=2019
replace blend = 1 if country == "Moldova" & year>=2010 & year<=2013
replace blend = 1 if country == "Moldova" & year>=2016 & year<=2019
replace arrangementtype = "SBA" if country == "Jamaica" & year>=2010 & year<=2012
replace arrangementtype = "EFF" if country == "Jamaica" & year>=2013 & year<=2015
replace arrangementtype = "SBA" if country == "Jamaica" & year>=2016 & year<=2019
replace arrangementtype = "SBA" if country == "Iraq" & year>=2010 & year<=2013
replace arrangementtype = "SBA" if country == "Iraq" & year>=2016 & year<=2019
replace arrangementtype = "SBA" if country == "El Salvador" & year>=2010 & year<=2013
replace arrangementtype = "SBA" if country == "Greece"  & year>=2010 & year<=2012
replace arrangementtype = "EFF" if country == "Greece"  & year>=2012 & year<=2016
replace arrangementtype = "SBA" if country == "Antigua and Barbuda" & year>=2010 & year<=2013
replace arrangementtype = "ECF-EFF" if country == "Armenia" & year>=2010 & year<=2013
replace arrangementtype = "EFF" if country == "Armenia" & year>=2014 & year<=2017
replace blend = 1 if country == "Armenia" & year>=2010 & year<=2013
replace arrangementtype = "SBA" if country == "Kosovo" & year>=2010 & year<=2013
replace arrangementtype = "SBA" if country == "Kosovo" & year>=2015 & year<=2017
replace arrangementtype = "SBA" if country == "Ukraine" & year>=2010 & year<=2012
replace arrangementtype = "SBA" if country == "Ukraine" & year==2014 
replace arrangementtype = "EFF" if country == "Ukraine" & year>=2015 & year<=2019
replace arrangementtype = "SBA-SCF" if country == "Honduras" & year>=2010 & year<=2012
replace arrangementtype = "SBA-SCF" if country == "Honduras" & year>=2014 & year<=2017
replace blend = 1 if country == "Honduras" & year>=2010 & year<=2012
replace blend = 1 if country == "Honduras" & year>=2014 & year<=2017
replace arrangementtype = "EFF" if country == "Ireland" & year>=2010 & year<=2013
replace arrangementtype = "SBA" if country == "Romania" & year>=2011 & year<=2015
replace arrangementtype = "EFF" if country == "Portugal" & year>=2011 & year<=2014
replace arrangementtype = "SBA" if country == "St. Kitts and Nevis" & year>=2011 & year<=2014
replace arrangementtype = "SBA" if country == "Serbia" & year>=2011 & year<=2013
replace arrangementtype = "SBA" if country == "Serbia" & year>=2015 & year<=2018
replace arrangementtype = "SBA-SCF" if country == "Georgia"  & year>=2012 & year<=2013
replace arrangementtype = "SBA" if country == "Georgia"  & year>=2014 & year<=2016
replace arrangementtype = "EFF" if country == "Georgia"  & year>=2017 & year<=2020
replace blend = 1 if country == "Georgia" & year>=2012 & year<=2013
replace arrangementtype = "SBA" if country == "Jordan" & year>=2012 & year<=2015
replace arrangementtype = "EFF" if country == "Jordan" & year>=2016 & year<=2019
replace arrangementtype = "PLL" if country == "Morocco" & year>=2012 & year<=2018
replace arrangementtype = "EFF" if country == "Cyprus"  & year>=2013 & year<=2016
replace arrangementtype = "SBA" if country == "Tunisia" & year>=2013 & year<=2015
replace arrangementtype = "EFF" if country == "Tunisia" & year>=2016 & year<=2020
replace arrangementtype = "EFF" if country == "Pakistan" & year>=2013 & year<=2016
replace arrangementtype = "EFF" if country == "Albania" & year>=2014 & year<=2017
replace arrangementtype = "ECF" if country == "Kenya" & year>=2011 & year<=2014
replace arrangementtype = "SBA-SCF" if country == "Kenya" & year>=2015 & year<=2018
replace blend = 1 if country == "Kenya" & year>=2015 & year<=2018
replace arrangementtype = "SBA" if country == "Suriname" & year>=2016 & year<=2017
replace arrangementtype = "EFF" if country == "Egypt, Arab Rep." & year>=2016 & year<=2019
replace arrangementtype = "ECF" if country == "Cote d'Ivoire" & year>=2011 & year<=2015
replace arrangementtype = "ECF-EFF" if country == "Cote d'Ivoire" & year>=2016 & year<=2019
replace blend = 1 if country == "Cote d'Ivoire" & year>=2016 & year<=2019
replace arrangementtype = "EFF" if country == "Mongolia" & year>=2017 & year<=2020
replace arrangementtype = "EFF" if country == "Gabon" & year>=2017 & year<=2020
replace arrangementtype = "PRGF-EFF" if country == "Liberia" & year>=2008 & year<=2011
replace arrangementtype = "ECF" if country == "Liberia" & year>=2012 & year<=2017
replace blend = 1 if country == "Liberia" & year>=2008 & year<=2011
replace arrangementtype = "PRGF" if country == "Mali" & year>=2008 & year<=2010
replace arrangementtype = "ECF" if country == "Mali" & year>=2011 & year<=2018
replace arrangementtype = "PRGF" if country == "Burundi" & year>=2008 & year<=2011
replace arrangementtype = "ECF" if country == "Burundi" & year>=2012 & year<=2016
replace arrangementtype = "PRGF" if country == "Djibouti" & year>=2008 & year<=2012
replace arrangementtype = "PRGF" if country == "Sao Tome and Principe" & year>=2009 & year<=2011
replace arrangementtype = "ECF" if country == "Sao Tome and Principe" & year>=2012 & year<=2018
replace arrangementtype = "PRGF" if country == "Tajikistan" & year>=2009 & year<=2012
replace arrangementtype = "PRGF" if country == "Ghana" & year>=2009 & year<=2012
replace arrangementtype = "ECF" if country == "Ghana" & year>=2015 & year<=2019
replace arrangementtype = "SBA" if country == "Comoros" & year>=2009 & year<=2013
replace arrangementtype = "PRGF" if country == "Congo, Dem. Rep." & year>=2009 & year<=2012
replace arrangementtype = "ECF" if country == "Malawi" & year>=2010 & year<=2017
replace arrangementtype = "ECF" if country == "Mauritania" & year>=2010 & year<=2013
replace arrangementtype = "ECF" if country == "Mauritania" & year>=2017 & year<=2020
replace arrangementtype = "ECF" if country == "Grenada" & year>=2010 & year<=2017
replace arrangementtype = "ECF" if country == "Guinea-Bissau" & year>=2010 & year<=2013
replace arrangementtype = "ECF" if country == "Guinea-Bissau" & year>=2015 & year<=2018
replace arrangementtype = "PSI" if country == "Uganda"  & year>=2010 & year<=2017
replace arrangementtype = "ECF" if country == "Lesotho" & year>=2010 & year<=2013
replace arrangementtype = "SCF" if country == "Solomon Islands" & year>=2010 & year<=2012
replace arrangementtype = "ECF" if country == "Solomon Islands" & year>=2012 & year<=2016
replace arrangementtype = "SBA" if country == "Sierra Leone" & year>=2010 & year<=2020
replace arrangementtype = "PSI" if country == "Tanzania" & year>=2010 & year<=2011
replace arrangementtype = "SCF" if country == "Tanzania" & year>=2012 & year<=2013
replace arrangementtype = "PSI" if country == "Tanzania" & year>=2014 & year<=2018
replace arrangementtype = "ECF" if country == "Benin" & year>=2010 & year<=2014
replace arrangementtype = "ECF" if country == "Benin" & year>=2017 & year<=2020
replace arrangementtype = "SBA" if country == "Burkina Faso" & year>=2017 & year<=2020
replace arrangementtype = "SBA" if country == "Mozambique" & year>=2017 & year<=2020
replace arrangementtype = "PSI" if country == "Rwanda" & year>=2010 & year<=2015
replace arrangementtype = "SCF" if country == "Rwanda" & year>=2016 & year<=2018
replace arrangementtype = "ECF" if country == "Haiti" & year>=2010 & year<=2016
replace arrangementtype = "ECF" if country == "Yemen, Rep." & year>=2010 & year<=2012
replace arrangementtype = "ECF" if country == "Yemen, Rep." & year>=2014 & year<=2016
replace arrangementtype = "PSI" if country == "Cabo Verde" & year>=2010 & year<=2012
replace arrangementtype = "PSI" if country == "Senegal" & year>=2010 & year<=2019
replace arrangementtype = "ECF" if country == "Kyrgyz Republic" & year>=2011 & year<=2018
replace arrangementtype = "ECF" if country == "Afghanistan" & year>=2011 & year<=2014
replace arrangementtype = "ECF" if country == "Afghanistan" & year>=2016 & year<=2019
replace arrangementtype = "ECF" if country == "Guinea" & year>=2012 & year<=2020
replace arrangementtype = "ECF" if country == "Niger" & year>=2012 & year<=2020
replace arrangementtype = "ECF" if country == "Bangladesh"  & year>=2012 & year<=2015
replace arrangementtype = "ECF" if country == "Gambia, The" & year>=2012 & year<=2015
replace arrangementtype = "ECF" if country == "Central African Republic" & year>=2012 & year<=2014
replace arrangementtype = "ECF" if country == "Central African Republic" & year>=2016 & year<=2019
replace arrangementtype = "PSI" if country == "Mozambique" & year>=2010 & year<=2014
replace arrangementtype = "SCF" if country == "Mozambique" & year>=2015 & year<=2017
replace arrangementtype = "ECF" if country == "Chad" & year>=2014 & year<=2020
replace arrangementtype = "ECF" if country == "Madagascar" & year>=2016 & year<=2019
replace arrangementtype = "ECF" if country == "Togo" & year>=2017 & year<=2020
replace arrangementtype = "ECF" if country == "Cameroon" & year>=2017 & year<=2020
replace arrangementtype = "ECF" if country == "Burkina Faso" & year>=2010 & year<=2017

gen GRA=1	
replace GRA=0 if ifscode==	512
replace GRA=0 if ifscode==	513
replace GRA=0 if ifscode==	638
replace GRA=0 if ifscode==	514
replace GRA=0 if ifscode==	748
replace GRA=0 if ifscode==	618
replace GRA=0 if ifscode==	522
replace GRA=0 if ifscode==	622
replace GRA=0 if ifscode==	624
replace GRA=0 if ifscode==	626
replace GRA=0 if ifscode==	628
replace GRA=0 if ifscode==	632
replace GRA=0 if ifscode==	636
replace GRA=0 if ifscode==	634
replace GRA=0 if ifscode==	662
replace GRA=0 if ifscode==	611
replace GRA=0 if ifscode==	321
replace GRA=0 if ifscode==	643
replace GRA=0 if ifscode==	644
replace GRA=0 if ifscode==	648
replace GRA=0 if ifscode==	652
replace GRA=0 if ifscode==	328
replace GRA=0 if ifscode==	656
replace GRA=0 if ifscode==	654
replace GRA=0 if ifscode==	336
replace GRA=0 if ifscode==	263
replace GRA=0 if ifscode==	268
replace GRA=0 if ifscode==	664
replace GRA=0 if ifscode==	826
replace GRA=0 if ifscode==	917
replace GRA=0 if ifscode==	544
replace GRA=0 if ifscode==	666
replace GRA=0 if ifscode==	668
replace GRA=0 if ifscode==	674
replace GRA=0 if ifscode==	676
replace GRA=0 if ifscode==	556
replace GRA=0 if ifscode==	678
replace GRA=0 if ifscode==	657
replace GRA=0 if ifscode==	682
replace GRA=0 if ifscode==	671
replace GRA=0 if ifscode==	921
replace GRA=0 if ifscode==	688
replace GRA=0 if ifscode==	518
replace GRA=0 if ifscode==	558
replace GRA=0 if ifscode==	278
replace GRA=0 if ifscode==	692
replace GRA=0 if ifscode==	853
replace GRA=0 if ifscode==	714
replace GRA=0 if ifscode==	862
replace GRA=0 if ifscode==	716
replace GRA=0 if ifscode==	722
replace GRA=0 if ifscode==	724
replace GRA=0 if ifscode==	813
replace GRA=0 if ifscode==	726
replace GRA=0 if ifscode==	885
replace GRA=0 if ifscode==	362
replace GRA=0 if ifscode==	364
replace GRA=0 if ifscode==	732
replace GRA=0 if ifscode==	923
replace GRA=0 if ifscode==	738
replace GRA=0 if ifscode==	537
replace GRA=0 if ifscode==	742
replace GRA=0 if ifscode==	866
replace GRA=0 if ifscode==	987
replace GRA=0 if ifscode==	746
replace GRA=0 if ifscode==	927
replace GRA=0 if ifscode==	846
replace GRA=0 if ifscode==	474
replace GRA=0 if ifscode==	754
replace GRA=0 if ifscode==	698


merge m:m ifscode year using "programinfo2011"
sort country year
drop  if _merge==2
drop _merge

replace arrangementtype2011="SBA" if year>=2009 & year<=2012 & country=="Angola"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2013 & country=="Antigua and Barbuda"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2003 & country=="Argentina"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2010 & country=="Armenia"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2010 & country=="Belarus"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2006 & country=="Bolivia"
replace arrangementtype2011="SBA" if year>=	2002 & year<=2004 & country=="Bosnia and Herzegovina" 
replace arrangementtype2011="SBA" if year>=	2009 & year<=2012 & country=="Bosnia and Herzegovina"
replace arrangementtype2011="SBA" if year>=	2002 & year<=2005 & country=="Brazil"
replace arrangementtype2011="SBA" if year>=	2004 & year<=2007 & country=="Bulgaria"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2005 & country=="Colombia"
replace arrangementtype2011="SBA" if year>=	2005 & year<=2006 & country=="Colombia"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2010 & country=="Costa Rica"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2004 & country=="Croatia"
replace arrangementtype2011="SBA" if year>=	2004 & year<=2006 & country=="Croatia"
replace arrangementtype2011="SBA" if year>=	2002 & year<=2004 & country=="Dominica"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2005 & country=="Dominican Republic"
replace arrangementtype2011="SBA" if year>=	2005 & year<=2008 & country=="Dominican Republic"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2012 & country=="Dominican Republic"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2004 & country=="Ecuador"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2010 & country=="El Salvador"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2013 & country=="El Salvador"
replace arrangementtype2011="SBA" if year>=	2004 & year<=2005 & country=="Gabon"
replace arrangementtype2011="SBA" if year>=	2007 & year<=2010 & country=="Gabon"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2011 & country=="Georgia"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2012 & country=="Greece"
replace arrangementtype2011="SBA" if year>=	2002 & year<=2003 & country=="Guatemala"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2004 & country=="Guatemala"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2010 & country=="Guatemala"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2009 & country=="Honduras"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2010 & country=="Hungary"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2011 & country=="Iceland"
replace arrangementtype2011="SBA" if year>=	2005 & year<=2007 & country=="Iraq"
replace arrangementtype2011="SBA" if year>=	2007 & year<=2009 & country=="Iraq"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2013 & country=="Iraq"
replace arrangementtype2011="EFF" if year>=	2010 & year<=2013 & country=="Ireland"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2012 & country=="Jamaica"
replace arrangementtype2011="SBA" if year>=	2002 & year<=2004 & country=="Jordan"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2012 & country=="Kosovo"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2011 & country=="Latvia"
replace arrangementtype2011="SBA" if year>=	2005 & year<=2008 & country=="Macedonia, FYR"
replace arrangementtype2011="SBAESF	" if year>=	2009 & year<=2012 & country=="Maldives"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2010 & country=="Mongolia"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2011 & country=="Pakistan"
replace arrangementtype2011="SBA" if year>=	2003 & year<=2005 & country=="Paraguay"
replace arrangementtype2011="SBA" if year>=	2006 & year<=2008 & country=="Paraguay"
replace arrangementtype2011="SBA" if year>=	2004 & year<=2006 & country=="Peru"
replace arrangementtype2011="SBA" if year>=	2007 & year<=2009 & country=="Peru"
replace arrangementtype2011="EFF" if year>=	2011 & year<=2014 & country=="Portugal"
replace arrangementtype2011="SBA" if year>=	2004 & year<=2006 & country=="Romania"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2011 & country=="Romania"
replace arrangementtype2011="SBA" if year>=	2011 & year<=2013 & country=="Romania"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2011 & country=="Serbia"
replace arrangementtype2011="SBA" if year>=	2011 & year<=2013 & country=="Serbia"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2009 & country=="Seychelles"
replace arrangementtype2011="EFF" if year>=	2009 & year<=2013 & country=="Seychelles"
replace arrangementtype2011="SBA" if year>=	2009 & year<=2012 & country=="Sri Lanka"
replace arrangementtype2011="SBA" if year>=	2011 & year<=2014 & country=="St. Kitts and Nevis"
replace arrangementtype2011="SBA" if year>=	2005 & year<=2008 & country=="Turkey"
replace arrangementtype2011="SBA" if year>=	2004 & year<=2005 & country=="Ukraine"
replace arrangementtype2011="SBA" if year>=	2008 & year<=2010 & country=="Ukraine"
replace arrangementtype2011="SBA" if year>=	2010 & year<=2012 & country=="Ukraine"
replace arrangementtype2011="SBA" if year>=	2002 & year<=2005 & country=="Uruguay"
replace arrangementtype2011="SBA" if year>=	2005 & year<=2006 & country=="Uruguay"
replace arrangementtype2011="PRGF" if year>=2006 & year<=2010 & ifscode==512
replace arrangementtype2011="PRGF" if year>=2002 & year<=2005 & ifscode==914
replace arrangementtype2011="PRGF-EFF" if year>=2006 & year<=2009 & ifscode==914
replace arrangementtype2011="PRGF" if year>=2005 & year<=2008 & ifscode==911
replace arrangementtype2011="PRGF" if year>=2008 & year<=2009 & ifscode==911
replace arrangementtype2011="ECF-EFF" if year>=2010 & year<=2013 & ifscode==911
replace arrangementtype2011="PRGF" if year>=2003 & year<=2007 & ifscode==513
replace arrangementtype2011="PRGF" if year>=2005 & year<=2009 & ifscode==638
replace arrangementtype2011="ECF" if year>=2010 & year<=2014 & ifscode==638
replace arrangementtype2011="PRGF" if year>=2003 & year<=2006 & ifscode==748
replace arrangementtype2011="PRGF" if year>=2007 & year<=2010 & ifscode==748
replace arrangementtype2011="ECF" if year>=2010 & year<=2013 & ifscode==748
replace arrangementtype2011="PRGF" if year>=2004 & year<=2008 & ifscode==618
replace arrangementtype2011="PRGF" if year>=2008 & year<=2012 & ifscode==618
replace arrangementtype2011="PRGF" if year>=2005 & year<=2009 & ifscode==622
replace arrangementtype2011="PRGF" if year>=2002 & year<=2005 & ifscode==624
replace arrangementtype2011="PSI" if year>=2006 & year<=2010 & ifscode==624
replace arrangementtype2011="PSI" if year>=2010 & year<=2012 & ifscode==624
replace arrangementtype2011="PRGF" if year>=2006 & year<=2010 & ifscode==626
replace arrangementtype2011="PRGF" if year>=2005 & year<=2008 & ifscode==628
replace arrangementtype2011="PRGF" if year>=2009 & year<=2013 & ifscode==632
replace arrangementtype2011="PRGF" if year>=2004 & year<=2008 & ifscode==634
replace arrangementtype2011="PRGF" if year>=2008 & year<=2011 & ifscode==634
replace arrangementtype2011="PRGF" if year>=2009 & year<=2012 & ifscode==636
replace arrangementtype2011="PRGF" if year>=2002 & year<=2005 & ifscode==662
replace arrangementtype2011="PRGF" if year>=2009 & year<=2011 & ifscode==662
replace arrangementtype2011="PRGF" if year>=2008 & year<=2012 & ifscode==611
replace arrangementtype2011="PRGF" if year>=2003 & year<=2006 & ifscode==321
replace arrangementtype2011="ESF" if year>=2009 & year<=2010 & ifscode==644
replace arrangementtype2011="PRGF" if year>=2002 & year<=2005 & ifscode==648
replace arrangementtype2011="PRGF" if year>=2007 & year<=2011 & ifscode==648
replace arrangementtype2011="PRGF" if year>=2004 & year<=2007 & ifscode==915
replace arrangementtype2011="PRGF" if year>=2003 & year<=2006 & ifscode==652
replace arrangementtype2011="PRGF" if year>=2009 & year<=2012 & ifscode==652
replace arrangementtype2011="PRGF" if year>=2006 & year<=2010 & ifscode==328
replace arrangementtype2011="ECF" if year>=2010 & year<=2013 & ifscode==328
replace arrangementtype2011="PRGF" if year>=2007 & year<=2010 & ifscode==656
replace arrangementtype2011="ECF" if year>=2010 & year<=2013 & ifscode==654
replace arrangementtype2011="PRGF" if year>=2006 & year<=2010 & ifscode==263
replace arrangementtype2011="ECF" if year>=2010 & year<=2014 & ifscode==263
replace arrangementtype2011="PRGF" if year>=2004 & year<=2007 & ifscode==268
replace arrangementtype2011="SBA-SCF" if year>=2010 & year<=2012 & ifscode==268
replace arrangementtype2011="PRGF" if year>=2003 & year<=2007 & ifscode==664
replace arrangementtype2011="ECF" if year>=2011 & year<=2014 & ifscode==664
replace arrangementtype2011="PRGF" if year>=2005 & year<=2008 & ifscode==917
replace arrangementtype2011="ESF" if year>=2008 & year<=2010 & ifscode==917
replace arrangementtype2011="ECF" if year>=2011 & year<=2014 & ifscode==917
replace arrangementtype2011="ECF" if year>=2010 & year<=2013 & ifscode==666
replace arrangementtype2011="PRGF-EFF" if year>=2008 & year<=2012 & ifscode==668
replace arrangementtype2011="PRGF" if year>=2006 & year<=2009 & ifscode==674
replace arrangementtype2011="PRGF" if year>=2005 & year<=2008 & ifscode==676
replace arrangementtype2011="ESF" if year>=2008 & year<=2009 & ifscode==676
replace arrangementtype2011="ECF" if year>=2010 & year<=2012 & ifscode==676
replace arrangementtype2011="PRGF" if year>=2004 & year<=2007 & ifscode==678
replace arrangementtype2011="PRGF" if year>=2008 & year<=2011 & ifscode==678
replace arrangementtype2011="PRGF" if year>=2003 & year<=2004 & ifscode==682
replace arrangementtype2011="PRGF" if year>=2006 & year<=2009 & ifscode==682
replace arrangementtype2011="ECF" if year>=2010 & year<=2013 & ifscode==682
replace arrangementtype2011="PRGF" if year>=2006 & year<=2009 & ifscode==921
replace arrangementtype2011="ECF-EFF" if year>=2010 & year<=2013 & ifscode==921
replace arrangementtype2011="PRGF" if year>=2004 & year<=2007 & ifscode==688
replace arrangementtype2011="PSI" if year>=2007 & year<=2010 & ifscode==688
replace arrangementtype2011="PSI" if year>=2010 & year<=2013 & ifscode==688
replace arrangementtype2011="PRGF" if year>=2003 & year<=2007 & ifscode==558
replace arrangementtype2011="PRGF" if year>=2002 & year<=2006 & ifscode==278
replace arrangementtype2011="PRGF" if year>=2007 & year<=2011 & ifscode==278
replace arrangementtype2011="PRGF" if year>=2005 & year<=2008 & ifscode==692
replace arrangementtype2011="PRGF" if year>=2008 & year<=2011 & ifscode==692
replace arrangementtype2011="PSI" if year>=2005	& year<=2007 & ifscode==694
replace arrangementtype2011="PRGF" if year>=2002 & year<=2006 & ifscode==714
replace arrangementtype2011="PRGF" if year>=2006 & year<=2009 & ifscode==714
replace arrangementtype2011="PSI" if year>=2010	& year<=2013 & ifscode==714
replace arrangementtype2011="PRGF" if year>=2005 & year<=2008 & ifscode==716
replace arrangementtype2011="PRGF" if year>=2009 & year<=2012 & ifscode==716
replace arrangementtype2011="PRGF" if year>=2003 & year<=2006 & ifscode==722
replace arrangementtype2011="PSI" if year>=2007 & year<=2010 & ifscode==722
replace arrangementtype2011="PSI" if year>=2010 & year<=2014 & ifscode==722
replace arrangementtype2011="PRGF" if year>=2001 & year<=2005 & ifscode==724
replace arrangementtype2011="PRGF" if year>=2006 & year<=2010 & ifscode==724
replace arrangementtype2011="ECF" if year>=2010 & year<=2013 & ifscode==724
replace arrangementtype2011="SCF" if year>=2010 & year<=2011 & ifscode==813
replace arrangementtype2011="PRGF-EFF" if year>=2003 & year<=2006 & ifscode==524
replace arrangementtype2011="PRGF" if year>=2002 & year<=2006 & ifscode==923
replace arrangementtype2011="PRGF" if year>=2009 & year<=2012 & ifscode==923
replace arrangementtype2011="PRGF" if year>=2000 & year<=2003 & ifscode==738
replace arrangementtype2011="PRGF" if year>=2003 & year<=2007 & ifscode==738
replace arrangementtype2011="PSI" if year>=2007 & year<=2010 & ifscode==738
replace arrangementtype2011="PSI" if year>=2010 & year<=2013 & ifscode==738
replace arrangementtype2011="PRGF" if year>=2008 & year<=2011 & ifscode==742
replace arrangementtype2011="PRGF" if year>=2002 & year<=2006 & ifscode==746
replace arrangementtype2011="PSI" if year>=2006 & year<=2007 & ifscode==746
replace arrangementtype2011="PSI" if year>=2006 & year<=2010 & ifscode==746
replace arrangementtype2011="PSI" if year>=2010 & year<=2013 & ifscode==746
replace arrangementtype2011="ECF" if year>=2010 & year<=2012 & ifscode==474
replace arrangementtype2011="PRGF" if year>=2004 & year<=2007 & ifscode==754
replace arrangementtype2011="PRGF" if year>=2008 & year<=2011 & ifscode==754




gen GRA2011	= 0
replace GRA2011 =1 if year>=2009 & year<=2012 & country=="Angola"
replace GRA2011=1 if year>=	2010 & year<=2013 & country=="Antigua and Barbuda"
replace GRA2011=1 if year>=	2003 & year<=2003 & country=="Argentina"
replace GRA2011=1 if year>=	2009 & year<=2010 & country=="Armenia"
replace GRA2011=1 if year>=	2009 & year<=2010 & country=="Belarus"
replace GRA2011=1 if year>=	2003 & year<=2006 & country=="Bolivia"
replace GRA2011=1 if year>=	2002 & year<=2004 & country=="Bosnia and Herzegovina" 
replace GRA2011=1 if year>=	2009 & year<=2012 & country=="Bosnia and Herzegovina"
replace GRA2011=1 if year>=	2002 & year<=2005 & country=="Brazil"
replace GRA2011=1 if year>=	2004 & year<=2007 & country=="Bulgaria"
replace GRA2011=1 if year>=	2003 & year<=2005 & country=="Colombia"
replace GRA2011=1 if year>=	2005 & year<=2006 & country=="Colombia"
replace GRA2011=1 if year>=	2009 & year<=2010 & country=="Costa Rica"
replace GRA2011=1 if year>=	2003 & year<=2004 & country=="Croatia"
replace GRA2011=1 if year>=	2004 & year<=2006 & country=="Croatia"
replace GRA2011=1 if year>=	2002 & year<=2004 & country=="Dominica"
replace GRA2011=1 if year>=	2003 & year<=2005 & country=="Dominican Republic"
replace GRA2011=1 if year>=	2005 & year<=2008 & country=="Dominican Republic"
replace GRA2011=1 if year>=	2009 & year<=2012 & country=="Dominican Republic"
replace GRA2011=1 if year>=	2003 & year<=2004 & country=="Ecuador"
replace GRA2011=1 if year>=	2009 & year<=2010 & country=="El Salvador"
replace GRA2011=1 if year>=	2010 & year<=2013 & country=="El Salvador"
replace GRA2011=1 if year>=	2004 & year<=2005 & country=="Gabon"
replace GRA2011=1 if year>=	2007 & year<=2010 & country=="Gabon"
replace GRA2011=1 if year>=	2008 & year<=2011 & country=="Georgia"
replace GRA2011=1 if year>=	2010 & year<=2012 & country=="Greece"
replace GRA2011=1 if year>=	2002 & year<=2003 & country=="Guatemala"
replace GRA2011=1 if year>=	2003 & year<=2004 & country=="Guatemala"
replace GRA2011=1 if year>=	2009 & year<=2010 & country=="Guatemala"
replace GRA2011=1 if year>=	2008 & year<=2009 & country=="Honduras"
replace GRA2011=1 if year>=	2008 & year<=2010 & country=="Hungary"
replace GRA2011=1 if year>=	2008 & year<=2011 & country=="Iceland"
replace GRA2011=1 if year>=	2005 & year<=2007 & country=="Iraq"
replace GRA2011=1 if year>=	2007 & year<=2009 & country=="Iraq"
replace GRA2011=1 if year>=	2010 & year<=2013 & country=="Iraq"
replace GRA2011=1 if year>=	2010 & year<=2013 & country=="Ireland"
replace GRA2011=1 if year>=	2010 & year<=2012 & country=="Jamaica"
replace GRA2011=1 if year>=	2002 & year<=2004 & country=="Jordan"
replace GRA2011=1 if year>=	2010 & year<=2012 & country=="Kosovo"
replace GRA2011=1 if year>=	2008 & year<=2011 & country=="Latvia"
replace GRA2011=1 if year>=	2005 & year<=2008 & country=="Macedonia, FYR"
replace GRA2011=1 if year>=	2009 & year<=2012 & country=="Maldives"
replace GRA2011=1 if year>=	2009 & year<=2010 & country=="Mongolia"
replace GRA2011=1 if year>=	2008 & year<=2011 & country=="Pakistan"
replace GRA2011=1 if year>=	2003 & year<=2005 & country=="Paraguay"
replace GRA2011=1 if year>=	2006 & year<=2008 & country=="Paraguay"
replace GRA2011=1 if year>=	2004 & year<=2006 & country=="Peru"
replace GRA2011=1 if year>=	2007 & year<=2009 & country=="Peru"
replace GRA2011=1 if year>=	2011 & year<=2014 & country=="Portugal"
replace GRA2011=1 if year>=	2004 & year<=2006 & country=="Romania"
replace GRA2011=1 if year>=	2009 & year<=2011 & country=="Romania"
replace GRA2011=1 if year>=	2011 & year<=2013 & country=="Romania"
replace GRA2011=1 if year>=	2009 & year<=2011 & country=="Serbia"
replace GRA2011=1 if year>=	2011 & year<=2013 & country=="Serbia"
replace GRA2011=1 if year>=	2008 & year<=2009 & country=="Seychelles"
replace GRA2011=1 if year>=	2009 & year<=2013 & country=="Seychelles"
replace GRA2011=1 if year>=	2009 & year<=2012 & country=="Sri Lanka"
replace GRA2011=1 if year>=	2011 & year<=2014 & country=="St. Kitts and Nevis"
replace GRA2011=1 if year>=	2005 & year<=2008 & country=="Turkey"
replace GRA2011=1 if year>=	2004 & year<=2005 & country=="Ukraine"
replace GRA2011=1 if year>=	2008 & year<=2010 & country=="Ukraine"
replace GRA2011=1 if year>=	2010 & year<=2012 & country=="Ukraine"
replace GRA2011=1 if year>=	2002 & year<=2005 & country=="Uruguay"
replace GRA2011=1 if year>=	2005 & year<=2006 & country=="Uruguay"


gen PRGT2011= 0
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==512
replace PRGT2011=1 if year>=2002 & year<=2005 & ifscode==914
replace PRGT2011=1 if year>=2006 & year<=2009 & ifscode==914
replace PRGT2011=1 if year>=2005 & year<=2008 & ifscode==911
replace PRGT2011=1 if year>=2008 & year<=2009 & ifscode==911
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==911
replace PRGT2011=1 if year>=2003 & year<=2007 & ifscode==513
replace PRGT2011=1 if year>=2005 & year<=2009 & ifscode==638
replace PRGT2011=1 if year>=2010 & year<=2014 & ifscode==638
replace PRGT2011=1 if year>=2003 & year<=2006 & ifscode==748
replace PRGT2011=1 if year>=2007 & year<=2010 & ifscode==748
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==748
replace PRGT2011=1 if year>=2004 & year<=2008 & ifscode==618
replace PRGT2011=1 if year>=2008 & year<=2012 & ifscode==618
replace PRGT2011=1 if year>=2005 & year<=2009 & ifscode==622
replace PRGT2011=1 if year>=2002 & year<=2005 & ifscode==624
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==624
replace PRGT2011=1 if year>=2010 & year<=2012 & ifscode==624
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==626
replace PRGT2011=1 if year>=2005 & year<=2008 & ifscode==628
replace PRGT2011=1 if year>=2009 & year<=2013 & ifscode==632
replace PRGT2011=1 if year>=2004 & year<=2008 & ifscode==634
replace PRGT2011=1 if year>=2008 & year<=2011 & ifscode==634
replace PRGT2011=1 if year>=2009 & year<=2012 & ifscode==636
replace PRGT2011=1 if year>=2002 & year<=2005 & ifscode==662
replace PRGT2011=1 if year>=2009 & year<=2011 & ifscode==662
replace PRGT2011=1 if year>=2008 & year<=2012 & ifscode==611
replace PRGT2011=1 if year>=2003 & year<=2006 & ifscode==321
replace PRGT2011=1 if year>=2009 & year<=2010 & ifscode==644
replace PRGT2011=1 if year>=2002 & year<=2005 & ifscode==648
replace PRGT2011=1 if year>=2007 & year<=2011 & ifscode==648
replace PRGT2011=1 if year>=2004 & year<=2007 & ifscode==915
replace PRGT2011=1 if year>=2003 & year<=2006 & ifscode==652
replace PRGT2011=1 if year>=2009 & year<=2012 & ifscode==652
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==328
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==328
replace PRGT2011=1 if year>=2007 & year<=2010 & ifscode==656
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==654
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==263
replace PRGT2011=1 if year>=2010 & year<=2014 & ifscode==263
replace PRGT2011=1 if year>=2004 & year<=2007 & ifscode==268
replace PRGT2011=1 if year>=2010 & year<=2012 & ifscode==268
replace PRGT2011=1 if year>=2003 & year<=2007 & ifscode==664
replace PRGT2011=1 if year>=2011 & year<=2014 & ifscode==664
replace PRGT2011=1 if year>=2005 & year<=2008 & ifscode==917
replace PRGT2011=1 if year>=2008 & year<=2010 & ifscode==917
replace PRGT2011=1 if year>=2011 & year<=2014 & ifscode==917
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==666
replace PRGT2011=1 if year>=2008 & year<=2012 & ifscode==668
replace PRGT2011=1 if year>=2006 & year<=2009 & ifscode==674
replace PRGT2011=1 if year>=2005 & year<=2008 & ifscode==676
replace PRGT2011=1 if year>=2008 & year<=2009 & ifscode==676
replace PRGT2011=1 if year>=2010 & year<=2012 & ifscode==676
replace PRGT2011=1 if year>=2004 & year<=2007 & ifscode==678
replace PRGT2011=1 if year>=2008 & year<=2011 & ifscode==678
replace PRGT2011=1 if year>=2003 & year<=2004 & ifscode==682
replace PRGT2011=1 if year>=2006 & year<=2009 & ifscode==682
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==682
replace PRGT2011=1 if year>=2006 & year<=2009 & ifscode==921
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==921
replace PRGT2011=1 if year>=2004 & year<=2007 & ifscode==688
replace PRGT2011=1 if year>=2007 & year<=2010 & ifscode==688
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==688
replace PRGT2011=1 if year>=2003 & year<=2007 & ifscode==558
replace PRGT2011=1 if year>=2002 & year<=2006 & ifscode==278
replace PRGT2011=1 if year>=2007 & year<=2011 & ifscode==278
replace PRGT2011=1 if year>=2005 & year<=2008 & ifscode==692
replace PRGT2011=1 if year>=2008 & year<=2011 & ifscode==692
replace PRGT2011=1 if year>=2005 & year<=2007 & ifscode==694
replace PRGT2011=1 if year>=2002 & year<=2006 & ifscode==714
replace PRGT2011=1 if year>=2006 & year<=2009 & ifscode==714
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==714
replace PRGT2011=1 if year>=2005 & year<=2008 & ifscode==716
replace PRGT2011=1 if year>=2009 & year<=2012 & ifscode==716
replace PRGT2011=1 if year>=2003 & year<=2006 & ifscode==722
replace PRGT2011=1 if year>=2007 & year<=2010 & ifscode==722
replace PRGT2011=1 if year>=2010 & year<=2014 & ifscode==722
replace PRGT2011=1 if year>=2001 & year<=2005 & ifscode==724
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==724
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==724
replace PRGT2011=1 if year>=2010 & year<=2011 & ifscode==813
replace PRGT2011=1 if year>=2003 & year<=2006 & ifscode==524
replace PRGT2011=1 if year>=2002 & year<=2006 & ifscode==923
replace PRGT2011=1 if year>=2009 & year<=2012 & ifscode==923
replace PRGT2011=1 if year>=2000 & year<=2003 & ifscode==738
replace PRGT2011=1 if year>=2003 & year<=2007 & ifscode==738
replace PRGT2011=1 if year>=2007 & year<=2010 & ifscode==738
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==738
replace PRGT2011=1 if year>=2008 & year<=2011 & ifscode==742
replace PRGT2011=1 if year>=2002 & year<=2006 & ifscode==746
replace PRGT2011=1 if year>=2006 & year<=2007 & ifscode==746
replace PRGT2011=1 if year>=2006 & year<=2010 & ifscode==746
replace PRGT2011=1 if year>=2010 & year<=2013 & ifscode==746
replace PRGT2011=1 if year>=2010 & year<=2012 & ifscode==474
replace PRGT2011=1 if year>=2004 & year<=2007 & ifscode==754
replace PRGT2011=1 if year>=2008 & year<=2011 & ifscode==754



gen hadprogram= 0 

replace hadprogram= 1 if country=="Angola"
replace hadprogram= 1 if country=="Antigua and Barbuda"
replace hadprogram =1 if country=="Argentina"
replace hadprogram =1 if country=="Armenia"
replace hadprogram =1 if country=="Belarus"
replace hadprogram =1 if country=="Bolivia"
replace hadprogram =1 if country=="Bosnia and Herzegovina"
replace hadprogram =1 if country=="Brazil"
replace hadprogram =1 if country=="Bulgaria"
replace hadprogram =1 if country=="Colombia"
replace hadprogram =1 if country=="Costa Rica"
replace hadprogram =1 if country=="Croatia"
replace hadprogram =1 if country=="Dominica"
replace hadprogram =1 if country=="Dominican Republic"
replace hadprogram =1 if country=="Ecuador"
replace hadprogram =1 if country=="El Salvador"
replace hadprogram =1 if country=="Gabon"
replace hadprogram =1 if country=="Georgia"
replace hadprogram =1 if country=="Greece"
replace hadprogram =1 if country=="Guatemala"
replace hadprogram =1 if country=="Honduras"
replace hadprogram =1 if country=="Hungary"
replace hadprogram =1 if country=="Iceland"
replace hadprogram =1 if country=="Iraq"
replace hadprogram =1 if country=="Ireland"
replace hadprogram =1 if country=="Jamaica"
replace hadprogram =1 if country=="Jordan"
replace hadprogram =1 if country=="Kosovo"
replace hadprogram =1 if country=="Latvia"
replace hadprogram =1 if country=="Macedonia, FYR"
replace hadprogram =1 if country=="Maldives"
replace hadprogram =1 if country=="Mongolia"
replace hadprogram =1 if country=="Pakistan"
replace hadprogram =1 if country=="Paraguay"
replace hadprogram =1 if country=="Peru"
replace hadprogram =1 if country=="Portugal"
replace hadprogram =1 if country=="Romania"
replace hadprogram =1 if country=="Serbia"
replace hadprogram =1 if country=="Seychelles"
replace hadprogram =1 if country=="Sri Lanka"
replace hadprogram =1 if country=="St. Kitts and Nevis"
replace hadprogram =1 if country=="Turkey"
replace hadprogram =1 if country=="Ukraine"
replace hadprogram =1 if country=="Uruguay"
replace hadprogram =1 if country=="Afghanistan"
replace hadprogram =1 if country=="Albania"
replace hadprogram =1 if country=="Bangladesh"
replace hadprogram =1 if country=="Benin"
replace hadprogram =1 if country=="Burkina Faso"
replace hadprogram =1 if country=="Burundi"
replace hadprogram =1 if country=="Cameroon"
replace hadprogram =1 if country=="Cabo Verde"
replace hadprogram =1 if country=="Central African Republic"
replace hadprogram =1 if country=="Chad"
replace hadprogram =1 if country=="Comoros"
replace hadprogram =1 if country=="Congo, Rep."
replace hadprogram =1 if country=="Congo,Dem. Rep."
replace hadprogram =1 if country=="Cote d'Ivoire"
replace hadprogram =1 if country=="Djibouti"
replace hadprogram =1 if country=="Ethiopia"
replace hadprogram =1 if country=="Gambia, The"
replace hadprogram =1 if country=="Ghana"
replace hadprogram =1 if country=="Grenada"
replace hadprogram =1 if country=="Guinea"
replace hadprogram =1 if country=="Guinea-Bissau"
replace hadprogram =1 if country=="Haiti"
replace hadprogram =1 if country=="Kenya"
replace hadprogram =1 if country=="Kyrgyz Republic"
replace hadprogram =1 if country=="Lesotho"
replace hadprogram =1 if country=="Liberia"
replace hadprogram =1 if country=="Madagascar"
replace hadprogram =1 if country=="Malawi"
replace hadprogram =1 if country=="Mali"
replace hadprogram =1 if country=="Mauritania"
replace hadprogram =1 if country=="Moldova"
replace hadprogram =1 if country=="Mozambique"
replace hadprogram =1 if country=="Nepal"
replace hadprogram =1 if country=="Nicaragua"
replace hadprogram =1 if country=="Niger"
replace hadprogram =1 if country=="Nigeria"
replace hadprogram =1 if country=="Rwanda"
replace hadprogram =1 if country=="Sao Tome and Principe"
replace hadprogram =1 if country=="Senegal"
replace hadprogram =1 if country=="Sierra Leone"
replace hadprogram =1 if country=="Solomon Islands"
replace hadprogram =1 if country=="Tajikistan"
replace hadprogram =1 if country=="Tanzania"
replace hadprogram =1 if country=="Togo"
replace hadprogram =1 if country=="Uganda"
replace hadprogram =1 if country=="Yemen,Rep."
replace hadprogram =1 if country=="Zambia"
replace hadprogram =1 if country=="Serbia"
replace hadprogram =1 if country=="Morocco"
replace hadprogram =1 if country=="Cyprus"
replace hadprogram =1 if country=="Tunisia"
replace hadprogram =1 if country=="Suriname"
replace hadprogram =1 if country=="Egypt, Arab Rep."


gen arragementall=arrangementtype
replace arragementall=arrangementtype2011 if arrangementtype2011!=""  

*Ratios
gen socialmratio = socialm/socialtotal if socialtotal!=0
gen socialmdratio = socialmd/socialtotal if socialtotal!=0
gen socialnmratio = socialnm/socialtotal if socialtotal!=0
gen pensionmratio = pensionm/pensiontotal if pensiontotal!=0
gen pensionmdratio = pensionmd/pensiontotal if pensiontotal!=0
gen pensionnmratio = pensionnm/pensiontotal if pensiontotal!=0
gen othermratio = otherm/othertotal if othertotal!=0
gen othermdratio = othermd/othertotal if othertotal!=0
gen othernmratio = othernm/othertotal if othertotal!=0

label var socialm "number of social SBs met"
label var pensionm "number of pension related SBs met"
label var otherm "number of other SBs met" 
label var socialmd "number of social SBs met with delay"
label var pensionmd "number of pension related SBs met with delay"
label var othermd "number of other SBs met with delay" 
label var socialnm "number of social SBs not met"
label var pensionnm "number of pension related SBs not met"
label var othernm "number of other SBs not met" 
label var socialtotal "total number of social SBs"
label var pensiontotal "total number of pension SBs"
label var othertotal "total number of other SBs" 
label var itmet "ITs met"
label var itnotmet "ITs not met"
label var consolidation_prog "Projected consolidation"
label var consolidation_actu "Actual consolidation"
label var GRA "Dummy for whether the country is a GRA country - value 0 means the country is PRGT elgibile"
label var blend "Corresponds to program dummy - Takes the value 1 if the country had a blend program in that year"
label var arragementall "Type of arrangement the country had in that year irrespective of ROC Sample"
label var arrangementtype "Corresponds to program dummy - type of arrangement the country had in that year"
label var hadprogram "Dummy for if the country had a program in any year"
label var socialmratio "Ratio of social SBs met to total"
label var socialmdratio "Ratio of social SBs met with delay to total"
label var socialnmratio "Ratio of social SBs not met to total"
label var pensionmratio "Ratio of pension related SBs met to total"
label var pensionmdratio "Ratio of pension related SBs met with delay to total"
label var pensionnmratio "Ratio of pension related SBs not met to total"
label var othermratio "Ratio of other SBs met to total"
label var othermdratio "Ratio of other SBs met with delay to total"
label var othernmratio "Ratio of other SBs not met to total"
label var arrangementtype2011 "Type of program the country had in each year in the 2011 ROC Sample"
label var GRA2011 "Dummy for the years in which the country had a GRA program in the 2011 ROC sample"
label var PRGT2011 "Dummy for the years in which the country had a PRGT program in the 2011 ROC sample"

gen arrangementtype2018 =""
label var arrangementtype2018 "Type of program the country had in each year in the 2018 ROC Sample"
replace arrangementtype2018="EFF" if year>= 2014 & year<= 2017 & ifscode==914
replace arrangementtype2018="SBA" if year>=	2009 & year<= 2012 & ifscode==614
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2013 & ifscode==311
replace arrangementtype2018="EFF" if year>=	2014 & year<= 2017 & ifscode==911
replace arrangementtype2018="SBA" if year>=	2009 & year<= 2012 & ifscode==963
replace arrangementtype2018="SBA" if year>=	2012 & year<= 2015 & ifscode==963
replace arrangementtype2018="EFF" if year>=	2016 & year<= 2020 & ifscode==963
replace arrangementtype2018="EFF" if year>=	2013 & year<= 2016 & ifscode==423
replace arrangementtype2018="SBA" if year>=	2009 & year<= 2012 & ifscode==243
replace arrangementtype2018="EFF" if year>=	2016 & year<= 2019 & ifscode==469
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2013 & ifscode==253
replace arrangementtype2018="EFF" if year>=	2017 & year<= 2020 & ifscode==646
replace arrangementtype2018="SBA" if year>=	2014 & year<= 2017 & ifscode==915
replace arrangementtype2018="EFF" if year>=	2017 & year<= 2020 & ifscode==915
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2012 & ifscode==174
replace arrangementtype2018="EFF" if year>=	2012 & year<= 2016 & ifscode==174
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2013 & ifscode==433
replace arrangementtype2018="SBA" if year>=	2016 & year<= 2019 & ifscode==433
replace arrangementtype2018="EFF" if year>=	2010 & year<= 2013 & ifscode==178
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2012 & ifscode==343
replace arrangementtype2018="EFF" if year>=	2013 & year<= 2016 & ifscode==343
replace arrangementtype2018="SBA" if year>=	2016 & year<= 2019 & ifscode==343
replace arrangementtype2018="SBA" if year>=	2012 & year<= 2015 & ifscode==439
replace arrangementtype2018="EFF" if year>=	2016 & year<= 2019 & ifscode==439
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2012 & ifscode==967
replace arrangementtype2018="SBA" if year>=	2012 & year<= 2013 & ifscode==967
replace arrangementtype2018="SBA" if year>=	2015 & year<= 2017 & ifscode==967
replace arrangementtype2018="SBA" if year>=	2008 & year<= 2011 & ifscode==941
replace arrangementtype2018="PCL" if year>=	2011 & year<= 2013 & ifscode==962
replace arrangementtype2018="SBA" if year>=	2009 & year<= 2012 & ifscode==556
replace arrangementtype2018="EFF" if year>=	2017 & year<= 2020 & ifscode==948
replace arrangementtype2018="PLL" if year>=	2012 & year<= 2014 & ifscode==686
replace arrangementtype2018="PLL" if year>=	2014 & year<= 2016 & ifscode==686
replace arrangementtype2018="PLL" if year>=	2016 & year<= 2018 & ifscode==686
replace arrangementtype2018="EFF" if year>=	2013 & year<= 2016 & ifscode==564
replace arrangementtype2018="EFF" if year>=	2011 & year<= 2014 & ifscode==182
replace arrangementtype2018="SBA" if year>=	2011 & year<= 2013 & ifscode==968
replace arrangementtype2018="SBA" if year>=	2013 & year<= 2015 & ifscode==968
replace arrangementtype2018="SBA" if year>=	2011 & year<= 2013 & ifscode==942
replace arrangementtype2018="SBA" if year>=	2015 & year<= 2018 & ifscode==942
replace arrangementtype2018="EFF" if year>=	2009 & year<= 2013 & ifscode==718
replace arrangementtype2018="EFF" if year>=	2014 & year<= 2017 & ifscode==718
replace arrangementtype2018="PCI" if year>=	2017 & year<= 2020 & ifscode==718
replace arrangementtype2018="SBA" if year>=	2009 & year<= 2012 & ifscode==524
replace arrangementtype2018="EFF" if year>=	2016 & year<= 2019 & ifscode==524
replace arrangementtype2018="SBA" if year>=	2011 & year<= 2014 & ifscode==361
replace arrangementtype2018="SBA" if year>=	2016 & year<= 2017 & ifscode==366
replace arrangementtype2018="SBA" if year>=	2013 & year<= 2015 & ifscode==744
replace arrangementtype2018="EFF" if year>=	2016 & year<= 2020 & ifscode==744
replace arrangementtype2018="SBA" if year>=	2010 & year<= 2012 & ifscode==926
replace arrangementtype2018="SBA" if year>=	2014 & year<= 2015 & ifscode==926
replace arrangementtype2018="EFF" if year>=	2015 & year<= 2019 & ifscode==926
replace arrangementtype2018="ECF" if year>=	2011 & year<= 2014 & ifscode==512
replace arrangementtype2018="ECF" if year>=	2016 & year<= 2019 & ifscode==512
replace arrangementtype2018="ECF-EFF" if year>=	2010 & year<= 2013 & ifscode==911
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2015 & ifscode==513
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2014 & ifscode==638
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==638
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2013 & ifscode==748
replace arrangementtype2018="ECF" if year>=	2013 & year<= 2017 & ifscode==748
replace arrangementtype2018="PRGF" if year>=2008 & year<= 2012 & ifscode==618
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2016 & ifscode==618
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==622
replace arrangementtype2018="PSI" if year>=	2010 & year<= 2012 & ifscode==624
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2014 & ifscode==626
replace arrangementtype2018="ECF" if year>=	2016 & year<= 2019 & ifscode==626
replace arrangementtype2018="ECF" if year>=	2014 & year<= 2017 & ifscode==628
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==628
replace arrangementtype2018="PRGF" if year>=2009 & year<= 2013 & ifscode==632
replace arrangementtype2018="PRGF" if year>=2009 & year<= 2012 & ifscode==636
replace arrangementtype2018="ECF" if year>=	2011 & year<= 2015 & ifscode==662
replace arrangementtype2018="ECF-EFF" if year>=2016 & year <= 2019 & ifscode==662
replace arrangementtype2018="PRGF" if year>=2008 & year<= 2012 & ifscode==611
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2015 & ifscode==648
replace arrangementtype2018="SBA-SCF" if year>=	2012 & year<= 2014 & ifscode==915
replace arrangementtype2018="PRGF" if year>=2009 & year<= 2012 & ifscode==652
replace arrangementtype2018="ECF" if year>=	2015 & year<= 2019 & ifscode==652
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2013 & ifscode==328
replace arrangementtype2018="ECF" if year>=	2014 & year<= 2017 & ifscode==328
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2016 & ifscode==656
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==656
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2013 & ifscode==654
replace arrangementtype2018="ECF" if year>=	2015 & year<= 2018 & ifscode==654
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2014 & ifscode==263
replace arrangementtype2018="ECF" if year>=	2015 & year<= 2016 & ifscode==263
replace arrangementtype2018="SBA-SCF" if year>=	2010 & year<= 2012 & ifscode==268
replace arrangementtype2018="SBA-SCF" if year>=	2014 & year<= 2016 & ifscode==268
replace arrangementtype2018="ECF" if year>=	2011 & year<= 2014 & ifscode==664
replace arrangementtype2018="SBA-SCF" if year>=	2015 & year<= 2016 & ifscode==664
replace arrangementtype2018="SBA-SCF" if year>=	2016 & year<= 2018 & ifscode==664
replace arrangementtype2018="ECF" if year>=	2011 & year<= 2014 & ifscode==917
replace arrangementtype2018="ECF" if year>=	2015 & year<= 2018 & ifscode==917
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2013 & ifscode==666
replace arrangementtype2018="PRGF-EFF" if year>=2008 & year<= 2012 & ifscode==668
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2017 & ifscode==668
replace arrangementtype2018="ECF" if year>=	2016 & year<= 2019 & ifscode==674
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2012 & ifscode==676
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2017 & ifscode==676
replace arrangementtype2018="PRGF" if year>=2008 & year<= 2011 & ifscode==678
replace arrangementtype2018="ECF" if year>=	2011 & year<= 2013 & ifscode==678
replace arrangementtype2018="ECF" if year>=	2013 & year<= 2018 & ifscode==678
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2013 & ifscode==682
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==682
replace arrangementtype2018="ECF-EFF" if year>=	2010 & year<= 2013 & ifscode==921
replace arrangementtype2018="ECF-EFF" if year>=	2016 & year<= 2019 & ifscode==921
replace arrangementtype2018="PSI" if year>=	2010 & year<= 2013 & ifscode==688
replace arrangementtype2018="PSI" if year>=	2013 & year<= 2016 & ifscode==688
replace arrangementtype2018="SCF" if year>=	2015 & year<= 2017 & ifscode==688
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2016 & ifscode==692
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==692
replace arrangementtype2018="PSI" if year>=	2010 & year<= 2013 & ifscode==714
replace arrangementtype2018="PSI" if year>=	2013 & year<= 2018 & ifscode==714
replace arrangementtype2018="SCF" if year>=	2016 & year<= 2018 & ifscode==714
replace arrangementtype2018="PRGF" if year>=2009 & year<= 2012 & ifscode==716
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2015 & ifscode==716
replace arrangementtype2018="ECF" if year>=	2015 & year<= 2018 & ifscode==716
replace arrangementtype2018="PSI" if year>=	2010 & year<= 2014 & ifscode==722
replace arrangementtype2018="PSI" if year>=	2015 & year<= 2019 & ifscode==722
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2013 & ifscode==724
replace arrangementtype2018="ECF" if year>=	2013 & year<= 2016 & ifscode==724
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==724
replace arrangementtype2018="SCF" if year>=	2010 & year<= 2011 & ifscode==813
replace arrangementtype2018="SCF" if year>=	2011 & year<= 2012 & ifscode==813
replace arrangementtype2018="ECF" if year>=	2012 & year<= 2016 & ifscode==813
replace arrangementtype2018="PRGF" if year>=2009 & year<= 2012 & ifscode==923
replace arrangementtype2018="PSI" if year>=	2010 & year<= 2013 & ifscode==738
replace arrangementtype2018="SCF" if year>=	2012 & year<= 2014 & ifscode==738
replace arrangementtype2018="PSI" if year>=	2014 & year<= 2018 & ifscode==738
replace arrangementtype2018="ECF" if year>=	2017 & year<= 2020 & ifscode==742
replace arrangementtype2018="PSI" if year>=	2010 & year<= 2013 & ifscode==746
replace arrangementtype2018="PSI" if year>=	2013 & year<= 2017 & ifscode==746
replace arrangementtype2018="ECF" if year>=	2010 & year<= 2012 & ifscode==459
replace arrangementtype2018="ECF" if year>=	2014 & year<= 2016 & ifscode==459
 
 
gen GRA2018 = 0
label var GRA2018 "Dummy for the years in which a country had a GRA program in 2018 ROC sample"
replace GRA2018= 1 if year>= 2014 & year<= 2017 & ifscode==914
replace GRA2018= 1 if year>= 2009 & year<= 2012 & ifscode==614
replace GRA2018= 1 if year>= 2010 & year<= 2013 & ifscode==311
replace GRA2018= 1 if year>= 2014 & year<= 2017 & ifscode==911
replace GRA2018= 1 if year>= 2009 & year<= 2012 & ifscode==963
replace GRA2018= 1 if year>= 2012 & year<= 2015 & ifscode==963
replace GRA2018= 1 if year>= 2016 & year<= 2020 & ifscode==963
replace GRA2018= 1 if year>= 2013 & year<= 2016 & ifscode==423
replace GRA2018= 1 if year>= 2009 & year<= 2012 & ifscode==243
replace GRA2018= 1 if year>= 2016 & year<= 2019 & ifscode==469
replace GRA2018= 1 if year>= 2010 & year<= 2013 & ifscode==253
replace GRA2018= 1 if year>= 2017 & year<= 2020 & ifscode==646
replace GRA2018= 1 if year>= 2014 & year<= 2017 & ifscode==915
replace GRA2018= 1 if year>= 2017 & year<= 2020 & ifscode==915
replace GRA2018= 1 if year>= 2010 & year<= 2012 & ifscode==174
replace GRA2018= 1 if year>= 2012 & year<= 2016 & ifscode==174
replace GRA2018= 1 if year>= 2010 & year<= 2013 & ifscode==433
replace GRA2018= 1 if year>= 2016 & year<= 2019 & ifscode==433
replace GRA2018= 1 if year>= 2010 & year<= 2013 & ifscode==178
replace GRA2018= 1 if year>= 2010 & year<= 2012 & ifscode==343
replace GRA2018= 1 if year>= 2013 & year<= 2016 & ifscode==343
replace GRA2018= 1 if year>= 2016 & year<= 2019 & ifscode==343
replace GRA2018= 1 if year>= 2012 & year<= 2015 & ifscode==439
replace GRA2018= 1 if year>= 2016 & year<= 2019 & ifscode==439
replace GRA2018= 1 if year>= 2010 & year<= 2012 & ifscode==967
replace GRA2018= 1 if year>= 2012 & year<= 2013 & ifscode==967
replace GRA2018= 1 if year>= 2015 & year<= 2017 & ifscode==967
replace GRA2018= 1 if year>= 2008 & year<= 2011 & ifscode==941
replace GRA2018= 1 if year>= 2011 & year<= 2013 & ifscode==962
replace GRA2018= 1 if year>= 2009 & year<= 2012 & ifscode==556
replace GRA2018= 1 if year>= 2017 & year<= 2020 & ifscode==948
replace GRA2018= 1 if year>= 2012 & year<= 2014 & ifscode==686
replace GRA2018= 1 if year>= 2014 & year<= 2016 & ifscode==686
replace GRA2018= 1 if year>= 2016 & year<= 2018 & ifscode==686
replace GRA2018= 1 if year>= 2013 & year<= 2016 & ifscode==564
replace GRA2018= 1 if year>= 2011 & year<= 2014 & ifscode==182
replace GRA2018= 1 if year>= 2011 & year<= 2013 & ifscode==968
replace GRA2018= 1 if year>= 2013 & year<= 2015 & ifscode==968
replace GRA2018= 1 if year>= 2011 & year<= 2013 & ifscode==942
replace GRA2018= 1 if year>= 2015 & year<= 2018 & ifscode==942
replace GRA2018= 1 if year>= 2009 & year<= 2013 & ifscode==718
replace GRA2018= 1 if year>= 2014 & year<= 2017 & ifscode==718
replace GRA2018= 1 if year>= 2017 & year<= 2020 & ifscode==718
replace GRA2018= 1 if year>= 2009 & year<= 2012 & ifscode==524
replace GRA2018= 1 if year>= 2016 & year<= 2019 & ifscode==524
replace GRA2018= 1 if year>= 2011 & year<= 2014 & ifscode==361
replace GRA2018= 1 if year>= 2016 & year<= 2017 & ifscode==366
replace GRA2018= 1 if year>= 2013 & year<= 2015 & ifscode==744
replace GRA2018= 1 if year>= 2016 & year<= 2020 & ifscode==744
replace GRA2018= 1 if year>= 2010 & year<= 2012 & ifscode==926
replace GRA2018= 1 if year>= 2014 & year<= 2015 & ifscode==926
replace GRA2018= 1 if year>= 2015 & year<= 2019 & ifscode==926

gen PRGT2018 = 0 
label var PRGT2018 "Dummy for the years in which a country had a PRGT program in 2018 ROC sample"
replace PRGT2018 = 1 if year>= 2011 & year<= 2014 & ifscode==512
replace PRGT2018 = 1 if year>= 2016 & year<= 2019 & ifscode==512
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==911
replace PRGT2018 = 1 if year>= 2012 & year<= 2015 & ifscode==513
replace PRGT2018 = 1 if year>= 2010 & year<= 2014 & ifscode==638
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==638
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==748
replace PRGT2018 = 1 if year>= 2013 & year<= 2017 & ifscode==748
replace PRGT2018 = 1 if year>= 2008 & year<= 2012 & ifscode==618
replace PRGT2018 = 1 if year>= 2012 & year<= 2016 & ifscode==618
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==622
replace PRGT2018 = 1 if year>= 2010 & year<= 2012 & ifscode==624
replace PRGT2018 = 1 if year>= 2012 & year<= 2014 & ifscode==626
replace PRGT2018 = 1 if year>= 2016 & year<= 2019 & ifscode==626
replace PRGT2018 = 1 if year>= 2014 & year<= 2017 & ifscode==628
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==628
replace PRGT2018 = 1 if year>= 2009 & year<= 2013 & ifscode==632
replace PRGT2018 = 1 if year>= 2009 & year<= 2012 & ifscode==636
replace PRGT2018 = 1 if year>= 2011 & year<= 2015 & ifscode==662
replace PRGT2018 = 1 if year>= 2016 & year <= 2019 & ifscode==662
replace PRGT2018 = 1 if year>= 2008 & year<= 2012 & ifscode==611
replace PRGT2018 = 1 if year>= 2012 & year<= 2015 & ifscode==648
replace PRGT2018 = 1 if year>= 2012 & year<= 2014 & ifscode==915
replace PRGT2018 = 1 if year>= 2009 & year<= 2012 & ifscode==652
replace PRGT2018 = 1 if year>= 2015 & year<= 2019 & ifscode==652
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==328
replace PRGT2018 = 1 if year>= 2014 & year<= 2017 & ifscode==328
replace PRGT2018 = 1 if year>= 2012 & year<= 2016 & ifscode==656
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==656
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==654
replace PRGT2018 = 1 if year>= 2015 & year<= 2018 & ifscode==654
replace PRGT2018 = 1 if year>= 2010 & year<= 2014 & ifscode==263
replace PRGT2018 = 1 if year>= 2015 & year<= 2016 & ifscode==263
replace PRGT2018 = 1 if year>= 2010 & year<= 2012 & ifscode==268
replace PRGT2018 = 1 if year>= 2014 & year<= 2016 & ifscode==268
replace PRGT2018 = 1 if year>= 2011 & year<= 2014 & ifscode==664
replace PRGT2018 = 1 if year>= 2015 & year<= 2016 & ifscode==664
replace PRGT2018 = 1 if year>= 2016 & year<= 2018 & ifscode==664
replace PRGT2018 = 1 if year>= 2011 & year<= 2014 & ifscode==917
replace PRGT2018 = 1 if year>= 2015 & year<= 2018 & ifscode==917
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==666
replace PRGT2018 = 1 if year>= 2008 & year<= 2012 & ifscode==668
replace PRGT2018 = 1 if year>= 2012 & year<= 2017 & ifscode==668
replace PRGT2018 = 1 if year>= 2016 & year<= 2019 & ifscode==674
replace PRGT2018 = 1 if year>= 2010 & year<= 2012 & ifscode==676
replace PRGT2018 = 1 if year>= 2012 & year<= 2017 & ifscode==676
replace PRGT2018 = 1 if year>= 2008 & year<= 2011 & ifscode==678
replace PRGT2018 = 1 if year>= 2011 & year<= 2013 & ifscode==678
replace PRGT2018 = 1 if year>= 2013 & year<= 2018 & ifscode==678
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==682
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==682
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==921
replace PRGT2018 = 1 if year>= 2016 & year<= 2019 & ifscode==921
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==688
replace PRGT2018 = 1 if year>= 2013 & year<= 2016 & ifscode==688
replace PRGT2018 = 1 if year>= 2015 & year<= 2017 & ifscode==688
replace PRGT2018 = 1 if year>= 2012 & year<= 2016 & ifscode==692
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==692
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==714
replace PRGT2018 = 1 if year>= 2013 & year<= 2018 & ifscode==714
replace PRGT2018 = 1 if year>= 2016 & year<= 2018 & ifscode==714
replace PRGT2018 = 1 if year>= 2009 & year<= 2012 & ifscode==716
replace PRGT2018 = 1 if year>= 2012 & year<= 2015 & ifscode==716
replace PRGT2018 = 1 if year>= 2015 & year<= 2018 & ifscode==716
replace PRGT2018 = 1 if year>= 2010 & year<= 2014 & ifscode==722
replace PRGT2018 = 1 if year>= 2015 & year<= 2019 & ifscode==722
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==724
replace PRGT2018 = 1 if year>= 2013 & year<= 2016 & ifscode==724
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==724
replace PRGT2018 = 1 if year>= 2010 & year<= 2011 & ifscode==813
replace PRGT2018 = 1 if year>= 2011 & year<= 2012 & ifscode==813
replace PRGT2018 = 1 if year>= 2012 & year<= 2016 & ifscode==813
replace PRGT2018 = 1 if year>= 2009 & year<= 2012 & ifscode==923
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==738
replace PRGT2018 = 1 if year>= 2012 & year<= 2014 & ifscode==738
replace PRGT2018 = 1 if year>= 2014 & year<= 2018 & ifscode==738
replace PRGT2018 = 1 if year>= 2017 & year<= 2020 & ifscode==742
replace PRGT2018 = 1 if year>= 2010 & year<= 2013 & ifscode==746
replace PRGT2018 = 1 if year>= 2013 & year<= 2017 & ifscode==746
replace PRGT2018 = 1 if year>= 2010 & year<= 2012 & ifscode==459
replace PRGT2018 = 1 if year>= 2014 & year<= 2016 & ifscode==459





*Adding the four analytical groupings

merge m:m ifscode using "groupings"

rename program program2018roc
label var program2018roc "Dummy for program year in 2018 ROC sample"

gen program=0
replace program=1 if arragementall!=""
label var program "Dummy for program year in 2011 and 2018 ROC sample"

save "master.dta", replace

