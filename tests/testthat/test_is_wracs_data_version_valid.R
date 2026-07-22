testthat::test_that("setting an impossible data version results in an error", {
  testthat::expect_snapshot(wracs::set_wracs_data_version(-1), error = TRUE)

  testthat::expect_snapshot(wracs::set_wracs_data_version(999), error = TRUE)
})

testthat::test_that("setting the version as a character throws an error", {
  testthat::expect_snapshot(wracs::set_wracs_data_version("1"), error = TRUE)
})
