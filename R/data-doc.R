#' Daily nitrate concentrations at NEON river sites (June–July 2019)
#'
#' A dataset containing daily mean nitrate concentrations for three NEON
#' freshwater sites, used for the `nitrateApp` Shiny app.
#'
#' @format A tibble with 183 rows and 3 variables:
#' \describe{
#'   \item{site}{NEON site code (ARIK, CARI, LEWI)}
#'   \item{date}{Date of observation (YYYY-MM-DD, UTC)}
#'   \item{nitrate_mgL}{Daily mean nitrate concentration (milligrams per litre, mg/L)}
#' }
#' @source National Ecological Observatory Network (NEON), product DP1.20033.001.
#' @examples
#' data("nitrates_small", package = "nitrateApp")
#' head(nitrates_small)
"nitrates_small"
