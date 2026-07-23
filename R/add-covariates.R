#' Add climate data covariates

#' @export
add_covariates <- function(
  gbif_occurrence_data = NULL,
  emission_scenario = base::c("ssp370"),
  time_period = base::c("2011.2040", "2041.2070")
) {
  gbif_occurrence_data_vect <- terra::vect(
    gbif_occurrence_data,
    geom = base::c("decimalLongitude", "decimalLatitude"),
    "EPSG:4326"
  )

  wracs_data_dir <- base::Sys.getenv("wracs_data_dir", unset = NA_character_)

  covariate_raster_path <- fs::path(
    wracs_data_dir,
    glue::glue("raster.ensemble.{time_period}.{emission_scenario}.tif")
  )

  covariate_raster <- terra::rast(covariate_raster_path)

  df <- dplyr::mutate(
    gbif_occurrence_data,
    terra::extract(covariate_raster, gbif_occurrence_data_vect, ID = FALSE)
  )

  return(df)
}
