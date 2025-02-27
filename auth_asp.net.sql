create table auth(
id int primary key identity,
email varchar(255),
pass varchar(255),
urole varchar(255),
status varchar(255)
)

insert into auth values('john','john@gmail.com','123','Admin')

create proc logincheck
@email varchar(255),
@pass varchar(255)
as 
begin
	select * from auth where email=@email and pass=@pass;
end