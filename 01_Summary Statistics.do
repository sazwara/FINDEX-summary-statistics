version 16
clear all
set more off

*=============================================================================*
* Global Findex 2025 - Indonesia
* Financial well-being indicator 
* (1) Summary Statistics
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
* 2. Standard binary recodes
*    Yes = 1
*    No  = 0
*    DK and refused = missing
* ---------------------------------------------------------------------------

generate byte account_fin_r = account_fin

generate byte fin2_r   = (fin2   == 1) if inlist(fin2,   1, 2)
generate byte fin13d_r = (fin13d == 1) if inlist(fin13d, 1, 2)

generate byte fin20_r  = (fin20  == 1) if inlist(fin20,  1, 2)
generate byte fin22f_r = (fin22f == 1) if inlist(fin22f, 1, 2)

generate byte fin17a_r = (fin17a == 1) if inlist(fin17a, 1, 2)
generate byte fin17c_r = (fin17c == 1) if inlist(fin17c, 1, 2)

generate byte fin24c_r = (fin24c == 1) if inlist(fin24c, 1, 2)

generate byte fin19_r  = (fin19  == 1) if inlist(fin19,  1, 2)
generate byte fin22a_r = (fin22a == 1) if inlist(fin22a, 1, 2)
generate byte fin22b_r = (fin22b == 1) if inlist(fin22b, 1, 2)
generate byte fin22d_r = (fin22d == 1) if inlist(fin22d, 1, 2)

generate byte fin37_r  = (fin37  == 1) if inlist(fin37,  1, 2)
generate byte fin22e_r = (fin22e == 1) if inlist(fin22e, 1, 2)
generate byte fin38_r  = (fin38  == 1) if inlist(fin38,  1, 2)

* Variables not requiring special structural-missing recodes
generate byte fin30_r = (fin30 == 1) if inlist(fin30, 1, 2)
generate byte fin32_r = (fin32 == 1) if inlist(fin32, 1, 2)
generate byte fin42_r = (fin42 == 1) if inlist(fin42, 1, 2)

generate byte fh1_r  = (fh1  == 1) if inlist(fh1,  1, 2)
generate byte fh2_r  = (fh2  == 1) if inlist(fh2,  1, 2)
generate byte fh2a_r = (fh2a == 1) if inlist(fh2a, 1, 2)


* ---------------------------------------------------------------------------
* 3. Binary variables where structural missing means No
*    DK/refused remain missing because the replacement refers to the raw
*    variable's missing values only.
* ---------------------------------------------------------------------------

generate byte fin3_r = (fin3 == 1) if inlist(fin3, 1, 2)
replace fin3_r = 0 if missing(fin3)

generate byte fin8_r = (fin8 == 1) if inlist(fin8, 1, 2)
replace fin8_r = 0 if missing(fin8)

generate byte fin9a_r = (fin9a == 1) if inlist(fin9a, 1, 2)
replace fin9a_r = 0 if missing(fin9a)

generate byte fin9b_r = (fin9b == 1) if inlist(fin9b, 1, 2)
replace fin9b_r = 0 if missing(fin9b)

generate byte fin10_r = (fin10 == 1) if inlist(fin10, 1, 2)
replace fin10_r = 0 if missing(fin10)

generate byte fin25e1_r = ///
    (fin25e1 == 1) if inlist(fin25e1, 1, 2)
replace fin25e1_r = 0 if missing(fin25e1)

generate byte fin25e2_r = ///
    (fin25e2 == 1) if inlist(fin25e2, 1, 2)
replace fin25e2_r = 0 if missing(fin25e2)

generate byte fin26a_r = (fin26a == 1) if inlist(fin26a, 1, 2)
replace fin26a_r = 0 if missing(fin26a)

generate byte fin26b_r = (fin26b == 1) if inlist(fin26b, 1, 2)
replace fin26b_r = 0 if missing(fin26b)

generate byte fin31a_r = (fin31a == 1) if inlist(fin31a, 1, 2)
replace fin31a_r = 0 if missing(fin31a)

generate byte fin31b_r = (fin31b == 1) if inlist(fin31b, 1, 2)
replace fin31b_r = 0 if missing(fin31b)

generate byte fin31c_r = (fin31c == 1) if inlist(fin31c, 1, 2)
replace fin31c_r = 0 if missing(fin31c)

generate byte fin31d_r = (fin31d == 1) if inlist(fin31d, 1, 2)
replace fin31d_r = 0 if missing(fin31d)

generate byte fin33_r = (fin33 == 1) if inlist(fin33, 1, 2)
replace fin33_r = 0 if missing(fin33)

generate byte fin34a_r = (fin34a == 1) if inlist(fin34a, 1, 2)
replace fin34a_r = 0 if missing(fin34a)

generate byte fin34b_r = (fin34b == 1) if inlist(fin34b, 1, 2)
replace fin34b_r = 0 if missing(fin34b)

generate byte fin34c_r = (fin34c == 1) if inlist(fin34c, 1, 2)
replace fin34c_r = 0 if missing(fin34c)

generate byte fin43a_r = (fin43a == 1) if inlist(fin43a, 1, 2)
replace fin43a_r = 0 if missing(fin43a)

generate byte fin43b_r = (fin43b == 1) if inlist(fin43b, 1, 2)
replace fin43b_r = 0 if missing(fin43b)

generate byte fin43c_r = (fin43c == 1) if inlist(fin43c, 1, 2)
replace fin43c_r = 0 if missing(fin43c)

generate byte fin43d_r = (fin43d == 1) if inlist(fin43d, 1, 2)
replace fin43d_r = 0 if missing(fin43d)

generate byte fin22g_r = (fin22g == 1) if inlist(fin22g, 1, 2)
replace fin22g_r = 0 if missing(fin22g)

generate byte fin22h_r = (fin22h == 1) if inlist(fin22h, 1, 2)
replace fin22h_r = 0 if missing(fin22h)

