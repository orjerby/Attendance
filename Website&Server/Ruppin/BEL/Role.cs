using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Role
    {
        public int RoleID { get; set; }
        public string RoleName { get; set; }

        public Role(int RoleID, string RoleName)
        {
            this.RoleID = RoleID;
            this.RoleName = RoleName;
        }
    }
}
