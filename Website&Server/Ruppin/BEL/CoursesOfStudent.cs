using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class CoursesOfStudent
    {
        public Student Student { get; set; }
        public Course Course { get; set; }
        public Cycle Cycle { get; set; }
        public bool IsActive { get; set; } = true;

        public CoursesOfStudent(Student Student, Course Course, Cycle Cycle, bool IsActive)
        {
            this.Student = Student;
            this.Course = Course;
            this.Cycle = Cycle;
            this.IsActive = IsActive;
        }
    }
}
