
CREATE PROCEDURE sp_ListOfPosts
AS
BEGIN
	select * from Posts order by PostDate
	
END
GO

exec sp_ListOfPosts

CREATE PROCEDURE sp_ListOfComments
AS
BEGIN
	select * from Comments
	
END
GO

exec sp_ListOfComments


CREATE PROCEDURE sp_CreatePost
	@PostContent varchar(255),
	@AuthorID int,
	@AuthorName varchar(50),
	@PostDate Date,
	@Likes int,
	@Dislikes int
AS
BEGIN
	insert into Posts values
	(@PostContent,@AuthorID,@AuthorName,@PostDate,@Likes,@Dislikes)
END
GO

exec sp_CreatePost

CREATE PROCEDURE sp_CreateComment
	@CommentContent varchar(255),
	@CommentById int,
	@CommentByName varchar(50),
	@CommentDate Date,
	@PostID int
AS
BEGIN
	insert into Comments values
	(@CommentContent,@CommentById,@CommentByName,@PostID,@CommentDate)
END
GO

exec sp_CreateComment

CREATE PROCEDURE sp_EditPost
	@Id int,
	@PostContent varchar(255),
	@AuthorID int,
	@AuthorName varchar(50),
	@PostDate Date,
	@Likes int,
	@Dislikes int
AS
BEGIN
	update Posts set
	PostContent=@PostContent,
	AuthorID=@AuthorID,
	AuthorName=@AuthorName,
	PostDate=@PostDate,
	Likes=@Likes,
	Dislikes=@Dislikes
	where Id=@Id
END
GO

exec sp_EditPost

CREATE PROCEDURE sp_EditComment
	@Id int,
	@CommentContent varchar(255),
	@CommentById int,
	@CommentByName varchar(50),
	@CommentDate Date,
	@PostID int
AS
BEGIN
	update Comments set
	CommentContent=@CommentContent,
	CommentedById=@CommentById,
	CommentedByName=@CommentByName,
	PostID=@PostID,
	CommentDate=@CommentDate
	where Id=@Id
END
GO

exec sp_EditComment

CREATE PROCEDURE sp_DeletePost
	@Id int
AS
BEGIN
	delete from Reactions where ReactedToPost=@Id
	delete from Comments where PostId=@Id
	delete from Posts where Id=@Id
END
GO

exec sp_DeletePost

CREATE PROCEDURE sp_DeleteComment
	@Id int
AS
BEGIN
	delete from Comments where Id=@Id
END
GO

exec sp_DeleteComment

CREATE PROCEDURE sp_UpVote
	@ReactedBy int,
	@ReactedToPost int,
	@Reaction varchar(50)
AS
BEGIN
	update Posts set Likes += 1 where Id=@ReactedToPost
	insert into Reactions values
	(@ReactedBy,@ReactedToPost,@Reaction)
END
GO

exec sp_UpVote  @ReactedBy=1,@ReactedToPost=2,@Reaction='like'

CREATE PROCEDURE sp_DownVote
	@ReactedBy int,
	@ReactedToPost int,
	@Reaction varchar(50)
AS
BEGIN
	update Posts set Dislikes += 1 where Id=@ReactedToPost
	insert into Reactions values
	(@ReactedBy,@ReactedToPost,@Reaction)
END
GO

exec sp_DownVote