-- Utilizamos o Microsoft SQL Server Management Studio;
--A base de dados foi gerada a partir de comando direto no programa (botão direito>New Database);
--Para carregamento das informações de "Births", utilizamos o wizard de importação do programa
	--(Botão direito sobre o nome da Base de Dados>tasks>import Data)

--Para tratamento da Base, seguem os scripts:

--01--Identifica Linhas que apresentam "Null" em alguma das informações
select * from a__births
where isnull([year], '') = '' or isnull([month], '') = '' or isnull([day], '') = '' or isnull([gender], '') = '' or isnull(births, '') = ''

--02--Destina as Linhas identificadas no script acima para outra tabela, para não perdermos as informações originais
select * into a__Linhas_Excluidas_Falta_Informacao
from a__births
where isnull([year], '') = '' or isnull([month], '') = '' or isnull([day], '') = '' or isnull([gender], '') = '' or isnull(births, '') = ''

--03--Deleta as linhas identificas no script 01
delete a__births
where isnull([year], '') = '' or isnull([month], '') = '' or isnull([day], '') = '' or isnull([gender], '') = '' or isnull(births, '') = ''

--04-Identifica quais anos, por gênero, foram impactados pela falta de informação
select distinct [year], gender, sum([births]) from a__Linhas_Excluidas_Falta_Informacao
group by [year], gender
order by [year]

--05--Identifica quais anos e meses, por gênero, foram impactados pela falta de informação
select distinct [year], [month], gender, sum([births]) from a__Linhas_Excluidas_Falta_Informacao
group by [year], [month], gender
order by [year], [month]


--06--Identifica linhas que apresentam inconsistências nas informações
	--06.01--Identifica linhas com informações inconsistentes, baseado nas colunas de dia, mês, ano e gênero.
select * from a__births
where ([month] not in (1,2,3,4,5,6,7,8,9,10,11,12))
	  or ([day] not in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,21,22,23,24,25,26,27,28,29,30,31))
	  or ([gender] not in('M', 'F'))
	  or (replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([year],1,'x'),2,'x'),3,'x'),4,'x'),5,'x'),6,'x'),7,'x'),8,'x'),9,'x'),0,'x') != 'xxxx')

	--06.02--Destina linhas para outra tabela, para não perdermos a informação original
insert into a__Linhas_Excluidas_Inconsistencia
([year],
[month],
[day],
[gender],
[births])
select
[year],
[month],
[day],
[gender],
[births]
from a__births
where ([month] not in (1,2,3,4,5,6,7,8,9,10,11,12))
	  or ([day] not in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,21,22,23,24,25,26,27,28,29,30,31))
	  or ([gender] not in('M', 'F'))
	  or (replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([year],1,'x'),2,'x'),3,'x'),4,'x'),5,'x'),6,'x'),7,'x'),8,'x'),9,'x'),0,'x') != 'xxxx')

--08--Deleta Linhas com Incosistência
delete a__births
where ([month] not in (1,2,3,4,5,6,7,8,9,10,11,12))
	  or ([day] not in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,21,22,23,24,25,26,27,28,29,30,31))
	  or ([gender] not in('M', 'F'))
	  or (replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([year],1,'x'),2,'x'),3,'x'),4,'x'),5,'x'),6,'x'),7,'x'),8,'x'),9,'x'),0,'x') != 'xxxx')

--07-Identifica quais anos, por gênero, foram impactados pela informação incosistente
select distinct [year], gender, sum([births]) from a__Linhas_Excluidas_Inconsistencia
group by [year], gender
order by [year]

--08--Identifica quais anos e meses, por gênero, foram impactados pela informação incosistente
select distinct [year], [month], gender, sum([births]) from a__Linhas_Excluidas_Inconsistencia
group by [year], [month], gender
order by [year], [month]

--09-Extrai tabela "limpa" para utilização em excel
select * from a__births

--O backup da base foi feito através da própria ferramenta
	--(botão direito sobre a base>Tasks>Backup)

