context("places")


test_that("Error messages are returned for erronous input ",{
  input <- "parks inw<>#! abozabi"
  f <- "AIzaSyAGdetT_wO2o2Q6LfHFVmEw7yxFnvVpCbo"
  expect_error(places(input,f))
})
