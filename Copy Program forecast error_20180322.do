cd "\\data1\SPR\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Growth\ForecastOptimism\Regressions"
set more off
clear all

use "Stata Files\Database.dta", clear



*set years as time variable
gen years_to_forecast=year-year(action)


encode review_id, generate(code)
xtset code years_to_forecast

*REMOVE OUTLIERS!!!

*JY: not use interest if interest == 0
replace interest_ = . if interest_ <= 0
replace interest_ = . if interest_ > 60

replace fb_ = . if fb_ < -60 | fb_ > 60

*replace bankcrisis = 0  if bankcrisis==. & bankcrisis!=1

*replace ggdebt_ = 0 if ggdebt_ > 250

*Broad Money as a share of GDP

gen bm_ngdp=.
replace bm_ngdp=100*fmb_/ngdp_ if  fmb_!=. & ngdp_!=. 
replace bm_ngdp=0 if fmb==.

gen bm_ngdp_adj=0
replace bm_ngdp_adj= bm_ngdp-l.bm_ngdp if bm_ngdp!=0 & l.bm_ngdp!=0
replace bm_ngdp_adj= . if bm_ngdp_adj<-40 | bm_ngdp_adj>40


*primary balance

gen pb_ = .
replace pb_ = fb_ + interest_ if(fb_!=. & interest_!=.)


* JY: using calculated pb_mona for MONA part
*replace pb_ = pb_mona if review!="" & pb_mona!=.

*replace pb_ = . if pb_ < -60 | pb_ > 60

*define adjustment

gen fb_adjustment = .
gen ca_adjustment = .
gen pb_adjustment = .
gen sb_adjustment = .

replace fb_adjustment = fb_ - L.fb_ if(fb_!=. & l.fb_!=0)
replace ca_adjustment = ca_ - L.ca_ if(ca_!=. & l.ca_!=0)
replace pb_adjustment = pb_ - L.pb_ if(pb_!=. & l.pb_!=0)
replace sb_adjustment = sb_ - L.sb_ if(sb_!=. & l.sb_!=0)

*define oil and commodity price log growth
gen oil_g_ = ln(oil_)-ln(L.oil_)
gen commodity_g_ = ln(commodity_)-ln(L.commodity_)

gen oil_g_actual_ = ln(oil_actual_)-ln(L.oil_actual_)
gen commodity_g_actual_ = ln(commodity_actual_)-ln(L.commodity_actual_)


*define forecast error

gen growth_error = .
gen fb_error = .
gen ca_error = .
gen partnergrowth_error = .
gen oil_g_error = .
gen commodity_g_error_ = .


replace growth_error = growth_ - growth_actual_ if(growth_!=. & growth_actual_!=.)
replace fb_error = fb_ - fb_actual_ if(fb_!=. & fb_actual_!=.)
replace ca_error = ca_ - ca_actual_ if(ca_!=. & ca_actual_!=.)
replace partnergrowth_error = partnergrowth_ - partnergrowth_actual_ if(partnergrowth_!=. & partnergrowth_actual_!=.)
replace oil_g_error = oil_g_ - oil_g_actual_ if(oil_g_!=. & oil_g_actual_!=.)
replace commodity_g_error_ = commodity_g_ - commodity_g_actual_ if(commodity_g_!=. & commodity_g_actual_!=.)

*time to forecast
gen month = 1
gen day = 1
gen forecast_date = mdy(month, day, year)
gen time_to_forecast = (forecast_date - action)/365

*time and country/time interaction dummies
gen year_of_vintage = year(action)
*xi: gen countryXtime=i.country*i.year_of_vintage

*program dummies
gen program_d = 0
replace program_d = 1 if review !=""

gen request_d = 0
replace request_d = 1 if review == "R0"

gen review_d = 0
replace review_d = 1 if program_d == 1 & request_d == 0

gen review1_d = 0
replace review1_d = 1 if review == "R1"

gen review2_d = 0
replace review2_d = 1 if review == "R2"

gen review3_d = 0
replace review3_d = 1 if review == "R3"

gen reviewlater_d = 0
replace reviewlater_d = 1 if review_d == 1 & review1_d == 0 & review2_d == 0 & review3_d == 0

* JY: using app* end* for the begin/end of a program
/*
gen program_ongoing = 0
replace program_ongoing = 1 if review == "" & ((action > xxx11 & action < xxx12) | (action > xxx21 & action < xxx22) | (action > xxx31 & action < xxx32) | (action > xxx41 & action < xxx42) | (action > xxx51 & action < xxx52)) 

gen program_country = 0
replace program_country = 1 if ((action >= xxx11 & action <= xxx12) | (action >= xxx21 & action <= xxx22) | (action >= xxx31 & action <= xxx32) | (action >= xxx41 & action <= xxx42) | (action >= xxx51 & action <= xxx52))  
*/
gen program_ongoing = 0
replace program_ongoing = 1 if (review == "" & (((action > graapp1 & action < graend1) | (action > graapp2 & action < graend2) | (action > graapp3 & action < graend3) | (action > graapp4 & action < graend4) | (action > graapp5 & action < graend5)) | ((action > prgtapp1 & action < prgtend1) | (action > prgtapp2 & action <prgtend2) | (action > prgtapp3 & action < prgtend3) | (action > prgtapp4 & action < prgtend4) | (action > prgtapp5 & action < prgtend5)|(action > prgtapp6 & action < prgtend6))))

* JY: add the conditon of review!="" to make sure that all MONA data are part of program_country
gen program_country = 0
replace program_country = 1 if review !="" | (((action >= graapp1 & action <= graend1) | (action >= graapp2 & action <= graend2) | (action >= graapp3 & action <= graend3) | (action >= graapp4 & action <= graend4) | (action >= graapp5 & action <= graend5)) | ((action >= prgtapp1 & action <= prgtend1) | (action >= prgtapp2 & action <=prgtend2) | (action >= prgtapp3 & action <= prgtend3) | (action >= prgtapp4 & action <= prgtend4) | (action >= prgtapp5 & action <= prgtend5)|(action >= prgtapp6 & action <= prgtend6)))

gen program_is_prgt=0
replace program_is_prgt=1 if ((action >= prgtapp1 & action <= prgtend1) | (action >= prgtapp2 & action <=prgtend2) | (action >= prgtapp3 & action <= prgtend3) | (action >= prgtapp4 & action <= prgtend4) | (action >= prgtapp5 & action <= prgtend5)|(action >= prgtapp6 & action <= prgtend6))

gen program_is_gra=0
replace program_is_gra=1 if ((action >= graapp1 & action <= graend1) | (action >= graapp2 & action <= graend2) | (action >= graapp3 & action <= graend3) | (action >= graapp4 & action <= graend4) | (action >= graapp5 & action <= graend5))

gen surv=0
replace surv=1 if program_country==0

replace sb = 0 if sb == .

gen time_sb = sb * time_to_forecast

replace sb1 = 0 if sb1 == .
replace sb2 = 0 if sb2 == .
replace sb3 = 0 if sb3 == .
replace sb4 = 0 if sb4 == .
replace sb5 = 0 if sb5 == .

gen SBA = 0
replace SBA = 1 if program_type == "SBA"

gen exceptional_d=0
replace exceptional_d=1 if exceptional_access=="Y"



gen pb_adjustment_actual_get_average = .
gen ca_adjustment_actual_get_average = .
gen bm_adjustment_actual_get_average = .

