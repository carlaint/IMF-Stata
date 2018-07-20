

gen dggr = ggr_gdp - l.ggr_gdp
*gen dcredit = credit - l.credit
gen dm2 = m2_gdp - l.m2_gdp

//drop if year>2000
drop if year<1980

gen decade = floor(year/10)*10 
gen pre2000 = (year < 2000)
gen pre1985 = (year < 1985)

sort ifscode year
by ifscode: gen t = _n



set more off
//preserve
	cd "Q:\DATA\DM\VELIC_Rethink\stata output files\crisis definition 4_1\ctry_year_interaction"
		
	gen start_crisis = 0 if externalcrisis4_1!=.
	bysort ifs (year): replace start_crisis = 1 if externalcrisis4_1== 1 & externalcrisis4_1[_n-1] == 0 // The start date of the crisis

	* Help variable to find period around crisis
	gen crisis_cycle = .
	replace crisis_cycle = 0 if start_crisis == 1
	forvalues i = 1(1)4 {
		gen start_crisisf`i' = f`i'.start_crisis
		}
	forvalues i = 1(1)4 {
		gen start_crisisl`i' = l`i'.start_crisis
		}
		
	forvalues i=1(1)4 {
		replace crisis_cycle = `i' if start_crisisl`i' == 1
		}
	forvalues i=1(1)4 {
		replace crisis_cycle = -`i' if start_crisisf`i' == 1
		}	 

	* Generating the dummyvariables (distance from the crisis)
	forvalues i=-4(1)4 {
			if `i'<0	{
				local j=-`i'
				qui generate bcrisis`j'=F`j'.start_crisis							 
				qui replace bcrisis`j'=0 if bcrisis`j'==.
			}
			else {
				qui generate bcrisisL`i'=L`i'.start_crisis 
				qui replace bcrisisL`i'=0 if bcrisisL`i'==.
			}
		}


	gen zero = 0
foreach var in cpia dtot_rel growth growth_xo inflation_c debtgrowth debt_gdp d_gdp ddebt m2_reserve2 m2_gdp credit_GDP credit_gdp_dev credit_pubgdp real_interest ///
	 bxgs_gdp_bp6 bmgs_gdp_bp6 bca_gdp_bp6 hp_reer hp_reer_trend EREER tot hp_tot_trend hp_tot dtt tt  ///
	 bis_gdp_bp6 amort_sched arrears rem_received_gdp ggrg_gdp ODA2 bca_xm dbca_xm dca dexports darrears dgrowth ///
	 rescoverage ob_gdp ggx_gdp ggr_gdp ggrc_gdp dggr dm2 txg_dpch diff_rescov d_res d_er overval_Rodrik price_nx_ctot prr vix gl w_growth dissum popgdp bankcrisis governmentexp health birthr mortalityr PRSVA PRSPV PRSGE PRSRQ PRSRL PRSCC {
	
	local graphtitle : variable label `var' 										// Graphtitle
	quietly xtreg `var' bcrisis*  i.ifs##i.decade if crisis_cycle != . | externalcrisis4_1!= 1, fe vce(robust)
	cap coefplot, vertical drop(_cons) recast(line) col("221 34 45") lpattern(dash) xline(0, lcolor(black) lpattern(dash)) /// legend(order(2  "95 % CI") ring(0)  pos(11) region(fcolor(none) lcolor(none))) ///
			  xlabel(, tposition(inside)) ylabel(, ticks tposition(inside) nogrid) ///
			  graphregion(color(white)) plotregion(lcolor(black) lpattern(solid)) ///
			  keep(bcrisis*) ///
			  relocate(bcrisis4 = -4 bcrisis3 = -3 bcrisis2 = -2 bcrisis1=-1 ///
			  bcrisisL0 = 0 bcrisisL1 = 1 bcrisisL2 = 2 bcrisisL3=3 bcrisisL4 = 4 ) ///
			  citop ciopts(recast(rcap) color("44 115 153")) title("`graphtitle'", size(vsmall)) xtitle(Years around the crisis) yline(0, lcolor(black) lpattern(dash)) /// title(`graphtitle', size(3.5))
			  xlabel(-4(1)4) addplot((line zero crisis_cycle, sort col(black) lpattern(dash))) scale(1.55) ///
			  saving(`var', replace) 
			  graph export `var'.png, replace
			  }
//restore

gen ggrnc_gdp=ggr_gdp-ggrc_gdp
sum ggrnc_gdp

foreach var in ggrc_gdp ggrnc_gdp {
	
	local graphtitle : variable label `var' 										// Graphtitle
	quietly xtreg `var' bcrisis*  i.ifs##i.decade if crisis_cycle != . | externalcrisis4_1!= 1, fe vce(robust)
	cap coefplot, vertical drop(_cons) recast(line) col("221 34 45") lpattern(dash) xline(0, lcolor(black) lpattern(dash)) /// legend(order(2  "95 % CI") ring(0)  pos(11) region(fcolor(none) lcolor(none))) ///
			  xlabel(, tposition(inside)) ylabel(, ticks tposition(inside) nogrid) ///
			  graphregion(color(white)) plotregion(lcolor(black) lpattern(solid)) ///
			  keep(bcrisis*) ///
			  relocate(bcrisis4 = -4 bcrisis3 = -3 bcrisis2 = -2 bcrisis1=-1 ///
			  bcrisisL0 = 0 bcrisisL1 = 1 bcrisisL2 = 2 bcrisisL3=3 bcrisisL4 = 4 ) ///
			  citop ciopts(recast(rcap) color("44 115 153")) title("`graphtitle'", size(vsmall)) xtitle(Years around the crisis) yline(0, lcolor(black) lpattern(dash)) /// title(`graphtitle', size(3.5))
			  xlabel(-4(1)4) addplot((line zero crisis_cycle, sort col(black) lpattern(dash))) scale(1.55) ///
			  saving(`var', replace) 
			  graph export `var'.png, replace
			  }