generate byte fin17b_r = (fin17b == 1) if inlist(fin17b, 1, 2)
replace fin17b_r = 0 if missing(fin17b)

generate byte fin17e_r = (fin17e == 1) if inlist(fin17e, 1, 2)
replace fin17e_r = 0 if missing(fin17e)

generate byte fin24d1_r = ///
    (fin24d1 == 1) if inlist(fin24d1, 1, 2)
replace fin24d1_r = 0 if missing(fin24d1)

generate byte fin24d2_r = ///
    (fin24d2 == 1) if inlist(fin24d2, 1, 2)
replace fin24d2_r = 0 if missing(fin24d2)

generate byte fin24d3_r = ///
    (fin24d3 == 1) if inlist(fin24d3, 1, 2)
replace fin24d3_r = 0 if missing(fin24d3)

generate byte fin22c_r = (fin22c == 1) if inlist(fin22c, 1, 2)
replace fin22c_r = 0 if missing(fin22c)

generate byte fin39a_r = (fin39a == 1) if inlist(fin39a, 1, 2)
replace fin39a_r = 0 if missing(fin39a)

generate byte fin39b_r = (fin39b == 1) if inlist(fin39b, 1, 2)
replace fin39b_r = 0 if missing(fin39b)

generate byte fin39c_r = (fin39c == 1) if inlist(fin39c, 1, 2)
replace fin39c_r = 0 if missing(fin39c)

generate byte fin39d_r = (fin39d == 1) if inlist(fin39d, 1, 2)
replace fin39d_r = 0 if missing(fin39d)

generate byte fin28_r = (fin28 == 1) if inlist(fin28, 1, 2)
replace fin28_r = 0 if missing(fin28)

generate byte fin29_r = (fin29 == 1) if inlist(fin29, 1, 2)
replace fin29_r = 0 if missing(fin29)

generate byte fin17f_r = (fin17f == 1) if inlist(fin17f, 1, 2)
replace fin17f_r = 0 if missing(fin17f)

generate byte fin21_r = fin21
replace fin21_r = 0 if inlist(fin21, ., 2)

* ---------------------------------------------------------------------------
* 4. Binary variables where structural missing means Yes
* ---------------------------------------------------------------------------

generate byte fin7_r = (fin7 == 1) if inlist(fin7, 1, 2)
replace fin7_r = 1 if missing(fin7)

generate byte fin18_r = (fin18 == 1) if inlist(fin18, 1, 2)
replace fin18_r = 1 if missing(fin18)

generate byte fin23_r = (fin23 == 1) if inlist(fin23, 1, 2)
replace fin23_r = 1 if missing(fin23)


* Apply the common Yes/No value label

label values account_fin_r ///
    fin2_r fin3_r fin7_r fin8_r fin9a_r fin9b_r fin10_r ///
    fin25e1_r fin25e2_r fin26a_r fin26b_r ///
    fin31a_r fin31b_r fin31c_r fin31d_r ///
    fin33_r fin34a_r fin34b_r fin34c_r ///
    fin43a_r fin43b_r fin43c_r fin43d_r ///
    fin20_r fin21_r fin22f_r fin22g_r fin22h_r ///
    fin17a_r fin17b_r fin17c_r fin17e_r fin18_r ///
    fin24c_r fin24d1_r fin24d2_r fin24d3_r fin19_r ///
    fin22a_r fin22b_r fin22c_r fin22d_r fin23_r ///
    fin37_r fin39a_r fin39b_r fin39c_r fin39d_r ///
    fin28_r fin29_r fin17f_r fin22e_r fin38_r ///
    fin30_r fin32_r fin42_r fh1_r fh2_r fh2a_r ///
    fin13d_r yesno_r


* ---------------------------------------------------------------------------
* 5. Ordered variables
* ---------------------------------------------------------------------------

* FIN5: structural missing becomes Never=4.
* Original DK=5 and refused=6 become missing.

generate byte fin5_r = fin5
replace fin5_r = . if inlist(fin5, 5, 6)
replace fin5_r = 4 if missing(fin5)


* FIN6: structural missing becomes Never=4.
* Original DK=5 and refused=6 become missing.

generate byte fin6_r = fin6
replace fin6_r = . if inlist(fin6, 5, 6)
replace fin6_r = 4 if missing(fin6)


* FIN25E3: structural missing becomes Less than once a month=3.

generate byte fin25e3_r = fin25e3
replace fin25e3_r = . if inlist(fin25e3, 4, 5)
replace fin25e3_r = 3 if missing(fin25e3)


* FIN17D: structural missing becomes Less than once a month=3.
* DK=4 is retained. Refused=5 becomes missing.

generate byte fin17d_r = fin17d
replace fin17d_r = . if fin17d == 5
replace fin17d_r = 3 if missing(fin17d)


* Ordered-variable labels

label define freq4_r ///
    1 "Weekly" ///
    2 "Monthly" ///
    3 "Less than once a month" ///
    4 "Never", replace

label values fin5_r fin6_r freq4_r

label define freq3_r ///
    1 "Weekly" ///
    2 "Monthly" ///
    3 "Less than once a month", replace

label values fin25e3_r freq3_r

label define freq3dk_r ///
    1 "Weekly" ///
    2 "Monthly" ///
    3 "Less than once a month" ///
    4 "Don't know", replace

label values fin17d_r freq3dk_r


* ---------------------------------------------------------------------------
* 6. Categorical variables and new n+1 categories
* ---------------------------------------------------------------------------

* FIN25E4
* Existing categories 1-5 are substantive.
* DK=6 is retained.
* Refused=7 becomes missing.
* Structural missing receives the new n+1 category 7.

generate byte fin25e4_r = fin25e4
replace fin25e4_r = . if fin25e4 == 7
replace fin25e4_r = 7 if missing(fin25e4)

