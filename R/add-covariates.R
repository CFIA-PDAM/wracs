#' Add climate data covariates
#'
#' @param gbif_occurrence_data a dataframe of GBIF occurrence data
#'
#' @param covariate_raster a terra raster object of covariate data
#
#' @export
add_covariates <- function(
  gbif_occurrence_data = NULL,
  covariate_raster = NULL
) {
  gbif_occurrence_data_vect <- terra::vect(
    gbif_occurrence_data,
    geom = base::c("decimalLongitude", "decimalLatitude"),
    "EPSG:4326"
  )

  df <- dplyr::mutate(
    gbif_occurrence_data,
    terra::extract(covariate_raster, gbif_occurrence_data_vect, ID = FALSE)
  )

  return(df)
}
