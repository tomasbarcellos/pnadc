test_that("Calculo da participacao", {
  df <- tibble::tibble(
    grupo = letters[c(1, 2, 2, 1)],
    metrica = c(10, 20, 15, 25),
    peso_posestrat = c(1, 4, 4, 1)
  )

  resp <- tibble::tibble(
    grupo = c("a", "b"),
    participacao = c(20, 80)
  )

  expect_equal(participacao(df, grupo), resp)
})
