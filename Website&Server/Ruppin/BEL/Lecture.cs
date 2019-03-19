using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Lecture
    {
        public int LectureID { get; set; }
        public Course Course { get; set; }
        public Department Department { get; set; }
        public Cycle Cycle { get; set; }
        public Lecturer Lecturer { get; set; }
        public Class Class { get; set; }
        public DateTime LectureDate { get; set; }
        public string BeginHour { get; set; }
        public string EndHour { get; set; }
        public bool IsCanceled { get; set; }
        public int TimerLong { get; set; }
        public int TimerRemaining { get; set; }
        public bool TimerFired { get; set; }
        public bool IsOld { get; set; }
        public int MinutesToEnd { get; set; }
        public int MinutesToBegin { get; set; }

        public Lecture(int LectureID)
        {
            this.LectureID = LectureID;
        }

        public Lecture(bool IsCanceled)
        {
            this.IsCanceled = IsCanceled;
        }

        public Lecture(int LectureID, bool IsCanceled) : this(LectureID)
        {
            this.IsCanceled = IsCanceled;
        }

        public Lecture(DateTime LectureDate)
        {
            this.LectureDate = DateTime.SpecifyKind(LectureDate, DateTimeKind.Utc);
        }

        public Lecture(Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, string BeginHour, string EndHour) : this(Course, Department, Cycle, Lecturer, BeginHour, EndHour)
        {
            this.Class = Class;
        }

        public Lecture(Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, DateTime LectureDate, string BeginHour, string EndHour) : this(Course, Department, Cycle, Lecturer, BeginHour, EndHour)
        {
            this.Class = Class;
            this.LectureDate = DateTime.SpecifyKind(LectureDate, DateTimeKind.Utc);
        }

        public Lecture(Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, string BeginHour, string EndHour) : this(Department, Cycle, BeginHour, EndHour)
        {
            this.Course = Course;
            this.Lecturer = Lecturer;
        }

        public Lecture(Department Department, Cycle Cycle, string BeginHour, string EndHour)
        {
            this.Department = Department;
            this.Cycle = Cycle;
            this.BeginHour = BeginHour;
            this.EndHour = EndHour;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, int TimerLong, int TimerRemaining) : this(LectureID, Course, Department, Cycle, Class, LectureDate, BeginHour, EndHour, IsCanceled, TimerLong, TimerRemaining)
        {
            this.Lecturer = Lecturer;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, int TimerLong, int TimerRemaining, int MinutesToEnd) : this(LectureID, Course, Department, Cycle, Lecturer, Class, LectureDate, BeginHour, EndHour, IsCanceled, TimerLong, TimerRemaining)
        {
            this.MinutesToEnd = MinutesToEnd;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled) : this(LectureID, Course, Department, Cycle, Class, LectureDate, BeginHour, EndHour, IsCanceled)
        {
            this.Lecturer = Lecturer;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, int MinutesToBegin) : this(LectureID, Course, Department, Cycle, Lecturer, Class, LectureDate, BeginHour, EndHour, IsCanceled)
        {
            this.MinutesToBegin = MinutesToBegin;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, bool IsOld) : this(LectureID, Course, Department, Cycle, Lecturer, Class, LectureDate, BeginHour, EndHour, IsCanceled)
        {
            this.IsOld = IsOld;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, int TimerLong, int TimerRemaining) : this(Department, Cycle, BeginHour, EndHour)
        {
            this.LectureID = LectureID;
            this.Course = Course;
            this.Class = Class;
            this.LectureDate = DateTime.SpecifyKind(LectureDate, DateTimeKind.Utc);
            this.IsCanceled = IsCanceled;
            this.TimerLong = TimerLong;
            this.TimerRemaining = TimerRemaining;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, int TimerLong, int TimerRemaining, int MinutesToEnd) : this(LectureID, Course, Department, Cycle, Class, LectureDate, BeginHour, EndHour, IsCanceled, TimerLong, TimerRemaining)
        {
            this.MinutesToEnd = MinutesToEnd;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, bool IsOld) : this(LectureID, Course, Department, Cycle, Class, LectureDate, BeginHour, EndHour, IsCanceled)
        {
            this.IsOld = IsOld;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled) : this(Department, Cycle, BeginHour, EndHour)
        {
            this.LectureID = LectureID;
            this.Course = Course;
            this.Class = Class;
            this.LectureDate = DateTime.SpecifyKind(LectureDate, DateTimeKind.Utc);
            this.IsCanceled = IsCanceled;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Class Class, DateTime LectureDate, string BeginHour, string EndHour, bool IsCanceled, int MinutesToBegin) : this(LectureID, Course, Department, Cycle, Class, LectureDate, BeginHour, EndHour, IsCanceled)
        {
            this.MinutesToBegin = MinutesToBegin;
        }

        public Lecture(int LectureID, int TimerLong) : this(LectureID)
        {
            this.TimerLong = TimerLong;
        }

        public Lecture(int LectureID, Course Course, Class Class) : this(LectureID)
        {
            this.Course = Course;
            this.Class = Class;
        }

        public Lecture(int LectureID, Course Course, Department Department, Cycle Cycle, Lecturer Lecturer, Class Class) : this(LectureID)
        {
            this.Course = Course;
            this.Department = Department;
            this.Cycle = Cycle;
            this.Lecturer = Lecturer;
            this.Class = Class;
        }

    }
}
