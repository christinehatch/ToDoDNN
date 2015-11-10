// Copyright (c) Charles Nurse. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

using DotNetNuke.Collections;
using DotNetNuke.Entities.Modules;

namespace ToDoDNN.ClassicWebForms.Components
{
    public class ToDoSettings
    {
        private const string OwnerTypeKey = "ToDoDNN_OwnerType";
        private const string SoftDeleteKey = "ToDoDNN_SoftDeleteToDos";

        public ToDoSettings(ModuleInfo module)
        {
            ModuleId = module.ModuleID;

            var owner = module.ModuleSettings.GetValueOrDefault(OwnerTypeKey, "module");
            OwnerType = owner == "module" ? OwnerType.Module : OwnerType.User;

            SoftDeleteToDos = module.ModuleSettings.GetValueOrDefault(SoftDeleteKey, false);
        }

        public int ModuleId { get; }

        public OwnerType OwnerType { get; set; }

        public bool SoftDeleteToDos { get; set; }

        public void Save()
        {
            var controller = new ModuleController();
            controller.UpdateModuleSetting(ModuleId, OwnerTypeKey, OwnerType.ToString().ToLowerInvariant());
            controller.UpdateModuleSetting(ModuleId, SoftDeleteKey, SoftDeleteToDos.ToString().ToLowerInvariant());
        }
    }
}