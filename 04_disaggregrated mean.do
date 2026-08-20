version 16
clear all
set more off

* ---------------------------------------------------------------------------
* Directories
* ---------------------------------------------------------------------------

global project ///
    "/Users/sazwara/Library/Mobile Documents/com~apple~CloudDocs/JPAL/FINDEX"
	
local workbook "$project/output/findex_statistics.xlsx"

local analysis_data ///
    "$project/output/1_summary_statistics_output.dta"

use "`analysis_data'", clear

* Verify the analysis sample
assert _N == 1068
assert economycode == "IDN"

confirm variable wgt

label define yesno_r 0 "No" 1 "Yes", replace

* ---------------------------------------------------------------------------
* 1. Demographics Construction
* ---------------------------------------------------------------------------
* ---------------------------------------------------------------------------
* Cleaned financial well-being indicators
* ---------------------------------------------------------------------------

local indicators ///
    account_fin_r fin2_r fin10_r ///
    fin3_r fin5_r fin6_r fin7_r fin8_r fin9a_r fin9b_r ///
    fin25e1_r fin25e2_r fin25e3_r fin26a_r fin26b_r ///
    fin30_r fin31a_r fin31b_r fin31c_r fin31d_r ///
    fin32_r fin33_r fin34a_r fin34b_r fin34c_r ///
    fin34d_r fin35_r ///
    fin42_r fin43a_r fin43b_r fin43c_r fin43d_r ///
    fin20_r fin21_r fin22f_r fin22g_r fin22h_r ///
    fin17a_r fin17b_r fin17c_r ///
    fin17e_r fin18_r ///
    fin24a_r fin24b_r ///
    fin24c_r fin24d1_r fin24d2_r fin24d3_r ///
    fin19_r fin22a_r fin22b_r fin22c_r fin22d_r fin23_r ///
    fin37_r fin39a_r fin39b_r fin39c_r fin39d_r fin41_r ///
    fh1_r fin28_r fh2_r fin29_r fh2a_r ///
    fin17f_r fin22e_r fin38_r fin44_r ///
	
*Female 

gen female_bin = female
replace female_bin=0 if female==2

label var female_bin "Respondent is female" 
label values female_bin yesno_r

tab female_bin

*Age

gen agequartiles = age
recode agequartile min/24=1 25/34=2 35/44=3 45/max=4
label define agequartiles ///
	1 "15-24 years old" ///
	2 "25-34 years old" ///
	3 "35-44 years old" ///
	4 "45-88 years old" ///
	
label var agequartile "Ages in quartiles"	
label values agequartiles agequartile

tab agequartiles

*Income

label define incquintiles ///
	1 "Lowest 20%" ///
	2 "Lowest 40%" ///
	3 "40-60%" ///
	4 "Top 40%" ///
	5 "Top 20%" ///
	
label values inc_q incquintiles 

*Urban/rural
gen rural_bin = urbanicity
replace rural_bin=0 if urbanicity==2

label var rural_bin "Respondent lives in rural area"
label values rural_bin yesno_r







	
	
	
