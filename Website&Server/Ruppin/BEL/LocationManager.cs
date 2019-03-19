using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class LocationManager
    {
        public int LocationManagerID { get; set; }
        public User User { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public bool IsActive { get; set; } = true;

        public LocationManager(int LocationManagerID)
        {
            this.LocationManagerID = LocationManagerID;
        }

        public LocationManager(int LocationManagerID, User User, string FirstName, string LastName, string Email) : this(LocationManagerID, Email, User)
        {
            this.FirstName = FirstName;
            this.LastName = LastName;
        }

        public LocationManager(int LocationManagerID, string Email):this(LocationManagerID)
        {
            this.Email = Email;
        }

        public LocationManager(int LocationManagerID, string Email, User User) : this(LocationManagerID, Email)
        {
            this.User = User;
        }

    }
}
