
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


*parmest,format(estimate min95 max95 %8.2f p %8.1e) list(,)

****used for ppt cahrts*****

*****all*****

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>1980& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace

*****oil*****

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>1980& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace

*****oil WEo fuel EMDE *****

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>1980& year<2017&weo_oil==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace









* Table 1 2007-2013

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006& year<2013&comm!=0 &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_TT if year>2006& year<2013&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006& year<2013&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006& year<2013&comm!=0 &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=. 
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_TT if year>2006& year<2013&comm!=0 &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=. 
outreg2 using table1, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


*** table 11 non-com***

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_TT if year>2006&year<2013&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==3 &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=. 
outreg2 using table11, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

*** table 12 oil***

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER  l(0/1).growth_TT if year>2006&year<2013&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table12, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace


*** table 1.3 metal***

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2006&year<2013&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_NEER l(0/1).growth_TT if year>2006&year<2013&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2006&year<2013&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table13, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


* Table 2 2013-2016

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table2, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

***non-com***

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3 &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=. 
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==3  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table21, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append



***oil***

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table22, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append


***metal***

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode  l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23 , ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append
reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_REL_CPI l(0/1).growth_TT if year>2012& year<2017&comm==2  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table23, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word append

*****all*****

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>1980& year<2017&comm!=0  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace

*****oil*****

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>1980& year<2017&comm==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace

*****oil WEo fuel EMDE *****

reg change_ca_gdp  i.ifscode l(0/1).growth_dem_part l(0/1).growth_dem_dom l(0/1).growth_NEER l(0/1).growth_REL_CPI l(0/1).growth_TT if year>1980& year<2017&weo_oil==1  &l.growth_dem_part!=. & growth_dem_part!=.& l.growth_dem_dom!=.&growth_dem_dom!=.& l.growth_NEER!=. &growth_NEER!=. & l.growth_REL_CPI!=. &growth_REL_CPI!=. & l.growth_TT!=.&growth_TT!=.
outreg2 using table3, ctitle(both_nx) bdec(3) tdec(3) rdec(3) adec(3) alpha (.01, .05, .1)e(all) word replace

