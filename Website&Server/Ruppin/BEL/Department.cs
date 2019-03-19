using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Department
    {
        public int DepartmentID { get; set; }
        public string DepartmentName { get; set; }
        public bool IsActive { get; set; } = true;

        public Department(int DepartmentID)
        {
            this.DepartmentID = DepartmentID;
        }

        public Department(int DepartmentID, string DepartmentName) : this(DepartmentID)
        {
            this.DepartmentName = DepartmentName;
        }
    }
}
