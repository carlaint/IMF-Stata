clear
cd  "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Ownership\charts"

foreach x in QPCs SBs ITs {

clear
import excel "QPC SB and IT.xlsx", sheet(`x') firstrow
***the file above is a direct paste of MONA_QPC and SB with_dummy.xlsx***

capture keep if Duplicates=="No"

gen met=1 if Status2=="Met"
gen nm=1 if Status2=="Not met"
gen md=1 if Status2=="Met with delay"
gen mod=1 if Status2=="Modified"

collapse(sum) met nm md mod, by( CountryName YearofTestDate CountryCode)
rename YearofTestDate year
rename CountryCode ifs_code
drop if year==.
gen total=met+nm+md
gen `x'metr=met/total
gen `x'nmr=nm/total
gen `x'mdr=md/total
rename total `x'total 
rename met `x'met
rename nm `x'nm
rename md `x'md
sort ifs_code year
 destring ifs_code, replace
save `x'.dta, replace
}
