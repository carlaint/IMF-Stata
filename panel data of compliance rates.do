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

collapse(sum) met nm md mod, by(ArrangementNumber CountryName ApprovalYear YearofTestDate)
sort YearofTestDate ArrangementNumber CountryName ApprovalYear

save `x'.dta, replace
}
