df <- add_qc_codes(bryonia_alba)

testthat::test_that("the number of rows is unchanged", {
  testthat::expect_equal(base::nrow(df), base::nrow(bryonia_alba))
})

testthat::test_that("the number of columns is increased by 8", {
  testthat::expect_equal(base::ncol(df) - base::ncol(bryonia_alba), 8)
})
