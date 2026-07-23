#' Check if the GBIF occurrence data has the required columns
#'
#' `r lifecycle::badge('experimental')`
#'
#' An internal helper to check if the GBIF occurrence data has the required
#' columns
#'
#' @param occurrence_data a dataframe of GBIF occurrence data
#'
#' @return returns invsibily if all required columns are present. If not, an
#' error is raised.
#'
#' @keywords internal
check_occurrence_data_required_cols <- function(occurrence_data) {
  required_columns <- base::c(
    "datasetName",
    "decimalLatitude",
    "decimalLongitude",
    "habitat",
    "locality",
    "year"
  )

  missing_cols <- dplyr::setdiff(required_columns, names(occurrence_data))

  if (!rlang::is_empty(missing_cols)) {
    cli::cli_abort(base::c(
      "The following column{?s} {?is/are} missing: {missing_cols}"
    ))
  }

  return(base::invisible(NULL))
}
