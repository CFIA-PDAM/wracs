add_qc_codes <- function(df) {
  expected_cols <- base::c(
    "datasetName",
    "decimalLatitude",
    "decimalLongitude",
    "habitat",
    "locality",
    "year"
  )

  missing_cols <- dplyr::setdiff(expected_cols, names(df))

  if (!rlang::is_empty(missing_cols)) {
    cli::cli_abort(
      base::c(
        "x" = "The following column{?s} {?is/are} missing: {missing_cols}"
      )
    )
  }

  # hasNoCoords is not a QC code itself but is useful in creating the other
  # quality control codes
  df <- dplyr::mutate(
    df,
    hasNoCoords = base::is.na(.data$decimalLatitude) &
      base::is.na(.data$decimalLongitude)
  )

  # fmt: skip
  df <- dplyr::mutate(
    df,
    NoXYold = .data$hasNoCoords & (base::is.na(.data$year) | .data$year < 1980),
    CurrReg = .data$hasNoCoords & !base::is.na(.data$year) & .data$year > 1979,
    `00XY` = !.data$hasNoCoords & .data$decimalLatitude == 0 & .data$decimalLongitude == 0,
    XYnoYR = !.data$hasNoCoords & base::is.na(.data$year),
    XYold = !.data$hasNoCoords & !base::is.na(.data$year) & .data$year < 1980,
    Cult = dplyr::when_any(
      !base::is.na(.data$habitat) & stringr::str_detect(.data$habitat, "(?i)grown|cultivat|ornamental|culture"),
      !base::is.na(.data$locality) & stringr::str_detect(.data$locality, "(?i)grown|cultivat|ornamental|culture")
    ),
    iNat = dplyr::when_all(
      !.data$hasNoCoords,
      !base::is.na(.data$datasetName),
      stringr::str_detect(.data$datasetName, "(?i)inaturalist")
    )
  )

  return(df)
}
