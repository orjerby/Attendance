using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Lecturer
    {
        public int LecturerID { get; set; }
        public User User { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Picture { get; set; }
        public bool IsActive { get; set; } = true;
        public bool QRMode { get; set; }

        public Lecturer(int LecturerID)
        {
            this.LecturerID = LecturerID;
        }

        public Lecturer(int LecturerID, bool QRMode) : this(LecturerID)
        {
            this.QRMode = QRMode;
        }

        public Lecturer(int LecturerID, string Email) : this(LecturerID)
        {
            this.Email = Email;
        }

        public Lecturer(int LecturerID, string Email, User User) : this(LecturerID)
        {
            this.Email = Email;
            this.User = User;
        }

        public Lecturer(int LecturerID, string FirstName, string LastName, string Email, string Picture) : this(LecturerID, FirstName, LastName, Picture)
        {
            this.Email = Email;
        }

        public Lecturer(int LecturerID, User User, string FirstName, string LastName, string Email, string Picture, bool QRMode) : this(LecturerID, FirstName, LastName)
        {
            this.User = User;
            this.FirstName = FirstName;
            this.LastName = LastName;
            this.Email = Email;
            this.Picture = Picture;
            this.QRMode = QRMode;
        }

        public Lecturer(int LecturerID, string FirstName, string LastName) : this(LecturerID)
        {
            this.FirstName = FirstName;
            this.LastName = LastName;
        }

        public Lecturer(int LecturerID, string FirstName, string LastName, string Picture) : this(LecturerID, FirstName, LastName)
        {
            this.Picture = Picture;
        }

        public Lecturer(int LecturerID, string FirstName, string LastName, string Picture, bool QRMode) : this(LecturerID, FirstName, LastName, Picture)
        {
            this.QRMode = QRMode;
        }

        public Lecturer(int LecturerID, User User, string FirstName) : this(LecturerID)
        {
            this.User = User;
            this.FirstName = FirstName;
        }
    }
}
