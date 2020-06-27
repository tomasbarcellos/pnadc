#' Title
#'
#' @param ano Ano
#' @param trimestre Trimestre
#'
#' @return Uma tibble
#' @export
#'
#' @examples
#' \notrun{res <- ler_pnad(2018, 3)}
ler_pnad <- function(ano, trimestre) {
  arqs <- dir("dados/", all.files = TRUE, full.names = TRUE)
  path <- arqs %>%
    stringr::str_subset(glue::glue("{ano}")) %>%
    stringr::str_subset(glue::glue("{trimestre}")) %>%
    stringr::str_subset(glue::glue("\\.txt$"))

  vars <- c("Ano", "Trimestre", "UF", "V1008", "V1014",
            "V1016", "V1022", "V1027", "V1028", "V1029",
            "V2007", "V2010", "V2009", "VD4009","VD4010",
            "V4010", "V4012", "V4013", "VD4017", "V403312",
            "V4039", "V4041", "V4043", "V4044", "V4047",
            "V4048", "V405112", "V4056"
  )

  input <- system.file("extdata", "input_PNADC_trimestral.txt",
                       package = "pnadc")
  # dic <- system.file("extdata", "dicionario_PNADC_microdados_trimestral.xls", package = "pnadc")

  resp <- PNADcIBGE::read_pnadc(path, input, vars) %>%
      dplyr::rename(
        ano = Ano, trimestre = Trimestre, uf = UF, estrato = Estrato, upa = UPA,
        num_domicilio = V1008, grupo_amostra = V1014, num_entrevista = V1016,
        situacao_domicilio = V1022, peso = V1027,
        peso_posestrat = V1028, proj_pop = V1029,
        sexo = V2007, cor = V2010, idade = V2009,
        profissao_principal = V4010, profissao_secundario = V4041,
        jornada_principal = V4039, jornada_secundario = V4056,
        rendimento = V403312,
        rendimento_primario = VD4017, rendimento_secundario = V405112,
        grupo_setor_principal = VD4010, setor_principal = V4013,
        setor_secundario = V4044,
        tipo_vinculo = V4012,
        vinculo_primario = VD4009, vinculo_secundario = V4043,
        funcionario_secundario = V4047, carteira_secundario = V4048
      ) %>%
      dplyr::mutate_at(dplyr::vars(ano:estrato), as.integer)
  resp
}
