// Copyright (c) Charles Nurse. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

using DotNetNuke.Entities.Modules;
using ToDoDNN.ClassicWebForms.Components;

namespace ToDoDNN.ClassicWebForms
{
    public partial class Settings : ModuleSettingsBase
    {
        public override void LoadSettings()
        {
            base.LoadSettings();

            var settings = new ToDoSettings(ModuleConfiguration);
            softDeleteTodos.Checked = settings.SoftDeleteToDos;
            ownerTypeList.SelectedIndex = (settings.OwnerType == OwnerType.Module) 
                                                ? 0 
                                                : 1;
        }

        public override void UpdateSettings()
        {
            var settings = new ToDoSettings(ModuleConfiguration)
                                {
                                    SoftDeleteToDos = softDeleteTodos.Checked,
                                    OwnerType = (ownerTypeList.SelectedIndex == 0) 
                                                ? OwnerType.Module 
                                                : OwnerType.User
                                };
            settings.Save();
        }
    }
}