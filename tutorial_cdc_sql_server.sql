/* CDC Features */

-- Developer Wallace Camargo

--verificar se o cdc est� habilitado em algum banco 
select name, is_cdc_enabled from sys.databases

--verificar se o cdc est� habilitado em alguma tabela
select name, is_tracked_by_cdc from sys.tables

use Workshop_SQL
go

create table tb_alunos (
	id int identity(1,1) primary key,
	nome varchar(30)
)
go

--Habilitar CDC no banco que est� posicionado
EXEC sys.sp_cdc_enable_db

-- Habilitar CDC na tabela
EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'tb_alunos',
@role_name = NULL
GO

insert into tb_alunos
values
('Walace'),
('Quintell�o'),
('Ricardo'),
('Iesus'),
('Mauro'),
('Jose'),
('Poliana'),
('Viviane'),
('Renato'),
('Pedro'),
('Rafael'),
('Decio')


create table cdc_operations_code (
	id_operation int identity (1,1),
	description varchar(100)
)

insert into cdc_operations_code 
values
('delete'),
('insert'),
('value before image'),
('value after image')

select 
	ta.*, 
	oc.description 
from 
	[cdc].[dbo_tb_alunos_CT] ta 
	inner join [dbo].[cdc_operations_code] oc on ta.__$operation = oc.id_operation

select * from tb_alunos

-- Update 
update [dbo].[tb_alunos]
set nome = 'Wallace'
where id = 1

-- Delete
delete tb_alunos

-- Desabilitar o CDC
-- Se desabilitar ele apaga a tabela de controle

EXEC sys.sp_cdc_disable_db
go