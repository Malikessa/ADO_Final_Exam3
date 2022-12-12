
CREATE PROCEDURE sp_ListOfPosts
AS
BEGIN
	select * from Posts order by PostDate
	
END
GO



CREATE PROCEDURE sp_ListOfComments
AS
BEGIN
	select * from Comments
	
END
GO




CREATE PROCEDURE sp_CreatePost
	@PostContent varchar(255),
	@AuthorID int,
	@AuthorName varchar(50),
	@PostDate Date
	
AS
BEGIN
	insert into Posts values
	(@PostContent,@AuthorID,@AuthorName,@PostDate,0,0)
END
GO



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


CREATE PROCEDURE sp_EditPost
	@PostId int,
	@PostContent varchar(255),
	@AuthorID int
	
AS
BEGIN
	update Posts set
	PostContent=@PostContent
	where Id=@PostId AND AuthorID=@AuthorID
END
GO

exec sp_EditPost @PostId=6,@PostContent='88888',@AuthorID=2

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



CREATE PROCEDURE sp_DeletePost
	@PostId int,
	@UserId int
AS
BEGIN
	delete from Reactions where ReactedToPost=@PostId
	delete from Comments where PostId=@PostId
	delete from Posts where Id=@PostId AND AuthorID=@UserId
END
GO

CREATE PROCEDURE sp_DeleteComment
	@Id int
AS
BEGIN
	delete from Comments where Id=@Id
END
GO



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

--exec sp_UpVote  @ReactedBy=1,@ReactedToPost=2,@Reaction='like'

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

