﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RestockLevel.aspx.cs" Inherits="Group8_AD_webapp.Manager.RestockLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <link href="../css/employee-style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="main">

        <div class="form-group form-inline m-2 text-center col-12">
            <div>
                <div style="display: inline-block;">
                    <span class="lbl-inherit">Threshold :</span>
                    <asp:DropDownList ID="ddlThreshold" CssClass="form-control mx-2" runat="server"  AutoPostBack="True" OnSelectedIndexChanged="ddlThreshold_SelectedIndexChanged">
                        <asp:ListItem Text="0%" Value="0" />
                        <asp:ListItem Text="5%" Value="0.05" />
                        <asp:ListItem Text="10%" Value="0.1" />
                        <asp:ListItem Text="15%" Value="0.15" />
                        <asp:ListItem Text="30%" Value="0.3" />
                        <asp:ListItem Text="50%" Value="0.5" />
                        <asp:ListItem Text="75%" Value="0.75" />
                        <asp:ListItem Text="100%" Value="1" />
                    </asp:DropDownList>
                </div>
                <asp:UpdatePanel runat="server"><ContentTemplate> <div style="display: inline-block;">
                    <span class="lbl-inherit">Category :</span>
                    <asp:DropDownList ID="ddlCategory" CssClass="form-control mx-2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="" />
                    </asp:DropDownList>
                    <div style="display: inline-block;">
                        <asp:TextBox ID="txtSearch" CssClass="txtSearch form-control mx-2" runat="server" OnTextChanged="txtSearch_Changed" AutoPostBack="True"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CssClass="btnSearch btn btn-success button" Text="Search" OnClick="btnSearch_Click" />
                    </div>
                </div></ContentTemplate></asp:UpdatePanel>
               
            </div>
        </div>
        <div class="subtitletext" style="margin-top:0px;">Change Restock Level and Quantity</div>
        
         <asp:UpdatePanel ID="udpRestock" runat="server"><ContentTemplate>
         <asp:GridView ID="grdRestockItem" PagerStyle-CssClass="pager" AllowPaging="True" runat="server" OnPageIndexChanging="grdRestockItem_PageIndexChanging" PageSize="10" CssClass="table table-bordered table-stock" AutoGenerateColumns="False" OnRowCommand="grdRestockItem_RowCommand" >
                   <Columns>
                <asp:TemplateField HeaderText="Product">
                    <ItemTemplate>
                        <table class="table borderless table-stock">
                                    <tr>
                                        <td style="text-align:left;padding:0px;">
                                            <asp:Label CssClass="item-info" ID="lblItemCode" runat="server" Text='<%# Eval("ItemCode") %>' Visible="True" />
                                            <span class="product-stock" style="float: right">
                                                <asp:Label ID="lblBalance" runat="server" Text='<%# Eval("Location") %>' /></span>
                                            <br />
                                            <span class="product-stock">
                                                <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Desc")%>' /></span><br />
                                        </td>
                                    </tr>
                         </table>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reorder Level">
                    <ItemTemplate>
                        <asp:Label CssClass="restock-content" ID="lblRestockLevel" runat="server" Text='<%# Eval("ReorderLevel") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Recommended Reorder Level">
                    <ItemTemplate>
                        <asp:Label CssClass="restock-content" ID="lblRecomLevel" runat="server" Text='<%# Eval("ReccReorderLvl") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                       <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                         <asp:Button ID="btnReLevel" runat="server" CommandName="ReLevel" CommandArgument='<%# Eval("ItemCode") %>' OnClick="btnReLevel_Click" CssClass="btn btn-primary restock-content"  Text="use" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Change Reorder Level">
                    <ItemTemplate>
                        <asp:TextBox ID="txtChangeReLevel" runat="server" type="number" CssClass="p-2 restock-content"  min="0" Value=" " Width="50px" Height="34px" />
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Reorder Qty">
                    <ItemTemplate>
                        <asp:Label ID="lblRestockQty" CssClass="restock-content" runat="server" Text='<%# Eval("ReorderQty") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Recommended Reorder Qty">
                    <ItemTemplate>
                        <asp:Label ID="lblRecomQty"  CssClass="restock-content" runat="server" Text='<%# Eval("ReccReorderQty") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                       <asp:TemplateField HeaderText="">
                    <ItemTemplate>
                         <asp:Button ID="btnReLevelQty"  CommandName="ReQty" CssClass="btn btn-primary restock-content" runat="server" Text="use" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Change Reorder Quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="txtChangeRestockQty" type="number" CssClass="p-2 restock-content" runat="server" min="0" Value=" " Width="50px" Height="34px" />
                    </ItemTemplate>
                </asp:TemplateField>
              
            </Columns>
    </asp:GridView>
             
        <div class="row">
        
    <div class="buttonarea">
        
        <asp:Button ID="btnUpdate" Cssclass="btn btn-success" runat="server" Text="Update" />
    </div>
    </div>
        </ContentTemplate></asp:UpdatePanel>
       </div> 
</asp:Content>
