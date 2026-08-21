*=============================================================================*
* MASTER DO-FILE: Global Findex Indonesia
*=============================================================================*

version 16
clear all
set more off

* User-specific project directory
if "`c(username)'" == "lolitamoorena" {
    global project "/Users/lolitamoorena/path/to/FINDEX"
}
else if "`c(username)'" == "sazwara" {
    global project ///
        "/Users/sazwara/Library/Mobile Documents/com~apple~CloudDocs/JPAL/FINDEX"
}
else {
    display as error "Project directory is not configured for this user."
    exit 198
}

* Shared directories
global code   "$project/FINDEX summary statistics"
global output "$project/output"

capture mkdir "$output"

* Run analysis
do "$code/01_Summary Statistics.do"
do "$code/02_correlation stats indicator.do"
do "$code/04_disaggregrated mean.do"

display as result "FINDEX analysis completed successfully."
