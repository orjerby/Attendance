using System;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Web.Script.Serialization;

namespace BEL
{
    static public class ExpoPushHelper
    {
        public static void SendPushNotification(string Token, string title, string body)
        {
            dynamic letter = new
            {
                to = Token,
                title,
                body,
                sound = "default"
            };
            
            using (WebClient client = new WebClient())
            {
                client.Encoding = Encoding.UTF8;
                client.Headers.Add("accept", "application/json");
                client.Headers.Add("accept-encoding", "gzip, deflate");
                client.Headers.Add("Content-Type", "application/json;charset=UTF-8");
                client.UploadString("https://exp.host/--/api/v2/push/send", new JavaScriptSerializer().Serialize(letter));
            }
        }
    }
}
