context("places")


test_that("Error messages are returned for erronous input ",{
  input <- "parks inw<>#! abozabi"
  f <- "AIzaSyAGdetT_wO2o2Q6LfHFVmEw7yxFnvVpCbo"
  expect_error(places(input,f))
})


test_that("output is correct",{
  input <- "Parks in berlin"
  f <- "AIzaSyAGdetT_wO2o2Q6LfHFVmEw7yxFnvVpCbo"
  h <- places(input,f)
  
  expect_equal(h$results$name[1] ,"Treptower Park")
  expect_equal(h$results$formatted_address[1] ,"Alt-Treptow, 12435 Berlin, Germany" )
  
}
)
