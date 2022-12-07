create table Users
(
	Id int primary key identity(1,1),
	FullName varchar(50),
	UserName varchar(50),
	Email varchar(50),
	Password varchar(50),
	UserType varchar(50),
	CreateDate Date
)

create table Posts
(
	Id int primary key identity(1,1),
	PostContent varchar(255),
	AuthorID int,
	AuthorName varchar(50),
	PostDate date,
	Likes int,
	Dislikes int
)

create table Comments
(
	Id int primary key identity(1,1),
	CommentContent varchar(255),
	CommentedById int,
	CommentedByName varchar(50),
	PostId int,
	CommentDate Date
)

create table Reactions
(
	Id int primary key identity(1,1),
	ReactedBy int,
	ReactedToPost int,
	Reaction varchar(50)
)
