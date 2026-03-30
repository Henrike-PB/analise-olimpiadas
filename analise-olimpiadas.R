# ============================================================
# Desafio - Análise Exploratória de Dados com R
# Evolução dos Tempos na Prova de 100 Metros - Olimpíadas
# Aluno: Henrike Braga | Março de 2026
# ============================================================

# ---- 1. CARREGAMENTO DOS DADOS ----

# Carregando os dados do arquivo CSV
dados <- read.csv("results.csv", sep = ",", stringsAsFactors = FALSE)

# Verificando as dimensões do dataset
cat("Total de registros:", nrow(dados), "\n")
cat("Total de colunas:", ncol(dados), "\n")

# ---- 2. VISUALIZAÇÃO DOS DADOS ----

# Visualizando as primeiras 10 linhas
head(dados, 10)

# Verificando a estrutura dos dados (tipos das colunas)
str(dados)

# Resumo estatístico geral
summary(dados)

# ---- 3. AJUSTE DOS DADOS ----

# Instalando e carregando a biblioteca dplyr
if (!require(dplyr)) install.packages("dplyr", repos = "https://cloud.r-project.org")
library(dplyr)

# Verificando o tipo da coluna Result ANTES da conversão
cat("Tipo da coluna Result ANTES:", class(dados$Result), "\n")

# Convertendo a coluna Result de character para double
dados <- dados %>%
  mutate(Result = as.double(Result))

# Verificando o tipo APÓS a conversão
cat("Tipo da coluna Result DEPOIS:", class(dados$Result), "\n")

# Verificando quantos valores ficaram como NA
cat("Valores NA na coluna Result:", sum(is.na(dados$Result)), "\n")
cat("Valores válidos na coluna Result:", sum(!is.na(dados$Result)), "\n")

# ---- 4. ANÁLISE DOS DADOS ----

# Filtrando medalhistas de ouro na prova de 100M - HOMENS
ouro_100m_homens <- dados %>%
  filter(
    Gender == "M",
    Medal == "G",
    Event == "100M Men",
    !is.na(Result)
  ) %>%
  arrange(Year)

# Filtrando medalhistas de ouro na prova de 100M - MULHERES
ouro_100m_mulheres <- dados %>%
  filter(
    Gender == "W",
    Medal == "G",
    Event == "100M Women",
    !is.na(Result)
  ) %>%
  arrange(Year)

# Visualizando os dados filtrados
cat("=== MEDALHISTAS DE OURO - 100M MASCULINO ===\n")
cat("Total de registros:", nrow(ouro_100m_homens), "\n\n")
print(ouro_100m_homens %>% select(Year, Name, Nationality, Result))

cat("\n=== MEDALHISTAS DE OURO - 100M FEMININO ===\n")
cat("Total de registros:", nrow(ouro_100m_mulheres), "\n\n")
print(ouro_100m_mulheres %>% select(Year, Name, Nationality, Result))

# Estatísticas descritivas
cat("\n=== Estatísticas - 100M Masculino (Ouro) ===\n")
cat("Melhor tempo:", min(ouro_100m_homens$Result), "s\n")
cat("Pior tempo:", max(ouro_100m_homens$Result), "s\n")
cat("Tempo médio:", round(mean(ouro_100m_homens$Result), 2), "s\n")
cat("Mediana:", round(median(ouro_100m_homens$Result), 2), "s\n")
cat("Desvio padrão:", round(sd(ouro_100m_homens$Result), 2), "s\n")

cat("\n=== Estatísticas - 100M Feminino (Ouro) ===\n")
cat("Melhor tempo:", min(ouro_100m_mulheres$Result), "s\n")
cat("Pior tempo:", max(ouro_100m_mulheres$Result), "s\n")
cat("Tempo médio:", round(mean(ouro_100m_mulheres$Result), 2), "s\n")
cat("Mediana:", round(median(ouro_100m_mulheres$Result), 2), "s\n")
cat("Desvio padrão:", round(sd(ouro_100m_mulheres$Result), 2), "s\n")

