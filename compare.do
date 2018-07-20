cd "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Evenhandedness\Clustering\"

//get Mona
import excel "Q:\DATA\SPRLP\EM\Review of Conditionality\Data\Section-Evenhandedness\Clustering\MONA_Conditionalities.xlsx", sheet("Summary") cellrange(A106:J1949) firstrow clear
save mona.dta, replace

//merge with dataset
merge 1:1 ccode year using "INETDataset_Main.dta"

drop if year<2002

keep country ifs ccode year QPCsnodup QPCsall otherQPCs IT SB cname cid QPCsTOT IBsTOT PAsTOT SPCsTOT SBsTOT _merge

export excel using compare.xlsx, firstrow(variables) replace
