*****gen variables***

xtset ifscode year

gen REL_CPI=NEER/REER
foreach X in TT REER NEER REL_CPI X_D_R NTTD_R { 
			gen log_`X'= log(`X')
			}

foreach X in TT REER NEER REL_CPI X_D_R NTTD_R{
 
			gen growth_`X'= log_`X' - l.log_`X'
						}
gen ca_gdp=BCA/NGDPD
gen change_ca_gdp=ca_gdp-l.ca_gdp


rename growth_X_D_R growth_dem_part
rename growth_NTTD_R growth_dem_dom


****weo chapter******

* Table 1

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2014&weo_chapter==1, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* peggers**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1&XRregime<3, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1&XRregime<3, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2014&weo_chapter==1&XRregime<3, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

**floaters**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1&XRregime>2, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1&XRregime>2, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2014&weo_chapter==1&XRregime>2, fe r
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***weo chpater until 2017***

*Table 2

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2017&weo_chapter==1, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2014&weo_chapter==1, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2017&weo_chapter==1, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


* peggers**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2017&weo_chapter==1&XRregime<3, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2017&weo_chapter==1&XRregime<3, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2017&weo_chapter==1&XRregime<3, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

**floaters**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2017&weo_chapter==1&XRregime>2, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2017&weo_chapter==1&XRregime>2, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2017&weo_chapter==1&XRregime>2, fe r
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

******************
***EM all BY ER 
******************

**until 2013

*Table 3

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* peggers**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm!=0&XRregime<3, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm!=0&XRregime<3, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2013&comm!=0&XRregime<3, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

**floaters**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm!=0&XRregime>2, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm!=0&XRregime>2, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2013&comm!=0&XRregime>2, fe r
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

**Table 11 2007-2012

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2006&year<2013&comm!=0, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if  year>2006&year<2013&comm!=0, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if  year>2006&year<2013&comm!=0, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* peggers**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if  year>2006&year<2013&comm!=0&XRregime<3, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if  year>2006&year<2013&comm!=0&XRregime<3, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if  year>2006&year<2013&comm!=0&XRregime<3, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

**floaters**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if  year>2006&year<2013&comm!=0&XRregime>2, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if  year>2006&year<2013&comm!=0&XRregime>2, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if  year>2006&year<2013&comm!=0&XRregime>2, fe r
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append



***EM all 2013-2016***

*Table 4

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm!=0, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm!=0, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012&year<2017&comm!=0, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* peggers**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm!=0&XRregime<3, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm!=0&XRregime<3, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2012&year<2017&comm!=0&XRregime<3, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

**floaters**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm!=0&XRregime>2, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm!=0&XRregime>2, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2012&year<2017&comm!=0&XRregime>2, fe r
outreg2 using table4, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append



***************************
***EM by exports groups****
***************************


*Table 5 2013-2016

* oil**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm==1, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm==1, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2012&year<2017&comm==1, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* commodity **
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm==2, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm==2, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2012&year<2017&comm==2, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* importers **
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm==3, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2012&year<2017&comm==3, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2012&year<2017&comm==3, fe r
outreg2 using table5, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***EM by gexports until 2013****

*Table 6

* oil**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* commodity **
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* importers **
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table6, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***EM by exports 2007 until 2013****

*Table 7

* oil**
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2006& year<2013&comm==1, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2006& year<2013&comm==1, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* commodity **
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2006& year<2013&comm==2, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* importers **
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REER l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REER l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_TT if year>2006 & year<2013&comm==3, fe r
outreg2 using table7, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***************************
******with NEER and CPI****
*****************************


*Table 8 until 2013

***EM all***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm!=0, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***oil***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==1, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***metal***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==2, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***non-com***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_REL_CPI l(0/1).growth_TT if year<2013&comm==3, fe r
outreg2 using table8, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

* Table 9 2007-2013

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006& year<2013&comm!=0, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm!=0, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm!=0, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_TT if year>2006& year<2013&comm!=0, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006& year<2013&comm!=0, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006& year<2013&comm!=0, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***non-com***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3, fe r
outreg2 using table9, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

***oil***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER  l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace


***metal***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_NEER l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==2, fe r
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


* Table 10 2013-2016

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm!=0, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm!=0, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

***non-com***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm==3, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==3, fe r
outreg2 using table10, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append



***oil***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word  replace
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm==1, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==1, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***metal***

xtreg change_ca_gdp l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm==2, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
xtreg change_ca_gdp  l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==2, fe r
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


