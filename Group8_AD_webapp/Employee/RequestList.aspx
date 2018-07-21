﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RequestList.aspx.cs" Inherits="Group8_AD_webapp.RequestList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">

        <link href="../css/employee-style.css" rel="stylesheet" />
            <script>
            $(function() {
              $('a[href*=#]').on('click', function(e) {
                e.preventDefault();
                $('html, body').animate({ scrollTop: $($(this).attr('href')).offset().top}, 1500, 'linear');
              });
            });
        </script>   
    <style type="text/css"> 
        .UpdateProgress1 { 
            top:450px; left: 450px; 
            position: absolute; 
            background-color: #C3E1FF; 
           background-repeat: repeat-x; } 
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="main">

        <div class="row">

        <asp:UpdatePanel ID="udpList" runat="server">
        <Triggers>
        </Triggers>
        <ContentTemplate>
            <script type="text/javascript">
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(toastr_message);
            </script>
        <div class="col-xs-12 col-lg-6">
       <div class="subtitletext">Request List <a href="#bookmarks" class="viewbmkarea btn btn-warning" style = '<%=IsNotSubmitted ? "" : "display: none;" %>'>VIEW <i class="fa fa-bookmark"></i></a> </div> 
        <span  style = '<%=IsEmpty ? "display: none;":""%>'>STATUS: <asp:Label ID="lblStatus" runat="server" Text="" ></asp:Label></span>
        <!-- Cart List -->

       <div class="listview"> 
        <asp:ListView runat="server" ID="lstShow" OnPagePropertiesChanged="lstCatalogue_PagePropertiesChanged">
        <LayoutTemplate>
            <table runat="server" class="table">
                <thead><tr id="grdHeader" runat="server">
                        <th scope="col" style="display:none">Item Code</th>
                        <th runat="server" id="thdBookmark" ></th>
                        <th scope="col">Product Description</th>
                        <th scope="col">Request Qty</th>
                        <th runat="server" id="thdRemove">Remove</th>
                        <th runat="server" id="thdFulfQty">Fulfilled Qty</th>
                        <th runat="server" id="thdBalQty">Balance Qty</th>
                        <th runat="server" id="thdFulf" style="border:none;"></th>
                </tr></thead>
                <tbody>
                    <tr id="itemPlaceholder" runat="server"></tr>
                </tbody>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td style="display:none;"><asp:Label ID="lblList" runat="server">Cart</asp:Label></td>
                <td style="display:none;"><asp:Label ID="lblReqId" runat="server" Text='<%# Eval("ReqId") %>'/></td>
                <td style="display:none;"><asp:Label ID="lblReqLineNo" runat="server" Text='<%# Eval("ReqLineNo") %>'/></td>
                <td style="display:none"><asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("ItemCode") %>'/></td>
                <td style = '<%=IsNotSubmitted ? "" : "display: none;" %>'><asp:LinkButton ID="btnBookmark" AutoPostBack="false" CssClass="btn btn-warning" OnClick="btnBookmark_Click" runat="server"><i class="fa fa-bookmark"></i> </asp:LinkButton></td>
                <td><asp:Label ID="lblDescription" runat="server" Text='<%#String.Format("{0:C}",Eval("Desc"))%>' /></td>
                <td style = '<%=IsEditable ? "display: none;" : "" %>'> <asp:Label ID="txtQty" runat="server" Text='<%# Eval("ReqQty") %>'></asp:Label></td>
                <td style = '<%=IsEditable ? "" : "display: none;" %>'> <asp:TextBox ID="spnQty" type="number" Cssclass="pad-left10" runat="server" min="0"  Value='<%# Eval("ReqQty") %>' Width="60px" /></td>
                <td style = '<%=IsEditable ? "" : "display: none;" %>'><asp:LinkButton runat="server" ID="btnRemove" CssClass="btn-remove" OnClick="btnRemove_Click"><i class="fa fa-times-circle"></i></asp:LinkButton></td>
                <td style = '<%=IsApproved ? "" : "display: none;" %>'><asp:Label ID="lblFulfilledQty" runat="server" Text='<%# Eval("FulfilledQty") %>'></asp:Label></td>
                <td style = '<%=IsApproved ? "" : "display: none;" %>'><asp:Label ID="lblBalanceQty" runat="server" Text='<%# Convert.ToInt32(Eval("ReqQty")) - Convert.ToInt32(Eval("FulfilledQty"))%>'></asp:Label></td>
                <td style = '<%=IsApproved ? "" : "display: none;" %> <%#(Convert.ToInt32(Eval("ReqQty")) == Convert.ToInt32(Eval("FulfilledQty"))) ? "border:none" : "display: none;" %>'><div class="btn-fulfilled"><i class="fa fa-check-circle"></i></div></td>
            </tr>
        </ItemTemplate>
        <EmptyDataTemplate>
            <span class="noresult">Sorry! There are no items in your cart!.<br />
                Go back to <a href ="CatalogueDash.aspx">Catalogue</a>.
            </span>
        </EmptyDataTemplate>
        </asp:ListView>
           </div>

            <div class="row">
        <div class="col-xs-3 backarea" style = '<%=IsEmpty ? "display: none;":""%>'>
            <asp:Button ID="btnReqList" Cssclass="btn btn-back" runat="server" Text="Back" OnClick ="btnReqList_Click" />
        </div>
        <div class="col-xs-9  buttonarea"  style = '<%=IsApproved ? "display: none;" : "" %> <%=IsEmpty ? "display: none;" : "" %>''>
            <asp:Button ID="btnCancel" Cssclass="btn btn-cancel" OnClick="btnCancel_Click" runat="server" Text="Cancel Request" />
            <asp:Button ID="btnSubmit" Cssclass="btn btn-success" OnClick="btnSubmit_Click" runat="server" Text="Submit" />
            <!-- <asp:Button ID="btnUpdate" Cssclass="btn btn-success" runat="server" Text="Update" /> -->
        </div></div>
        </div>
                     </ContentTemplate>
        </asp:UpdatePanel>

        <div class="col-xs-12 col-lg-4 col-lg-offset-1"> 
        <div class="showbookmarks" style = '<%=IsNotSubmitted ? "" : "display: none;" %>'>
        <a id="bookmarks"></a>
        <div class="subtitletext ml-5">Bookmark List</div>

        <!-- Bookmark List -->
        <asp:UpdatePanel ID="udpBookmark" runat="server">
        <Triggers>
        </Triggers>
        <ContentTemplate>
        <asp:ListView runat="server" ID="lstBookmark" OnPagePropertiesChanged="lstCatalogue_PagePropertiesChanged">
        <LayoutTemplate>
            <table runat="server" class="table">
                <thead><tr id="grdHeader" runat="server">
                        <th scope="col" style="display:none;">Item Code</th>
                        <th></th>
                        <th scope="col">Product Description</th>
                        <th scope="col">Remove</th>
                </tr></thead>
                <tbody>
                    <tr id="itemPlaceholder" runat="server"></tr>
                </tbody>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td style="display:none;"><asp:Label ID="lblList" runat="server">Bookmark</asp:Label></td>
                <td style="display:none;"><asp:Label ID="lblReqId" runat="server" Text='<%# Eval("ReqId") %>'/></td>
                <td style="display:none;"><asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("ItemCode") %>'/></td>
                <td><asp:Button ID="btnAdd" CssClass="btn-warning btn" runat="server" Text="ADD" OnClick="btnAdd_Click"/></td>
                <td><asp:Label ID="lblDescription" runat="server" Text='<%#String.Format("{0:C}",Eval("Desc"))%>' />
                <asp:TextBox ID="spnQty" type="number" runat="server" min="0" Visible="false" Value="1" Width="60px" /></td>
               <td><asp:LinkButton runat="server" ID="btnRemove" CssClass="btn-remove" OnClick="btnRemove_Click"><i class="fa fa-times-circle"></i></asp:LinkButton></td>
            </tr>
        </ItemTemplate>
        <EmptyDataTemplate>
            <span class="noresult">Your Bookmarks List is empty.<a href ="CatalogueDash.aspx">Add some bookmarks!</a></span>
        </EmptyDataTemplate>
        </asp:ListView>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
         </ContentTemplate>
        </asp:UpdatePanel>

           </div>
        </div>
        </div>
    </div>


    <!-- modal content-->
    <div id="mdlConfirm" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
        <div class="modal-content">
        <div class="panel panel-default">
        <div class="panel-heading"><button type="button" ID="btnClose" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" style="font-size: 3.2rem"><strong>&times;</strong></span></button>
            <h3 class="detail-subtitle">Please Confirm Request Details</h3></div>
            <div class="panel-body">
            <asp:UpdatePanel ID="udpConfirmModal" runat="server">
                           <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnConfirm" />
            </Triggers>
            <ContentTemplate>
                <div class="detail-item"><asp:ListView runat="server" ID="lstConfirm">
                    <LayoutTemplate>
                        <table runat="server" class="table table-detail">
                        <thead><tr id="grdHeader" runat="server">
                                    <th scope="col" class="tableleft">Item Description</th>
                                    <th scope="col">Quantity</th>
                        </tr></thead>
                        <tbody><tr id="itemPlaceholder" runat="server"></tr></tbody>
                    </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Desc") %>' /></td>
                            <td><asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("ReqQty") %>' /></td>
                        </tr>
                    </ItemTemplate>
                 </asp:ListView></div>
              </ContentTemplate>
              </asp:UpdatePanel>
                
                <div class="action-btn">
                    <!-- <asp:Button ID="btnFinalCancel" class="btn btn-danger btn-msize" runat="server" Text="Cancel" /> -->
                    <asp:Button ID="btnConfirm" class="btn btn-success btn-msize" OnClick="btnConfirm_Click" runat="server" Text="Confirm" />
                    <button ID="btnLoading" runat="server" class="btn btn-msize btn-warning " style="display:none"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...</button>
                </div>
              </div>
       </div></div></div>
    </div>

    <!-- modal content-->
    <div id="mdlCancel" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog2 modal-lg">
        <div class="modal-content">
        <div class="panel panel-default">
        <div class="panel-heading"><button type="button" ID="btnClose2" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" style="font-size: 3.2rem"><strong>&times;</strong></span></button>
            
            <div class="panel-body panel-body2">
                <h4 class="detail-subtitle">Request will be cancelled.<br /><br /> Please confirm!</h4></div>

                <div class="action-btn action-btn2">
                     <asp:Button ID="btnConfirmCancel" class="btn btn-danger btn-msize" OnClick="btnConfirmCancel_Click" runat="server" Text="Confirm" /> 
                </div>

              </div>
       </div></div></div>
    </div>
     <script type="text/javascript">
        function openModal() {
            $('#mdlConfirm').modal('show');
         }
        function openCancelModal() {
            $('#mdlCancel').modal('show');
         }

</script>
</asp:Content>