replace pb_adjustment_actual_get_average = pb_adjustment if (years_to_forecast < 0 & year(action)==2017)
replace ca_adjustment_actual_get_average = ca_adjustment if (years_to_forecast < 0 & year(action)==2017)
replace bm_adjustment_actual_get_average = bm_ngdp_adj if (years_to_forecast < 0 & year(action)==2017)


egen pb_adjustment_actual_average= mean(pb_adjustment_actual_get_average), by(country)
egen ca_adjustment_actual_average= mean(ca_adjustment_actual_get_average), by(country)
egen bm_adjustment_actual_average= mean (bm_adjustment_actual_get_average), by (country)

egen pb_adjustment_actual_std= sd(pb_adjustment_actual_get_average), by(country)
egen ca_adjustment_actual_std= sd(ca_adjustment_actual_get_average), by(country)
egen bm_adjustment_actual_std = sd(bm_adjustment_actual_average)

gen pb_adjustment_actual = .
gen ca_adjustment_actual = .
gen bm_adjustment_actual= .

local ycode 1990
local year_r 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
foreach m of local year_r{

egen pb_adjustment_actual_`ycode'= mean(pb_adjustment_actual_get_average) if(year == `ycode'), by(country) 
egen ca_adjustment_actual_`ycode'= mean(pb_adjustment_actual_get_average) if(year == `ycode'), by(country)
egen bm_adjustment_actual_`ycode'= mean(bm_adjustment_actual_get_average) if(year == `ycode'), by(country)
replace pb_adjustment_actual = pb_adjustment_actual_`ycode' if (year == `ycode')
replace ca_adjustment_actual = ca_adjustment_actual_`ycode' if (year == `ycode')
replace bm_adjustment_actual = bm_adjustment_actual_`ycode' if (year == `ycode')


drop pb_adjustment_actual_`ycode'
drop ca_adjustment_actual_`ycode'
drop bm_adjustment_actual_`ycode'

local ycode = `ycode'+1
}

gen cumulative_pb_adj = .
gen cumulative_sb_adj = .
gen cumulative_ca_adj = .

replace cumulative_pb_adj = pb_adjustment+f.pb_adjustment+f2.pb_adjustment
replace cumulative_sb_adj = sb_adjustment+f.sb_adjustment+f2.sb_adjustment
replace cumulative_ca_adj = ca_adjustment+f.ca_adjustment+f2.ca_adjustment

gen cumulative_pb_adj_actual= .
replace cumulative_pb_adj_actual = cumulative_pb_adj if (years_to_forecast < -2 & year(action)==2017)

gen cumulative_sb_adj_actual= .
replace cumulative_sb_adj_actual = cumulative_sb_adj if (years_to_forecast < -2 & year(action)==2017)

gen cumulative_ca_adj_actual= .
replace cumulative_ca_adj_actual = cumulative_ca_adj if (years_to_forecast < -2 & year(action)==2017)

egen cumulative_pb_adj_average = mean(cumulative_pb_adj_actual), by(country) 
egen cumulative_pb_adj_std =  sd(cumulative_pb_adj_actual), by(country) 

egen cumulative_sb_adj_average = mean(cumulative_sb_adj_actual), by(country) 
egen cumulative_sb_adj_std =  sd(cumulative_sb_adj_actual), by(country) 

egen cumulative_ca_adj_average = mean(cumulative_ca_adj_actual), by(country)
egen cumulative_ca_adj_std =  sd(cumulative_ca_adj_actual), by(country)

gen prog_growth_error = program_country*growth_error

*Capturing high fiscal adjustment

gen high_fiscal_adj=0

*replace high_fiscal_adj=1 if cumulative_pb_adj!=. & (cumulative_pb_adj>5 | l.cumulative_pb_adj>5 | l2.cumulative_pb_adj>5)
*replace high_fiscal_adj=1 if cumulative_pb_adj!=. & (cumulative_pb_adj>cumulative_pb_adj_average+cumulative_pb_adj_std | l.cumulative_pb_adj>cumulative_pb_adj_average+cumulative_pb_adj_std | l2.cumulative_pb_adj>cumulative_pb_adj_average+cumulative_pb_adj_std)
replace high_fiscal_adj=1 if pb_adjustment!=. & (pb_adjustment>pb_adjustment_actual_average+0.5*pb_adjustment_actual_std)

gen low_fiscal_adj=0
replace low_fiscal_adj=1 if high_fiscal_adj==0

gen fiscal_expansion=0
replace fiscal_expansion=1 if pb_adjustment<0

gen high_sb_fiscal_adj=0
*replace high_sb_fiscal_adj=1 if cumulative_sb_adj!=. & (cumulative_sb_adj>cumulative_sb_adj_average+cumulative_sb_adj_std | l.cumulative_sb_adj>cumulative_sb_adj_average+cumulative_sb_adj_std | l2.cumulative_sb_adj>cumulative_sb_adj_average+cumulative_sb_adj_std)

gen high_ca_adj=0
*replace high_ca_adj=1 if cumulative_ca_adj!=. & (cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l2.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std)
replace high_ca_adj=1 if ca_adjustment!=. & (ca_adjustment>ca_adjustment_actual_average+0.5*ca_adjustment_actual_std)
gen low_ca_adj=0
replace low_ca_adj=1 if high_ca_adj==0

gen high_bm_adj=0
*replace high_ca_adj=1 if cumulative_ca_adj!=. & (cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std | l2.cumulative_ca_adj>cumulative_ca_adj_average+cumulative_ca_adj_std)
replace high_bm_adj=1 if bm_ngdp_adj !=. & (bm_ngdp_adj < bm_adjustment_actual_average-0.5*bm_adjustment_actual_std)
gen low_bm_adj=0
replace low_bm_adj=1 if high_bm_adj==0

**********************************
**Multipliers
**********************************

gen growth_delta=.
replace growth_delta=growth_-l.growth_ if (growth_!=. & l.growth_!=.)
gen pb_adjustment_m=.
replace pb_adjustment_m = pb_adjustment-l.pb_adjustment if (growth_delta!=.)
gen ca_adjustment_m=.
replace ca_adjustment_m = ca_adjustment-l.ca_adjustment if (growth_delta!=.)
*egen pb_adjustment_planned_average=mean(pb_adjustment_m), by(review_id)
*egen ca_adjustment_planned_average=mean(ca_adjustment_m), by(review_id)
*egen growth_delta_planned_average=mean(growth_delta), by(review_id)
gen fiscal_multiplier_sr= .
gen external_multiplier_sr=.

replace fiscal_multiplier_sr= -growth_delta/pb_adjustment_m if(pb_adjustment_m!=. & growth_delta!=. & years_to_forecast>=0)
replace external_multiplier_sr= -growth_delta/ca_adjustment_m if(ca_adjustment_m!=. & growth_delta!=. & years_to_forecast>=0)
*replace fiscal_multiplier_sr= growth_delta_planned_average/pb_adjustment_planned_average if(pb_adjustment_planned_average!=. & growth_delta_planned_average!=.)
*replace external_multiplier_sr= growth_delta_planned_average/ca_adjustment_planned_average if(ca_adjustment_planned_average!=. & growth_delta_planned_average!=.)
egen fm_average_sr= mean(fiscal_multiplier_sr), by(review_id)
egen em_average_sr= mean(external_multiplier_sr), by(review_id)


*drop pb_adjustment_planned_average
*drop ca_adjustment_planned_average
*drop growth_delta_planned_average
drop pb_adjustment_m
drop ca_adjustment_m
drop growth_delta

