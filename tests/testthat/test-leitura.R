test_that("leitura da PNAD", {
  ano <- 2019
  trim <- 4

  old <- getwd()
  on.exit(setwd(old))
  setwd("../..")
  resp <- ler_pnad(ano, trim)

  cols <- c("ano", "trimestre", "uf",
            "peso_posestrat",
            "peso", "proj_pop")

  expect_is(resp, c("tibble", "data.frame"))
  expect_true(all(cols %in% names(resp)))
  expect_true(all(resp$ano == ano))
  expect_true(all(resp$trimestre == trim))
})

# vars <- c("Ano", "Trimestre", "UF", "Estrato", "UPA",
#           "V1008", "V1014", "V1016", "V1022", "V1027", "V1028",
#           "V1029", "posest",
#           "V4010", "V2007", "V2010", "V403312",
#           "V2009", "V4039", "VD3001", "V4012")

