#' Launch the nitrateApp Shiny application
#'
#' Opens the interactive app bundled with this package to explore daily
#' nitrate concentrations by site and date.
#'
#' @return Invisibly returns the result of \code{shiny::runApp()}.
#'
#' @examples
#' \dontrun{
#'   nitrateApp::run_nitrate_app()
#' }
#'
#' @export
#' @importFrom shiny runApp
run_nitrate_app <- function() {
  app_dir <- system.file("app", package = "nitrateApp")
  if (app_dir == "" || !dir.exists(app_dir)) {
    stop("App directory not found inside the installed package. Try reinstalling.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