gen growth_delta_high_fiscal=.
replace growth_delta_high_fiscal=growth_-l.growth_ if (growth_!=. & l.growth_!=. & high_fiscal_adj==1)
gen growth_delta_high_ca=.
replace growth_delta_high_ca=growth_-l.growth_ if (growth_!=. & l.growth_!=. & high_ca_adj==1)
gen pb_adjustment_m=.
replace pb_adjustment_m = pb_adjustment-l.pb_adjustment if (growth_delta_high_fiscal!=. & high_fiscal_adj==1)
gen ca_adjustment_m=.
replace ca_adjustment_m = ca_adjustment-l.ca_adjustment if (growth_delta_high_ca!=. & high_ca_adj==1)
*egen pb_adjustment_planned_average=mean(pb_adjustment_m), by(review_id)
*egen ca_adjustment_planned_average=mean(ca_adjustment_m), by(review_id)
*egen growth_delta_planned_average_f=mean(growth_delta_high_fiscal), by(review_id)
*egen growth_delta_planned_average_ca=mean(growth_delta_high_ca), by(review_id)
gen fiscal_multiplier_sr_high= .
gen external_multiplier_sr_high= .
replace fiscal_multiplier_sr_high= -growth_delta_high_fiscal/pb_adjustment_m if(pb_adjustment_m!=. & growth_delta_high_fiscal!=. & years_to_forecast>=0)
replace external_multiplier_sr_high= -growth_delta_high_ca/ca_adjustment_m if(ca_adjustment_m!=. & growth_delta_high_ca!=. & years_to_forecast>=0)
egen fm_average_sr_high= mean(fiscal_multiplier_sr_high), by(review_id)
egen em_average_sr_high= mean(external_multiplier_sr_high), by(review_id)

*replace fiscal_multiplier_sr_high= growth_delta_planned_average_f/pb_adjustment_planned_average if(pb_adjustment_planned_average!=. & growth_delta_planned_average_f!=.)
*replace external_multiplier_sr_high= growth_delta_planned_average_ca/ca_adjustment_planned_average if(ca_adjustment_planned_average!=. & growth_delta_planned_average_ca!=.)

*drop pb_adjustment_planned_average
*drop ca_adjustment_planned_average
*drop growth_delta_planned_average_f
*drop growth_delta_planned_average_ca
drop pb_adjustment_m
drop ca_adjustment_m
drop growth_delta_high_fiscal
drop growth_delta_high_ca


gen fb_m_adjustment=.
replace fb_m_adjustment= f5.pb_ - l.pb_ 
replace fb_m_adjustment= f4.pb_ - l.pb_ if (f5.pb_==.)
replace fb_m_adjustment= f3.pb_ - l.pb_ if (f5.pb_==. & f4.pb_==.)
replace fb_m_adjustment= f2.pb_ - l.pb_ if (f5.pb_==. & f4.pb_==. & f3.pb_==.)
replace fb_m_adjustment= f.pb_ - l.pb_ if (f5.pb_==. & f4.pb_==. & f3.pb_==. & f2.pb_==.)
replace fb_m_adjustment= pb_ - l.pb_ if (f5.pb_==. & f4.pb_==. & f3.pb_==. & f2.pb_==. & f.pb_==.)

gen ca_m_adjustment=.
replace ca_m_adjustment= f5.ca_ - l.ca_ 
replace ca_m_adjustment= f4.ca_ - l.ca_ if (f5.ca_==.)
replace ca_m_adjustment= f3.ca_ - l.ca_ if (f5.ca_==. & f4.ca_==.)
replace ca_m_adjustment= f2.ca_ - l.ca_ if (f5.ca_==. & f4.ca_==. & f3.ca_==.)
replace ca_m_adjustment= f.ca_ - l.ca_ if (f5.ca_==. & f4.ca_==. & f3.ca_==. & f2.ca_==.)
replace ca_m_adjustment= ca_ - l.ca_ if (f5.ca_==. & f4.ca_==. & f3.ca_==. & f2.ca_==. & f.ca_==.)

gen growth_m_adjustment=.
replace growth_m_adjustment= f5.growth_+f4.growth_+f3.growth_+f2.growth_+f.growth_+growth_ 
replace growth_m_adjustment= f4.growth_+f3.growth_+f2.growth_+f.growth_+growth_ if (f5.growth_==.)
replace growth_m_adjustment= f3.growth_+f2.growth_+f.growth_+growth_ if (f5.growth_==. & f4.growth_==.)
replace growth_m_adjustment= f2.growth_+f.growth_+growth_ if (f5.growth_==. & f4.growth_==. & f3.growth_==.)
replace growth_m_adjustment= f.growth_+growth_ if (f5.growth_==. & f4.growth_==. & f3.growth_==. & f2.growth_==.)
replace growth_m_adjustment= growth_ if (f5.growth_==. & f4.growth_==. & f3.growth_==. & f2.growth_==. & f.growth_==.)

gen fm_average_lr=.
gen em_average_lr=.
replace fm_average_lr=-growth_m_adjustment/fb_m_adjustment if (growth_m_adjustment!=. & fb_m_adjustment!=. & years_to_forecast==0)
replace em_average_lr=-growth_m_adjustment/ca_m_adjustment if (growth_m_adjustment!=. & ca_m_adjustment!=. & years_to_forecast==0)



*********************************************

*Interaction with dummies
gen oil_exp_error = oil_g_error * oilexporter
gen oil_notexp_error= oil_g_error * !oilexporter
gen oil_g_exp= oil_g_ * oilexporter
gen oil_g_notexp= oil_g_ * !oilexporter
gen oil_g_exp_actual = oil_g_actual * oilexporter


gen commodity_exp_error = commodity_g_error * commexporter
gen commodity_notexp_error = commodity_g_error * !commexporter
gen commodity_g_exp=commodity_g_* commexporter
gen commodity_g_notexp= commodity_g_ * !commexporter
gen commodity_g_exp_actual= commodity_g_actual * commexporter

gen prog_partnergrowth_error = program_country * partnergrowth_error
gen prog_fb_adjustment = program_country * fb_adjustment
gen prog_pb_adjustment = program_country * pb_adjustment
gen prog_sb_adjustment = program_country * sb_adjustment
gen prog_bm_adjustment = program_country * bm_ngdp_adj
gen surv_pb_adjustment = surv * pb_adjustment

gen high_pb_adjustment = high_fiscal_adj * pb_adjustment
gen prog_high_pb_adjustment = program_country * high_fiscal_adj * pb_adjustment
gen surv_high_pb_adjustment = surv * high_fiscal_adj * pb_adjustment
gen surv_fiscal_expansion = surv * fiscal_expansion * pb_adjustment
gen prog_low_pb_adjustment = program_country * low_fiscal_adj * pb_adjustment
gen surv_low_pb_adjustment = surv * low_fiscal_adj * pb_adjustment
gen prog_fiscal_expansion = program_country * fiscal_expansion * pb_adjustment

gen high_sb_adjustment = high_fiscal_adj * sb_adjustment
gen prog_high_sb_adjustment = program_country * high_fiscal_adj * sb_adjustment

gen high_ca_adjustment = high_ca_adj * ca_adjustment
gen prog_high_ca_adjustment = program_country * high_ca_adj * ca_adjustment
gen prog_low_ca_adjustment = program_country * low_ca_adj * ca_adjustment
gen surv_low_ca_adjustment = surv* low_ca_adj * ca_adjustment
gen surv_high_ca_adjustment = surv* high_ca_adj * ca_adjustment

