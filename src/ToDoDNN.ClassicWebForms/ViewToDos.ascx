<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewToDos.ascx.cs" Inherits="ToDoDNN.ClassicWebForms.ViewToDos" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>

<div id="toDoDNN_ViewToDos">
    <div>
        <div class="dnnClear">
            <asp:HyperLink ID="allFilter" runat="server" resourcekey="All" />&nbsp;&nbsp;
            <asp:HyperLink ID="activeFilter" runat="server" resourcekey="Active" />&nbsp;&nbsp;
            <asp:HyperLink ID="completedFilter" runat="server" resourcekey="Completed" />&nbsp;&nbsp;
            <asp:HyperLink ID="deletedFilter" runat="server" resourcekey="Deleted" Visible="false" />
        </div>
        <asp:DataGrid ID="toDos" runat="server" AutoGenerateColumns="false" GridLines="None" CssClass="dnnGrid">
            <HeaderStyle CssClass="dnnGridHeader" />
            <ItemStyle CssClass="dnnGridItem" />
            <AlternatingItemStyle CssClass="dnnGridAltItem" />
            <Columns>
                <asp:BoundColumn DataField="Name" HeaderText="Name" HeaderStyle-Width="100px" />
                <asp:BoundColumn DataField="Description" HeaderText="Description" HeaderStyle-Width="250px" />
                <asp:BoundColumn DataField="IsComplete" HeaderText="IsComplete" HeaderStyle-Width="100px" />
                <asp:TemplateColumn HeaderText="Actions">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CommandName="Complete">
                            <asp:Image runat="server" ImageUrl="images/Complete.gif"/>
                        </asp:LinkButton>
                        &nbsp;&nbsp;
                        <asp:HyperLink runat="server">
                            <asp:Image runat="server" ImageUrl="images/Edit_16X16.png"/>
                        </asp:HyperLink>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="deleteToDo" runat="server" CommandName="Delete">
                            <asp:Image runat="server" ImageUrl="images/Delete_16x16.png"/>
                        </asp:LinkButton>
                        <asp:LinkButton ID="restoreToDo" runat="server" CommandName="Restore">
                            <asp:Image runat="server" ImageUrl="images/Restore.gif"/>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>

        <ul class="dnnActions dnnClear">
            <li><asp:HyperLink ID="addToDo" runat="server" CssClass="dnnPrimaryAction" resourcekey="AddToDo" /></li>
        </ul>
    </div>
</div>

<script language="javascript" type="text/javascript">
    /*globals jQuery, window, Sys */
    (function ($, Sys) {
        function setUpToDos() {
            $("a[id*='toDos_deleteToDo']").dnnConfirm({
                text: '<%= Localization.GetSafeJSString("DeleteToDo.Text", LocalResourceFile) %>',
                yesText: '<%= Localization.GetSafeJSString("Yes.Text", Localization.SharedResourceFile) %>',
                noText: '<%= Localization.GetSafeJSString("No.Text", Localization.SharedResourceFile) %>',
                title: '<%= Localization.GetSafeJSString("Confirm.Text", Localization.SharedResourceFile) %>'
            });
        }
        $(document).ready(function () {
            setUpToDos();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpToDos();
            });
        });
    }(jQuery, window.Sys));
</script>