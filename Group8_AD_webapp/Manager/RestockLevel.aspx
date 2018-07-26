﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RestockLevel.aspx.cs" Inherits="Group8_AD_webapp.Manager.RestockLevel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
    <link href="../css/employee-style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="main">

           <asp:UpdatePanel runat="server"><ContentTemplate>
        <div class="subtitletext" style="margin-top: 8px;">Change Restock Level and Quantity</div>
        <div class="form-group form-inline m-2 text-center col-12">
            <div class="sh-section-reorder">

            
                        <div style="display: inline-block;">
                            <div style="display: inline-block;">
                                <span class="lbl-inherit" style="vertical-align: text-bottom">Threshold :</span>
                                <asp:DropDownList ID="ddlThreshold" CssClass="form-control mx-2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlThreshold_SelectedIndexChanged">
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
                            <span class="lbl-inherit" style="vertical-align: text-bottom">Category :</span>
                            <asp:DropDownList ID="ddlCategory" CssClass="form-control mx-2" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                <asp:ListItem Text="All" Value="All" />
                            </asp:DropDownList>
                            <div style="display: inline-block;">
                                <asp:TextBox ID="txtSearch" CssClass="txtSearch form-control mx-2" runat="server" OnTextChanged="txtSearch_Changed" AutoPostBack="True"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" CssClass="btnSearch btn btn-success button" Text="Search" OnClick="btnSearch_Click" />
                            </div>
                        </div>
               </div>

            </div>
       </ContentTemplate></asp:UpdatePanel>
         <asp:UpdatePanel runat="server"><ContentTemplate>
         <asp:Label ID="lblPageCount" runat="server" Text="Label"></asp:Label>
                <asp:GridView ID="grdRestockItem" PagerStyle-CssClass="pager" AllowPaging="True" runat="server" OnPageIndexChanging="grdRestockItem_PageIndexChanging" PageSize="10" CssClass="table table-bordered" AutoGenerateColumns="False" OnRowCommand="grdRestockItem_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Product">
                            <ItemTemplate>
                                <table class="table borderless">
                                    <tr>
                                        <td style="text-align: left; padding: 0px;">
                                            <asp:Label CssClass="item-info" ID="lblItemCode" runat="server" Text='<%# Bind("ItemCode") %>' Visible="True" />
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
                                <asp:Button ID="btnReLevel" runat="server" CommandName="ReLevel" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CssClass="btn btn-primary restock-content" Text="use" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Change Reorder Level">
                            <ItemTemplate>
                                <asp:TextBox ID="txtChangeReLevel" runat="server" CssClass="p-2 restock-content" type="number" Text='<%# Eval("NewReorderLvl") %>' min="0" Width="50px" Height="34px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reorder Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblRestockQty" CssClass="restock-content" runat="server" Text='<%# Eval("ReorderQty") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Recommended Reorder Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblRecomQty" CssClass="restock-content" runat="server" Text='<%# Eval("ReccReorderQty") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:Button ID="btnReLevelQty" CommandName="ReQty" CssClass="btn btn-primary restock-content" runat="server" Text="use" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Change Reorder Quantity">
                            <ItemTemplate>
                                <asp:TextBox ID="txtChangeRestockQty" type="number" CssClass="p-2 restock-content" Text='<%# Eval("NewReorderQty") %>' runat="server" min="0" Width="50px" Height="34px" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <EmptyDataTemplate>
                        There is nothing in the list 
                    </EmptyDataTemplate>
                </asp:GridView>

                <div class="row">

                    <div class="buttonarea">

                        <asp:Button ID="btnUpdate" CssClass="btn btn-success" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div id="mdlConfirm" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
        <div class="modal-content">
        <div class="panel panel-default">
        <div class="panel-heading"><button type="button" ID="btnClose" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" style="font-size: 3.2rem"><strong>&times;</strong></span></button>
            <h3 class="detail-subtitle">Change Restock Level & Quantity</h3></div>
            <div class="panel-body">
                You are about to change the restock levels and restock quantities.<br />
                Are you sure?
            
                
                <div class="action-btn">
                 
                    <asp:Button ID="btnConfirm" class="btn btn-success btn-msize" OnClick="btnConfirm_Click" runat="server" Text="Yes" />
                     <asp:Button ID="btnCancel" class="btn btn-danger btn-msize" OnClick="btnNo_Click" runat="server" Text="No" />
                </div>
              </div>
       </div></div></div>
    </div>

</asp:Content>