gen high_bm_adjustment = high_bm_adj * bm_ngdp_adj
gen prog_high_bm_adjustment = program_country * high_bm_adj * bm_ngdp_adj
gen prog_low_bm_adjustment = program_country * low_bm_adj * bm_ngdp_adj
gen surv_low_bm_adjustment = surv* low_bm_adj * bm_ngdp_adj
gen surv_high_bm_adjustment = surv* high_bm_adj * bm_ngdp_adj

gen prog_ca_adjustment  = program_country * ca_adjustment
gen prog_oil_g_error  = program_country * oil_g_error
gen prog_commodity_g_error  = program_country * commodity_g_error
gen prog_time_to_forecast = program_country * time_to_forecast

gen req_time_to_forecast = request_d * time_to_forecast

gen prog_ca_ = program_country * ca_
gen prog_fb_ = program_country * fb_
gen prog_pb_ = program_country * pb_
gen prog_sb_ = program_country * sb_
gen prog_ggdebt_ = program_country * ggdebt_

gen sb_time_to_forecast = sb * time_to_forecast

*Generating past program controls

gen PastProgram_d=0
replace PastProgram_d= 1 if (action> graapp1)
replace PastProgram_d= 2 if (action> graapp2)
replace PastProgram_d= 3 if (action> graapp3)
replace PastProgram_d= 4 if (action> graapp4)
replace PastProgram_d= 5 if (action> graapp5)

egen PastProgram = min(PastProgram_d), by(review_id)
drop PastProgram_d

gen time_PastProgram = PastProgram* time_to_forecast
*Controlling for GFC

gen GFC=0
replace GFC=1 if year==2008 | year== 2009

*Last Commodity and oil shock before forecats year

gen commodity_shock_at_forecast=.
replace commodity_shock_at_forecast=commodity_g_actual_ if year==year(action)
egen commodity_shock = mean(commodity_shock_at_forecast), by(code)
gen commodity_shock_exp=commodity_shock*commexporter
drop commodity_shock_at_forecast

gen oil_shock_at_forecast=.
replace oil_shock_at_forecast=oil_g_actual_ if year==year(action)
egen oil_shock = mean(oil_shock_at_forecast), by(code)
gen oil_shock_exp=oil_shock*oilexporter
drop oil_shock_at_forecast

*gen oil/commodity actual price interaction with dummies

gen oil_exp_actual_g=oil_g_actual*oilexporter
gen commodity_exp_actual_g=commodity_g_actual*commexporter

*Area Dept Dummies

gen isWHD=0
replace isWHD=1 if region=="WHD"
gen isAFR=0
replace isAFR=1 if region=="AFR"
gen isEUR=0
replace isEUR=1 if region=="EUR"
gen isMCD=0
replace isMCD=1 if region=="MCD"
gen isAPD=0
replace isAPD=1 if region=="APD"

*Clean Up before regressions

*drop if years_to_forecast < 0
*drop if years_to_forecast > 5
*Auxillary code
*by review_id, sort: gen nvals = _n == 1
*drop if (growth_error==. | partnergrowth_error==. | pb_adjustment==. | prog_pb_adjustment==. | high_pb_adjustment==. | ca_adjustment==. | prog_ca_adjustment==. | high_ca_adjustment==. | oil_g_error==. | oil_exp_error==. | commodity_g_error==. | commodity_exp_error==. | time_to_forecast==.)
*count if !(growth_error==. | partnergrowth_error==. | pb_adjustment==. | prog_pb_adjustment==. | high_pb_adjustment==. | ca_adjustment==. | prog_ca_adjustment==. | high_ca_adjustment==. | oil_g_error==. | oil_exp_error==. | commodity_g_error==. | commodity_exp_error==. | time_to_forecast==.) & (program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)))


*****************************

* Main Specification for GRA sample only (WEO), country*WEO fixed effects

cd "C:\Users\MFarid\Desktop"
gen ss=.
replace ss=1 if inlist(country, 

gen fs=.
replace fs=1 if inlist(country, 999

// GRA program periods + surveillance 
xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment fxregime2/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_gra.xls, replace ctitle(All) 

// GRA program periods 
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment high_ca_adjustment fxregime2 /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_gra.xls, append ctitle(GRA perods) 

// Surveillance only
xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment fxregime2 /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) & years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using main_specification_gra.xls, append ctitle(Surveillance only) 


* Alternative Specification for GRA sample only (WEO), country+WEO fixed effects
tab (weo), gen(weo_d)
tab (cty), gen(cty_d)

// GRA program periods + surveillance 
reg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment bm_ngdp_adj prog_bm_adjustment ca_adjustment prog_ca_adjustment weo_d* cty_d* fxregime2 /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , r
outreg2 using alt_specification_gra.xls, drop (weo_d* cty_d*) replace ctitle(All) 

// GRA program periods 
reg growth_error partnergrowth_error pb_adjustment bm_ngdp_adj ca_adjustment weo_d* cty_d* fxregime2/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) ,
outreg2 using alt_specification_gra.xls, drop (weo_d* cty_d*) append ctitle(GRA perods) 

// Surveillance only
reg growth_error partnergrowth_error pb_adjustment bm_ngdp_adj ca_adjustment weo_d* cty_d* fxregime2/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) ,

outreg2 using alt_specification_gra.xls, drop (weo_d* cty_d*) append ctitle(Surveillance only) 



// PRGT program periods + surveillance 
xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment fxregime2/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt== 1 | program_is_gra!=1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_prgt.xls, replace ctitle(All) 

// PRGT program periods 
xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment bm_ngdp_adj ca_adjustment high_ca_adjustment fxregime2 /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_prgt.xls, append ctitle(PRGT periods) 

// Surveillance only
xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj ca_adjustment prog_ca_adjustment high_ca_adjustment fxregime2 /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 

outreg2 using main_specification_prgt.xls, append ctitle(Surveillance only) 

STOP
reg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment bm_ngdp_adj prog_bm_adjustment ca_adjustment prog_ca_adjustment weo_d* cty_d*/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt== 1 | program_is_gra!=1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) 
outreg2 using alt_specification_test_prgt.xls, replace ctitle(All) 

