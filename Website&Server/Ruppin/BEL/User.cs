using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class User
    {
        public int UserID { get; set; }
        public string Password { get; set; }
        public Role Role { get; set; }
        public string Token { get; set; }

        public User(string Password)
        {
            this.Password = Password;
        }

        public User(int UserID, string Password, Role Role, string Token) : this(UserID, Password, Role)
        {
            this.Token = Token;
        }

        public User(int UserID, string Password, Role Role) : this(Password)
        {
            this.UserID = UserID;
            this.Role = Role;
        }

        public User(int UserID, string Token)
        {
            this.UserID = UserID;
            this.Token = Token;
        }
    }
}
