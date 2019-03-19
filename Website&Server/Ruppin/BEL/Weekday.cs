using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Weekday
    {
        public int WeekdayID { get; set; }
        public string WeekdayName { get; set; }

        public Weekday(int WeekdayID)
        {
            this.WeekdayID = WeekdayID;
        }
    }
}
