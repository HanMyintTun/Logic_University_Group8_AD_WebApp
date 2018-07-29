﻿using Group8_AD_webapp.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Group8AD_WebAPI.BusinessLogic;
namespace Group8_AD_webapp
{
    public partial class Submitted_Requests : System.Web.UI.Page
    {
        static int rid;
        int empId = 1;
        string status = "Submitted";

        EmployeeVM emp = new EmployeeVM();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
               
                BindGrid();
            }

        }

        //bind grid for submitted requests 
        protected void BindGrid()
        {
            List<EmpReqVM> requestlists = BusinessLogic.GetEmpReqList(empId, status);
            lstOrder.DataSource = requestlists;
            lstOrder.DataBind();
        }

        //populate req detail in modal
        protected void PopulateDetailList(int rid)
        {
            RequestVM req = RequestBL.GetReq(rid);
            EmployeeVM emp = EmployeeBL.GetEmp(req.EmpId);
            List<RequestDetailVM> showList = BusinessLogic.GetItemDetailList(rid);
            lblReqid.Text = req.ReqId.ToString();
            lblEmpName.Text = emp.EmpName.ToString();
            lblSubmitteddate.Text = req.ReqDateTime.ToString("dd'/'MM'/'yyyy");
            lblEmployeename.Text = emp.EmpName.ToString();
            lblReqEmployeename.Text = emp.EmpName.ToString();
            lstShow.DataSource = showList;
            lstShow.DataBind();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);//modal popup
        }

        //modal close button
        protected void btn_modal_Click(object sender, EventArgs e)
        {
            Response.Redirect("Submitted-Requests.aspx");
        }
        //Accept
        protected void btnAccept_Click(object sender, EventArgs e)
        {
            RequestVM req = RequestBL.GetReq(rid);
            EmployeeVM emp = EmployeeBL.GetEmp(req.EmpId);
            lblReqEmployeename.Text = emp.EmpName.ToString();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mdlaccept", "$('#mdlaccept').modal();", true);

        }
        protected void btnAcceptYes_Click(object sender, EventArgs e)
        {

            string cmt = txtComments.Text.ToString();
            
            bool success = RequestBL.AcceptRequest(rid, empId, cmt);

            if (success)
            {
                Main master = (Main)this.Master;
                master.ShowToastr(this, String.Format("Request has been accepted!"), "Successfully approved!", "success");
                BindGrid();
            }
            else
            {
                Main master = (Main)this.Master;
                master.ShowToastr(this, String.Format("Changes not Submitted"), "Something Went Wrong!", "error");
            }

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal('toggle');", true);//modal popup
        }

        protected void btnAcceptNo_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#mdlConfirm').modal('toggle');", true);//modal popup
        }

        //Reject

        protected void btnReject_Click(object sender, EventArgs e)
        {
            RequestVM req = RequestBL.GetReq(rid);
            EmployeeVM emp = EmployeeBL.GetEmp(req.EmpId);
            lblEmployeename.Text = emp.EmpName.ToString();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mdlreject", "$('#mdlreject').modal();", true);
           
        }
        protected void btnRejectYes_Click(object sender, EventArgs e)
        {
            string cmt = txtComments.Text.ToString();
            
            bool success = RequestBL.RejectRequest(rid, empId, cmt);

            if (success)
            {
                Main master = (Main)this.Master;
                master.ShowToastr(this, String.Format("Request has been rejected!"), "Successfully rejected!", "success");
                BindGrid();
            }
            else
            {
                Main master = (Main)this.Master;
                master.ShowToastr(this, String.Format("Changes not Submitted"), "Something Went Wrong!", "error");
            }

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal('toggle');", true);//modal popup
        }

        protected void btnRejectNo_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#mdlConfirm').modal('toggle');", true);//modal popup
        }
       

        //detail buttom action 
        protected void lstOrder_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            if (e.CommandName == "ReqDetail")
            {
                if (e.CommandArgument.ToString() != "")
                {

                    rid = Convert.ToInt32(e.CommandArgument);

                    PopulateDetailList(rid);
                }

            }

            
        }
        protected void DataPagerProducts_PreRender(object sender, EventArgs e)
        {
            BindGrid();
        }

    }
}