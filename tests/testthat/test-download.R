context("Download")

test_that("Cria link", {
  resp <- criar_link(2019, 4)
  expect_equal(class(resp), c("glue", "character"))
  expect_true(stringr::str_detect(resp, "\\.zip$"))
})

test_that("Download funciona", {
  # link que vem é valido
  link <- criar_link(2019, 4)
  expect_true(RCurl::url.exists(link))

  with_mock(
    `download.file` = function(url, dest, ...) TRUE,
    `unzip` = function(str, ...) TRUE,
    `file.size` = function(path) 123,
    expect_silent(resp <- download_pnad(2019, 4)),
    expect_is(resp, "logical"),
    expect_true(resp)
  )
})
