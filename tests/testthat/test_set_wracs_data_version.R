testthat::test_that("the WRACS data version can be retrieved as an environment variable", {
  withr::local_envvar("wracs_data_version" = "")

  wracs::set_wracs_data_version(1)

  version_actual <- base::as.integer(base::Sys.getenv("wracs_data_version"))

  testthat::expect_equal(version_actual, 1)
})

testthat::test_that("setting an impossible data version results in an error", {
  testthat::expect_snapshot(wracs::set_wracs_data_version(999), error = TRUE)
})
