version 16
clear all
set more off

*=============================================================================*
* Global Findex 2025 - Indonesia
* Financial well-being indicator 
* (2) and (3) Correlation tables and correlation indicators x income
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
* Cleaned financial well-being indicators
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
	fin36_all_cash fin36_leave_money fin36_transfer fin36_not_applicable ///
	fin24_savings fin24_family fin24_work fin24_loan ///
	fin24_sell_asset fin24_other fin24_cannot_raise fin24_dk ///
	fin40_all_cash fin40_leave_money fin40_not_applicable ///
	fin41_yes fin41_no fin41_not_applicable ///
	fin44_yes fin44_no fin44_not_applicable ///
	fin45_old_age fin45_business fin45_medical ///
	fin45_monthly_expenses fin45_education fin45_other fin45_dk 

local all_locals ///
	`binaryvars' `ordinalvars' `nominalvars'
	
* ---------------------------------------------------------------------------
* Weighted pairwise Pearson correlations
* ---------------------------------------------------------------------------

pwcorr `all_locals' inc_q [aw=wgt], obs

* Store the coefficient matrix for later Excel export
matrix indicator_correlations = r(C)
matrix list indicator_correlations

putexcel set ///
    "`workbook'", ///
    sheet("Indicator Correlations") modify
	
putexcel A1 = "Table 2"

putexcel A2 = "Weighted Pearson correlations among financial well-being indicators"

putexcel A4 = matrix(indicator_correlations), names


* ---------------------------------------------------------------------------
* Weighted correlation indicators x income
*
* inc_q = 1 -> Poorest
* 		  5 -> Richest
* ---------------------------------------------------------------------------

* Generate income vars

tab inc_q, gen(income_q)

qui pwcorr `all_locals' income_q* [aw=wgt], obs

* Store the coefficient matrix 
matrix indicatorxincome = r(C)

local number_indicators : word count `all_locals'
local first_income = `number_indicators' + 1
local last_income  = `number_indicators' + 5

matrix C_income = ///
    indicatorxincome[1..`number_indicators', `first_income'..`last_income']

matrix colnames C_income = ///
    "Lowest 20%" "20%-40%" "40%-60%" "60%-80%" "Top 20%"

matrix list C_income

putexcel set ///
    "`workbook'", ///
    sheet("Indicator x Income") modify
	
putexcel A1 = "Table 3"

putexcel A2 = "Weighted Pearson correlations of financial well-being indicators and income quintiles"

putexcel A4 = matrix(C_income), names

*---
* Done
*---

save "$project/output/2_correlation_indicators", replace
