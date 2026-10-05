version 16
clear all
set more off

*=============================================================================*
* Global Findex 2025 - Indonesia
* Financial well-being indicator 
* (4) Disaggregrated means
*=============================================================================*
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

* ---------------------------------------------------------------------------
* 1. Demographics Construction
* ---------------------------------------------------------------------------

label define yesno_r 0 "No" 1 "Yes", replace
	
*Female 

gen female_bin = female
replace female_bin=0 if female==2

label var female_bin "Respondent is female" 
label values female_bin yesno_r

tab female_bin

*Age

gen agequartiles = age
recode agequartiles min/24=1 25/34=2 35/44=3 45/max=4
label define agequartilelabel ///
	1 "15-24 years old" ///
	2 "25-34 years old" ///
	3 "35-44 years old" ///
	4 "45-88 years old" ///
	
label var agequartiles "Age Group"	
label values agequartiles agequartilelabel

tab agequartiles

*Income

label define incquintiles ///
	1 "Lowest 20%" ///
	2 "20-40%" ///
	3 "40-60%" ///
	4 "60-80%" ///
	5 "Top 20%" ///
	
label values inc_q incquintiles 

*Income quintile respondents
count if !missing(inc_q)
tab inc_q
tab inc_q [aw=wgt]

*Urban/rural
gen rural_bin = urbanicity
replace rural_bin=0 if urbanicity==2

label var rural_bin "Respondent lives in rural area"
label values rural_bin yesno_r

* ---------------------------------------------------------------------------
* 2. Locals
* ---------------------------------------------------------------------------

*BINARY
local binaryvars ///
    account_fin_r fin2_r fin10_r ///
    fin3_r fin7_r fin8_r fin9a_r fin9b_r ///
    fin25e1_r fin25e2_r fin26a_r fin26b_r ///
    fin30_r fin31a_r fin31b_r fin31c_r fin31d_r ///
    fin32_r fin33_r fin34a_r fin34b_r fin34c_r ///
    fin42_r fin43a_r fin43b_r fin43c_r fin43d_r ///
    fin20_r fin21_r fin22f_r fin22g_r fin22h_r ///
    fin17a_r fin17b_r fin17c_r ///
    fin17e_r fin18_r ///
    fin24a_r ///
    fin24c_r fin24d1_r fin24d2_r fin24d3_r ///
    fin19_r fin22a_r fin22b_r fin22c_r fin22d_r fin23_r ///
    fin37_r fin39a_r fin39b_r fin39c_r fin39d_r ///
    fh1_r fin28_r fh2_r fin29_r fh2a_r ///
    fin17f_r fin22e_r fin38_r 

*ORDINAL: FIN17D, FIN24B - DK = 4, 5 is excluded

gen fin17d_score = fin17d_r
replace fin17d_score = . if fin17d_score == 4

gen fin24b_score = fin24b_r
replace fin24b_score = . if fin24b_score == 5

local ordinalvars ///
	fin5_r ///
	fin5_weekly fin5_monthly fin5_less_month fin5_never ///
	fin6_r ///
	fin6_weekly fin6_monthly fin6_less_month fin6_never ///
	fin25e3_r ///
	fin25e3_weekly fin25e3_monthly fin25e3_less_month ///
	fin17d_score ///
	fin17d_weekly fin17d_monthly fin17d_less_month ///
	fin24b_score ///
	fin24b_less_2weeks fin24b_one_month fin24b_two_months fin24b_more_2months

*NOMINAL

local nominalvars ///
	fin25e4_merchant_cash fin25e4_more_expensive fin25e4_no_trust ///
	fin25e4_used_cash fin25e4_other fin25e4_dk fin25e4_phone_used ///
	fin27_online fin27_cash fin27_both fin27_no_online_purchase ///
	fin34d_yes fin34d_no fin34d_other_payment ///
	fin35_yes fin35_no fin35_not_applicable ///
	fin17d_dk fin24b_dk ///
	fin36_all_cash fin36_leave_money fin36_transfer fin36_not_applicable ///
	fin24_savings fin24_family fin24_work fin24_loan ///
	fin24_sell_asset fin24_other fin24_cannot_raise fin24_dk ///
	fin40_all_cash fin40_leave_money fin40_not_applicable ///
	fin41_yes fin41_no fin41_not_applicable ///
	fin44_yes fin44_no fin44_not_applicable ///
	fin45_old_age fin45_business fin45_medical ///
	fin45_monthly_expenses fin45_education fin45_other fin45_dk 

	
* ---------------------------------------------------------------------------
* 3. CREATING THE MATRIX FOR THE VALUES 
* ---------------------------------------------------------------------------
	
local all_locals ///
	`binaryvars' `ordinalvars' `nominalvars'
	
* Female
estpost tabstat `all_locals' [aw=wgt] ///
    if female_bin == 1, ///
    statistics(count mean sd) columns(statistics)

matrix female_stats = (e(count)', e(mean)', e(sd)')

* Male
estpost tabstat `all_locals' [aw=wgt] ///
    if female_bin == 0, ///
    statistics(count mean sd) columns(statistics)