// PRGT program periods 
reg growth_error partnergrowth_error pb_adjustment high_pb_adjustment bm_ngdp_adj ca_adjustment high_ca_adjustment weo_d* cty_d*/*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_prgt==1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) 
outreg2 using alt_specification_test_prgt.xls, append ctitle(PRGT periods) 

// Surveillance only
reg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment bm_ngdp_adj ca_adjustment prog_ca_adjustment weo_d* cty_d* /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (review=="") & (program_is_gra==0 & program_is_prgt == 0) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action))

outreg2 using alt_specification_test_prgt.xls, append ctitle(Surveillance only) 


estimate store feFull

*predict Fixed_Effects_growth_error, u

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/ if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_GRA_WEO.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="")& (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_GRA_WEO.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor

*predict Random_Effects_growth_error, u

hausman feFull Taylor, df(6)

outreg2 using main_specification_GRA_WEO.xls, append ctitle(Hausman-Taylor Estimation)

*****************************

* Main Specification for GRA sample only (WEO) 

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_GRA_WEO_ORG.xls, replace ctitle(Fixed effects) 

estimate store feFull

*predict Fixed_Effects_growth_error, u

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/ if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_GRA_WEO_ORG.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="")& (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_GRA_WEO_ORG.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor

*predict Random_Effects_growth_error, u

hausman feFull Taylor, df(3)

outreg2 using main_specification_GRA_WEO_ORG.xls, append ctitle(Hausman-Taylor Estimation)

* Main Specification for GRA sample only (MONA) 

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 0) & (program_is_prgt != 1 | program_is_gra==1) &  years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_GRA_MONA.xls, replace ctitle(Fixed effects) 

estimate store feFull

*predict Fixed_Effects_growth_error, u

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/ if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_GRA_MONA.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="")& years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_GRA_MONA.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor

*predict Random_Effects_growth_error, u

hausman feFull Taylor, df(6)

outreg2 using main_specification_GRA_MONA.xls, append ctitle(Hausman-Taylor Estimation)


* Main Specification for GRA sample only (MONA) (Without Broad Money)

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 0) & (program_is_prgt != 1 | program_is_gra==1) &  years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_GRA_MONA_ORG.xls, replace ctitle(Fixed effects) 

estimate store feFull

*predict Fixed_Effects_growth_error, u

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/ if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_GRA_MONA_ORG.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="")& years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_GRA_MONA_ORG.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt != 1 | program_is_gra==1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor

*predict Random_Effects_growth_error, u

hausman feFull Taylor, df(3)

outreg2 using main_specification_GRA_MONA_ORG.xls, append ctitle(Hausman-Taylor Estimation)


*****************************

* Main Specification for PRGT sample only (WEO) 

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt == 1 | program_is_gra!=1) &   years_to_forecast>=0  & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_prgt_WEO.xls, replace ctitle(Fixed effects) 

estimate store feFull

*predict Fixed_Effects_growth_error, u

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/ if (program_ongoing == 1 | review=="") & (program_is_prgt == 1 | program_is_gra!=1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_prgt_WEO.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/  oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if (program_ongoing == 1 | review=="")& (program_is_prgt == 1 | program_is_gra!=1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_prgt_WEO.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/  oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if (program_ongoing == 1 | review=="") & (program_is_prgt == 1 | program_is_gra!=1) & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(pb_adjustment prog_pb_adjustment high_pb_adjustment bm_ngdp_adj prog_bm_adjustment high_bm_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor

*predict Random_Effects_growth_error, u

hausman feFull Taylor, df(6)

outreg2 using main_specification_prgt_WEO.xls, append ctitle(Hausman-Taylor Estimation)


*********************************************
*********************************************
****Tests on Fixed effects

drop if Fixed_Effects_growth_error==.

by review_id, sort: gen nvals = _n == 1 
gen year_of_vintage_1=year_of_vintage-2002
gen year_of_vintage_2=year_of_vintage_1*year_of_vintage_1
gen ggdebt_2=ggdebt_*ggdebt_
/*
regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram if (nvals==1), robust
outreg2 using fixed_effects_by_AD.xls, replace ctitle(OLS-All sample-robust) 

regress Fixed_Effects_growth_error year_of_vintage_1 year_of_vintage_2 ggdebt_ ggdebt_2 PastProgram if (nvals==1), robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-All sample-robust) 

regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram fxregime2 if (nvals==1), robust
outreg2 using fixed_effects_by_AD.xls, replace ctitle(OLS-All sample-robust) 

regress Fixed_Effects_growth_error year_of_vintage_1 year_of_vintage_2 ggdebt_ ggdebt_2 PastProgram fxregime2 if (nvals==1), robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-All sample-robust) 

regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram if (nvals==1 & program_country==1), robust
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-robust) 
regress Fixed_Effects_growth_error year_of_vintage_1 year_of_vintage_2 ggdebt_ ggdebt_2 PastProgram if (nvals==1 & program_country==1), robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-robust) 

regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram fxregime2 if (nvals==1 & program_country==1), robust
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-robust) 
regress Fixed_Effects_growth_error year_of_vintage_1 year_of_vintage_2 ggdebt_ ggdebt_2 PastProgram fxregime2 if (nvals==1 & program_country==1), robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-robust) 

regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram if (nvals==1 & program_country==1 & year_of_vintage>2009), robust
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-post 2009- robust) 
regress Fixed_Effects_growth_error year_of_vintage_1 year_of_vintage_2 ggdebt_ ggdebt_2 PastProgram if (nvals==1 & program_country==1 & year_of_vintage>2009), robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-post 2009- robust) 

*/

**************************
*regress Fixed_Effects_growth_error fxregime2 if (nvals==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-All sample-robust) 
*regress Fixed_Effects_growth_error fxregime2 if (nvals==1 & program_country==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Program sample-robust) 
*regress Fixed_Effects_growth_error isEUR isAPD isMCD isWHD isAFR if (nvals==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-All sample-robust) 
*regress Fixed_Effects_growth_error isEUR isAPD isMCD isWHD isAFR fxregime2 if (nvals==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-All sample-robust) 
*regress Fixed_Effects_growth_error isEUR isAPD isMCD isWHD isAFR if (nvals==1 & program_country==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Program sample-robust) 
*regress Fixed_Effects_growth_error isEUR isAPD isMCD isWHD isAFR fxregime2 if (nvals==1 & program_country==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Program sample-robust) 
*regress Fixed_Effects_growth_error isEUR isAPD isMCD isWHD isAFR if (nvals==1 & program_country==1 & year_of_vintage>2009), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Program sample- post 2009-robust)
*regress Fixed_Effects_growth_error isEUR isAPD isMCD isWHD isAFR fxregime2 if (nvals==1 & program_country==1 & year_of_vintage>2009), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Program sample- post 2009-robust) 


*regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram isEUR isAPD isMCD isWHD isAFR if (nvals==1 & program_country==1), noconstant robust
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only- robust) 
*regress Fixed_Effects_growth_error year_of_vintage_1 year_of_vintage_2 ggdebt_ ggdebt_2 PastProgram  isEUR isAPD isMCD isWHD isAFR if (nvals==1 & program_country==1), noconstant robust 
*outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-- robust) 


regress Fixed_Effects_growth_error year_of_vintage_1  ggdebt_ PastProgram gap  fxregime2 isEUR isAPD isMCD isWHD isAFR if (nvals==1 & program_country==1), noconstant robust 
outreg2 using fixed_effects_by_AD.xls, replace ctitle(OLS-Programs Only-- robust) 
regress Fixed_Effects_growth_error year_of_vintage_1  ggdebt_ PastProgram gap fxregime2 isEUR isAPD isMCD isWHD isAFR request_d review1_d review2_d review3_d reviewlater_d if (nvals==1 & program_country==1), noconstant robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-Programs Only-- robust) 
regress Fixed_Effects_growth_error year_of_vintage_1 ggdebt_ PastProgram gap  fxregime2 isEUR isAPD isMCD isWHD isAFR if (nvals==1), noconstant robust 
outreg2 using fixed_effects_by_AD.xls, append ctitle(OLS-All sample -- robust) 

regress Fixed_Effects_growth_error year_of_vintage_1  ggdebt_  PastProgram fxregime2 gap i.country if  (nvals==1 & program_country==1), noconstant robust
outreg2 using fixed_effects_by_Country.xls, replace ctitle(OLS-Programs Only- Country FE) 
regress Fixed_Effects_growth_error year_of_vintage_1  ggdebt_ PastProgram fxregime2 gap if  (nvals==1 & program_country==1), robust
outreg2 using fixed_effects_by_Country.xls, append ctitle(OLS-Programs Only) 
regress Fixed_Effects_growth_error year_of_vintage_1  ggdebt_ fxregime2 PastProgram  gap i.country  if  (nvals==1), noconstant robust
outreg2 using fixed_effects_by_Country.xls, append ctitle(OLS-All sample- Country FE) 
regress Fixed_Effects_growth_error year_of_vintage_1  ggdebt_  fxregime2 PastProgram  gap if  (nvals==1),robust
outreg2 using fixed_effects_by_Country.xls, append ctitle(OLS-All sample) 


