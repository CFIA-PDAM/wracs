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
    hasNoCoords = base::is.na(decimalLatitude) & base::is.na(decimalLongitude)
  )

  # fmt: skip
  df <- dplyr::mutate(
    df,
    NoXYold = hasNoCoords & (base::is.na(year) | year < 1980),
    CurrReg = hasNoCoords & !base::is.na(year) & year > 1979,
    `00XY` = !hasNoCoords & decimalLatitude == 0 & decimalLongitude == 0,
    XYnoYR = !hasNoCoords & base::is.na(year),
    XYold = !hasNoCoords & !base::is.na(year) & year < 1980,
    Cult = dplyr::when_any(
      !base::is.na(habitat) & stringr::str_detect(habitat, "(?i)grown|cultivat|ornamental|culture"),
      !base::is.na(locality) & stringr::str_detect(locality, "(?i)grown|cultivat|ornamental|culture")
    ),
    iNat = dplyr::when_all(
      !hasNoCoords,
      !base::is.na(datasetName),
      stringr::str_detect(datasetName, "(?i)inaturalist")
    )
  )

  return(df)
}
