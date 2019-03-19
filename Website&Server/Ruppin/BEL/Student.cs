using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Student
    {
        public int StudentID { get; set; }
        public User User { get; set; }
        public Department Department { get; set; }
        public Cycle Cycle { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Picture { get; set; }
        public bool IsActive { get; set; } = true;

        public Student()
        {

        }

        public Student(int StudentID)
        {
            this.StudentID = StudentID;
        }

        public Student(int StudentID, User User) : this(StudentID)
        {
            this.User = User;
        }

        public Student(int StudentID, string Email) : this(StudentID)
        {
            this.Email = Email;
        }

        public Student(int StudentID, string Email, User User) : this(StudentID)
        {
            this.StudentID = StudentID;
            this.Email = Email;
            this.User = User;
        }

        public Student(int StudentID, string FirstName, string LastName, string Email, string Picture) : this(StudentID, FirstName, LastName, Picture)
        {
            this.Email = Email;
        }

        public Student(int StudentID, Department Department, Cycle Cycle, string FirstName, string LastName, string Email, bool IsActive) : this(StudentID)
        {
            this.Department = Department;
            this.Cycle = Cycle;
            this.FirstName = FirstName;
            this.LastName = LastName;
            this.Email = Email;
            this.IsActive = IsActive;
        }

        public Student(int StudentID, User User, Department Department, Cycle Cycle, string FirstName, string LastName, string Email, string Picture) : this(StudentID)
        {
            this.User = User;
            this.Department = Department;
            this.Cycle = Cycle;
            this.FirstName = FirstName;
            this.LastName = LastName;
            this.Email = Email;
            this.Picture = Picture;
        }

        public Student(int StudentID, string FirstName, string LastName, string Picture) : this(StudentID, FirstName, LastName)
        {
            this.Picture = Picture;
        }

        public Student(int StudentID, string FirstName, string LastName) : this(StudentID)
        {
            this.FirstName = FirstName;
            this.LastName = LastName;
        }

        public Student(int StudentID, User User, string FirstName) : this(StudentID)
        {
            this.User = User;
            this.FirstName = FirstName;
        }
    }
}