# ---- 5. APRESENTAÇÃO DOS RESULTADOS (GRÁFICOS) ----

# Instalando e carregando a biblioteca plotly
if (!require(plotly)) install.packages("plotly", repos = "https://cloud.r-project.org")
library(plotly)

# Gráfico de dispersão - 100M Masculino
grafico_homens <- plot_ly(
  data = ouro_100m_homens,
  x = ~Year,
  y = ~Result,
  type = "scatter",
  mode = "lines+markers",
  text = ~paste("Atleta:", Name, "<br>País:", Nationality, "<br>Tempo:", Result, "s"),
  hoverinfo = "text",
  marker = list(color = "#2B5E5B", size = 10),
  line = list(color = "#2B5E5B", width = 2)
) %>%
  layout(
    title = list(text = "Evolução dos Tempos - 100M Masculino (Medalhistas de Ouro)"),
    xaxis = list(title = "Ano da Olimpíada", dtick = 8),
    yaxis = list(title = "Tempo (segundos)"),
    hovermode = "closest"
  )

grafico_homens

# Gráfico de dispersão - 100M Feminino
grafico_mulheres <- plot_ly(
  data = ouro_100m_mulheres,
  x = ~Year,
  y = ~Result,
  type = "scatter",
  mode = "lines+markers",
  text = ~paste("Atleta:", Name, "<br>País:", Nationality, "<br>Tempo:", Result, "s"),
  hoverinfo = "text",
  marker = list(color = "#E8834A", size = 10),
  line = list(color = "#E8834A", width = 2)
) %>%
  layout(
    title = list(text = "Evolução dos Tempos - 100M Feminino (Medalhistas de Ouro)"),
    xaxis = list(title = "Ano da Olimpíada", dtick = 8),
    yaxis = list(title = "Tempo (segundos)"),
    hovermode = "closest"
  )

grafico_mulheres

# Gráfico comparativo - Homens vs Mulheres
grafico_comparativo <- plot_ly() %>%
  add_trace(
    data = ouro_100m_homens,
    x = ~Year, y = ~Result,
    type = "scatter", mode = "lines+markers",
    name = "Masculino",
    text = ~paste("Atleta:", Name, "<br>Tempo:", Result, "s"),
    hoverinfo = "text",
    marker = list(color = "#2B5E5B", size = 8),
    line = list(color = "#2B5E5B", width = 2)
  ) %>%
  add_trace(
    data = ouro_100m_mulheres,
    x = ~Year, y = ~Result,
    type = "scatter", mode = "lines+markers",
    name = "Feminino",
    text = ~paste("Atleta:", Name, "<br>Tempo:", Result, "s"),
    hoverinfo = "text",
    marker = list(color = "#E8834A", size = 8),
    line = list(color = "#E8834A", width = 2)
  ) %>%
  layout(
    title = list(text = "Comparativo - Evolução dos Tempos 100M (Medalhistas de Ouro)"),
    xaxis = list(title = "Ano da Olimpíada", dtick = 8),
    yaxis = list(title = "Tempo (segundos)"),
    hovermode = "closest",
    legend = list(x = 0.8, y = 0.95)
  )

grafico_comparativo

# ---- 6. CONCLUSÕES ----
#
# 1. Tendência de queda nos tempos: Tanto no masculino quanto no feminino,
#    observa-se uma clara redução dos tempos ao longo das décadas.
#
# 2. Evolução mais acentuada nas primeiras décadas: A redução foi mais
#    expressiva no início do século XX. Nas últimas décadas, tornou-se gradual.
#
# 3. Diferença consistente entre gêneros: Os homens apresentam tempos menores,
#    com diferença relativamente estável ao longo das edições.
#
# 4. Marcos históricos: Destaque para a quebra da barreira dos 10 segundos
#    no masculino e as performances de Usain Bolt (9.63s em Londres 2012).
#
# 5. Estabilização recente: Os tempos tendem a se estabilizar, sugerindo
#    proximidade dos limites do desempenho humano.
