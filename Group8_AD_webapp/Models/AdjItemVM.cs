﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Group8_AD_webapp.Models
{
    public class AdjItemVM
    {
        public string ItemCode { get; set; }
        public string Desc { get; set; }
        public double Price1 { get; set; }
        public double Value { get; set; }
        public int QtyChange { get; set; }
        public string VoucherNo { get; set; }
    }
}