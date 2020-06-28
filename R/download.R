listar_ftp <- function(url) {
  RCurl::getURL(url, dirlistonly = TRUE) %>%
    stringr::str_split('\\n') %>%
    magrittr::extract2(1) %>%
    stringr::str_remove_all('\\r') %>%
    # remove vazio
    stringr::str_subset(".")
}

criar_link <-  function(ano, trimestre) {
  inicio <- glue::glue(
    "ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/",
    "Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/",
    "Trimestral/Microdados/",
    "{ano}/"
  )

  arquivos <- listar_ftp(inicio) %>%
    stringr::str_subset("\\.zip$") %>%
    sort()

  glue::glue(
    "{inicio}{arquivos[trimestre]}"
  )
}

download_pnad <- function(ano, trimestre) {
  link <- criar_link(ano, trimestre)
  dest <- glue::glue("dados/{ano}_{trimestre}.zip")


  if (!dir.exists("dados")) dir.create("dados")

  download.file(link, dest)
  file.size(dest) > 10
}

unzip_pnad <- function(ano, trimestre) {
  path_zip <- glue::glue("dados/{ano}_{trimestre}.zip")

  if (!file.exists(path_zip))
    stop("Zip deste ano/trimestre não foi encontrado.")

  old <- dir("dados")

  unzip(path_zip, exdir = "dados")

  any(dir("dados") != old)
}

