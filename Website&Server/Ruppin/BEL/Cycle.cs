using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Cycle
    {
        public int CycleID { get; set; }
        public string CycleName { get; set; }
        public int Year { get; set; }
        public bool IsActive { get; set; } = true;

        public Cycle(int CycleID)
        {
            this.CycleID = CycleID;
        }

        public Cycle(int CycleID, string CycleName, int Year) : this(CycleID, CycleName)
        {
            this.Year = Year;
        }

        public Cycle(int CycleID, string CycleName) : this(CycleID)
        {
            this.CycleName = CycleName;
        }
    }
}
