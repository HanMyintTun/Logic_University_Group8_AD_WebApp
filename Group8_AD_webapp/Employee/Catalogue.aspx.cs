﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Group8_AD_webapp
{
    public partial class Catalogue : System.Web.UI.Page
    {
        static List<Item> items = new List<Item>();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                List<String> productList = new List<String> { "Pen", "Exercise", "Folder" };
                ddlCategory.DataSource = productList;
                ddlCategory.DataBind();

                DoSearch();

                showlist.Visible = true;
                showgrid.Visible = false;
            }
        }
        protected void AddItems()
        {
            items.Add(new Item("A001", "Pen", "Pencil 2B", 50, 1.02, "pack of 12"));
            items.Add(new Item("B053", "File", "File, Yellow", 100, 1.23, "each"));
            items.Add(new Item("C007", "Stapler", "Stapler 1in", 150, 1.50, "box"));
            items.Add(new Item("A002", "Pen", "Pencil 2B, With Eraser End", 50, 1.02, "pack of 12"));
            items.Add(new Item("B054", "File", "File, Blue", 100, 1.23, "each"));
            items.Add(new Item("C008", "Stapler", "Stapler 2in", 150, 1.50, "box"));
            items.Add(new Item("A001", "Pen", "Pencil 2B", 50, 1.02, "pack of 12"));
            items.Add(new Item("B053", "File", "File, Yellow", 100, 1.23, "each"));
            items.Add(new Item("C007", "Stapler", "Stapler 1in", 150, 1.50, "box"));
            items.Add(new Item("A002", "Pen", "Pencil 2B, With Eraser End", 50, 1.02, "pack of 12"));
            items.Add(new Item("B054", "File", "File, Blue", 100, 1.23, "each"));
            items.Add(new Item("C008", "Stapler", "Stapler 2in", 150, 1.50, "box"));
            items.Add(new Item("A001", "Pen", "Pencil 2B", 50, 1.02, "pack of 12"));
            items.Add(new Item("B053", "File", "File, Yellow", 100, 1.23, "each"));
            items.Add(new Item("C007", "Stapler", "Stapler 1in", 150, 1.50, "box"));
            items.Add(new Item("A002", "Pen", "Pencil 2B, With Eraser End", 50, 1.02, "pack of 12"));
            items.Add(new Item("B054", "File", "File, Blue", 100, 1.23, "each"));
            items.Add(new Item("C008", "Stapler", "Stapler 2in", 150, 1.50, "box"));
            items.Add(new Item("A001", "Pen", "Pencil 2B", 50, 1.02, "pack of 12"));
            items.Add(new Item("B053", "File", "File, Yellow", 100, 1.23, "each"));
            items.Add(new Item("C007", "Stapler", "Stapler 1in", 150, 1.50, "box"));
            items.Add(new Item("A002", "Pen", "Pencil 2B, With Eraser End", 50, 1.02, "pack of 12"));
            items.Add(new Item("B054", "File", "File, Blue", 100, 1.23, "each"));
            items.Add(new Item("C008", "Stapler", "Stapler 2in", 150, 1.50, "box"));
        }

        protected void DoSearch()
        {
            items = new List<Item>();
            if (Request.QueryString["s"] == "1")
            {
                lblCatTitle.Text = "Frequently Ordered Items";
                // Insert method for finding frequent items
                items.Add(new Item("A001", "Pen", "Kittens", 50, 1.02, "pack of 12"));
                items.Add(new Item("B053", "Exercise", "Puppies", 100, 1.23, "each"));
                BindGrids();
            }
            else if (Request.QueryString["s"] == "2")
            {
                lblCatTitle.Text = "Search Results";
                // use Session["cataloguequery"] and Session["querycategory"] to search
                items = new List<Item>();
                //items.Add(new Item("A001", "Pen", "Kittens", 50, 1.02, "pack of 12"));
                //items.Add(new Item("B053", "Exercise", "Puppies", 100, 1.23, "each"));
                BindGrids();
            }
            else 
            {
                lblCatTitle.Text = "Catalogue";
                // Display all
                AddItems();
                BindGrids();
            }
        }

        protected void BindGrids()
        {
            lstCatalogue.DataSource = items;
            lstCatalogue.DataBind();

            grdCatalogue.DataSource = items;
            grdCatalogue.DataBind();
        }

        protected void ListPager_PreRender(object sender, EventArgs e)
        {
            //lstCatalogue.DataSource = items;
            //lstCatalogue.DataBind();

            //grdCatalogue.DataSource = items;
            //grdCatalogue.DataBind();
        }

        protected void list_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //(lstCatalogue.FindControl("dpgLstCatalogue") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            //lstCatalogue.DataSource = items;
            //lstCatalogue.DataBind();

            //(grdCatalogue.FindControl("dpgCatalogue") as DataPager).SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

            //grdCatalogue.DataSource = items;
            //grdCatalogue.DataBind();
        }

        protected void lstCatalogue_PagePropertiesChanged(object sender, EventArgs e)
        {
            lstCatalogue.DataSource = items;
            lstCatalogue.DataBind();

            grdCatalogue.DataSource = items;
            grdCatalogue.DataBind();
        }

        protected void btnBookmark_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            var item = (ListViewItem)btn.NamingContainer;
            Label lblItemCode = (Label)item.FindControl("lblItemCode");
            Label lblDescription = (Label)item.FindControl("lblDescription");
            string description = lblDescription.Text;

            Main master = (Main)this.Master;
            master.ShowToastr(this, String.Format("{0} Added to Bookmarks", description), "Item Added Successfully", "success");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            var item = (ListViewItem)btn.NamingContainer;
            TextBox txtQty = (TextBox)item.FindControl("spnQty");
            Label lblItemCode = (Label)item.FindControl("lblItemCode");
            Label lblDescription = (Label)item.FindControl("lblDescription");
            int quantity = Convert.ToInt32(txtQty.Text);
            string description = lblDescription.Text;

            Main master = (Main)this.Master;
            master.ShowToastr(this, String.Format("{0} Qty:{1} Added to Order",description,quantity), "Item Added Successfully", "success");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Main master = (Main)this.Master;
            master.ShowToastr(this, "", "Test Message", "success");
        }
        protected void btnGrid_Click(object sender, EventArgs e)
        {
            showlist.Visible = true;
            showgrid.Visible = false;
            btnGrid.CssClass = "listbutton active";
            btnList.CssClass = "listbutton";
        }
        protected void btnList_Click(object sender, EventArgs e)
        {
            showlist.Visible = false;
            showgrid.Visible = true;
            btnList.CssClass = "listbutton active";
            btnGrid.CssClass = "listbutton";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetSearchQuery();
            DoSearch();
        }

        protected void GetSearchQuery()
        {
            Session["cataloguequery"] = txtSearch.Text;
            Session["querycategory"] = ddlCategory.Text;
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetSearchQuery();
            DoSearch();
        }

        protected void txtSearch_Changed(object sender, EventArgs e)
        {
            Main master = (Main)this.Master;
            master.ShowToastr(this, "", "Cat: " + ddlCategory.Text + " Query: " + txtSearch.Text, "success");

            GetSearchQuery();
            DoSearch();
        }
    }
}