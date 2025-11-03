#'Launch the nitrateApp Shiny application
#'
#'Opening the nitrate concentration app contained in this package to explore daily nitrate concentrations by site and date.
#'
#'@return Returns the result of \code{shiny::runApp()}
#'@export
#'@examples
#' if (interactive()) {
#'   nitrateApp::run_nitrate_app()
#' }
run_nitrate_app <- function() {
  app_dir <- system.file("app", package = "nitrateApp")
  if (app_dir == "" || !dir.exists(app_dir)) {
    stop("App directory not found inside the installed package. Try reinstalling.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
