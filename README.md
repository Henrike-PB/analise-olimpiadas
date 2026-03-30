# Análise Exploratória de Dados com R - Olimpíadas

Análise exploratória dos tempos dos medalhistas de ouro na prova de 100 metros rasos nas Olimpíadas (1896-2016), utilizando a linguagem R.

## Estrutura do Repositório

| Arquivo | Descrição |
|---------|-----------|
| `analise-olimpiadas.R` | Script R com toda a análise |
| `results.csv` | Dataset Olympic Track & Field Results (Kaggle) |
| `Desafio-Analise-Olimpiadas.html` | Resultado final com gráficos interativos |

## Como Executar

1. Instale o [R](https://cran.r-project.org/) e o [RStudio](https://posit.co/download/rstudio-desktop/)
2. Abra o `analise-olimpiadas.R` no RStudio
3. Defina o diretório de trabalho para a pasta do projeto:
   ```r
   setwd("caminho/para/a/pasta")
   ```
4. Execute o script linha por linha ou selecione tudo e clique em **Run**

## Bibliotecas Utilizadas

- **dplyr** - Manipulação e filtragem de dados
- **plotly** - Gráficos interativos

As bibliotecas são instaladas automaticamente pelo script caso não estejam presentes.

## Dataset

Fonte: [Olympic Track & Field Results - Kaggle](https://www.kaggle.com/datasets/jayrav13/olympic-track-field-results)

Contém resultados de atletismo olímpico de 1896 até 2016.

## Autor

Henrike Braga - Unisinos EAD (ADS)
