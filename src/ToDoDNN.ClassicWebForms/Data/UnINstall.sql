/* Copyright (c) Charles Nurse. All rights reserved.										*/
/* Licensed under the MIT License. See LICENSE in the project root for license information. */
/********************************************************************************************/

/*  AddToDo  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_AddToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_AddToDo
GO

/*  DeleteToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_DeleteToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_DeleteToDo
GO

/*  GetToDo  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_GetToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_GetToDo
GO

/*  GetToDos  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_GetToDos]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_GetToDos
GO

/*  UpdateToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_UpdateToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE {databaseOwner}{objectQualifier}ToDoDNN_UpdateToDo
GO

/*  ToDos Table  */
/*****************/

IF EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'{databaseOwner}[{objectQualifier}ToDoDNN_ToDos]') 
		AND type in (N'U'))
	DROP TABLE {databaseOwner}[{objectQualifier}ToDoDNN_ToDos]

