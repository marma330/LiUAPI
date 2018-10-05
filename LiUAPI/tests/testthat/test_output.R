context("latlong")


test_that("output is correct",{
  place <- "Tehran"
  f <- "AIzaSyAGdetT_wO2o2Q6LfHFVmEw7yxFnvVpCbo"
  h <- latlong("Tehran",f)
  
  expect_equal(h$`Complete name` , "Tehran, Tehran Province, Iran")
  expect_equal(h$`latitude and longitude`$lat ,35.6891975 )
  expect_equal(h$`latitude and longitude`$lng , 51.3889736)

}
)