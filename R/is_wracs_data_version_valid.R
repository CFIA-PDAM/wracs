#' @noRd
is_wracs_data_version_valid <- function(wracs_data_version = NULL) {
  if (rlang::is_null(wracs_data_version)) {
    cli::cli_abort(base::c(
      "{.arg wracs_data_version} must be a positive integer, not {.type {wracs_data_version}}"
    ))
  }

  if (!rlang::is_scalar_integerish(wracs_data_version)) {
    cli::cli_abort(base::c(
      "{.arg wracs_data_version} must be a positive integer of length 1, not {.type {wracs_data_version}}"
    ))
  }

  zenodo <- zen4R::ZenodoManager$new(logger = NULL)

  record <- base::suppressMessages(zenodo$getRecordById("21400412"))

  available_versions <- base::suppressMessages(record$getVersions()$version)

  is_valid <- wracs_data_version %in% available_versions

  output <- base::structure(is_valid, available_versions = available_versions)

  return(output)
}
