# Loading packages
required <- c("neonUtilities","dplyr","lubridate","here","usethis")
to_install <- setdiff(required, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install)
lapply(required, library, character.only = TRUE)

# Configuring a small dataset
neon_sites <- c("ARIK","CARI","LEWI")
start_ym <- "2018-01"
end_ym   <- "2019-12"
neon_release <- "RELEASE-2021"

cache_dir <- here::here("data-raw", "cache")
dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)

# Helper to load NEON .rds
load_neon <- function(dpID, fname) {
  fpath <- file.path(cache_dir, fname)
  if (file.exists(fpath)) {
    readRDS(fpath)
  } else {
    if (nzchar(Sys.getenv("NEON_TOKEN")) == FALSE) {
      stop("NEON_TOKEN not set and cache miss for ", dpID,
           ". Either set NEON_TOKEN or provide cached .rds in data-raw/cache/")
    }
    out <- neonUtilities::loadByProduct(
      dpID      = dpID,
      site      = neon_sites,
      startdate = start_ym,
      enddate   = end_ym,
      package   = "expanded",
      token     = Sys.getenv("NEON_TOKEN"),
      check.size = FALSE,
      release   = neon_release
    )
    saveRDS(out, fpath)
    out
  }
}

# Downloading water quality data
message("Fetching NEON data (cached if available)…")
waq <-  load_neon("DP1.20288.001", "waq.rds")
nsw <-  load_neon("DP1.20033.001", "nsw.rds")
temp_all <- load_neon("DP1.20053.001", "temp_all.rds")
swe_all  <- load_neon("DP1.20016.001", "swe_all.rds")

stopifnot(!is.null(nsw$NSW_15_minute))

nitrate_df <- nsw$NSW_15_minute |>
  dplyr::transmute(
    site   = .data$siteID,
    datetime = lubridate::as_datetime(.data$startDateTime, tz = "UTC"),
    nitrate_mgL = .data$surfWaterNitrateMean
  )

nitrates_small <- nitrate_df |>
  dplyr::mutate(date = as.Date(datetime)) |>
  dplyr::filter(
    date >= as.Date("2019-06-01"),
    date <= as.Date("2019-07-31")
  ) |>
  dplyr::group_by(site, date) |>
  dplyr::summarise(
    nitrate_mgL = mean(nitrate_mgL, na.rm = TRUE),
    .groups = "drop"
  ) |>
  dplyr::arrange(site, date)


usethis::use_data(nitrates_small, overwrite = TRUE)
message("Saved 'nitrates_small' to data/.")
