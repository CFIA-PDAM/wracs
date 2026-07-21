#' Get the WRACS data directory
#'
#' Get the WRACS data directory which will store rasters of derived climate
#' variables downloaded from Zenodo. The location of the WRACS data directory
#' can be customized by setting `wracs_data_dir` as an environment variable.
#'
#' @return a path to the WRACS data directory
#'
#' @export
get_wracs_data_dir <- function() {
  wracs_data_dir <- base::Sys.getenv("wracs_data_dir", unset = NA_character_)

  if (rlang::is_na(wracs_data_dir)) {
    wracs_data_dir <- tools::R_user_dir("wracs", "data")
  }

  wracs_data_dir <- fs::path(wracs_data_dir)

  Sys.setenv("wracs_data_dir" = wracs_data_dir)

  fs::dir_create(wracs_data_dir)

  return(wracs_data_dir)
}
