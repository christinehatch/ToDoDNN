// Copyright (c) Charles Nurse. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

using System;

namespace ToDoDNN.ClassicWebForms.Components
{
    public class ToDo
    {
        public int ToDoId { get; set; }

        public int OwnerId { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public bool IsComplete { get; set; }

        public bool IsDeleted { get; set; }

        public DateTime CreatedOnDate { get; set; }
    }
}