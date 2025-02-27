create proc SearchProduct
@srch varchar(255)
as
begin
	select * from prodtbl where pname like '%'+@srch+'%';
end


exec SearchProduct 'clo'