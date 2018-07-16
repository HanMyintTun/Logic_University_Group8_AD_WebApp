﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Catalogue.aspx.cs" Inherits="Group8_AD_webapp.Catalogue" %>
<asp:Content ID="cphHead" ContentPlaceHolderID="cphHead" runat="server">
    <link href="../css/employee-style.css" rel="stylesheet" />
     <script>
         $(document).on('keyup', '.txtSearch', function () {
            $(".txtSearch").blur();
            $(".txtSearch").focus();
        });
    </script>
</asp:Content>



<asp:Content ID="cphBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="main">
     <div class="form-group form-inline formstyle m-2 text-center col-12">
        <asp:DropDownList ID="ddlCategory" CssClass="form-control mx-2" runat="server" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="True">
            <asp:listitem text="Select All" value="0" />
        </asp:DropDownList>
        <asp:TextBox ID="txtSearch" CssClass="txtSearch form-control mx-2" runat="server" OnTextChanged="txtSearch_Changed" AutoPostBack ="True"></asp:TextBox>

        <asp:Button ID="btnSearch" runat="server" CssClass="btnSearch btn btn-success button" Text="Search" OnClick="btnSearch_Click" />
    </div>
        
        <asp:UpdatePanel ID="udpCatalogue" runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" />
        </Triggers>
        <ContentTemplate>
            <script type="text/javascript">
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(toastr_message);
            </script>
          <%--<asp:Button ID="Button1" runat="server" Text="Example Toast" OnClick="Button1_Click" />--%>

        <span class="titletext mt-5 ml-5"><asp:Label ID="lblCatTitle" runat="server" Text="Label"></asp:Label></span>
        <asp:LinkButton ID="btnGrid" Cssclass="listbutton active" runat="server" Text="Button" OnClick="btnGrid_Click"><i class="fa fa-th-large"></i></asp:LinkButton>
        <asp:LinkButton ID="btnList" Cssclass="listbutton" runat="server" Text="Button" OnClick="btnList_Click"><i class="fa fa-list"></i></asp:LinkButton>


    <div id="showlist" class="showlist" runat="server">
    <div class="dpager col-12"><br />
    <asp:DataPager ID="dpgGrdCatalogue" runat="server" PageSize="8" PagedControlID="grdCatalogue" OnPreRender="ListPager_PreRender">
         <Fields>
            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true"   ShowLastPageButton="false" ShowNextPageButton="false" PreviousPageText="Prev" ButtonCssClass="pagingbutton" />
            <asp:NumericPagerField ButtonCount="5" NumericButtonCssClass="pagingbutton" ButtonType="Button" CurrentPageLabelCssClass="currentpg" PreviousPageText="..." NextPreviousButtonCssClass="pagingbutton" />
            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="true" ShowNextPageButton="true" ShowPreviousPageButton="false" ButtonCssClass="pagingbutton" />
      </Fields>
    </asp:DataPager></div>

    <div class="row m-4"> <!-- Listview -->
       <asp:ListView ID="grdCatalogue" runat="server" OnPagePropertiesChanged="lstCatalogue_PagePropertiesChanged">
        <ItemTemplate>
               <div class="product-wrapper col-sm-11 col-md-6"> 
                   <table class="table borderless">
                    <tr>
                      <td rowspan="2">
                          <!--<div class="bookmarkarea btn btn-primary"><i class="fa fa-bookmark"></i> </div> -->
                          <div class="product-image col-4"><img src="../images/pencils.png" class="img-responsive">
                          </div><asp:LinkButton ID="btnBookmark" CssClass="btn btn-warning" OnClick="btnBookmark_Click" runat="server"><i class="fa fa-bookmark"></i> </asp:LinkButton>
                      </td> 
                      <td rowspan="2"><asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("ItemCode") %>' Visible="False" />
                        <span class="product-desc"><asp:Label ID="lblDescription" runat="server" Text='<%#String.Format("{0:C}",Eval("Description"))%>' /></span><br />
                        <span class="product-stock"><asp:Label ID="lblBalance" runat="server" Text='<%# Eval("Balance") %>' /> in stock</span></td>
                      <td class="align-top product-price"><asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:C}",Eval("Price"))%>' /><br />
                          <span class="product-uom">/<asp:Label ID="lblUom" runat="server" Text='<%# Eval("Uom") %>' /></span>
                      </td>
                    </tr>
                     <tr>

                        <td class="td-add align-bottom p-2">
                        <asp:TextBox ID="spnQty" type="number" Cssclass="p-2" runat="server" min="0"  Value="1" Width="60px" /><br />
                        <asp:Button ID="btnAdd" CssClass="btn-add mt-2 btn" runat="server" Text="ADD TO CART" OnClick="btnAdd_Click"/>
                        </td>
                   </tr>
                   </table>
               </div>
        </ItemTemplate>
        <EmptyDataTemplate>
            <span class="noresult">Sorry! There are no items matching your search.</span>
        </EmptyDataTemplate>
        </asp:ListView>
        </div>


        <div class="dpager col-12"><br />
        <asp:DataPager ID="dpgGrdCatalogue2" runat="server" PageSize="8" PagedControlID="grdCatalogue">
             <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true"   ShowLastPageButton="false" ShowNextPageButton="false" PreviousPageText="Prev" ButtonCssClass="pagingbutton" />
                <asp:NumericPagerField ButtonCount="5" NumericButtonCssClass="pagingbutton" ButtonType="Button" CurrentPageLabelCssClass="currentpg" PreviousPageText="..." NextPreviousButtonCssClass="pagingbutton" />
                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="true" ShowNextPageButton="true" ShowPreviousPageButton="false" ButtonCssClass="pagingbutton" />
          </Fields>
        </asp:DataPager></div>
        </div>

        <div id="showgrid" class="showgrid" runat="server">
        <div class="dpager col-12"><br />
        <asp:DataPager ID="dpgLstCatalogue" runat="server" PageSize="15" PagedControlID="lstCatalogue" OnPreRender="ListPager_PreRender">
             <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true"   ShowLastPageButton="false" ShowNextPageButton="false" PreviousPageText="Prev" ButtonCssClass="pagingbutton" />
                <asp:NumericPagerField ButtonCount="5" NumericButtonCssClass="pagingbutton" ButtonType="Button" CurrentPageLabelCssClass="currentpg" PreviousPageText="..." NextPreviousButtonCssClass="pagingbutton" />
                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="true" ShowNextPageButton="true" ShowPreviousPageButton="false" ButtonCssClass="pagingbutton" />
          </Fields>
        </asp:DataPager></div>

       <div class="m-4"> 
        <asp:ListView runat="server" ID="lstCatalogue" OnPagePropertiesChanged="lstCatalogue_PagePropertiesChanged">
        <LayoutTemplate>
            <table runat="server" class="table">
                <thead><tr id="grdHeader" runat="server">
                        <th scope="col" style="display:none;">Item Code</th>
                        <th scope="col">Product Description</th>
                        <th scope="col">Unit Price</th>
                        <th scope="col">Balance in Stock</th>
                        <th scope="col">Quantity</th>
                        <th scope="col"></th>
                </tr></thead>
                <tbody>
                    <tr id="itemPlaceholder" runat="server"></tr>
                </tbody>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td style="display:none;"><asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("ItemCode") %>'/></td>
                <td><asp:Label ID="lblDescription" runat="server" Text='<%#String.Format("{0:C}",Eval("Description"))%>' /></td>
                <td><asp:Label ID="lblPrice" runat="server" Text='<%#String.Format("{0:C}",Eval("Price"))%>' /> 
                    /<asp:Label ID="lblUom" runat="server" Text='<%# Eval("Uom") %>' /></td>
                <td><asp:Label ID="lblBalance" runat="server" Text='<%# Eval("Balance") %>' /></td>
                <td> <asp:TextBox ID="spnQty" type="number" Cssclass="p-2" runat="server" min="0"  Value="1" Width="60px" /></td>
                <td><asp:Button ID="btnAdd" CssClass="btn-add mt-2 btn" runat="server" Text="ADD TO CART" OnClick="btnAdd_Click"/></td>
            </tr>
        </ItemTemplate>
        <EmptyDataTemplate>
            <span class="noresult">Sorry! There are no items matching your search.</span>
        </EmptyDataTemplate>
        </asp:ListView>
           </div>

        <div class="dpager col-12"><br />
        <asp:DataPager ID="dpgLstCatalogue2" runat="server" PageSize="15" PagedControlID="lstCatalogue">
             <Fields>
                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="true"   ShowLastPageButton="false" ShowNextPageButton="false" PreviousPageText="Prev" ButtonCssClass="pagingbutton" />
                <asp:NumericPagerField ButtonCount="5" NumericButtonCssClass="pagingbutton" ButtonType="Button" CurrentPageLabelCssClass="currentpg" PreviousPageText="..." NextPreviousButtonCssClass="pagingbutton" />
                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="true" ShowNextPageButton="true" ShowPreviousPageButton="false" ButtonCssClass="pagingbutton" />
          </Fields>
        </asp:DataPager></div>

        </div>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
