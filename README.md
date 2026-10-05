# Financial inclusion and financial well-being in Indonesia

Stata analysis of the World Bank’s Global Findex 2025 Indonesia microdata, examining financial-inclusion and financial well-being indicators across demographic and income groups.

The workflow produces summary statistics, weighted correlations, and demographic comparisons, with results exported to an Excel workbook.

## What the project covers

- Organising binary, ordinal, and categorical indicators for analysis.
- Excluding selected “don’t know” responses from ordinal scores.
- Calculating weighted pairwise Pearson correlations between indicators.
- Examining correlations with income-quintile membership.
- Reporting counts, weighted means, and standard deviations by sex, age group, income quintile, and rural or urban location.
- Estimating female–male and rural–urban differences using weighted survey regressions and linear contrasts.
- Exporting statistical matrices to separate Excel worksheets.

The correlation and disaggregation scripts check that the input contains 1,068 observations and that all observations belong to Indonesia.

## Repository contents

| Script | Purpose |
|---|---|
| `00_Directory.do` | Configure directories and run the analysis |
| `01_Summary Statistics.do` | Initial summary-statistics stage |
| `02_correlation stats indicator.do` | Indicator correlations and income-quintile comparisons |
| `04_disaggregrated mean.do` | Demographic summaries and group-difference tests |

## Where to start

`00_Directory.do` shows the execution order.

`02_correlation stats indicator.do` demonstrates the correlation workflow: organising indicator lists, calculating weighted matrices, extracting relevant columns, and exporting results.

`04_disaggregrated mean.do` demonstrates demographic-variable construction, subgroup reporting, and loops for estimating differences across multiple indicators.

## Data access

The original microdata are not included. Obtain the Global Findex 2025 Indonesia dataset directly from the World Bank and follow its access and citation requirements:

https://microdata.worldbank.org/catalog/7917

The correlation and disaggregation stages read the intermediate dataset `1_summary_statistics_output.dta`.

## Running the analysis

The scripts specify Stata 16. The disaggregated statistics use `estpost`, provided by the `estout` package.

1. Download the scripts and obtain the required microdata.
2. Update the project and code paths for your computer.
3. Ensure that the input filenames match those expected by the scripts.
4. Install `estout` if needed using `ssc install estout`.
5. Run `00_Directory.do`.

The analysis uses the project’s `output/` folder. The reporting workbook is `findex_statistics.xlsx`.

## Interpretation

Descriptive statistics and correlations use the respondent weight. Group-difference tests use a weight-only survey specification.

Correlations use pairwise available observations, so the effective sample can vary between indicator pairs. The results describe associations and group differences rather than causal effects.
