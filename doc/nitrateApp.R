## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  fig.width = 6, fig.height = 3
)

## -----------------------------------------------------------------------------
library(nitrateApp)
data("nitrates_small", package = "nitrateApp")
str(nitrates_small)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)

nitrates_small |>
  group_by(site)|>
  summarise(
    mean_mgL = mean(nitrate_mgL, na.rm = TRUE),
    min_mgL = min(nitrate_mgL, na.rm = TRUE),
    max_mgL = max(nitrate_mgL, na.rm = TRUE)
  )

## ----message=FALSE, warning=FALSE, fig.cap="Daily nitrate by site (June–July 2019)", fig.alt="Line chart showing daily nitrate concentrations for ARIK, CARI, LEWI over June–July 2019."----

library(ggplot2)

ggplot(nitrates_small, aes(date, nitrate_mgL, color = site)) +
geom_line() +
geom_point() +
labs(x = NULL, y = "Nitrate (mg/L)", title = "Daily nitrate concentrations by site") +
theme_minimal()

## ----eval=FALSE---------------------------------------------------------------
# nitrateApp::run_nitrate_app()

