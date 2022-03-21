---
marp: true
theme: 
paginate: true
---
# Objetivo

Esse projeto tem como objetivo demonstrar as análises realizadas para o projeto integrador 2, onde foram utilizadas as ferramentas apresentadas durante o projeto **Deloitte Data Literacy**.

---

# Ferramentas

## Utilizamos 4 ferramentas para a realização desse projeto, são elas:

 * **Microsoft Teams** - Para a elaboração de Kanban, utilizamos a função *TAREFAS* do Microsoft Teams.
 
 * **SQL** - Utilizamos o SQL para realizar a limpeza de linhas nulas, colunas que não foram usadas e demais modelagens de dados;
 
 * **COLAB (PYTHON)**- O Colab foi utilizado para realizar as análises dos dados e apresentação de gráficos;
 
 * **Power BI** - Para a criação de análises e Dashboards.

---

# Base de Dados

## As bases de dados aplicadas nesse projeto foram:

### - births.csv
### - brasil.csv

---


## Modelagem dos dados


1. Antes de iniciar as análises, realizamos a modelagem dos dados da base denominada como **Births.csv**, e utilizamos a ferramente **SQL**.
Assim, limpamos as linhas nulas, colunas que não foram usadas nas análies e demais modelagens de dados, para visualizar tais alterações, vide o arquivo disponibilizado no repositório **Base limpas**. 

2. Já a base de dados denominada como **Brasil.csv** não passou por modelagem de dados antes de iniciarmos as análises.

---
# Análise de dados - Base USA
---
Para a análise da taxa de nascimentos nos Estados Unidos, desde o ano de 1969, criamos o arquivo **Births_Limpa.xlsx** e disponibilizamos no diretório **Base de dados**.

Utilizando a ferramenta COLAB, realizamos a importação do arquivo **Births_Limpa.xlsx**, via comando **uploaded = files.upload()**, vejamos:

``` py
# Importando tabela Births

from google.colab import files
uploaded = files.upload()

```
Além disso, se fez necessário a importação da biblioteca **Pandas**.
``` py
#Importando Pandas

import pandas as pd

```
E a importação da tabela Births como variável tabela.

``` py
#Importando tabela Births como variável tabela
tabela = pd.read_excel("Births_Limpa.xlsx")

```
# Resultado das análises 

Posto isso, vejamos os resultados das análises realizadas:

1.  **Total de nascimentos por ano e genêro.**

``` py
Nascimentos_Totais = tabela[["year","gender","births"]].groupby(["year","gender"]).sum()

display(Nascimentos_Totais)

```
* 1969 até 1975

![Total de nascimentos por ano e genêro ](https://user-images.githubusercontent.com/100967007/159377410-0e677b3b-c777-42b1-919e-8821fa63ee1f.png)

2.  **total de nascimentos por gênero.**

``` py

#Trazendo o total de nascimentos por gênero

Nascimento_por_Gênero = tabela[["gender", "births"]].groupby(["gender"]).sum()

display(Nascimento_por_Gênero)

```
![total de nascimentos por gênero ](https://user-images.githubusercontent.com/100967007/159377653-f11390db-7745-4743-bd04-47c7743a9124.png)

3.  **total de nascimentos por mês e gênero.**

``` py

#Trazendo o total de nascimentos por mês e gênero

Nascimento_por_mês = tabela[["month","gender","births"]].groupby(["month","gender"]).sum()

display(Nascimento_por_mês)

```
![total de nascimentos por mês e gênero](https://user-images.githubusercontent.com/100967007/159377743-10adfbda-8191-46e0-aacd-e7fa27c79f16.png)


4.  **Total de nascimentos por ano.**

``` py

#Trazendo o total de nascimentos por ano

Nascimento_por_ano = tabela[["year", "births"]].groupby(["year"]).sum()

display(Nascimento_por_ano)

```
![total de nascimentos por ano](https://user-images.githubusercontent.com/100967007/159377946-a4e3f8a8-8fff-4147-82bb-841c031a95e7.png)

5.  **Total de nascimentos por mês.**

``` py

#Trazendo o total de nascimentos por mês

Nascimento_por_mês_total = tabela[["month", "births"]].groupby(["month"]).sum()

display(Nascimento_por_mês_total)

```
![total de nascimentos por mês](https://user-images.githubusercontent.com/100967007/159378067-453a59e3-2cea-44a4-83e1-8c468e81c0fd.png)


---

Conclusão USA

Foi possivel concluir que no período de 1969 a 1988 o mês em que mais houve nascimentos foi o mês de Agosto, totalizando 6.309.764 nascimentos.

Ademais, nasceram menos crianças do gênero feminino do que masculino nesse mês, sendo 3.234.413 mulheres e 3.075.351 homens. 




