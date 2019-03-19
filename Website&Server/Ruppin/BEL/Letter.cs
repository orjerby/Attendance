using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    public class Letter
    {
        public string Token { get; set; }
        public string Title { get; set; }
        public string Body { get; set; }

        public Letter(string Token, string Title, string Body)
        {
            this.Token = Token;
            this.Title = Title;
            this.Body = Body;
        }

        public Letter(string Token)
        {
            this.Token = Token;
        }
    }
}
