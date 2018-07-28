﻿using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Group8_AD_webapp.Models;
using Newtonsoft.Json;
using Group8AD_WebAPI.BusinessLogic;

namespace Group8_AD_webapp.Controllers
{
    public static class RequestCtrl
    {
        // Can remove after GetRequestByReqId(int reqId, string access_token) fully superseded
        private static readonly string API_Url = System.Configuration.ConfigurationManager.AppSettings["ApiBaseUrl"];

        public static List<RequestVM> GetReq(int empId, string status)
        {
            return RequestBL.GetReq(empId, status);

            //string querystring = "?empId=" + empId + "&status=" + status;
            //string jsonResponse = Service.UtilityService.SendPostRequest("/Request/get", querystring, "", true);

            //if (jsonResponse != "false")
            //{
            //    var response = JsonConvert.DeserializeObject<List<RequestVM>>(jsonResponse);
            //    return (List<RequestVM>)response;
            //}
            //else return null;
        }

        //superseded by above
        public static List<RequestVM> GetReq(int empId, string status, string access_token)
        {
            RestClient restClient = new RestClient(API_Url);

            var request = new RestRequest("/Request/get/?empId=" + empId + "&status=" + status, Method.POST);
            request.AddHeader("authorization", "Bearer " + access_token);
            request.RequestFormat = DataFormat.Json;


            var response = restClient.Execute<List<RequestVM>>(request);
            if (response.Content == null || response.StatusCode != System.Net.HttpStatusCode.OK)
            {
                return null;
            }
            else if (response.Content != null)
            {
                return response.Data.ToList<RequestVM>();
            }
            else
            {
                return null;
            }

        }

        public static List<RequestVM> GetRequestByDateRange(int empId, string status, DateTime fromDate, DateTime toDate)
        {
            return RequestBL.GetReq(empId, status, fromDate, toDate);

            //string from = fromDate.ToString("yyyy-MM-ddTHH:mm:ss");
            //string to = toDate.ToString("yyyy-MM-ddTHH:mm:ss");

            //string querystring = "?empId=" + empId + "&status=" + status + "&fromDate=" + from + "&toDate=" + to;
            //string jsonResponse = Service.UtilityService.SendPostRequest("/Request/get", querystring, "", true);

            //if (jsonResponse != "false")
            //{
            //    var response = JsonConvert.DeserializeObject<List<RequestVM>>(jsonResponse);
            //    return (List<RequestVM>)response;
            //}
            //else return null;
        }

        // Superseded by Below Method
        public static RequestVM GetRequestByReqId(int reqId, string access_token)
        {
            RestClient restClient = new RestClient(API_Url);

            var request = new RestRequest("/Request/get?reqId=" + reqId, Method.POST);
            request.AddHeader("authorization", "Bearer " + access_token);
            request.RequestFormat = DataFormat.Json;

            var response = restClient.Execute<RequestVM>(request);
            if (response.Content == null || response.StatusCode != System.Net.HttpStatusCode.OK)
            {
                return null;
            }
            else if (response.Content != null)
            {
                return response.Data;
            }
            else
            {
                return null;
            }
        }

        public static RequestVM GetRequestByReqId(int reqId)
        {
            return RequestBL.GetReq(reqId);

            //string querystring = "?reqId=" + reqId;
            //string jsonResponse = Service.UtilityService.SendPostRequest("/Request/get", querystring, "", true);

            //if (jsonResponse != "false")
            //{
            //    var response = JsonConvert.DeserializeObject<RequestVM>(jsonResponse);
            //    return (RequestVM)response;
            //}
            //else return null;
        }

        public static bool SubmitRequest(int reqId, List<RequestDetailVM> reqDetList)
        {
            RequestVM req = RequestBL.SubmitReq(reqId, reqDetList);
            if (req != null)
            {
                return true;
            }
            return false;

            //var jsonList = JsonConvert.SerializeObject(reqDetList);
            //string querystring = "?reqId=" + reqId;
            //string jsonResponse = Service.UtilityService.SendPostRequest("/Request/submit", querystring, jsonList, false);
            //return Convert.ToBoolean(jsonResponse);
        }

        // TO REPLACE DUMMY
        public static bool CancelRequest(int reqId)
        {
            RequestBL.RemoveReq(reqId);
            return true;        // DUMMY - TO REPLACE

            //string querystring = "?reqId=" + reqId;
            //string jsonResponse = Service.UtilityService.SendPostRequest("/Request/remove", querystring, "", false);
            //return Convert.ToBoolean(jsonResponse);
        }

      

    }
}