using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Course
    {
        public int CourseID { get; set; }
        public string CourseName { get; set; }
        public bool IsActive { get; set; } = true;

        public Course(int CourseID)
        {
            this.CourseID = CourseID;
        }

        public Course(int CourseID, string CourseName) : this(CourseID)
        {
            this.CourseName = CourseName;
        }
    }
}
