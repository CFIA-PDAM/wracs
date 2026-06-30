bryonia_alba <- rgbif::occ_download(rgbif::pred("taxonKey", "2874497"))

bryonia_alba <- rgbif::occ_download_wait(bryonia_alba)

bryonia_alba <- rgbif::occ_download_get(
  bryonia_alba$key,
  path = withr::local_tempdir(),
  overwrite = TRUE
)

bryonia_alba <- rgbif::occ_download_import(bryonia_alba)

usethis::use_data(bryonia_alba)
