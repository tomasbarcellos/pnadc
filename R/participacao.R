#' Participação
#'
#' @param df df da PNAD resultado de ler_pnad
#' @param variavel Variável que será contada
#'
#' @return Um data.frame com propoção
#' @export
#'
#' @examples
participacao <- function(df, variavel) {
  cont <- dplyr::count(df, {{variavel}})

  var <- as.character(substitute(variavel))


  cont %>%
    dplyr::group_by({{variavel}}) %>%
    dplyr::mutate(
      participacao = stats::weighted.mean(
        ifelse({{variavel}} == df[[var]], 1, 0),
        df$peso_posestrat, na.rm = TRUE
      ),
      participacao = participacao * 100
    ) %>%
    dplyr::select(-n)
}