label define lbl_fin25e4_r ///
    1 "Merchant only accepts cash" ///
    2 "More expensive to use card or phone" ///
    3 "Does not trust card or phone payments" ///
    4 "Used to paying by cash" ///
    5 "Some other reason" ///
    6 "Don't know" ///
    7 "Has used mobile phone", replace

label values fin25e4_r lbl_fin25e4_r


* FIN27
* DK=4 and refused=5 first become missing.
* Original structural missing receives new category 4.

generate byte fin27_r = fin27
replace fin27_r = . if inlist(fin27, 4, 5)
replace fin27_r = 4 if missing(fin27)

label define lbl_fin27_r ///
    1 "Pay online" ///
    2 "In cash" ///
    3 "Both" ///
    4 "Does not buy online", replace

label values fin27_r lbl_fin27_r


* FIN34D
* DK=3 and refused=4 become missing.
* Structural missing receives new category 3.

generate byte fin34d_r = fin34d
replace fin34d_r = . if inlist(fin34d, 3, 4)
replace fin34d_r = 3 if missing(fin34d)

label define lbl_fin34d_r ///
    1 "Yes" ///
    2 "No" ///
    3 "Other forms of payment for salary and wages", replace

label values fin34d_r lbl_fin34d_r


* FIN35
* DK=3 and refused=4 become missing.
* Structural missing receives new category 3.

generate byte fin35_r = fin35
replace fin35_r = . if inlist(fin35, 3, 4)
replace fin35_r = 3 if missing(fin35)

label define lbl_fin35_r ///
    1 "Yes" ///
    2 "No" ///
    3 "Not applicable", replace

label values fin35_r lbl_fin35_r


* FIN36
* DK=4 and refused=5 become missing.
* Structural missing receives new category 4.

generate byte fin36_r = fin36
replace fin36_r = . if inlist(fin36, 4, 5)
replace fin36_r = 4 if missing(fin36)

label define lbl_fin36_r ///
    1 "Take out all as cash at one time" ///
    2 "Leave some money in the account" ///
    3 "Transfer money to another personal account" ///
    4 "Not employed / received money in cash", replace

label values fin36_r lbl_fin36_r


* FIN24
* DK=8 is retained.
* Refused=9 becomes missing.

generate byte fin24_r = fin24
replace fin24_r = . if fin24 == 9

label define lbl_fin24_r ///
    1 "Savings" ///
    2 "Family, relatives, or friends" ///
    3 "Money from working" ///
    4 "Loan from institution, employer, or private lender" ///
    5 "Selling something owned" ///
    6 "Some other source" ///
    7 "Could not come up with the money" ///
    8 "Don't know", replace

label values fin24_r lbl_fin24_r


* FIN24A Likert Scale, Numerical
* (.) in fin24a can either be unable to come up with money-->very difficult, or actually unknown
* I will replace fin24a==. to fin24a==1 if fin24==7
* DK and refused is treated as missing n=31

generate byte fin24a_r = fin24a

replace fin24a_r = 1 ///
	if fin24 == 7 & missing(fin24a)

replace fin24a_r = . ///
	if inlist(fin24a, 4, 5)
	
	
* FIN24B
* DK=5 is retained.
* Refused=6 becomes missing.

generate byte fin24b_r = fin24b
replace fin24b_r = . if fin24b == 6

* FIN40
* DK=4 and refused=5 become missing.
* Structural missing receives new category 3.

generate byte fin40_r = fin40
replace fin40_r = . if inlist(fin40, 3, 4, 5)
replace fin40_r = 3 if missing(fin40)

label define lbl_fin40_r ///
    1 "Take out all as cash at one time" ///
    2 "Leave some money in the account" ///
    3 "Not applicable / does not receive money", replace

label values fin40_r lbl_fin40_r


* FIN41
* DK=3 and refused=4 become missing.
* Structural missing receives new category 3.

generate byte fin41_r = fin41
replace fin41_r = . if inlist(fin41, 3, 4)
replace fin41_r = 3 if missing(fin41)

label define lbl_fin41_r ///
    1 "Yes" ///
    2 "No" ///
    3 "Not applicable / does not receive money from government", replace

label values fin41_r lbl_fin41_r


* FIN44
* DK=3 and refused=4 become missing.
* Structural missing receives new category 3.

generate byte fin44_r = fin44
replace fin44_r = . if inlist(fin44, 3, 4)
replace fin44_r = 3 if missing(fin44)

label define lbl_fin44_r ///
    1 "Yes" ///
    2 "No" ///
    3 "Not applicable", replace

label values fin44_r lbl_fin44_r


* FIN45
* DK=7 is retained.
* Refused=8 becomes missing.

generate byte fin45_r = fin45
replace fin45_r = . if fin45 == 8

label define lbl_fin45_r ///
    1 "For old age" ///
    2 "For business" ///
    3 "For medical costs" ///
    4 "For monthly expenses" ///
    5 "For school or education fees" ///
    6 "Some other reason" ///
    7 "Don't know", replace

label values fin45_r lbl_fin45_r


* ---------------------------------------------------------------------------
* 7. Numerical score helpers for mixed categorical variables
*    The score variables preserve the numerical row in the summary table.
*    New not-applicable categories and retained DK categories are excluded
*    from the score, but remain available in the categorical breakdown.
* ---------------------------------------------------------------------------
/*
generate byte fin34d_score = (fin34d_r == 1) if inlist(fin34d_r, 1, 2)
generate byte fin35_score  = (fin35_r  == 1) if inlist(fin35_r,  1, 2)
generate byte fin41_score  = (fin41_r  == 1) if inlist(fin41_r,  1, 2)
generate byte fin44_score  = (fin44_r  == 1) if inlist(fin44_r,  1, 2)

label values fin34d_score fin35_score ///
    fin41_score fin44_score yesno_r

label variable fin34d_score "fin34d"
label variable fin35_score  "fin35"
label variable fin41_score  "fin41"
label variable fin44_score  "fin44"
*/

