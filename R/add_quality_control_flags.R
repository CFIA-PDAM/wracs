#' Add quality control flags to each GBIF occurrence record
#'
#' Check each GBIF occurrence record (i.e. row) for common quality control
#' concerns and assign records that exhibit a particular quality concern `TRUE`
#' for the given column, else `FALSE`.
#'
#' @param occurrence_data a data frame of occurrence data extracted from GBIF
#'
#' @return a data frame with eight additional columns corresponding to the
#' different quality control flags
#'
#' @export
add_quality_control_flags <- function(occurrence_data) {
  check_occurrence_data_required_cols(occurrence_data)

  occurrence_data <- dplyr::mutate(
    occurrence_data,
    hasNoCoords = base::is.na(.data$decimalLatitude) &
      base::is.na(.data$decimalLongitude)
  )

  occurrence_data <- dplyr::mutate(
    occurrence_data,
    NoXYold = .data$hasNoCoords & (base::is.na(.data$year) | .data$year < 1980),
    CurrReg = .data$hasNoCoords & !base::is.na(.data$year) & .data$year > 1979,
    `00XY` = !.data$hasNoCoords &
      .data$decimalLatitude == 0 &
      .data$decimalLongitude == 0,
    XYnoYR = !.data$hasNoCoords & base::is.na(.data$year),
    XYold = !.data$hasNoCoords & !base::is.na(.data$year) & .data$year < 1980,
    Cult = dplyr::when_any(
      !base::is.na(.data$habitat) &
        stringr::str_detect(
          .data$habitat,
          "(?i)grown|cultivat|ornamental|culture"
        ),
      !base::is.na(.data$locality) &
        stringr::str_detect(
          .data$locality,
          "(?i)grown|cultivat|ornamental|culture"
        )
    ),
    iNat = dplyr::when_all(
      !.data$hasNoCoords,
      !base::is.na(.data$datasetName),
      stringr::str_detect(.data$datasetName, "(?i)inaturalist")
    )
  )

  return(occurrence_data)
}
