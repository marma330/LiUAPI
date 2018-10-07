context("distanfu")


test_that("Error messages are returned for erronous input ",{
  place1 <- "parks inw<>#! abozabi"
  place2 <- "hospital"
  f <- "AIzaSyAGdetT_wO2o2Q6LfHFVmEw7yxFnvVpCbo"
  expect_error(distanfu(place1,place2,f))
})


