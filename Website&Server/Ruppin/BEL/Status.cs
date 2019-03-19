using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Status
    {
        public int StatusID { get; set; }
        public string StatusName { get; set; }

        public Status(int StatusID)
        {
            this.StatusID = StatusID;
        }

        public Status(int StatusID, string StatusName) : this(StatusID)
        {
            this.StatusName = StatusName;
        }
    }
}
