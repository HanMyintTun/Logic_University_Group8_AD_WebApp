﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Group8_AD_webapp.Models;
using System.Web.UI.HtmlControls;
using Group8AD_WebAPI.BusinessLogic;

namespace Group8_AD_webapp
{
    public partial class Main : System.Web.UI.MasterPage
    {
        public static List<RequestDetailVM> cartDetailList = new List<RequestDetailVM>();
        public static List<NotificationVM> notifList = new List<NotificationVM>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                SetProfile();
                FillCart();
                FillNotifications();
                PopulateMenuItems();
            }
        }

        protected void SetProfile()
        {
            if(Session["empId"] != null)
            {
                int empId = (int)Session["empId"];

                if (File.Exists(Server.MapPath("~/img/employee/" + empId + ".png")))
                {
                    imgProfile.Src = "~/img/employee/" + empId + ".png";
                }
                else
                {
                    imgProfile.Src = "~/img/employee/profile_default.png";
                }

            lblName.Text = (string)Session["empName"];
                lblRole.Text = (string)Session["role"];
            }
            else
            {
                Response.Redirect("~/Home.aspx");
            }

        }

        protected void PopulateMenuItems()
        {
            List<HtmlGenericControl> deptHeadList = new List<HtmlGenericControl>() { menuDeptHeadDash, menuDeptHeadRequest };
            List<HtmlGenericControl> employeeList = new List<HtmlGenericControl>() { menuCatalogueDash, menuEmployeeRequest};
            List<HtmlGenericControl> storeList = new List<HtmlGenericControl>() { menuManagerDash, menuProductVol, menuRestock, menuSuppliers,menuReports };
            List<HtmlGenericControl> managerList = new List<HtmlGenericControl>() { menuManagerDash, menuProductVol, menuRestock, menuSuppliers, menuAdjustment, menuReports };
            List<HtmlGenericControl> allMenu = new List<HtmlGenericControl>();
            allMenu.AddRange(deptHeadList);
            allMenu.AddRange(employeeList);
            allMenu.AddRange(storeList);
            allMenu.AddRange(managerList);
            foreach (HtmlGenericControl m in allMenu)
            {
                m.Visible = false;
            }
            btnCartLi.Visible = false;

            switch (Session["role"])
            {
                case "Department Head":
                        foreach (HtmlGenericControl m in deptHeadList)  m.Visible = true; break; 
                case "Delegate":
                    foreach (HtmlGenericControl m in deptHeadList) m.Visible = true; break;
                case "Representative":
                    {
                        foreach (HtmlGenericControl m in employeeList) m.Visible = true;
                        btnCartLi.Visible = true;
                        break;
                    }
                case "Employee":
                    {
                        foreach (HtmlGenericControl m in employeeList) m.Visible = true;
                        btnCartLi.Visible = true;
                        break;
                    }
                case "Store Manager":
                    foreach (HtmlGenericControl m in managerList) m.Visible = true; break;
                case "Store Supervisor":
                    foreach (HtmlGenericControl m in managerList) m.Visible = true; break;
                case "Store Clerk":
                    foreach (HtmlGenericControl m in storeList) m.Visible = true; break;
                default:  break;
            }
        }

        public void ShowToastr(object sender, string message, string title, string type)
        {
            ScriptManager.RegisterStartupScript((Page)sender, sender.GetType(), "toastr_message",
            String.Format("toastr.{0}('{1}', '{2}', {{positionClass: 'toast-bottom-right'}});", type.ToLower(), message, title), true);
        }

        public void FillCart()
        {
            int empId = (int)Session["empId"];
            RequestVM cart = Controllers.RequestCtrl.GetReq(empId, "Unsubmitted").FirstOrDefault();
            
            if (cart != null)
            {
                int reqId = cart.ReqId;
                List<RequestDetailVM> reqDetails = Controllers.RequestDetailCtrl.GetReqDetList(reqId);
                reqDetails = BusinessLogic.AddItemDescToReqDet(reqDetails);
                cartDetailList = reqDetails;
                lstCart.DataSource = cartDetailList;
                lstCart.DataBind();
                UpdateCartCount();

            }
            else {
                cartDetailList = new List<RequestDetailVM>();
                lstCart.DataSource = cartDetailList;
                lstCart.DataBind();
            }
        }

        public void FillNotifications()
        {
            int empId = (int)Session["empId"];
            notifList = NotificationBL.GetNotifications(empId);
            lblNotifCount.Text = notifList.Where(x => x.IsRead == false).Count().ToString();

            notifList = notifList.OrderByDescending(x => x.NotificationDateTime).Take(10).ToList();

            lstNotifications.DataSource = notifList;
            lstNotifications.DataBind();
        }

        public void UpdateCartCount()
        {
            int cartCount = 0;
            foreach(RequestDetailVM item in cartDetailList)
            {
                cartCount += item.ReqQty;
            }

            lblCartCount.Text = cartCount.ToString();
        }

        protected void lstCart_PagePropertiesChanged(object sender, EventArgs e)
        {
            lstCart.DataSource = cartDetailList;
            lstCart.DataBind();
        }

        protected void lstNotif_PagePropertiesChanged(object sender, EventArgs e)
        {
            lstNotifications.DataSource = notifList;
            lstNotifications.DataBind();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Home.aspx");
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {

            int empId = (int)Session["empId"];
            RequestVM unsubRequest = Controllers.RequestCtrl.GetReq(empId, "Unsubmitted").FirstOrDefault();
            Main master = this;
            if (unsubRequest != null)
            {
                if (cartDetailList.Count != 0)
                {
                    Response.Redirect("~/Employee/RequestList.aspx");
                }

            }
        }

        protected void btnViewNotif_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Notifications.aspx");

        }

        protected void btnOnNotif_Click(object sender, EventArgs e)
        {
            var lbl = (LinkButton)sender;
            var item = (ListViewItem)lbl.NamingContainer;
            int id = Convert.ToInt32(((Label)item.FindControl("lblID")).Text);
            NotificationBL.MarkOneAsRead(id);

            switch (Session["role"])
            {
                case "Department Head": Response.Redirect("~/DepartmentHead/Submitted-Requests.aspx"); break;   
                case "Delegate": Response.Redirect("~/DepartmentHead/Submitted-Requests.aspx"); break;          
                case "Representative": Response.Redirect("~/Employee/RequestHistory.aspx"); break;
                case "Employee": Response.Redirect("~/Employee/RequestHistory.aspx"); break;
                case "Store Manager": Response.Redirect("~/Manager/AdjRequestHistory.aspx"); break;
                case "Store Supervisor": Response.Redirect("~/Manager/AdjRequestHistory.aspx"); break;
                case "Store Clerk": break;
                default:  break;
            }

        }

        protected void btnMarkRead_Click(object sender, EventArgs e)
        {

            NotificationBL.MarkAllAsRead(notifList);
            FillNotifications();
            
        }
    }
}