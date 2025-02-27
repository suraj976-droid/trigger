create table employees
(
id int primary key identity,
name varchar(255),
email varchar(255)
);

create table employeelogs
(
id int primary key identity,
name varchar(255),
email varchar(255),
dt varchar(100)
);

 create trigger InsertTrigger
 on employees
 after insert
 as 
 begin
		print'Emp saved successfully !!';
end

/* insert query */

insert into employees Values('suraj','Rhj@gmail.com',50000.2);

 /* Create Trigger InsertTrigger2 on employees when insert is done after event log table insert done */

 create trigger InsertTrigger2
 on employees
 after insert
 as 
 begin
   insert into employeelogs(name,email,dt) select name,email,getdate() from inserted;
  end

  truncate table employees
  select * from employees
    select * from employeelogs

	/* add new column salary in log */
	alter table employeelogs add salary decimal(9,2);

	 alter trigger InsertTrigger2
 on employees
 after insert
 as 
 begin
   insert into employeelogs(name,email,dt,salary) select name,email,getdate(),salary from inserted;
  end

  /* check */

  truncate table employees
  select * from employees
    select * from employeelogs

  /* check */

  truncate table employees
  select * from employees
    select * from employeelogs


	/* update employees if it done, then update employeelogs table */

	create trigger TriggerUpdatesecond
	on employees
	after update
	as 
	begin
		update employeelogs 
		set name = (select name from inserted),
		email = (select email from inserted),
		dt = getdate()
		where id = (select id from inserted)
	end

	/* another way of doing this by using decalred value*/
	alter trigger TriggerUpdatesecond
	on employees
	after update
	as 
	begin
			declare @Name varchar(255);
			declare @Id int;
			select @Name = name ,@Id= id from inserted;
			update employeelogs set name=@Name Where id = @Id
	end


	/* Delete trigger for both employees and employeelogs same as before */

	create trigger TriggerDelete
	on employees 
	after delete
	as
	begin 
	delete from employeelogs where id = (select id from deleted)
	end

	delete from employees where id = 2;

	/* alter table add new column salary */

	alter table employees
	add salary decimal(9,2)

/* add salary check condition in trigger*/
 alter trigger InsertTrigger2
 on employees
 Instead of insert
 as 
 begin
		 declare @salary decimal(9,2);
		 select  @salary =salary from inserted;

		 if (@salary < 10000)
					begin 
					print 'salary is less than 10000';
					end
			else
				begin
				insert into employees(name,email,salary) select name,email,salary from inserted;
				end
  end



/* deleted in employees and emploeelogs table also check if id is present or not */

create trigger DeleteTrigger
on employees
Instead of delete
as 
begin 
	declare @Id int ;
	select @Id=id from deleted;
	if (@Id > 0)
		begin
			delete from employees where id= @Id;
		end
	else 
	begin 
		print'Invalid Id';
	end

End

/* check */  delete from employees where id = 355

/* check id before update */
create trigger BeforeUpdateTrigger
on employees
instead of update
as
begin
		 
		declare @Id int;
		select @Id =id from inserted;
end








 