**************************************************************************************************************************
**************************************************************************************************************************
*************Historical Structural Break analysis

* Testing for time trends in forecasting errors across vintages (truncating sample at 2003-2008) and excluding forecasts for crisis years



xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if  program_ongoing == 0  & year_of_vintage<=2008 & year!=2008 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using Main_Specification-pre2009.xls, replace ctitle(Fixed effects)
outreg2 using main_specification.xls, append ctitle(Fixed Effects Estimation 2003-8) 

estimate store feFull_pre2009

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country exceptional_d /*
*/ if program_ongoing == 0 & year_of_vintage<=2008 & year!=2008 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , re 
outreg2 using Main_Specification-pre2009.xls, append ctitle(Random effects) 

estimate store reFull_pre2009

hausman feFull_pre2009 reFull_pre2009

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/ if program_ongoing == 0 & year_of_vintage<=2008 & year!=2008 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor_pre2009

hausman feFull_pre2009 Taylor_pre2009, df(4)


outreg2 using Main_Specification-pre2009.xls, append ctitle(Hausman-Taylor Estimation)

* Testing for time trends in forecasting errors across vintages (truncating sample at 2009 - 2016)

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if  program_ongoing == 0  & year_of_vintage>=2009 & year!=2008 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using Main_Specification-post2009.xls, replace ctitle(Fixed effects)
outreg2 using main_specification.xls, append ctitle(Fixed Effects Estimation 2009-16)

estimate store feFull_post2008

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country exceptional_d /*
*/ if program_ongoing == 0 & year_of_vintage>=2009 & year!=2008 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , re 
outreg2 using Main_Specification-post2009.xls, append ctitle(Random effects) 

estimate store reFull_post2008

hausman feFull_post2008 reFull_post2008

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/ if program_ongoing == 0 & year_of_vintage>=2009 & year!=2008 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 

estimate store Taylor_post2008

hausman feFull_post2008 Taylor_post2008, df(4)


outreg2 using Main_Specification-post2009.xls, append ctitle(Hausman-Taylor Estimation)


**************************************************************************************************************************
**************************************************************************************************************************
*************Learning Analaysis***

****The impact of past program experience on bias

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC time_PastProgram PastProgram /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_learning.xls, replace ctitle(Fixed effects) 

estimate store feFull_l

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC time_PastProgram PastProgram program_country exceptional_d /*
*/ if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_learning.xls, append ctitle(Random effects) 

estimate store reFull_l

hausman feFull_l reFull_l

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC time_PastProgram PastProgram program_country exceptional_d  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 

outreg2 using main_specification_learning.xls, append ctitle(Fixed effects) 

estimate store Taylor_l

hausman feFull_l Taylor_l, df(5)

outreg2 using main_specification.xls, append ctitle(Hausman-Taylor Est with learning)

* Testing for learning before 2013 (truncating sample at 2009 - 2013)


xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if  program_ongoing == 0  & year_of_vintage>2008 & year_of_vintage<=2012 & year!=2009 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using Main_Specification-pre2013.xls, replace ctitle(Fixed effects)
outreg2 using main_specification.xls, append ctitle(Fixed Effects Estimation 2009-12) 

estimate store feFull_pre2013

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country exceptional_d /*
*/ if program_ongoing == 0 & year_of_vintage>2008 & year_of_vintage<=2012 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , re 
outreg2 using Main_Specification-pre2013.xls, append ctitle(Random effects) 

estimate store reFull_pre2013

hausman feFull_pre2013 reFull_pre2013

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/ if program_ongoing == 0 & year_of_vintage>2008 & year_of_vintage<=2012 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor_pre2013

hausman feFull_pre2013 Taylor_pre2013, df(4)


outreg2 using Main_Specification-pre2013.xls, append ctitle(Hausman-Taylor Estimation)

* Testing for learning before after 2013 (truncating sample at 2013 - 2016)

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if  program_ongoing == 0  & year_of_vintage>=2013  & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using Main_Specification-post2013.xls, replace ctitle(Fixed effects)
outreg2 using main_specification.xls, append ctitle(Fixed Effects Estimation 2013-16)

estimate store feFull_post2013

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country exceptional_d /*
*/ if program_ongoing == 0 & year_of_vintage>=2013 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , re 
outreg2 using Main_Specification-post2013.xls, append ctitle(Random effects) 

estimate store reFull_post2013

hausman feFull_post2013 reFull_post2013

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment  ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/ if program_ongoing == 0 & year_of_vintage>=2013 & years_to_forecast>=0 & year<=2016 & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 

estimate store Taylor_post2013

hausman feFull_post2013 Taylor_post2013, df(4)


outreg2 using Main_Specification-post2013.xls, append ctitle(Hausman-Taylor Estimation)
*********************************************************************************************************
*********************************************************************************************************
******************Robustness tests 		*********************************
*********************************************************************************************************
*********************************************************************************************************


* Main specification with banking crisis


xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification-banking-crisis.xls, replace ctitle(Fixed effects) 

estimate store feFull_bc

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast bankcrisis GFC program_country exceptional_d /*
*/ if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification-banking-crisis.xls, append ctitle(Random effects) 

estimate store reFull_bc

hausman feFull_bc reFull_bc

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error bankcrisis time_to_forecast GFC/*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification-banking-crisis.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter bankcrisis time_to_forecast GFC program_country exceptional_d  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor_bc

hausman feFull_bc Taylor_bc, df(5)


outreg2 using main_specification-banking-crisis.xls, append ctitle(Hausman-Taylor Fixed effects)

* Using WEO Data only

xtreg growth_error partnergrowth_error surv_low_pb_adjustment surv_high_pb_adjustment prog_low_pb_adjustment prog_high_pb_adjustment surv_low_ca_adjustment surv_high_ca_adjustment prog_low_ca_adjustment prog_high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error  commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if review == "" & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_WEO.xls, replace ctitle(Fixed effects) 

estimate store feFull_WEO

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment prog_high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/ oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast GFC program_country /*
*/  if review == "" & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_WEO.xls, append ctitle(Random effects) 

estimate store reFull_WEO

hausman feFull_WEO reFull_WEO

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment prog_high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error  commodity_exp_error GFC time_to_forecast/*
*/  if review == "" & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_WEO.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment prog_high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment  /*
*/ oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast GFC  program_country/*
*/  if review == "" & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment program_country) 


estimate store Taylor_WEO

hausman feFull_WEO Taylor_WEO, df(4)


outreg2 using main_specification_WEO.xls, append ctitle(Hausman-Taylor Fixed effects)


* Old Main Specification for total sample with no high adjustment interaction

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment ca_adjustment prog_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_nohighinteractions.xls, replace ctitle(Fixed effects) 

