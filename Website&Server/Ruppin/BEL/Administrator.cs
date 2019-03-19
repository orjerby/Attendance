using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Administrator
    {
        public int AdministratorID { get; set; }
        public User User { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }

        public Administrator(int AdministratorID, User User) : this(AdministratorID)
        {
            this.User = User;
        }

        public Administrator(int AdministratorID)
        {
            this.AdministratorID = AdministratorID;
        }

        public Administrator(int AdministratorID, string Email, User User) : this(AdministratorID, User)
        {
            this.Email = Email;
        }

        public Administrator(int AdministratorID, User User, string FirstName, string LastName, string Email)
        {
            this.AdministratorID = AdministratorID;
            this.User = User;
            this.FirstName = FirstName;
            this.LastName = LastName;
            this.Email = Email;
        }
    }
}
