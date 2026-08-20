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


* ---------------------------------------------------------------------------
* Weighted pairwise Pearson correlations
* ---------------------------------------------------------------------------

pwcorr `indicators' [aw=wgt], obs

* Store the coefficient matrix for later Excel export
matrix indicator_correlations = r(C)
matrix list indicator_correlations

export excel using ///
    "`workbook'", ///
    sheet("Correlation table 1", replace) firstrow(varlabels)
	
save "$project/output/2_correlation_indicators", replace

