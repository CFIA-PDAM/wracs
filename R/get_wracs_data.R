get_wracs_data <- function(
  wracs_data_dir = get_wracs_data_dir(),
  wracs_data_doi = get_wracs_data_doi()
) {
  cl <- parallel::makeCluster(4)

  parallel::clusterExport(cl, varlist = base::c("wracs_data_dir"))

  withr::defer(parallel::stopCluster(cl))

  zen4R::download_zenodo(
    doi = wracs_data_doi,
    path = wracs_data_dir,
    quiet = TRUE,
    timeout = 3600,
    parallel = TRUE,
    parallel_handler = parallel::parLapply,
    cl = cl
  )
}