estimate store feFull

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment  ca_adjustment prog_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country review_d request_d /*
*/ if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_nohighinteractions.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment prog_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC/*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_nohighinteractions.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment prog_pb_adjustment  ca_adjustment prog_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment prog_pb_adjustment ca_adjustment prog_ca_adjustment program_country exceptional_d) 


estimate store Taylor

hausman feFull Taylor, df(4)

outreg2 using main_specification_nohighinteractions.xls, append ctitle(Hausman-Taylor Fixed effects)

*  Main Specification for total sample with no program interaction

xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_noproginteraction.xls, replace ctitle(Fixed effects) 

estimate store feFull

xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment  ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country review_d request_d /*
*/ if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_noproginteraction.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC/*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_noproginteraction.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment high_pb_adjustment  ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment high_pb_adjustment ca_adjustment high_ca_adjustment program_country exceptional_d) 


estimate store Taylor

hausman feFull Taylor, df(4)

outreg2 using main_specification_noproginteraction.xls, append ctitle(Hausman-Taylor Fixed effects)

* Main Specification for total sample with no interactions

xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_nointeractions.xls, replace ctitle(Fixed effects) 

estimate store feFull

xtreg growth_error partnergrowth_error pb_adjustment ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC program_country review_d request_d /*
*/ if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_nointeractions.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC/*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_nointeractions.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment  ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC program_country exceptional_d  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment ca_adjustment program_country exceptional_d) 


estimate store Taylor

hausman feFull Taylor, df(2)

outreg2 using main_specification_nointeractions.xls, append ctitle(Hausman-Taylor Fixed effects)

*Simplistic OLS Regression with only Country and year fixed effects (do not use)

xi: regress growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC bankcrisis i.country i.year/*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , robust
outreg2 using Simple_regression_with_count_and_year_dummies.xls, replace ctitle(OLS) 


*Main specification but with only programs


xtreg growth_error partnergrowth_error pb_adjustment  high_pb_adjustment ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if program_country!=0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification-only-programs.xls, replace ctitle(Fixed effects) 

estimate store feFull

xtreg growth_error partnergrowth_error pb_adjustment high_pb_adjustment  ca_adjustment high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC  exceptional_d /*
*/ if program_country!=0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification-only-programs.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error pb_adjustment high_pb_adjustment ca_adjustment  high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC/*
*/  if program_country!=0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification-only-programs.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error pb_adjustment  high_pb_adjustment  ca_adjustment  high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error oilexporter commodity_notexp_error commodity_exp_error commexporter time_to_forecast GFC exceptional_d  /*
*/  if program_country!=0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb pb_adjustment  high_pb_adjustment ca_adjustment high_ca_adjustment exceptional_d) 


estimate store Taylor

hausman feFull Taylor, df(4)

outreg2 using main_specification-only-programs.xls, append ctitle(Hausman-Taylor Fixed effects)

* Main Specification for total sample with 4 fiscal brackets (use this for template)

xtreg growth_error partnergrowth_error surv_low_pb_adjustment surv_high_pb_adjustment prog_low_pb_adjustment prog_high_pb_adjustment surv_low_ca_adjustment surv_high_ca_adjustment prog_low_ca_adjustment prog_high_ca_adjustment /*
*/ time_sb oil_notexp_error oil_exp_error commodity_notexp_error commodity_exp_error time_to_forecast GFC /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_fiscal_brackets.xls, replace ctitle(Fixed effects) 

estimate store feFull

xtreg growth_error partnergrowth_error surv_low_pb_adjustment surv_high_pb_adjustment prog_low_pb_adjustment prog_high_pb_adjustment surv_low_ca_adjustment surv_high_ca_adjustment prog_low_ca_adjustment prog_high_ca_adjustment  /*
*/ time_sb  oil_notexp_error oil_exp_error  commodity_notexp_error commodity_exp_error commexporter oilexporter time_to_forecast GFC exceptional_d program_d /*
*/ if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , re 
outreg2 using main_specification_fiscal_brackets.xls, append ctitle(Random effects) 

estimate store reFull

hausman feFull reFull

xtregar growth_error partnergrowth_error   surv_low_pb_adjustment surv_high_pb_adjustment prog_low_pb_adjustment prog_high_pb_adjustment surv_low_ca_adjustment surv_high_ca_adjustment prog_low_ca_adjustment prog_high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error  commodity_notexp_error commodity_exp_error time_to_forecast GFC  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , fe lbi
outreg2 using main_specification_fiscal_brackets.xls, append ctitle(Cochrane-Orcutt Fixed effects) 
 

xthtaylor growth_error partnergrowth_error  surv_low_pb_adjustment surv_high_pb_adjustment prog_low_pb_adjustment prog_high_pb_adjustment surv_low_ca_adjustment surv_high_ca_adjustment prog_low_ca_adjustment prog_high_ca_adjustment  /*
*/ time_sb oil_notexp_error oil_exp_error  commodity_notexp_error commodity_exp_error oilexporter commexporter time_to_forecast GFC exceptional_d program_d  /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016  & (month(action)<=10 | year!=year(action)) , endog(time_sb surv_high_pb_adjustment prog_low_pb_adjustment prog_high_pb_adjustment surv_low_ca_adjustment surv_high_ca_adjustment prog_low_ca_adjustment prog_high_ca_adjustment exceptional_d program_d) 


estimate store Taylor

hausman feFull Taylor, df(6)


outreg2 using main_specification_fiscal_brackets.xls, append ctitle(Hausman-Taylor Fixed effects)



*************************************************************************************************************
*************************************************************************************************************
*************************************************************************************************************
*************************************************************************************************************
********************** Channels of impact analysis



*IV Analysis on the actual driver of optimism (implementation vs plan)

regress pb_adjustment_actual partnergrowth_error  pb_adjustment oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast if (years_to_forecast>0 & year<2017)

predict pb_adjustment_actual_res, residual
predict pb_adjustment_actual_hat

regress ca_adjustment_actual ca_adjustment  time_to_forecast if (years_to_forecast>0 & year<2017)

predict ca_adjustment_actual_res, residual
predict ca_adjustment_actual_hat


gen high_pb_adjust_actual_hat= pb_adjustment_actual_hat*high_fiscal_adj
gen prog_pb_adjust_actual_hat= pb_adjustment_actual_hat*program_country

gen high_pb_adjust_actual_res= pb_adjustment_actual_res*high_fiscal_adj
gen prog_pb_adjust_actual_res= pb_adjustment_actual_res*program_country


gen high_ca_adjust_actual_hat= ca_adjustment_actual_hat*high_ca_adj
gen prog_ca_adjust_actual_hat= ca_adjustment_actual_hat*program_country

gen high_ca_adjust_actual_res= ca_adjustment_actual_res*high_ca_adj
gen prog_ca_adjust_actual_res= ca_adjustment_actual_res*program_country


xtreg growth_actual pb_adjustment prog_pb_adjustment high_pb_adjustment pb_adjustment_actual_res oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast if (years_to_forecast>0 & year<2017), fe
est store FE_IV

xtreg growth_error  pb_adjustment_actual_hat high_pb_adjust_actual_hat prog_pb_adjust_actual_hat pb_adjustment_actual_res high_pb_adjust_actual_res prog_pb_adjust_actual_res oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast if (years_to_forecast>0 & year<2017), fe


xtreg growth_error  partnergrowth_error  pb_adjustment_actual_hat high_pb_adjust_actual_hat prog_pb_adjust_actual_hat ca_adjustment_actual_hat high_ca_adjust_actual_hat prog_ca_adjust_actual_hat oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast if (years_to_forecast>0 & year<2017), fe


xtivreg2 growth_error (pb_adjustment_actual = pb_adjustment oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast) time_to_forecast pb_adjustment prog_pb_adjustment high_pb_adjustment oil_g_actual commodity_g_actual if (years_to_forecast>0 & year<2017), fe 

 
*xtreg growth_actual pb_adjustment prog_pb_adjustment high_pb_adjustment pb_adjustment_actual_hat oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast if (years_to_forecast>0 & year<2017), fe
 
xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_IV_multiplier_or_confidence.xls, replace ctitle(Fixed effects)  
 
 xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment pb_adjustment_actual_hat high_pb_adjust_actual_hat prog_pb_adjust_actual_hat ca_adjustment prog_ca_adjustment high_ca_adjustment /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  if program_ongoing == 0 & years_to_forecast>=0 & year <= 2016 & (month(action)<=10 | year!=year(action)) , fe 
outreg2 using main_specification_IV_multiplier_or_confidence.xls, append ctitle(Fixed effects W/ instrument) 

drop pb_adjustment_actual_res
drop pb_adjustment_actual_hat
drop high_pb_adjust_actual_hat
drop prog_pb_adjust_actual_hat



/*
*Country fixed effects

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d review_d i.country if time_to_forecast > -366 & program_ongoing == 0
outreg2 using errors.xls, append adjr2


*SBA / EFF
reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d review_d SBA if time_to_forecast > -366 & program_ongoing == 0
outreg2 using errors.xls, append adjr2



*PROGRAM SAMPLE ONLY (everything above)

*Basic specification
reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2


*Split reviews

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d review1_d review2_d review3_d if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2


*Structural reforms

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d sb if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d sb1 sb2 sb3 sb4 sb5 if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2


*Commodity exporter / oil exporter x price errors

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_exp_error commodity_exp_error time_to_forecast request_d if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast /*
*/ request_d if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2


*Country fixed effects

reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d i.country if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2


*SBA / EFF
reg growth_error partnergrowth_error fb_adjustment ca_adjustment oil_g_error commodity_g_error time_to_forecast request_d SBA if time_to_forecast > -366 & program_d == 1 
outreg2 using errors.xls, append adjr2


*AAND THE WINNERS ARE: 
reg growth_error partnergrowth_error fb_adjustment prog_fb_adjustment ca_adjustment prog_ca_adjustment oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error /*
*/ commexporter time_to_forecast   program_d if time_to_forecast > -366 & program_ongoing == 0
outreg2 using errors.xls, replace adjr2

reg growth_error partnergrowth_error fb_adjustment prog_fb_adjustment oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error /*
*/ commexporter time_to_forecast   program_d if time_to_forecast > -366 & program_ongoing == 0
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error ca_adjustment prog_ca_adjustment oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error /*
*/ commexporter time_to_forecast   program_d if time_to_forecast > -366 & program_ongoing == 0
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error fb_adjustment  ca_adjustment  oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error /*
*/ commexporter time_to_forecast    if time_to_forecast > -366 & program_d == 1
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error fb_adjustment    oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error /*
*/ commexporter time_to_forecast    if time_to_forecast > -366 & program_d == 1
outreg2 using errors.xls, append adjr2

reg growth_error partnergrowth_error   ca_adjustment  oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error /*
*/ commexporter time_to_forecast    if time_to_forecast > -366 & program_d == 1
outreg2 using errors.xls, append adjr2


* WEO ONLY DATA

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error  time_to_forecast /*
*/  program_country exceptional_d i.country if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, replace adjr2

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast europe /*
*/  program_country exceptional_d i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, append adjr2

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, append adjr2

xtreg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == ""), fe
outreg2 using WEOonlyWork.xls, append ctitle(Fixed Effects)

xtreg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, append ctitle(Random Effects) 

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == ""), fe
outreg2 using WEOonlyWork.xls, append ctitle(Fixed Effects)

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, append ctitle(Random Effects) 

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast europe /*
*/  program_country if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, append adjr2


reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast europe /*
*/  program_country if time_to_forecast > -366 & (program_ongoing == 1 | review == "")
outreg2 using WEOonlyWork.xls, replace adjr2

* WEO ONLY DATA BEFORE 2010

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error  time_to_forecast /*
*/  program_country exceptional_d i.country if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010
outreg2 using WEOonlyWork_before_2010.xls, replace adjr2

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast europe /*
*/  program_country exceptional_d i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010
outreg2 using WEOonlyWork_before_2010.xls, append adjr2

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010
outreg2 using WEOonlyWork_before_2010.xls, append adjr2

xtreg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010, fe
outreg2 using WEOonlyWork_before_2010.xls, append ctitle(Fixed Effects)

xtreg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010
outreg2 using WEOonlyWork_before_2010.xls, append ctitle(Random Effects) 

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010, fe
outreg2 using WEOonlyWork_before_2010.xls, append ctitle(Fixed Effects)

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage < 2010
outreg2 using WEOonlyWork_before_2010.xls, append ctitle(Random Effects) 


* WEO ONLY AFTER 2010

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error  time_to_forecast /*
*/  program_country exceptional_d i.country if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage >= 2010
outreg2 using WEOonlyWork_after_2010.xls, replace adjr2 

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error oilexporter commodity_g_error commodity_exp_error commexporter time_to_forecast europe /*
*/  program_country exceptional_d i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage >= 2010
outreg2 using WEOonlyWork_after_2010.xls, append adjr2 

reg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "")& year_of_vintage >= 2010
outreg2 using WEOonlyWork_after_2010.xls, append adjr2 

xtreg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage >= 2010, fe
outreg2 using WEOonlyWork_after_2010.xls, append ctitle(Fixed Effects)

xtreg growth_error L.growth_error L.prog_growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage >= 2010
outreg2 using WEOonlyWork_after_2010.xls, append ctitle(Random Effects) 

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage >= 2010, fe
outreg2 using WEOonlyWork_after_2010.xls, append ctitle(Fixed Effects)

xtreg growth_error partnergrowth_error pb_adjustment prog_pb_adjustment high_pb_adjustment ca_adjustment prog_ca_adjustment  /*
*/ time_sb oil_g_error oil_exp_error commodity_g_error commodity_exp_error time_to_forecast /*
*/  program_country exceptional_d i.country i.year_of_vintage if time_to_forecast > -366 & (program_ongoing == 1 | review == "") & year_of_vintage >= 2010
outreg2 using WEOonlyWork_after_2010.xls, append ctitle(Random Effects) 


*Blanchard-Leigh compatible variables

gen growth_error_2 = growth_error + L.growth_error
gen sb_adjustment_2 = sb_adjustment + L.sb_adjustment
gen fb_adjustment_2 = fb_adjustment + L.fb_adjustment
gen pb_adjustment_2 = pb_adjustment + L.pb_adjustment
gen ca_adjustment_2 = ca_adjustment + L.ca_adjustment
gen partnergrowth_error_2 = partnergrowth_error + L.partnergrowth_error


reg growth_error_2 sb_adjustment_2  if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, replace adjr2

reg growth_error_2 pb_adjustment_2  if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 fb_adjustment_2  if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error sb_adjustment  if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2  if action == date("01apr2011", "DMY") & year == 2012 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2  if action == date("01apr2012", "DMY") & year == 2013 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2  if action == date("01apr2013", "DMY") & year == 2014 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2  if action == date("01apr2014", "DMY") & year == 2015 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2  if action == date("01apr2015", "DMY") & year == 2016 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2  if action == date("01apr2010", "DMY") & year == 2011
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2 ca_adjustment_2 if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2 partnergrowth_error_2 if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, append adjr2

reg growth_error_2 sb_adjustment_2 ca_adjustment_2 partnergrowth_error_2 if action == date("01apr2010", "DMY") & year == 2011 & europe == 1
outreg2 using checks.xls, append adjr2
