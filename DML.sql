select * from Users

insert into Users values
('Ghulam Essa','malik_786','essakhan7868@gmail.com','1234567','admin',GETDATE()),
('Yasir Ali','yasir_786','yasirali799@gmail.com','1234567','instructor',GETDATE()),
('Zubair Khan','zubair_000','zuhairkhan883@gmail.com','1234567','instructor',GETDATE()),
('Zuhan Khan','zuhan_777','zuhankhan883@gmail.com','1234567','user',GETDATE()),
('Ali Khan','ali_999','zuhankhan883@gmail.com','1234567','user',GETDATE())

select * from Posts
update Posts set Likes=0, Dislikes=0 
insert into Posts values
('Annocement of Quiz. Be ready guys.',1,'Ghulam Essa',GetDate(),0,0),
('Welcome guys in Bootcamp2 of CureMD',2,'Yasir Ali',GetDate(),0,0)

select * from Comments

insert into Comments values
('We are ready sir...',3,'Zuhan Khan',1,GETDATE()),
('Boys are ready sir...',2,'Yasir Ali',2,GETDATE()),
('OK guys just a minute',1,'Ghulam Essa',1,GETDATE())

select * from Reactions
delete from Reactions