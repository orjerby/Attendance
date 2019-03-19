using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class FormStatus
    {
        public int FormStatusID { get; set; }
        public string FormStatusName { get; set; }

        public FormStatus(int FormStatusID, string FormStatusName)
        {
            this.FormStatusID = FormStatusID;
            this.FormStatusName = FormStatusName;
        }
    }
}
