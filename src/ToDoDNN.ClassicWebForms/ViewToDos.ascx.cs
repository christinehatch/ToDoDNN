// Copyright (c) Charles Nurse. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

using System;
using System.Linq;
using System.Web.UI.WebControls;
using DotNetNuke.Collections;
using DotNetNuke.Common;
using DotNetNuke.Services.Localization;
using DotNetNuke.UI.Modules;
using ToDoDNN.ClassicWebForms.Components;

namespace ToDoDNN.ClassicWebForms
{
    public partial class ViewToDos : ModuleUserControlBase
    {
        private int _ownerId;
        private ToDoSettings _settings;

        private void BindGrid()
        {
            var controller = new ToDoController();
            var filter = Request.QueryString.GetValueOrDefault<string>("filter", String.Empty);
            switch (filter)
            {
                case "active":
                    toDos.DataSource = controller.GetToDos(_ownerId).Where(t => !t.IsComplete && !t.IsDeleted);
                    break;
                case "completed":
                    toDos.DataSource = controller.GetToDos(_ownerId).Where(t => t.IsComplete && !t.IsDeleted);
                    break;
                case "deleted":
                    toDos.DataSource = controller.GetToDos(_ownerId).Where(t => t.IsDeleted);
                    break;
                default:
                    toDos.DataSource = controller.GetToDos(_ownerId).Where(t => !t.IsDeleted);
                    break;
            }
            toDos.DataBind();
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            Localization.LocalizeDataGrid(ref toDos, LocalResourceFile);
            toDos.ItemDataBound += toDos_ItemDataBound;
            toDos.ItemCommand += toDos_ItemCommand;
            addToDo.NavigateUrl = ModuleContext.EditUrl("Edit");
            allFilter.NavigateUrl = Globals.NavigateURL();
            activeFilter.NavigateUrl = Globals.NavigateURL(ModuleContext.TabId, ModuleContext.PortalSettings, "", "filter=active");
            completedFilter.NavigateUrl = Globals.NavigateURL(ModuleContext.TabId, ModuleContext.PortalSettings, "", "filter=completed");
            deletedFilter.NavigateUrl = Globals.NavigateURL(ModuleContext.TabId, ModuleContext.PortalSettings, "", "filter=deleted");
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            _settings = new ToDoSettings(ModuleContext.Configuration);
            _ownerId = (_settings.OwnerType == OwnerType.Module)
                                ? ModuleContext.ModuleId
                                : ModuleContext.PortalSettings.UserId;

            if (_settings.SoftDeleteToDos)
            {
                deletedFilter.Visible = true;
            }

            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        void toDos_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            var controller = new ToDoController();
            var toDo = controller.GetToDos(_ownerId).ToList()[e.Item.ItemIndex];

            if (toDo != null)
            {
                if (e.CommandName == "Delete")
                {
                    if (_settings.SoftDeleteToDos)
                    {
                        toDo.IsDeleted = true;
                        controller.UpdateToDo(toDo);
                    }
                    else
                    {
                        controller.DeleteToDo(toDo);
                    }
                }

                if (e.CommandName == "Restore")
                {
                    toDo.IsDeleted = false;
                    controller.UpdateToDo(toDo);
                }

                if (e.CommandName == "Complete")
                {
                    toDo.IsComplete = true;
                    controller.UpdateToDo(toDo);
                }

                BindGrid();
            }
        }

        void toDos_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var toDo = e.Item.DataItem as ToDo;

                if (toDo != null)
                {
                    var editLink = e.Item.Cells[3].Controls[3] as HyperLink;
                    if (editLink != null)
                    {
                        editLink.NavigateUrl = ModuleContext.EditUrl("ToDoId", toDo.ToDoId.ToString(), "Edit");
                    }

                    var completedButton = e.Item.Cells[3].Controls[1] as LinkButton;
                    if (completedButton != null)
                    {
                        completedButton.Visible = !toDo.IsComplete;
                    }

                    var deletedButton = e.Item.Cells[3].Controls[5] as LinkButton;
                    if (deletedButton != null)
                    {
                        deletedButton.Visible = !toDo.IsDeleted;
                    }

                    var restoreButton = e.Item.Cells[3].Controls[7] as LinkButton;
                    if (restoreButton != null)
                    {
                        restoreButton.Visible = toDo.IsDeleted;
                    }
                }
            }
        }

    }
}