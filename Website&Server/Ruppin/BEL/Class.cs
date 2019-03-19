using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BEL
{
    [Serializable]
    public class Class
    {
        public int ClassID { get; set; }
        public string ClassName { get; set; }
        public double Longitude { get; set; }
        public double Latitude { get; set; }
        public bool IsActive { get; set; } = true;
        public DateTime LastLocationUpdate { get; set; }

        public Class(int ClassID)
        {
            this.ClassID = ClassID;
        }

        public Class(int ClassID, double Longitude, double Latitude) : this(ClassID)
        {
            this.Longitude = Longitude;
            this.Latitude = Latitude;
        }

        public Class(int ClassID, string ClassName, double Longitude, double Latitude) : this(ClassID, Longitude, Latitude)
        {
            this.ClassName = ClassName;
        }

        public Class(int ClassID, string ClassName, double Longitude, double Latitude, DateTime LastLocationUpdate) : this(ClassID, ClassName, Longitude, Latitude)
        {
            this.LastLocationUpdate = DateTime.SpecifyKind(LastLocationUpdate, DateTimeKind.Utc);
        }

        public Class(int ClassID, string ClassName) : this(ClassID)
        {
            this.ClassName = ClassName;
        }
    }
}