* ---------------------------------------------------------------------------
* 8. Breaking down categorical specifications into its own binary variable [note: could've used tab var, gen(var)]
* ---------------------------------------------------------------------------

* FIN5
generate byte fin5_weekly      = (fin5_r == 1) if !missing(fin5_r)
generate byte fin5_monthly     = (fin5_r == 2) if !missing(fin5_r)
generate byte fin5_less_month  = (fin5_r == 3) if !missing(fin5_r)
generate byte fin5_never       = (fin5_r == 4) if !missing(fin5_r)

label variable fin5_weekly     "fin5: Weekly"
label variable fin5_monthly    "fin5: Monthly"
label variable fin5_less_month "fin5: Less than once a month"
label variable fin5_never      "fin5: Never"

assert fin5_weekly + fin5_monthly + fin5_less_month + fin5_never == 1 ///
    if !missing(fin5_r)


* FIN6
generate byte fin6_weekly      = (fin6_r == 1) if !missing(fin6_r)
generate byte fin6_monthly     = (fin6_r == 2) if !missing(fin6_r)
generate byte fin6_less_month  = (fin6_r == 3) if !missing(fin6_r)
generate byte fin6_never       = (fin6_r == 4) if !missing(fin6_r)

label variable fin6_weekly     "fin6: Weekly"
label variable fin6_monthly    "fin6: Monthly"
label variable fin6_less_month "fin6: Less than once a month"
label variable fin6_never      "fin6: Never"

assert fin6_weekly + fin6_monthly + fin6_less_month + fin6_never == 1 ///
    if !missing(fin6_r)


* FIN25E3
generate byte fin25e3_weekly     = (fin25e3_r == 1) if !missing(fin25e3_r)
generate byte fin25e3_monthly    = (fin25e3_r == 2) if !missing(fin25e3_r)
generate byte fin25e3_less_month = (fin25e3_r == 3) if !missing(fin25e3_r)

label variable fin25e3_weekly     "fin25e3: Weekly"
label variable fin25e3_monthly    "fin25e3: Monthly"
label variable fin25e3_less_month "fin25e3: Less than once a month"

assert fin25e3_weekly + fin25e3_monthly + fin25e3_less_month == 1 ///
    if !missing(fin25e3_r)


* FIN25E4
generate byte fin25e4_merchant_cash = ///
    (fin25e4_r == 1) if !missing(fin25e4_r)
generate byte fin25e4_more_expensive = ///
    (fin25e4_r == 2) if !missing(fin25e4_r)
generate byte fin25e4_no_trust = ///
    (fin25e4_r == 3) if !missing(fin25e4_r)
generate byte fin25e4_used_cash = ///
    (fin25e4_r == 4) if !missing(fin25e4_r)
generate byte fin25e4_other = ///
    (fin25e4_r == 5) if !missing(fin25e4_r)
generate byte fin25e4_dk = ///
    (fin25e4_r == 6) if !missing(fin25e4_r)
generate byte fin25e4_phone_used = ///
    (fin25e4_r == 7) if !missing(fin25e4_r)

label variable fin25e4_merchant_cash "fin25e4: Merchant only accepts cash"
label variable fin25e4_more_expensive "fin25e4: More expensive"
label variable fin25e4_no_trust "fin25e4: Does not trust card or phone"
label variable fin25e4_used_cash "fin25e4: Used to paying by cash"
label variable fin25e4_other "fin25e4: Some other reason"
label variable fin25e4_dk "fin25e4: Don't know"
label variable fin25e4_phone_used "fin25e4: Has used mobile phone"

assert fin25e4_merchant_cash + fin25e4_more_expensive + ///
    fin25e4_no_trust + fin25e4_used_cash + fin25e4_other + ///
    fin25e4_dk + fin25e4_phone_used == 1 if !missing(fin25e4_r)


* FIN27
generate byte fin27_online = (fin27_r == 1) if !missing(fin27_r)
generate byte fin27_cash   = (fin27_r == 2) if !missing(fin27_r)
generate byte fin27_both   = (fin27_r == 3) if !missing(fin27_r)
generate byte fin27_no_online_purchase = ///
    (fin27_r == 4) if !missing(fin27_r)

label variable fin27_online "fin27: Pay online"
label variable fin27_cash "fin27: In cash"
label variable fin27_both "fin27: Both"
label variable fin27_no_online_purchase "fin27: Does not buy online"

assert fin27_online + fin27_cash + fin27_both + ///
    fin27_no_online_purchase == 1 if !missing(fin27_r)


* FIN34D
generate byte fin34d_yes = ///
    (fin34d_r == 1) if !missing(fin34d_r)
generate byte fin34d_no = ///
    (fin34d_r == 2) if !missing(fin34d_r)
generate byte fin34d_other_payment = ///
    (fin34d_r == 3) if !missing(fin34d_r)

label variable fin34d_yes ///
    "fin34d: Yes"
label variable fin34d_no ///
    "fin34d: No"
label variable fin34d_other_payment ///
    "fin34d: Not applicable / other forms of salary payment"

assert fin34d_yes + fin34d_no + ///
    fin34d_other_payment == 1 if !missing(fin34d_r)


* FIN35
generate byte fin35_yes = ///
    (fin35_r == 1) if !missing(fin35_r)
generate byte fin35_no = ///
    (fin35_r == 2) if !missing(fin35_r)
generate byte fin35_not_applicable = ///
    (fin35_r == 3) if !missing(fin35_r)

label variable fin35_yes ///
    "fin35: Yes"
label variable fin35_no ///
    "fin35: No"
label variable fin35_not_applicable ///
    "fin35: Not applicable / receives money in cash"

assert fin35_yes + fin35_no + ///
    fin35_not_applicable == 1 if !missing(fin35_r)


/*
	* FIN21 and FIN24A: added categories
generate byte fin21_not_applicable = ///
    (fin21_r == 3) if !missing(fin21_r)
generate byte fin24a_not_applicable = ///
    (fin24a_r == 4) if !missing(fin24a_r)

label variable fin21_not_applicable ///
    "fin21: Not applicable"
* FIN34D, FIN35, FIN24A: added n+1 categories
generate byte fin34d_other_payment = ///
    (fin34d_r == 3) if !missing(fin34d_r)
generate byte fin35_not_applicable = ///
    (fin35_r == 3) if !missing(fin35_r)
generate byte fin24a_not_applicable = ///
    (fin24a_r == 4) if !missing(fin24a_r)

label variable fin34d_other_payment "fin34d: Other forms of salary payment"
label variable fin35_not_applicable "fin35: Not applicable"

*/

* FIN36
generate byte fin36_all_cash = (fin36_r == 1) if !missing(fin36_r)
generate byte fin36_leave_money = (fin36_r == 2) if !missing(fin36_r)
generate byte fin36_transfer = (fin36_r == 3) if !missing(fin36_r)
generate byte fin36_not_applicable = ///
    (fin36_r == 4) if !missing(fin36_r)

label variable fin36_all_cash "fin36: Take out all as cash"
label variable fin36_leave_money "fin36: Leave some money"
label variable fin36_transfer "fin36: Transfer to another account"
label variable fin36_not_applicable "fin36: Not applicable"

assert fin36_all_cash + fin36_leave_money + fin36_transfer + ///
    fin36_not_applicable == 1 if !missing(fin36_r)


* FIN17D
generate byte fin17d_weekly = (fin17d_r == 1) if !missing(fin17d_r)
generate byte fin17d_monthly = (fin17d_r == 2) if !missing(fin17d_r)
generate byte fin17d_less_month = (fin17d_r == 3) if !missing(fin17d_r)
generate byte fin17d_dk = (fin17d_r == 4) if !missing(fin17d_r)

label variable fin17d_weekly "fin17d: Weekly"
label variable fin17d_monthly "fin17d: Monthly"
label variable fin17d_less_month "fin17d: Less than once a month"
label variable fin17d_dk "fin17d: Don't know"

assert fin17d_weekly + fin17d_monthly + fin17d_less_month + ///
    fin17d_dk == 1 if !missing(fin17d_r)


* FIN24
generate byte fin24_savings = (fin24_r == 1) if !missing(fin24_r)
generate byte fin24_family = (fin24_r == 2) if !missing(fin24_r)
generate byte fin24_work = (fin24_r == 3) if !missing(fin24_r)
generate byte fin24_loan = (fin24_r == 4) if !missing(fin24_r)
generate byte fin24_sell_asset = (fin24_r == 5) if !missing(fin24_r)
generate byte fin24_other = (fin24_r == 6) if !missing(fin24_r)
generate byte fin24_cannot_raise = (fin24_r == 7) if !missing(fin24_r)
generate byte fin24_dk = (fin24_r == 8) if !missing(fin24_r)

label variable fin24_savings "fin24: Savings"
label variable fin24_family "fin24: Family, relatives, or friends"
label variable fin24_work "fin24: Money from working"
label variable fin24_loan "fin24: Loan"
label variable fin24_sell_asset "fin24: Selling something owned"
label variable fin24_other "fin24: Some other source"
label variable fin24_cannot_raise "fin24: Could not come up with money"
label variable fin24_dk "fin24: Don't know"

assert fin24_savings + fin24_family + fin24_work + fin24_loan + ///
    fin24_sell_asset + fin24_other + fin24_cannot_raise + fin24_dk == 1 ///
    if !missing(fin24_r)

* FIN24B
generate byte fin24b_less_2weeks = ///
    (fin24b_r == 1) if !missing(fin24b_r)
generate byte fin24b_one_month = ///
    (fin24b_r == 2) if !missing(fin24b_r)
generate byte fin24b_two_months = ///
    (fin24b_r == 3) if !missing(fin24b_r)
generate byte fin24b_more_2months = ///
    (fin24b_r == 4) if !missing(fin24b_r)
generate byte fin24b_dk = ///
    (fin24b_r == 5) if !missing(fin24b_r)

label variable fin24b_less_2weeks "fin24b: Less than two weeks"
label variable fin24b_one_month "fin24b: About one month"
label variable fin24b_two_months "fin24b: About two months"
label variable fin24b_more_2months "fin24b: More than two months"
label variable fin24b_dk "fin24b: Don't know"

assert fin24b_less_2weeks + fin24b_one_month + fin24b_two_months + ///
    fin24b_more_2months + fin24b_dk == 1 if !missing(fin24b_r)


* FIN40
generate byte fin40_all_cash = (fin40_r == 1) if !missing(fin40_r)
generate byte fin40_leave_money = (fin40_r == 2) if !missing(fin40_r)
generate byte fin40_not_applicable = ///
    (fin40_r == 3) if !missing(fin40_r)

label variable fin40_all_cash "fin40: Take out all as cash"
label variable fin40_leave_money "fin40: Leave some money"
label variable fin40_not_applicable "fin40: Not applicable"

assert fin40_all_cash + fin40_leave_money + ///
    fin40_not_applicable == 1 if !missing(fin40_r)


* FIN41
generate byte fin41_yes = ///
    (fin41_r == 1) if !missing(fin41_r)
generate byte fin41_no = ///
    (fin41_r == 2) if !missing(fin41_r)
generate byte fin41_not_applicable = ///
    (fin41_r == 3) if !missing(fin41_r)

label variable fin41_yes ///
    "fin41: Yes"
label variable fin41_no ///
    "fin41: No"
label variable fin41_not_applicable ///
    "fin41: Not applicable / does not receive government money"

assert fin41_yes + fin41_no + ///
    fin41_not_applicable == 1 if !missing(fin41_r)


* FIN44
generate byte fin44_yes = ///
    (fin44_r == 1) if !missing(fin44_r)
generate byte fin44_no = ///
    (fin44_r == 2) if !missing(fin44_r)
generate byte fin44_not_applicable = ///
    (fin44_r == 3) if !missing(fin44_r)

label variable fin44_yes ///
    "fin44: Yes"
label variable fin44_no ///
    "fin44: No"
label variable fin44_not_applicable ///
    "fin44: Not applicable"

assert fin44_yes + fin44_no + ///
    fin44_not_applicable == 1 if !missing(fin44_r)
	
/*
	* FIN41 and FIN44: added n+1 categories
generate byte fin41_not_applicable = ///
    (fin41_r == 3) if !missing(fin41_r)
generate byte fin44_not_applicable = ///
    (fin44_r == 3) if !missing(fin44_r)

label variable fin41_not_applicable "fin41: Not applicable"
label variable fin44_not_applicable "fin44: Not applicable"
*/


* FIN45
generate byte fin45_old_age = (fin45_r == 1) if !missing(fin45_r)
generate byte fin45_business = (fin45_r == 2) if !missing(fin45_r)
generate byte fin45_medical = (fin45_r == 3) if !missing(fin45_r)
generate byte fin45_monthly_expenses = ///
    (fin45_r == 4) if !missing(fin45_r)
generate byte fin45_education = (fin45_r == 5) if !missing(fin45_r)
generate byte fin45_other = (fin45_r == 6) if !missing(fin45_r)
generate byte fin45_dk = (fin45_r == 7) if !missing(fin45_r)

label variable fin45_old_age "fin45: For old age"
label variable fin45_business "fin45: For business"
label variable fin45_medical "fin45: For medical costs"
label variable fin45_monthly_expenses "fin45: For monthly expenses"
label variable fin45_education "fin45: For education fees"
label variable fin45_other "fin45: Some other reason"
label variable fin45_dk "fin45: Don't know"

assert fin45_old_age + fin45_business + fin45_medical + ///
    fin45_monthly_expenses + fin45_education + fin45_other + fin45_dk == 1 ///
    if !missing(fin45_r)


* ---------------------------------------------------------------------------
* 9. Weighted numerical summary statistics
* ---------------------------------------------------------------------------

capture which estpost

estpost tabstat ///
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
    [aw=wgt], ///
    statistics(count min max mean sd p50) ///
    columns(statistics)

* Exporting estpost to Excel

matrix numerical_stats = (e(count)' , e(min)' , e(max)' , e(mean)' , e(sd)' , e(p50)')
matrix colnames numerical_stats = N Minimum Maximum Mean SD Median
matrix list numerical_stats

putexcel set  "`workbook'", ///
    sheet("Summary Statistics") replace

putexcel A1 = matrix(numerical_stats), names

* ---------------------------------------------------------------------------
* 10. Weighted categorical distributions
*    Missing DK/refusal responses are excluded unless DK was explicitly kept.
* ---------------------------------------------------------------------------

tabulate fin25e4_r [aw=wgt]
tabulate fin27_r   [aw=wgt]
tabulate fin34d_r  [aw=wgt]
tabulate fin35_r   [aw=wgt]
tabulate fin36_r   [aw=wgt]

tabulate fin17d_r  [aw=wgt]
tabulate fin24a_r  [aw=wgt]
tabulate fin24b_r  [aw=wgt]

tabulate fin40_r   [aw=wgt]
tabulate fin41_r   [aw=wgt]
tabulate fin44_r   [aw=wgt]
tabulate fin45_r   [aw=wgt]


* ---------------------------------------------------------------------------
* 11. Categorical Excel Rows
* ---------------------------------------------------------------------------

tempfile category_statistics
tempname category_post

postfile `category_post' ///
    int order ///
    str12 code ///
    str80 category ///
    str32 dummy_variable ///
    double N minimum maximum mean sd median ///
    using "`category_statistics'", replace


* FIN5
quietly count if fin5_weekly == 1
local category_N = r(N)
quietly summarize fin5_weekly [aw=wgt], detail
post `category_post' (1) ("fin5") ("Weekly") ("fin5_weekly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin5_monthly == 1
local category_N = r(N)
quietly summarize fin5_monthly [aw=wgt], detail
post `category_post' (2) ("fin5") ("Monthly") ("fin5_monthly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin5_less_month == 1
local category_N = r(N)
quietly summarize fin5_less_month [aw=wgt], detail
post `category_post' (3) ("fin5") ("Less than once a month") ///
    ("fin5_less_month") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin5_never == 1
local category_N = r(N)
quietly summarize fin5_never [aw=wgt], detail
post `category_post' (4) ("fin5") ("Never") ("fin5_never") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN6
quietly count if fin6_weekly == 1
local category_N = r(N)
quietly summarize fin6_weekly [aw=wgt], detail
post `category_post' (5) ("fin6") ("Weekly") ("fin6_weekly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin6_monthly == 1
local category_N = r(N)
quietly summarize fin6_monthly [aw=wgt], detail
post `category_post' (6) ("fin6") ("Monthly") ("fin6_monthly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin6_less_month == 1
local category_N = r(N)
quietly summarize fin6_less_month [aw=wgt], detail
post `category_post' (7) ("fin6") ("Less than once a month") ///
    ("fin6_less_month") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin6_never == 1
local category_N = r(N)
quietly summarize fin6_never [aw=wgt], detail
post `category_post' (8) ("fin6") ("Never") ("fin6_never") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN25E3
quietly count if fin25e3_weekly == 1
local category_N = r(N)
quietly summarize fin25e3_weekly [aw=wgt], detail
post `category_post' (9) ("fin25e3") ("Weekly") ("fin25e3_weekly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e3_monthly == 1
local category_N = r(N)
quietly summarize fin25e3_monthly [aw=wgt], detail
post `category_post' (10) ("fin25e3") ("Monthly") ///
    ("fin25e3_monthly") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e3_less_month == 1
local category_N = r(N)
quietly summarize fin25e3_less_month [aw=wgt], detail
post `category_post' (11) ("fin25e3") ("Less than once a month") ///
    ("fin25e3_less_month") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN25E4
quietly count if fin25e4_merchant_cash == 1
local category_N = r(N)
quietly summarize fin25e4_merchant_cash [aw=wgt], detail
post `category_post' (12) ("fin25e4") ///
    ("Because the merchant only accepts cash") ("fin25e4_merchant_cash") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e4_more_expensive == 1
local category_N = r(N)
quietly summarize fin25e4_more_expensive [aw=wgt], detail
post `category_post' (13) ("fin25e4") ///
    ("More expensive to pay using a card or phone") ///
    ("fin25e4_more_expensive") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e4_used_cash == 1
local category_N = r(N)
quietly summarize fin25e4_used_cash [aw=wgt], detail
post `category_post' (14) ("fin25e4") ("Used to paying by cash") ///
    ("fin25e4_used_cash") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e4_other == 1
local category_N = r(N)
quietly summarize fin25e4_other [aw=wgt], detail
post `category_post' (15) ("fin25e4") ("Some other reason") ///
    ("fin25e4_other") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e4_dk == 1
local category_N = r(N)
quietly summarize fin25e4_dk [aw=wgt], detail
post `category_post' (16) ("fin25e4") ("Don't know") ("fin25e4_dk") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin25e4_phone_used == 1
local category_N = r(N)
quietly summarize fin25e4_phone_used [aw=wgt], detail
post `category_post' (17) ("fin25e4") ///
    ("Not applicable / has used mobile phone payment") ///
    ("fin25e4_phone_used") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN27
quietly count if fin27_online == 1
local category_N = r(N)
quietly summarize fin27_online [aw=wgt], detail
post `category_post' (18) ("fin27") ("Pay online") ("fin27_online") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin27_cash == 1
local category_N = r(N)
quietly summarize fin27_cash [aw=wgt], detail
post `category_post' (19) ("fin27") ("In cash") ("fin27_cash") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin27_both == 1
local category_N = r(N)
quietly summarize fin27_both [aw=wgt], detail
post `category_post' (20) ("fin27") ("Both") ("fin27_both") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin27_no_online_purchase == 1
local category_N = r(N)
quietly summarize fin27_no_online_purchase [aw=wgt], detail
post `category_post' (21) ("fin27") ("Does not buy online") ///
    ("fin27_no_online_purchase") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN34D
quietly summarize fin34d_yes [aw=wgt], detail
local category_N = r(N)
post `category_post' (22) ("fin34d") ("Yes") ("fin34d_yes") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin34d_no [aw=wgt], detail
local category_N = r(N)
post `category_post' (23) ("fin34d") ("No") ("fin34d_no") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin34d_other_payment [aw=wgt], detail
local category_N = r(N)
post `category_post' (24) ("fin34d") ///
    ("Not applicable / other forms of salary payment") ///
    ("fin34d_other_payment") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN35
quietly summarize fin35_yes [aw=wgt], detail
local category_N = r(N)
post `category_post' (25) ("fin35") ("Yes") ("fin35_yes") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin35_no [aw=wgt], detail
local category_N = r(N)
post `category_post' (26) ("fin35") ("No") ("fin35_no") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin35_not_applicable [aw=wgt], detail
local category_N = r(N)
post `category_post' (27) ("fin35") ///
    ("Not applicable / receives money in cash") ///
    ("fin35_not_applicable") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN36
quietly count if fin36_all_cash == 1
local category_N = r(N)
quietly summarize fin36_all_cash [aw=wgt], detail
post `category_post' (28) ("fin36") ("Take out all as cash at one time") ///
    ("fin36_all_cash") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin36_leave_money == 1
local category_N = r(N)
quietly summarize fin36_leave_money [aw=wgt], detail
post `category_post' (29) ("fin36") ("Leave some money in the account") ///
    ("fin36_leave_money") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin36_transfer == 1
local category_N = r(N)
quietly summarize fin36_transfer [aw=wgt], detail
post `category_post' (30) ("fin36") ///
    ("Transfer money to another personal account") ("fin36_transfer") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin36_not_applicable == 1
local category_N = r(N)
quietly summarize fin36_not_applicable [aw=wgt], detail
post `category_post' (31) ("fin36") ///
    ("Not employed / received money in cash") ("fin36_not_applicable") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

* FIN17D
quietly count if fin17d_weekly == 1
local category_N = r(N)
quietly summarize fin17d_weekly [aw=wgt], detail
post `category_post' (32) ("fin17d") ("Weekly") ("fin17d_weekly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin17d_monthly == 1
local category_N = r(N)
quietly summarize fin17d_monthly [aw=wgt], detail
post `category_post' (33) ("fin17d") ("Monthly") ("fin17d_monthly") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin17d_less_month == 1
local category_N = r(N)
quietly summarize fin17d_less_month [aw=wgt], detail
post `category_post' (34) ("fin17d") ("Less than once a month") ///
    ("fin17d_less_month") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin17d_dk == 1
local category_N = r(N)
quietly summarize fin17d_dk [aw=wgt], detail
post `category_post' (35) ("fin17d") ("Don't know") ("fin17d_dk") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN24
quietly count if fin24_savings == 1
local category_N = r(N)
quietly summarize fin24_savings [aw=wgt], detail
post `category_post' (36) ("fin24") ("Savings") ("fin24_savings") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_family == 1
local category_N = r(N)
quietly summarize fin24_family [aw=wgt], detail
post `category_post' (37) ("fin24") ///
    ("Family, relatives, or friends") ("fin24_family") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_work == 1
local category_N = r(N)
quietly summarize fin24_work [aw=wgt], detail
post `category_post' (38) ("fin24") ("Money from working") ///
    ("fin24_work") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_loan == 1
local category_N = r(N)
quietly summarize fin24_loan [aw=wgt], detail
post `category_post' (39) ("fin24") ///
    ("Loan from financial institution, employer, or private lender") ///
    ("fin24_loan") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_sell_asset == 1
local category_N = r(N)
quietly summarize fin24_sell_asset [aw=wgt], detail
post `category_post' (40) ("fin24") ///
    ("Selling something you own") ("fin24_sell_asset") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_other == 1
local category_N = r(N)
quietly summarize fin24_other [aw=wgt], detail
post `category_post' (41) ("fin24") ("Other") ("fin24_other") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_cannot_raise == 1
local category_N = r(N)
quietly summarize fin24_cannot_raise [aw=wgt], detail
post `category_post' (42) ("fin24") ("Cannot come up with the money") ///
    ("fin24_cannot_raise") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24_dk == 1
local category_N = r(N)
quietly summarize fin24_dk [aw=wgt], detail
post `category_post' (43) ("fin24") ("Don't know") ("fin24_dk") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

* FIN24B
quietly count if fin24b_less_2weeks == 1
local category_N = r(N)
quietly summarize fin24b_less_2weeks [aw=wgt], detail
post `category_post' (44) ("fin24b") ("Less than two weeks") ///
    ("fin24b_less_2weeks") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24b_one_month == 1
local category_N = r(N)
quietly summarize fin24b_one_month [aw=wgt], detail
post `category_post' (45) ("fin24b") ("About one month") ///
    ("fin24b_one_month") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24b_two_months == 1
local category_N = r(N)
quietly summarize fin24b_two_months [aw=wgt], detail
post `category_post' (46) ("fin24b") ("About two months") ///
    ("fin24b_two_months") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24b_more_2months == 1
local category_N = r(N)
quietly summarize fin24b_more_2months [aw=wgt], detail
post `category_post' (47) ("fin24b") ("More than two months") ///
    ("fin24b_more_2months") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin24b_dk == 1
local category_N = r(N)
quietly summarize fin24b_dk [aw=wgt], detail
post `category_post' (48) ("fin24b") ("Don't know") ("fin24b_dk") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN40
quietly count if fin40_all_cash == 1
local category_N = r(N)
quietly summarize fin40_all_cash [aw=wgt], detail
post `category_post' (49) ("fin40") ("Take out all as cash at one time") ///
    ("fin40_all_cash") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin40_leave_money == 1
local category_N = r(N)
quietly summarize fin40_leave_money [aw=wgt], detail
post `category_post' (50) ("fin40") ("Leave some money in the account") ///
    ("fin40_leave_money") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin40_not_applicable == 1
local category_N = r(N)
quietly summarize fin40_not_applicable [aw=wgt], detail
post `category_post' (51) ("fin40") ///
    ("Not applicable / does not receive money from government") ///
    ("fin40_not_applicable") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN41
quietly summarize fin41_yes [aw=wgt], detail
local category_N = r(N)
post `category_post' (52) ("fin41") ("Yes") ("fin41_yes") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin41_no [aw=wgt], detail
local category_N = r(N)
post `category_post' (53) ("fin41") ("No") ("fin41_no") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin41_not_applicable [aw=wgt], detail
local category_N = r(N)
post `category_post' (54) ("fin41") ///
    ("Not applicable / does not receive money from government") ///
    ("fin41_not_applicable") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN44
quietly summarize fin44_yes [aw=wgt], detail
local category_N = r(N)
post `category_post' (55) ("fin44") ("Yes") ("fin44_yes") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin44_no [aw=wgt], detail
local category_N = r(N)
post `category_post' (56) ("fin44") ("No") ("fin44_no") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly summarize fin44_not_applicable [aw=wgt], detail
local category_N = r(N)
post `category_post' (57) ("fin44") ("Not applicable") ///
    ("fin44_not_applicable") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


* FIN45
quietly count if fin45_old_age == 1
local category_N = r(N)
quietly summarize fin45_old_age [aw=wgt], detail
post `category_post' (58) ("fin45") ("For old age") ("fin45_old_age") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin45_business == 1
local category_N = r(N)
quietly summarize fin45_business [aw=wgt], detail
post `category_post' (59) ("fin45") ("For your business") ///
    ("fin45_business") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin45_medical == 1
local category_N = r(N)
quietly summarize fin45_medical [aw=wgt], detail
post `category_post' (60) ("fin45") ///
    ("For medical costs in case of serious illness or accident") ///
    ("fin45_medical") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin45_monthly_expenses == 1
local category_N = r(N)
quietly summarize fin45_monthly_expenses [aw=wgt], detail
post `category_post' (61) ("fin45") ///
    ("For monthly expenses, such as food, housing, or bills") ///
    ("fin45_monthly_expenses") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin45_education == 1
local category_N = r(N)
quietly summarize fin45_education [aw=wgt], detail
post `category_post' (62) ("fin45") ("For school or education fees") ///
    ("fin45_education") (`category_N') ///
    (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin45_other == 1
local category_N = r(N)
quietly summarize fin45_other [aw=wgt], detail
post `category_post' (63) ("fin45") ("Others") ("fin45_other") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))

quietly count if fin45_dk == 1
local category_N = r(N)
quietly summarize fin45_dk [aw=wgt], detail
post `category_post' (64) ("fin45") ("Don't know") ("fin45_dk") ///
    (`category_N') (r(min)) (r(max)) (r(mean)) (r(sd)) (r(p50))


postclose `category_post'

preserve
use "`category_statistics'", clear

isid order
sort order

label variable order          "Order"
label variable code           "Code"
label variable category       "Category"
label variable dummy_variable "Stata indicator"
label variable N              "Valid N"
label variable minimum        "Minimum"
label variable maximum        "Maximum"
label variable mean           "Weighted share"
label variable sd             "Weighted standard deviation"
label variable median         "Weighted median"

format N %9.0f
format minimum maximum median %9.0f
format mean sd %9.3f

export excel using ///
    "`workbook'", ///
    sheet("Category Statistics", replace) firstrow(varlabels)

restore

save "$project/output/1_summary_statistics_output.dta", replace
