/* Copyright (c) Charles Nurse. All rights reserved.										*/
/* Licensed under the MIT License. See LICENSE in the project root for license information. */
/********************************************************************************************/

/*  ToDos Table  */
/*****************/

IF NOT EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_ToDos]') 
		AND type in (N'U'))
	BEGIN
		CREATE TABLE {databaseOwner}[{objectQualifier}ToDoDNN_ToDos]
		(
			[ToDoID]		INT				NOT NULL PRIMARY KEY IDENTITY, 
			[OwnerID]		INT             NOT NULL,	
			[Name]			NVARCHAR(100)	NOT NULL, 
			[Description]	NVARCHAR(2000)	NULL, 
			[IsComplete]	BIT				NOT NULL CONSTRAINT [DF_{objectQualifier}ToDoDNN_ToDos_IsComplete] DEFAULT 0, 
			[IsDeleted]		BIT				NOT NULL CONSTRAINT [DF_{objectQualifier}ToDoDNN_ToDos_IsDeleted] DEFAULT 0, 
			[CreatedOnDate]	DATETIME		NOT NULL CONSTRAINT [DF_{objectQualifier}ToDoDNN_ToDos_DateCreated] DEFAULT getdate()
		)
	END

/*  AddToDo  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_AddToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_AddToDo
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_AddToDo
	@OwnerID			int,
	@Name				NVARCHAR(100),
	@Description		nvarchar(2000),
	@IsComplete 		bit
AS
	INSERT INTO {databaseOwner}{objectQualifier}ToDoDNN_ToDos (
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_DeleteToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_DeleteToDo
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_DeleteToDo
	@ToDoID		int
AS
	DELETE FROM {databaseOwner}{objectQualifier}ToDoDNN_ToDos
	WHERE ToDoID = @ToDoID
GO

/*  GetToDo  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_GetToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_GetToDo
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_GetToDo
	@ToDoID		int
AS
	SELECT * FROM {databaseOwner}{objectQualifier}ToDoDNN_ToDos
	WHERE ToDoID = @ToDoID

GO

/*  GetToDos  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_GetToDos]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_GetToDos
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_GetToDos
	@OwnerID	int
AS
	SELECT * FROM {databaseOwner}{objectQualifier}ToDoDNN_ToDos
	WHERE OwnerID = @OwnerID OR @OwnerID IS NULL

GO

/*  UpdateToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_UpdateToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_UpdateToDo
GO

CREATE PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_UpdateToDo
	@ToDoID				int,
	@Name				NVARCHAR(100),
	@Description		nvarchar(2000),
	@IsComplete 		bit,
	@IsDeleted 			bit
AS
	UPDATE {databaseOwner}{objectQualifier}ToDoDNN_ToDos
		SET 
			Name = @Name,
			Description = @Description,
			IsComplete = @IsComplete,
			IsDeleted = @IsDeleted
		WHERE ToDoID = @ToDoID
GO