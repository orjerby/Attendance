using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class StudentsInLecture
    {
        public Lecture Lecture { get; set; }
        public Student Student { get; set; }
        public Status Status { get; set; }

        public StudentsInLecture(Lecture Lecture, Student Student)
        {
            this.Lecture = Lecture;
            this.Student = Student;
        }

        public StudentsInLecture(Lecture Lecture, Student Student, Status Status) : this(Lecture, Student)
        {
            this.Status = Status;
        }

        public StudentsInLecture(Student Student, Status Status) : this(Status)
        {
            this.Student = Student;
        }

        public StudentsInLecture(Lecture Lecture, Status Status) : this(Status)
        {
            this.Lecture = Lecture;
        }

        public StudentsInLecture(Status Status)
        {
            this.Status = Status;
        }

        public StudentsInLecture(Student Student)
        {
            this.Student = Student;
        }
    }
}
