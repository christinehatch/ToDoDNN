// Copyright (c) Charles Nurse. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

using System;
using DotNetNuke.Collections;
using DotNetNuke.Common;
using DotNetNuke.UI.Modules;
using ToDoDNN.ClassicWebForms.Components;

namespace ToDoDNN.ClassicWebForms
{
    public partial class EditToDo : ModuleUserControlBase
    {
        private int _ownerId;
        private ToDoSettings _settings;
        private int _toDoId;

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            saveToDo.Click += saveToDo_Click;
        }

        protected override void OnLoad(EventArgs e)
        {
            _toDoId = Request.QueryString.GetValueOrDefault<int>("ToDoId", -1);

            if (!IsPostBack && _toDoId > -1)
            {
                var controller = new ToDoController();
                var toDo = controller.GetToDo(_toDoId);
                toDoName.Text = toDo.Name;
                toDoDescription.Text = toDo.Description;
                isComplete.Checked = toDo.IsComplete;
            }

            _settings = new ToDoSettings(ModuleContext.Configuration);
            _ownerId = (_settings.OwnerType == OwnerType.Module)
                                ? ModuleContext.ModuleId
                                : ModuleContext.PortalSettings.UserId;

            cancel.NavigateUrl = Globals.NavigateURL();
        }

        private void saveToDo_Click(object sender, EventArgs e)
        {
            var controller = new ToDoController();
            var toDo = new ToDo
                            {
                                OwnerId = _ownerId,
                                Name = toDoName.Text,
                                Description = toDoDescription.Text,
                                IsComplete = isComplete.Checked
                            };

            if (_toDoId > -1)
            {
                toDo.ToDoId = _toDoId;
                controller.UpdateToDo(toDo);
            }
            else
            {
                controller.AddToDo(toDo);
            }

            Response.Redirect(Globals.NavigateURL());
        }
    }
}