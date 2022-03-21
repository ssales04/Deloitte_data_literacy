-- Utilizamos o Microsoft SQL Server Management Studio;
--A base de dados foi gerada a partir de comando direto no programa (bot�o direito>New Database);
--Para carregamento das informa��es de "Births", utilizamos o wizard de importa��o do programa
	--(Bot�o direito sobre o nome da Base de Dados>tasks>import Data)

--Para tratamento da Base, seguem os scripts:

--01--Identifica Linhas que apresentam "Null" em alguma das informa��es
select * from a__births
where isnull([year], '') = '' or isnull([month], '') = '' or isnull([day], '') = '' or isnull([gender], '') = '' or isnull(births, '') = ''

--02--Destina as Linhas identificadas no script acima para outra tabela, para n�o perdermos as informa��es originais
select * into a__Linhas_Excluidas_Falta_Informacao
from a__births
where isnull([year], '') = '' or isnull([month], '') = '' or isnull([day], '') = '' or isnull([gender], '') = '' or isnull(births, '') = ''

--03--Deleta as linhas identificas no script 01
delete a__births
where isnull([year], '') = '' or isnull([month], '') = '' or isnull([day], '') = '' or isnull([gender], '') = '' or isnull(births, '') = ''

--04-Identifica quais anos, por g�nero, foram impactados pela falta de informa��o
select distinct [year], gender, sum([births]) from a__Linhas_Excluidas_Falta_Informacao
group by [year], gender
order by [year]

--05--Identifica quais anos e meses, por g�nero, foram impactados pela falta de informa��o
select distinct [year], [month], gender, sum([births]) from a__Linhas_Excluidas_Falta_Informacao
group by [year], [month], gender
order by [year], [month]


--06--Identifica linhas que apresentam inconsist�ncias nas informa��es
	--06.01--Identifica linhas com informa��es inconsistentes, baseado nas colunas de dia, m�s, ano e g�nero.
select * from a__births
where ([month] not in (1,2,3,4,5,6,7,8,9,10,11,12))
	  or ([day] not in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,21,22,23,24,25,26,27,28,29,30,31))
	  or ([gender] not in('M', 'F'))
	  or (replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([year],1,'x'),2,'x'),3,'x'),4,'x'),5,'x'),6,'x'),7,'x'),8,'x'),9,'x'),0,'x') != 'xxxx')

	--06.02--Destina linhas para outra tabela, para n�o perdermos a informa��o original
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

--08--Deleta Linhas com Incosist�ncia
delete a__births
where ([month] not in (1,2,3,4,5,6,7,8,9,10,11,12))
	  or ([day] not in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,21,22,23,24,25,26,27,28,29,30,31))
	  or ([gender] not in('M', 'F'))
	  or (replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([year],1,'x'),2,'x'),3,'x'),4,'x'),5,'x'),6,'x'),7,'x'),8,'x'),9,'x'),0,'x') != 'xxxx')

--07-Identifica quais anos, por g�nero, foram impactados pela informa��o incosistente
select distinct [year], gender, sum([births]) from a__Linhas_Excluidas_Inconsistencia
group by [year], gender
order by [year]

--08--Identifica quais anos e meses, por g�nero, foram impactados pela informa��o incosistente
select distinct [year], [month], gender, sum([births]) from a__Linhas_Excluidas_Inconsistencia
group by [year], [month], gender
order by [year], [month]

--09-Extrai tabela "limpa" para utiliza��o em excel
select * from a__births

--O backup da base foi feito atrav�s da pr�pria ferramenta
	--(bot�o direito sobre a base>Tasks>Backup)

