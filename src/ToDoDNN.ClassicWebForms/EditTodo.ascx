<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditToDo.ascx.cs" Inherits="ToDoDNN.ClassicWebForms.EditToDo" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnForm dnnEditToDo dnnClear" id="dnnEditToDo">
	<fieldset>
		<div class="dnnFormItem">
			<dnn:label id="toDoNameLabel" runat="server" controlname="toDoName"/>
			<asp:TextBox ID="toDoName" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn:label id="toDoDescriptionLabel" runat="server" controlname="toDoDescription"/>
			<asp:TextBox ID="toDoDescription" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn:label id="isCompleteLabel" runat="server" controlname="isComplete" />
			<asp:checkbox id="isComplete" runat="server" />
		</div>
		<ul class="dnnActions dnnClear">
			<li><asp:LinkButton id="saveToDo" runat="server" class="dnnPrimaryAction" resourcekey="save" /></li>
			<li><asp:HyperLink id="cancel" runat="server" class="dnnSecondaryAction" resourcekey="cancel" /></li>
		</ul>
	</fieldset>
</div>