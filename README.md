
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nitrateApp

`nitrateApp` is a package that can be used to explore **daily nitrate
concentrations** for three NEON river sites from June 2019 to July 2019.
This package can be used as an exploratory tool to access the cleaned
dataset of nitrate concentrations, and a *Shiny* app to visualise
patterns over time and location.

**Website:** [View the nitrateApp pkgdown
site](https://ETC5523-2025.github.io/assignment-4-packages-and-shiny-apps-malaiikkkaa/)

<!-- badges: start -->
<!-- badges: end -->

## Installing `nitrateApp`

To install the package directly from GitHub, run the following:

``` r
# Install remotes if required
install.packages("remotes")

# Then install the nitrateApp
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-malaiikkkaa")
```

## Package contents

### Dataset

The package contains a clean dataset `nitrates_small`. Key variables:

- `site`: NEON site code
- `date`: Date (Range: June 2019 - July 2019)
- `nitrate_mgL`: Nitrate concentrations (mg/L)

### Shiny app

Use the interactive app to explore nitrate concentrations over specified
dates and regions.

To launch the app:

``` r
# First load the app
library(nitrateApp)

# Then run the app
nitrateApp::run_nitrate_app()
```
