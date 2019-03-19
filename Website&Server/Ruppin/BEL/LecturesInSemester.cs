using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class LecturesInSemester
    {
        public Lecture Lecture { get; set; }
        public Weekday Weekday { get; set; }
        public DateTime OpenDate { get; set; }
        public DateTime EndDate { get; set; }

        public LecturesInSemester(Lecture Lecture, Weekday Weekday, DateTime OpenDate, DateTime EndDate)
        {
            this.Lecture = Lecture;
            this.Weekday = Weekday;
            this.OpenDate = DateTime.SpecifyKind(OpenDate, DateTimeKind.Utc);
            this.EndDate = DateTime.SpecifyKind(EndDate, DateTimeKind.Utc);
        }
    }
}
