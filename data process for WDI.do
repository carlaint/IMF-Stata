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


keep if year>=1980 & year<=2017
drop if ifscode == .
drop if country == "Macao SAR, China"
drop if country == "Hong Kong SAR, China"
 

gen program = 0
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

merge 1:m ifscode year using "programinfo"
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

gen GRA = 0
replace GRA = 1 if country == "Albania"
replace GRA = 1 if country == "Angola"
replace GRA = 1 if country == "Antigua and Barbuda"
replace GRA = 1 if country == "Argentina"
replace GRA = 1 if country == "Armenia"
replace GRA = 1 if country == "Belarus"
replace GRA = 1 if country == "Bolivia"
replace GRA = 1 if country == "Bosnia and Herzegovina"
replace GRA = 1 if country == "Brazil"
replace GRA = 1 if country == "Bulgaria"
replace GRA = 1 if country == "Colombia"
replace GRA = 1 if country == "Costa Rica"
replace GRA = 1 if country == "Cote D'Ivoire"
replace GRA = 1 if country == "Croatia"
replace GRA = 1 if country == "Cyprus"
replace GRA = 1 if country == "Dominica"
replace GRA = 1 if country == "Dominican Republic"
replace GRA = 1 if country == "Ecuador"
replace GRA = 1 if country == "Egypt"
replace GRA = 1 if country == "El Salvador"
replace GRA = 1 if country == "Gabon"
replace GRA = 1 if country == "Georgia"
replace GRA = 1 if country == "Greece"
replace GRA = 1 if country == "Guatemala"
replace GRA = 1 if country == "Honduras"
replace GRA = 1 if country == "Hungary"
replace GRA = 1 if country == "Iceland"
replace GRA = 1 if country == "Iraq"
replace GRA = 1 if country == "Ireland"
replace GRA = 1 if country == "Jamaica"
replace GRA = 1 if country == "Jordan"
replace GRA = 1 if country == "Kenya"
replace GRA = 1 if country == "Kosovo"
replace GRA = 1 if country == "Latvia"
replace GRA = 1 if country == "Liberia"
replace GRA = 1 if country == "Macedonia (Fyr)"
replace GRA = 1 if country == "Maldives"
replace GRA = 1 if country == "Moldova"
replace GRA = 1 if country == "Mongolia"
replace GRA = 1 if country == "Pakistan"
replace GRA = 1 if country == "Paraguay"
replace GRA = 1 if country == "Peru"
replace GRA = 1 if country == "Portugal"
replace GRA = 1 if country == "Romania"
replace GRA = 1 if country == "Serbia"
replace GRA = 1 if country == "Seychelles"
replace GRA = 1 if country == "Sri Lanka"
replace GRA = 1 if country == "St. Kitts And Nevis"
replace GRA = 1 if country == "Tunisia"
replace GRA = 1 if country == "Turkey"
replace GRA = 1 if country == "Ukraine"
replace GRA = 1 if country == "Uruguay"

merge 1:m ifscode year using "programinfo2011"
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
save "master.dta", replace

