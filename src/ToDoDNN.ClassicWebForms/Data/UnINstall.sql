/* Copyright (c) Charles Nurse. All rights reserved.										*/
/* Licensed under the MIT License. See LICENSE in the project root for license information. */
/********************************************************************************************/

/*  AddToDo  */
/*************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_AddToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_AddToDo
GO

/*  DeleteToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_DeleteToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_DeleteToDo
GO

/*  GetToDo  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_GetToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_GetToDo
GO

/*  GetToDos  */
/**************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_GetToDos]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_GetToDos
GO

/*  UpdateToDo  */
/****************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[dnn_ToDoDnn_UpdateToDo]') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.dnn_ToDoDnn_UpdateToDo
GO

/*  ToDos Table  */
/*****************/

IF EXISTS (SELECT * FROM sys.objects 
		WHERE object_id = OBJECT_ID(N'[dbo].[dnn_ToDoDnn_ToDos]') 
		AND type in (N'U'))
	DROP TABLE [dbo].[dnn_ToDoDnn_ToDos]

