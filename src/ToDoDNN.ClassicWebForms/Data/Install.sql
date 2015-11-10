/* Copyright (c) Charles Nurse. All rights reserved.										*/
/* Licensed under the MIT License. See LICENSE in the project root for license information. */
/********************************************************************************************/

/*  ToDos Table  */
/*****************/

IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[dnn_ToDoDnn_ToDos]') 
		AND type in (N'U'))
	BEGIN
		CREATE TABLE [dbo].[dnn_ToDoDnn_ToDos]
		(
			[ToDoID]		INT				NOT NULL PRIMARY KEY IDENTITY, 
			[OwnerID]		INT             NOT NULL,	
			[Name]			NVARCHAR(100)	NOT NULL, 
			[Description]	NVARCHAR(2000)	NULL, 
			[IsComplete]	BIT				NOT NULL CONSTRAINT [DF_dnn_ToDoDnn_ToDos_IsComplete] DEFAULT 0, 
			[IsDeleted]		BIT				NOT NULL CONSTRAINT [DF_dnn_ToDoDnn_ToDos_IsDeleted] DEFAULT 0, 
			[CreatedOnDate]	DATETIME		NOT NULL CONSTRAINT [DF_dnn_ToDoDnn_ToDos_DateCreated] DEFAULT getdate()
		)
	END

/*  AddToDo  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_AddToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_AddToDo
GO

CREATE PROCEDURE dbo.dnn_ToDoDnn_AddToDo
	@OwnerID			int,
	@Name				NVARCHAR(100),
	@Description		nvarchar(2000),
	@IsComplete 		bit
AS
	INSERT INTO dbo.dnn_ToDoDnn_ToDos (
	  OwnerID,
	  Name,
	  Description,
	  IsComplete
	)
	VALUES (
	  @OwnerID,
	  @Name,
	  @Description,
	  @IsComplete
	)
	SELECT SCOPE_IDENTITY()
GO

/*  DeleteToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_DeleteToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_DeleteToDo
GO

CREATE PROCEDURE dbo.dnn_ToDoDnn_DeleteToDo
	@ToDoID		int
AS
	DELETE FROM dbo.dnn_ToDoDnn_ToDos
	WHERE ToDoID = @ToDoID
GO

/*  GetToDo  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}GetToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_GetToDo
GO

CREATE PROCEDURE dbo.dnn_ToDoDnn_GetToDo
	@ToDoID		int
AS
	SELECT * FROM dbo.dnn_ToDoDnn_ToDos
	WHERE ToDoID = @ToDoID

GO

/*  GetToDos  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}GetToDos]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_GetToDos
GO

CREATE PROCEDURE dbo.dnn_ToDoDnn_GetToDos
	@OwnerID	int
AS
	SELECT * FROM dbo.dnn_ToDoDnn_ToDos
	WHERE OwnerID = @OwnerID OR @OwnerID IS NULL

GO

/*  UpdateToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}UpdateToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_UpdateToDo
GO

CREATE PROCEDURE dbo.dnn_ToDoDnn_UpdateToDo
	@ToDoID				int,
	@Name				NVARCHAR(100),
	@Description		nvarchar(2000),
	@IsComplete 		bit,
	@IsDeleted 			bit
AS
	UPDATE dbo.dnn_ToDoDnn_ToDos
		SET 
			Name = @Name,
			Description = @Description,
			IsComplete = @IsComplete,
			IsDeleted = @IsDeleted
		WHERE ToDoID = @ToDoID
GO