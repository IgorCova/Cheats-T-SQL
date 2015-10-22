use master;
go

exec sp_configure 'show advanced options', 1;
reconfigure;
exec sp_configure 'max server memory (MB)', 1024;
reconfigure;

--drop database [Pages_and_Extents_Architecture];

if db_id( '[Pages_and_Extents_Architecture]' ) is null
create database [Pages_and_Extents_Architecture];
go

