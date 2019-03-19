using BAL;
using BEL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Timers;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

/// <summary>
/// Summary description for RuppinWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class RuppinWebService : System.Web.Services.WebService
{

    public RuppinWebService()
    {

        //Uncomment the following line if using designed components
        //InitializeComponent(); 
    }
    
    [WebMethod]
    public string ValidateLecturer(int lecturerID, string password, string token)
    {
        Lecturer lecturer = Operations.ValidateLecturer(lecturerID, password, token);
        if (lecturer == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    User = (string)null
                }
                );
        }
        return new JavaScriptSerializer().Serialize(
            new
            {
                User = new
                {
                    lecturer.User.UserID,
                    lecturer.User.Password,
                    Role = new
                    {
                        lecturer.User.Role.RoleID,
                        lecturer.User.Role.RoleName
                    },
                    lecturer.User.Token
                },
                Lecturer = new
                {
                    lecturer.LecturerID,
                    lecturer.FirstName,
                    lecturer.LastName,
                    lecturer.Email,
                    lecturer.Picture,
                    lecturer.QRMode
                }
            }
            );
    }

    [WebMethod]
    public string ValidateStudent(int studentID, string password, string token)
    {
        Student student = Operations.ValidateStudent(studentID, password, token);
        if (student == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    User = (string)null
                }
                );
        }
        return new JavaScriptSerializer().Serialize(
                new
                {
                    User = new
                    {
                        student.User.UserID,
                        student.User.Password,
                        Role = new
                        {
                            student.User.Role.RoleID,
                            student.User.Role.RoleName
                        },
                        student.User.Token
                    },
                    Student = new
                    {
                        student.StudentID,
                        student.FirstName,
                        student.LastName,
                        student.Email,
                        student.Picture,
                        Department = new { student.Department.DepartmentID, student.Department.DepartmentName },
                        Cycle = new { student.Cycle.CycleID, student.Cycle.CycleName, student.Cycle.Year }
                    }
                }
                );
    }

    [WebMethod]
    public string ValidateLocationManager(int locationManagerID, string password, string token)
    {
        LocationManager locationManager = Operations.ValidateLocationManager(locationManagerID, password, token);
        if (locationManager == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    User = (string)null
                }
                );
        }
        return new JavaScriptSerializer().Serialize(
                new
                {
                    User = new
                    {
                        locationManager.User.UserID,
                        locationManager.User.Password,
                        Role = new
                        {
                            locationManager.User.Role.RoleID,
                            locationManager.User.Role.RoleName
                        },
                        locationManager.User.Token
                    },
                    LocationManager = new
                    {
                        locationManager.LocationManagerID,
                        locationManager.FirstName,
                        locationManager.LastName,
                        locationManager.Email
                    }
                }
                );
    }

    [WebMethod]
    public string GetNextLectureByLecturer(int lecturerID)
    {
        Lecturer lecturer = new Lecturer(lecturerID);
        object obj = new object();
        obj = Operations.GetNextLectureByLecturer(lecturer);
        if (obj == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Lecture = (string)null
                }
                );
        }
        Type type = obj.GetType();
        bool isLive = (bool)type.GetProperty("isLive").GetValue(obj, null);
        Lecture lecture = (Lecture)type.GetProperty("lecture").GetValue(obj, null);
        if (isLive)
        {
            List<StudentsInLecture> studentsInLecture = (List<StudentsInLecture>)type.GetProperty("studentsInLecture").GetValue(obj, null);
            var studentsInLectureRecords = from studentInLecture in studentsInLecture
                                           select new
                                           {
                                               Student = new
                                               {
                                                   studentInLecture.Student.StudentID,
                                                   studentInLecture.Student.FirstName,
                                                   studentInLecture.Student.LastName,
                                                   studentInLecture.Student.Picture
                                               },
                                               Status = new { studentInLecture.Status.StatusID, studentInLecture.Status.StatusName }
                                           };
            object statusCount = type.GetProperty("StatusCount").GetValue(obj, null);
            return new JavaScriptSerializer().Serialize(
                 new
                 {
                     Lecture = new
                     {
                         lecture.LectureID,
                         Course = new { lecture.Course.CourseID, lecture.Course.CourseName },
                         Department = new { lecture.Department.DepartmentID, lecture.Department.DepartmentName },
                         Cycle = new { lecture.Cycle.CycleID, lecture.Cycle.CycleName, lecture.Cycle.Year },
                         Class = new { lecture.Class.ClassID, lecture.Class.ClassName, lecture.Class.Longitude, lecture.Class.Latitude },
                         lecture.LectureDate,
                         lecture.BeginHour,
                         lecture.EndHour,
                         lecture.IsCanceled,
                         lecture.TimerLong,
                         lecture.TimerRemaining,
                         IsLive = isLive,
                         lecture.MinutesToEnd
                     },
                     StudentsInLecture = studentsInLectureRecords,
                     StatusCount = statusCount
                 }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                 new
                 {
                     Lecture = new
                     {
                         lecture.LectureID,
                         Course = new { lecture.Course.CourseID, lecture.Course.CourseName },
                         Department = new { lecture.Department.DepartmentID, lecture.Department.DepartmentName },
                         Cycle = new { lecture.Cycle.CycleID, lecture.Cycle.CycleName, lecture.Cycle.Year },
                         Class = new { lecture.Class.ClassID, lecture.Class.ClassName, lecture.Class.Longitude, lecture.Class.Latitude },
                         lecture.LectureDate,
                         lecture.BeginHour,
                         lecture.EndHour,
                         lecture.IsCanceled,
                         IsLive = isLive,
                         lecture.MinutesToBegin
                     }
                 }
                );
        }
    }

    [WebMethod]
    public string GetNextLectureByStudent(int studentID)
    {
        Student student = new Student(studentID);
        object obj = new object();
        obj = Operations.GetNextLectureByStudent(student);
        if (obj == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Lecture = (string)null
                }
                );
        }
        Type type = obj.GetType();
        bool isLive = (bool)type.GetProperty("isLive").GetValue(obj, null);
        object courseDataObject = type.GetProperty("CourseData").GetValue(obj, null);
        if (isLive)
        {
            StudentsInLecture studentInLecture = (StudentsInLecture)type.GetProperty("studentInLecture").GetValue(obj, null);
            return new JavaScriptSerializer().Serialize(
                 new
                 {
                     Lecture = new
                     {
                         studentInLecture.Lecture.LectureID,
                         Course = new { studentInLecture.Lecture.Course.CourseID, studentInLecture.Lecture.Course.CourseName },
                         Department = new { studentInLecture.Lecture.Department.DepartmentID, studentInLecture.Lecture.Department.DepartmentName },
                         Cycle = new { studentInLecture.Lecture.Cycle.CycleID, studentInLecture.Lecture.Cycle.CycleName, studentInLecture.Lecture.Cycle.Year },
                         Class = new { studentInLecture.Lecture.Class.ClassID, studentInLecture.Lecture.Class.ClassName, studentInLecture.Lecture.Class.Latitude, studentInLecture.Lecture.Class.Longitude },
                         Lecturer = new { studentInLecture.Lecture.Lecturer.LecturerID, studentInLecture.Lecture.Lecturer.FirstName, studentInLecture.Lecture.Lecturer.LastName, studentInLecture.Lecture.Lecturer.Picture, studentInLecture.Lecture.Lecturer.QRMode },
                         studentInLecture.Lecture.LectureDate,
                         studentInLecture.Lecture.BeginHour,
                         studentInLecture.Lecture.EndHour,
                         studentInLecture.Lecture.IsCanceled,
                         studentInLecture.Lecture.TimerLong,
                         studentInLecture.Lecture.TimerRemaining,
                         IsLive = isLive,
                         studentInLecture.Lecture.MinutesToEnd
                     },
                     StudentsInLecture = new
                     {
                         Status = new { studentInLecture.Status.StatusID, studentInLecture.Status.StatusName }
                     },
                     CourseData = courseDataObject
                 }
                );
        }
        else
        {
            Lecture lecture = (Lecture)type.GetProperty("lecture").GetValue(obj, null);
            return new JavaScriptSerializer().Serialize(
                 new
                 {
                     Lecture = new
                     {
                         lecture.LectureID,
                         Course = new { lecture.Course.CourseID, lecture.Course.CourseName },
                         Department = new { lecture.Department.DepartmentID, lecture.Department.DepartmentName },
                         Cycle = new { lecture.Cycle.CycleID, lecture.Cycle.CycleName, lecture.Cycle.Year },
                         Class = new { lecture.Class.ClassID, lecture.Class.ClassName, lecture.Class.Longitude, lecture.Class.Latitude },
                         Lecturer = new { lecture.Lecturer.LecturerID, lecture.Lecturer.FirstName, lecture.Lecturer.LastName, lecture.Lecturer.Picture },
                         lecture.LectureDate,
                         lecture.BeginHour,
                         lecture.EndHour,
                         lecture.IsCanceled,
                         IsLive = isLive,
                         lecture.MinutesToBegin
                     },
                     CourseData = courseDataObject
                 }
                );
        }
    }

    [WebMethod]
    public string GetLecturesByLecturerAndDate(int lecturerID, DateTime lectureDate)
    {
        Lecturer lecturer = new Lecturer(lecturerID);
        Lecture lecture = new Lecture(lectureDate);
        List<Lecture> lectures = new List<Lecture>();
        lectures = Operations.GetLecturesByLecturerAndDate(lecturer, lecture);
        if (lectures == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Lecture = (string)null
                }
                );
        }
        else
        {
            var lecturesRecords = from lecture1 in lectures
                                  select new
                                  {
                                      lecture1.LectureID,
                                      Course = new { lecture1.Course.CourseID, lecture1.Course.CourseName },
                                      Department = new { lecture1.Department.DepartmentID, lecture1.Department.DepartmentName },
                                      Cycle = new { lecture1.Cycle.CycleID, lecture1.Cycle.CycleName, lecture1.Cycle.Year },
                                      Class = new { lecture1.Class.ClassID, lecture1.Class.ClassName },
                                      lecture1.LectureDate,
                                      lecture1.BeginHour,
                                      lecture1.EndHour,
                                      lecture1.IsCanceled,
                                      lecture1.IsOld
                                  };
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Lecture = lecturesRecords
                }
                );
        }
    }

    [WebMethod]
    public string GetLecturesByStudentAndDate(int studentID, DateTime lectureDate)
    {
        Student student = new Student(studentID);
        Lecture lecture = new Lecture(lectureDate);
        List<StudentsInLecture> studentInLectures = new List<StudentsInLecture>();
        studentInLectures = Operations.GetLecturesByStudentAndDate(student, lecture);
        if (studentInLectures == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Lecture = (string)null
                }
                );
        }
        else
        {
            var lecturesRecords = from studentInLecture in studentInLectures
                                  select new
                                  {
                                      Lecture = new
                                      {
                                          studentInLecture.Lecture.LectureID,
                                          Course = new { studentInLecture.Lecture.Course.CourseID, studentInLecture.Lecture.Course.CourseName },
                                          Department = new { studentInLecture.Lecture.Department.DepartmentID, studentInLecture.Lecture.Department.DepartmentName },
                                          Cycle = new { studentInLecture.Lecture.Cycle.CycleID, studentInLecture.Lecture.Cycle.CycleName, studentInLecture.Lecture.Cycle.Year },
                                          Class = new { studentInLecture.Lecture.Class.ClassID, studentInLecture.Lecture.Class.ClassName },
                                          Lecturer = new { studentInLecture.Lecture.Lecturer.LecturerID, studentInLecture.Lecture.Lecturer.FirstName, studentInLecture.Lecture.Lecturer.LastName },
                                          studentInLecture.Lecture.LectureDate,
                                          studentInLecture.Lecture.BeginHour,
                                          studentInLecture.Lecture.EndHour,
                                          studentInLecture.Lecture.IsCanceled,
                                          studentInLecture.Lecture.IsOld
                                      },
                                      Status = new
                                      {
                                          studentInLecture.Status.StatusID,
                                          studentInLecture.Status.StatusName
                                      }
                                  };
            return new JavaScriptSerializer().Serialize(
                new
                {
                    StudentInLecture = lecturesRecords
                }
                );
        }
    }

    [WebMethod]
    public string GetStudentsInLectureByLecture(int lectureID)
    {
        Lecture lecture = new Lecture(lectureID);
        object obj = new object();
        obj = Operations.GetStudentsInLectureByLecture(lecture);

      
        if (obj == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Lecture = (string)null
                }
                );
        }
        Type type = obj.GetType();
        List<StudentsInLecture> studentsInLecture = (List<StudentsInLecture>)type.GetProperty("studentsInLecture").GetValue(obj, null);
        object statusCount = type.GetProperty("StatusCount").GetValue(obj, null);
        var studentsInLectureRecords = from studentInLecture in studentsInLecture
                                       select new
                                       {
                                           Student = new
                                           {
                                               studentInLecture.Student.StudentID,
                                               studentInLecture.Student.FirstName,
                                               studentInLecture.Student.LastName,
                                               studentInLecture.Student.Picture
                                           },
                                           Status = new { studentInLecture.Status.StatusID, studentInLecture.Status.StatusName }
                                       };

        return new JavaScriptSerializer().Serialize(
            new
            {
                Lecture = new
                {
                    LectureID = lectureID
                },
                StudentsInLecture = studentsInLectureRecords,
                StatusCount = statusCount
            }
            );

    }

    [WebMethod]
    public string FireTimer(int lectureID)
    {
        Lecture lecture = new Lecture(lectureID);
        object obj = Operations.FireTimer(lecture);
        Type type = obj.GetType();
        lecture = (Lecture)type.GetProperty("lecture").GetValue(obj, null);
        Status status = (Status)type.GetProperty("status").GetValue(obj, null);
        if (lecture == null)
        {
            return new JavaScriptSerializer().Serialize(
            new
            {
                Lecture = (string)null
            }
            );
        }
        return new JavaScriptSerializer().Serialize(
            new
            {
                Lecture = new
                {
                    lecture.TimerLong
                },
                StudentsInLecture = new
                {
                    Status = new
                    {
                        status.StatusID,
                        status.StatusName
                    }
                }
            }
            );
    }
   

    [WebMethod]
    public string UpdateStatusOfStudentByTimer(int lectureID, int studentID)
    {
        Lecture lecture = new Lecture(lectureID);
        Student student = new Student(studentID);
        StudentsInLecture studentInLecture = new StudentsInLecture(lecture, student);
        return new JavaScriptSerializer().Serialize(Operations.UpdateStatusOfStudentByTimer(studentInLecture));
    }

    [WebMethod]
    public string UpdateStatusOfStudent(int lectureID, int studentID, int statusID)
    {
        Lecture lecture = new Lecture(lectureID);
        Student student = new Student(studentID);
        Status status = new Status(statusID);
        StudentsInLecture studentInLecture = new StudentsInLecture(lecture, student, status);

        object obj = new object();
        obj = Operations.UpdateStatusOfStudent(studentInLecture);
        if (obj == null)
        {
            return new JavaScriptSerializer().Serialize(
                null
                );
        }
        Type type = obj.GetType();
        status = (Status)type.GetProperty("status").GetValue(obj, null);
        object statusCount = type.GetProperty("StatusCount").GetValue(obj, null);

        return new JavaScriptSerializer().Serialize(
            new
            {
                Status = status,
                StatusCount = statusCount
            }
            );
    }

    [WebMethod]
    public string UpdateLecturerQRMode(int lecturerID, bool qRMode)
    {
        Lecturer lecturer = new Lecturer(lecturerID, qRMode);
        bool isOk = Operations.UpdateLecturerQRMode(lecturer);

        if (!isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    QRMode = (string)null
                }
                );
        }

        return new JavaScriptSerializer().Serialize(
                new
                {
                    QRMode = qRMode
                }
                );
    }

    [WebMethod]
    public string UpdateLectureCancel(int lectureID, bool isCanceled)
    {
        Lecture lecture = new Lecture(lectureID, isCanceled);
        lecture = Operations.UpdateLectureCancel(lecture);

        if (lecture == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsCanceled = (string)null
                }
                );
        }

        return new JavaScriptSerializer().Serialize(
                new
                {
                    lecture.IsCanceled
                }
                );
    }

    [WebMethod]
    public string GetCoursesByStudent(int studentID)
    {
        Student student = new Student(studentID);
        List<Course> courses = Operations.GetCoursesByStudent(student);
        var coursesRecords = from course in courses
                             select new
                             {
                                 course.CourseID,
                                 course.CourseName
                             };

        return new JavaScriptSerializer().Serialize(
            new
            {
                Course = coursesRecords
            }
            );
    }

    [WebMethod]
    public string GetCoursesByLecturer(int lecturerID)
    {
        Lecturer lecturer = new Lecturer(lecturerID);
        List<Course> courses = Operations.GetCoursesByLecturer(lecturer);

        var coursesRecords = from course in courses
                             select new
                             {
                                 course.CourseID,
                                 course.CourseName
                             };

        return new JavaScriptSerializer().Serialize(
            new
            {
                Course = coursesRecords
            }
            );
    }

    [WebMethod]
    public string GetCourseDataByStudent(int studentID, int courseID)
    {
        Student student = new Student(studentID);
        Course course = new Course(courseID);
        object courseDataObject = Operations.GetCourseDataByStudent(student, course);
        if (courseDataObject == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    CourseData = (string)null
                }
                );
        }
        return new JavaScriptSerializer().Serialize(courseDataObject);
    }

    [WebMethod]
    public string GetCourseDataByLecturer(int lecturerID, int courseID)
    {
        Lecturer lecturer = new Lecturer(lecturerID);
        Course course = new Course(courseID);
        List<object> coursesDataObject = Operations.GetCourseDataByLecturer(lecturer, course);
        if (coursesDataObject.Count == 0)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    CourseData = (string)null
                }
                );
        }
        return new JavaScriptSerializer().Serialize(new
        {
            CourseData = coursesDataObject
        });
    }

    [WebMethod]
    public string UpdateStudentPassword(int studentID, string currentPassword, string newPassword)
    {
        Student student = new Student(studentID);
        bool isOk = Operations.UpdateStudentPassword(student, currentPassword, newPassword);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }
    }

    [WebMethod]
    public string UpdateLecturerPassword(int lecturerID, string currentPassword, string newPassword)
    {
        Lecturer lecturer = new Lecturer(lecturerID);
        bool isOk = Operations.UpdateLecturerPassword(lecturer, currentPassword, newPassword);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }
    }

    [WebMethod]
    public string UpdateLocationManagerPassword(int locationManagerID, string currentPassword, string newPassword)
    {
        LocationManager locationManager = new LocationManager(locationManagerID);
        bool isOk = Operations.UpdateLocationManagerPassword(locationManager, currentPassword, newPassword);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }
    }

    [WebMethod]
    public string UpdateStudentEmail(int studentID, string email)
    {
        Student student = new Student(studentID, email);
        bool isOk = Operations.UpdateStudentEmail(student);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }
    }

    [WebMethod]
    public string UpdateLecturerEmail(int lecturerID, string email)
    {
        Lecturer lecturer = new Lecturer(lecturerID, email);
        bool isOk = Operations.UpdateLecturerEmail(lecturer);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }
    }

    [WebMethod]
    public string UpdateLocationManagerEmail(int locationManagerID, string email)
    {
        LocationManager locationManager = new LocationManager(locationManagerID, email);
        bool isOk = Operations.UpdateLocationManagerEmail(locationManager);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }
    }

    [WebMethod]
    public string GetClassesByLocationManager()
    {
        List<Class> classes = Operations.GetClassesByLocationManager();
        var classesRecords = from class1 in classes
                             select new
                             {
                                 class1.ClassID,
                                 class1.ClassName,
                                 class1.Longitude,
                                 class1.Latitude,
                                 class1.LastLocationUpdate
                             };

        return new JavaScriptSerializer().Serialize(
            new
            {
                Class = classesRecords
            }
            );
    }

    [WebMethod]
    public string UpdateClassLocation(int classID, double longitude, double latitude)
    {
        Class class1 = new Class(classID, longitude, latitude);
        class1 = Operations.UpdateClassLocation(class1);
        if (class1 == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Class = (string)null
                }
                );
        }
        return new JavaScriptSerializer().Serialize(
            new
            {
                Class = new
                {
                    class1.ClassID,
                    class1.ClassName,
                    class1.Longitude,
                    class1.Latitude,
                    class1.LastLocationUpdate
                }
            }
            );
    }

    [WebMethod]
    public string GetFormsByStudent(int studentID)
    {
        Student student = new Student(studentID);
        List<Form> forms = Operations.GetFormsByStudent(student);

        var formsRecords = from form in forms
                           select new
                           {
                               form.FormID,
                               Student = new { form.Student.StudentID },
                               form.OpenDate,
                               form.EndDate,
                               form.Picture,
                               FormStatus = new { form.FormStatus.FormStatusID, form.FormStatus.FormStatusName }
                           };

        return new JavaScriptSerializer().Serialize(
            new
            {
                Form = formsRecords
            }
            );
    }

    [WebMethod]
    public string AddForm(int studentID, DateTime openDate, DateTime endDate, string pictureName, string pictureBase64)
    {
        Student student = new Student(studentID);
        Form form = new Form(student, openDate, endDate);
        form = Operations.AddForm(form, pictureName, pictureBase64);
        if (form == null)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    Form = (string)null
                }
                );
        }

        return new JavaScriptSerializer().Serialize(
                new
                {
                    Form = new
                    {
                        form.FormID,
                        form.OpenDate,
                        form.EndDate,
                        form.Picture,
                        FormStatus = new { form.FormStatus.FormStatusID, form.FormStatus.FormStatusName }
                    }
                }
                );
    }

    [WebMethod]
    public string DeleteForm(int formID)
    {
        Form form = new Form(formID);
        bool isOk = Operations.DeleteForm(form);
        if (isOk)
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = true
                }
                );
        }
        else
        {
            return new JavaScriptSerializer().Serialize(
                new
                {
                    IsOk = false
                }
                );
        }

    }

}