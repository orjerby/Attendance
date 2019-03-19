using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Form
    {
        public int FormID { get; set; }
        public Student Student { get; set; }
        public DateTime OpenDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Picture { get; set; }
        public FormStatus FormStatus { get; set; }

        public Form(int FormID)
        {
            this.FormID = FormID;
        }

        public Form(Student Student, DateTime OpenDate, DateTime EndDate)
        {
            this.Student = Student;
            this.OpenDate = DateTime.SpecifyKind(OpenDate, DateTimeKind.Utc);
            this.EndDate = DateTime.SpecifyKind(EndDate, DateTimeKind.Utc);
        }

        public Form(int FormID, Student Student, DateTime OpenDate, DateTime EndDate, string Picture, FormStatus FormStatus) : this(Student, OpenDate, EndDate)
        {
            this.FormID = FormID;
            this.FormStatus = FormStatus;
            this.Picture = Picture;
        }
    }
}
