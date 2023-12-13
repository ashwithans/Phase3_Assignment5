create database ExerciseDb5
use ExerciseDb5

create schema bank

drop table bank.Customer
create table bank.Customer
(
CId int primary key identity(1000,1),
CName nvarchar(150) not null,
CEmail nvarchar(150) not null unique,
Contact nvarchar(150) not null unique,
CPwd as (substring(CName, len(CName) - 1, 2) + convert(nvarchar(10), CId) + substring(Contact, 1, 2)) persisted
)

drop table bank.MailInfo

create table bank.MailInfo
(
MailTo nvarchar(150),
MailDate date,
MailMessage nvarchar(max)
)


drop trigger bank.trgMailToCust;

create trigger bank.trgMailToCust
on bank.Customer
after insert
as
begin
insert into bank.MailInfo(MailTo,MailDate,MailMessage)
select inserted.CEmail, getdate(), 'Your net banking password is: ' +inserted.CPwd + 'It is valid upto 2 days only. Update it.'
from inserted
end

insert into bank.Customer (CName,CEmail,Contact) values
('Mridhul Sharma', 'mrisharma@gmail.com', '9380538276'),
('Sarah Sarosh', 'saroshsarah@gmail.com', '9380498272'),
('Jahnvi Tiwari', 'tiwarijahn@gmail.com', '9845374586')

select * from bank.Customer
select * from bank.MailInfo