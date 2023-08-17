create database Assesment05Db
use Assesment05Db

create schema bank
create table bank.Customer
(
	CId int primary key identity(1000,1),
	CName nvarchar(50) not null,
	CEmail nvarchar(50) not null unique,
	Contact nvarchar(50) not null unique,
	CPwd as right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2) persisted 
)
insert into bank.Customer(CName,CEmail,Contact) values ('Sam','Sam@gmail.com','7776534214')
insert into bank.Customer(CName,CEmail,Contact) values ('Amit','Amit@gmail.com','8888678761')
insert into bank.Customer(CName,CEmail,Contact) values ('Rahul','Rahul@gmail.com','9999876920')
insert into bank.Customer(CName,CEmail,Contact) values ('Jeetendra','Jeetendra@gmail.com','6666787321')
insert into bank.Customer(CName,CEmail,Contact) values ('Dipak','Dipak@gmail.com','4444747623')

select * from bank.Customer

create table bank.MailInfo
(	
	MailTo nvarchar(50),
	MailDate date,
	MailMessage nvarchar(50)
)


create trigger InsertIntoCust
on bank.Customer
after insert
as
begin
declare @id int
declare @name nvarchar(50)
declare @mail nvarchar(50)
declare @contact nvarchar(50)
declare @pwd nvarchar(50)

declare @msg nvarchar(50)

select @id=Cid,@name=CName,@mail=CEmail,@contact=Contact,@pwd=(right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2)) from inserted
select @msg='Your NetBanking password is : '+@pwd+'it is valid up to 2 days only. Update it'

insert into MailInfo values (@mail,GETDATE(),@msg)

if(@@ROWCOUNT>=1)
begin
print 'After trigger value inserted'
end
end

insert into bank.Customer(CName,CEmail,Contact) values ('manjesh','manjesh@gmail.com','98987476444')
select * from bank.Customer
select * from bank.MailInfo