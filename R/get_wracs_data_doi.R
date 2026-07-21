#' Get the DOI for the specified version of the WRACS data
#'
#' @param wracs_data_version A positive integer indicating the Zenodo record version.
#'
#' @export
get_wracs_data_doi <- function(wracs_data_version = NULL) {
  if (rlang::is_null(wracs_data_version)) {
    wracs_data_version <- Sys.getenv(
      "wracs_data_version",
      unset = NA_character_
    )
  }

  zenodo <- zen4R::ZenodoManager$new(logger = NULL)

  record <- base::suppressMessages(zenodo$getRecordById("21400412"))

  versions <- base::suppressMessages(record$getVersions())

  if (rlang::is_na(wracs_data_version)) {
    version_latest <- base::max(versions$version)

    doi <- versions |>
      dplyr::filter(version == version_latest) |>
      dplyr::pull(doi)

    cli::cli_inform(base::c(
      "No version number specified",
      "i" = "Defaulting to the latest version {.val {version_latest}}"
    ))
  } else {
    doi <- versions |>
      dplyr::filter(version == wracs_data_version) |>
      dplyr::pull(doi)
  }

  return(doi)
}
