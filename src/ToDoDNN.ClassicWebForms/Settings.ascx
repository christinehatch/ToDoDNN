<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="ToDoDNN.ClassicWebForms.Settings" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnForm dnnClear" id="toDoDNN_Settings">
	<fieldset>
		<div class="dnnFormItem">
			<dnn:label id="ownerTypeListLabel" runat="server" controlname="ownerTypeList"/>
			<asp:dropDownList id="ownerTypeList" runat="server">
			    <asp:listItem Value="module" resourcekey="Module"></asp:listItem>
			    <asp:listItem Value="user" resourcekey="User"></asp:listItem>
			</asp:dropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn:label id="softDeleteTodosLabel" runat="server" controlname="softDeleteTodos" />
			<asp:checkbox id="softDeleteTodos" runat="server" />
		</div>
	</fieldset>
</div>