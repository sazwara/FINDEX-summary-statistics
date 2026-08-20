version 16
clear all
set more off

*=============================================================================*
* Global Findex 2025 - Indonesia
* Financial well-being indicator 
* (4) Disaggregrated Mean of Findex Indicators
*=============================================================================*

global project "/Users/sazwara/Library/Mobile Documents/com~apple~CloudDocs/JPAL/FINDEX"

local microdata "$project/findex_microdata_2025_labelled_update112425.dta"

confirm file "`microdata'"
use "`microdata'", clear

capture mkdir $project/output

local workbook "$project/output/findex_statistics.xlsx"

keep if economycode == "IDN"
assert _N == 1068

confirm variable wgt

label define yesno_r 0 "No" 1 "Yes", replace

* ---------------------------------------------------------------------------
* 1. Binary Construction
* yes = 1, no = 0
* ---------------------------------------------------------------------------

*Female 

gen female_bin = female
replace female_bin=0 if female==2

label var female_bin "Respondent is female" 
label values yesno_r female_bin

tab female_bin

*Age

gen agequartile = age
recode agequartile min/32=1 33/50=2 51/69=3 70/max=4
label define agequartiles ///
	1 "15-32 years old" ///
	2 "33-50 years old" ///
	3 "51-69 years old" ///
	4 "70-88 years old" ///
	
label var agequartile "Ages in quartiles"	
label values agequartile agequartiles

tab agequartiles

*Income

desc    account_fin_r fin2_r fin10_r ///
    fin3_r fin5_r fin6_r fin7_r fin8_r fin9a_r fin9b_r ///
    fin25e1_r fin25e2_r fin25e3_r fin26a_r fin26b_r ///
    fin30_r fin31a_r fin31b_r fin31c_r fin31d_r ///
    fin32_r fin33_r fin34a_r fin34b_r fin34c_r ///
    fin34d_score fin35_score ///
    fin42_r fin43a_r fin43b_r fin43c_r fin43d_r ///
    fin20_r fin21_score fin22f_r fin22g_r fin22h_r ///
    fin17a_r fin17b_r fin17c_r fin17d_score ///
    fin17e_r fin18_r ///
    fin24a_r fin24b_score ///
    fin24c_r fin24d1_r fin24d2_r fin24d3_r ///
    fin19_r fin22a_r fin22b_r fin22c_r fin22d_r fin23_r ///
    fin37_r fin39a_r fin39b_r fin39c_r fin39d_r fin41_score ///
    fh1_r fin28_r fh2_r fin29_r fh2a_r ///
    fin17f_r fin22e_r fin38_r fin44_score ///
