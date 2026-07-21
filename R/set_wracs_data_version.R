#' Set the WRACS data version
#'
#' Set the version of WRACS data to download from Zenodo and use in climate
#' suitability analyses
#'
#' @param wracs_data_version A positive integer indicating the Zenodo record version.
#'
#' @export
set_wracs_data_version <- function(wracs_data_version) {
  is_valid <- is_wracs_data_version_valid(wracs_data_version)

  if (!is_valid) {
    cli::cli_abort(base::c(
      "Version {wracs_data_version} of {.pkg wracs_data} does not exist",
      "i" = "Available versions: {.val {attr(is_valid, 'available_versions')}}"
    ))
  }

  base::Sys.setenv("wracs_data_version" = wracs_data_version)

  return(base::invisible())
}
