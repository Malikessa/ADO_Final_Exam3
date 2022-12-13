-------------------------------
		---Task01---			
-------------------------------
CREATE PROCEDURE sp_ListOfPosts
AS
BEGIN
	select * from Posts order by Likes desc,PostDate desc
	
END
GO
-------------------------------
		---Task01---			
-------------------------------
CREATE PROCEDURE sp_ListOfComments
AS
BEGIN
	select * from Comments
	
END
GO
-------------------------------
		---Task02---			
-------------------------------
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
-------------------------------
		---Task03---			
-------------------------------
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
exec sp_EditPost @PostId=5,@PostContent='777',@AuthorID=1
-------------------------------
		---Task04---			
-------------------------------
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
-------------------------------
		---Task05---			
-------------------------------
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
-------------------------------
		---Task06---			
-------------------------------
CREATE PROCEDURE sp_EditComment
	@Id int,
	@CommentContent varchar(255),
	@CommentById int
	
AS
BEGIN
	update Comments set
	CommentContent=@CommentContent
	where Id=@Id AND CommentedById=@CommentById
END
GO
-------------------------------
		---Task07---			
-------------------------------
CREATE PROCEDURE sp_DeleteComment
	@Id int,
	@UserId int
AS
BEGIN
	delete from Comments where Id=@Id AND CommentedById=@UserId
END
GO
-------------------------------
		---Task08---			
-------------------------------
CREATE PROCEDURE sp_UpVote
	@ReactedBy int,
	@ReactedToPost int,
	@Reaction varchar(50)
AS
BEGIN
	IF(EXISTS(select Id from Reactions where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost AND Reaction=@Reaction))
	BEGIN
		update Reactions set Reaction=@Reaction where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost
	END
	ELSE IF(EXISTS(select Id from Reactions where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost AND Reaction='dislike'))
	BEGIN
		update Reactions set Reaction=@Reaction where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost
		update Posts set Likes += 1 where Id=@ReactedToPost
		update Posts set Dislikes -= 1 where Id=@ReactedToPost
	END
	ELSE
	BEGIN
		update Posts set Likes += 1 where Id=@ReactedToPost
		insert into Reactions values
		(@ReactedBy,@ReactedToPost,@Reaction)
	END
END
GO
-------------------------------
		---Task09---			
-------------------------------
CREATE PROCEDURE sp_DownVote
	@ReactedBy int,
	@ReactedToPost int,
	@Reaction varchar(50)
AS
BEGIN
	IF(EXISTS(select Id from Reactions where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost AND Reaction=@Reaction))
	BEGIN
		update Reactions set Reaction=@Reaction where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost
	END
	ELSE IF(EXISTS(select Id from Reactions where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost AND Reaction='like'))
	BEGIN
		update Reactions set Reaction=@Reaction where ReactedBy=@ReactedBy AND ReactedToPost=@ReactedToPost
		update Posts set Dislikes += 1 where Id=@ReactedToPost
		update Posts set Likes -= 1 where Id=@ReactedToPost
	END
	ELSE
	BEGIN
		update Posts set Dislikes += 1 where Id=@ReactedToPost
		insert into Reactions values
		(@ReactedBy,@ReactedToPost,@Reaction)
	END
END
GO