matrix male_stats = (e(count)', e(mean)', e(sd)')


* Income: lowest 20%
estpost tabstat `all_locals' [aw=wgt] ///
    if inc_q == 1, ///
    statistics(count mean sd) columns(statistics)

matrix income1_stats = (e(count)', e(mean)', e(sd)')

* Income: 20-40%
estpost tabstat `all_locals' [aw=wgt] ///
    if inc_q == 2, ///
    statistics(count mean sd) columns(statistics)

matrix income2_stats = (e(count)', e(mean)', e(sd)')

* Income: 40-60%
estpost tabstat `all_locals' [aw=wgt] ///
    if inc_q == 3, ///
    statistics(count mean sd) columns(statistics)

matrix income3_stats = (e(count)', e(mean)', e(sd)')

* Income: 60-80%
estpost tabstat `all_locals' [aw=wgt] ///
    if inc_q == 4, ///
    statistics(count mean sd) columns(statistics)

matrix income4_stats = (e(count)', e(mean)', e(sd)')

* Income: highest 20%
estpost tabstat `all_locals' [aw=wgt] ///
    if inc_q == 5, ///
    statistics(count mean sd) columns(statistics)

matrix income5_stats = (e(count)', e(mean)', e(sd)')


* Age 15-24
estpost tabstat `all_locals' [aw=wgt] ///
    if agequartiles == 1, ///
    statistics(count mean sd) columns(statistics)

matrix age1_stats = (e(count)', e(mean)', e(sd)')

* Age 25-34
estpost tabstat `all_locals' [aw=wgt] ///
    if agequartiles == 2, ///
    statistics(count mean sd) columns(statistics)

matrix age2_stats = (e(count)', e(mean)', e(sd)')

* Age 35-44
estpost tabstat `all_locals' [aw=wgt] ///
    if agequartiles == 3, ///
    statistics(count mean sd) columns(statistics)

matrix age3_stats = (e(count)', e(mean)', e(sd)')

* Age 45-88
estpost tabstat `all_locals' [aw=wgt] ///
    if agequartiles == 4, ///
    statistics(count mean sd) columns(statistics)

matrix age4_stats = (e(count)', e(mean)', e(sd)')


* Rural
estpost tabstat `all_locals' [aw=wgt] ///
    if rural_bin == 1, ///
    statistics(count mean sd) columns(statistics)

matrix rural_stats = (e(count)', e(mean)', e(sd)')

* Urban
estpost tabstat `all_locals' [aw=wgt] ///
    if rural_bin == 0, ///
    statistics(count mean sd) columns(statistics)

matrix urban_stats = (e(count)', e(mean)', e(sd)')


* Female vs. Male and Rural vs. Urban t-tests
svyset [pweight=wgt]

local number_variables : word count `all_locals'

matrix female_male_tests = J(`number_variables', 3, .)
matrix rural_urban_tests = J(`number_variables', 3, .)

local row = 1

foreach variable of local all_locals {

	quietly svy: regress `variable' i.female_bin
	quietly lincom 1.female_bin

	matrix female_male_tests[`row', 1] = r(estimate)
	matrix female_male_tests[`row', 2] = r(estimate) / r(se)
	matrix female_male_tests[`row', 3] = r(p)

	quietly svy: regress `variable' i.rural_bin
	quietly lincom 1.rural_bin

	matrix rural_urban_tests[`row', 1] = r(estimate)
	matrix rural_urban_tests[`row', 2] = r(estimate) / r(se)
	matrix rural_urban_tests[`row', 3] = r(p)

	local row = `row' + 1
}

matrix colnames female_male_tests = ///
	FemaleMale_Difference FemaleMale_t FemaleMale_p

matrix colnames rural_urban_tests = ///
	RuralUrban_Difference RuralUrban_t RuralUrban_p

matrix means_disaggregated = ///
	female_stats, male_stats, female_male_tests, ///
	income1_stats, income2_stats, income3_stats, ///
	income4_stats, income5_stats, ///
	age1_stats, age2_stats, age3_stats, age4_stats, ///
	rural_stats, urban_stats, rural_urban_tests

matrix colnames means_disaggregated = ///
	Female_N Female_Mean Female_SD ///
	Male_N Male_Mean Male_SD ///
	FemaleMale_Difference FemaleMale_t FemaleMale_p ///
	IncomeLowest20_N IncomeLowest20_Mean IncomeLowest20_SD ///
    Income20_40_N Income20_40_Mean Income20_40_SD ///
    Income40_60_N Income40_60_Mean Income40_60_SD ///
    Income60_80_N Income60_80_Mean Income60_80_SD ///
    IncomeHighest20_N IncomeHighest20_Mean IncomeHighest20_SD ///
    Age15_24_N Age15_24_Mean Age15_24_SD ///
    Age25_34_N Age25_34_Mean Age25_34_SD ///
    Age35_44_N Age35_44_Mean Age35_44_SD ///
	Age45_88_N Age45_88_Mean Age45_88_SD ///
	Rural_N Rural_Mean Rural_SD ///
	Urban_N Urban_Mean Urban_SD ///
	RuralUrban_Difference RuralUrban_t RuralUrban_p

matrix list means_disaggregated

* ---------------------------------------------------------------------------
* 4. EXPORT
* ---------------------------------------------------------------------------
	
putexcel set "`workbook'", ///
    sheet("Disaggregrated Mean") modify
	
putexcel A1 = "Table 4"

putexcel A2 = "Summary statistics for Indonesian Financial Inclusion Index, by sex, age, income quintiles, and urban status."

putexcel A4 = matrix(means_disaggregated), names

*------
* done
*------
	
save "$project/output/4_means_disaggregrated", replace
