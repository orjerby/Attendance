using BEL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Timers;
using System.Web;
using System.Web.Security;
using System.Drawing;
using System.Drawing.Imaging;
using System.Transactions;

namespace DAL
{
    public class DBConnections
    {
        static string CS = ConfigurationManager.ConnectionStrings["Live"].ConnectionString;
        static List<Letter> lettersToSend = new List<Letter>();
        static Timer sendNotificationsTimer = new Timer();

        public static int DeleteLecturesInSemester(LecturesInSemester lecturesInSemester)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecturesInSemester.Lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecturesInSemester.Lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@WeekdayID", lecturesInSemester.Weekday.WeekdayID));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecturesInSemester.Lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecturesInSemester.Lecture.EndHour));
                cmd.Parameters.Add(new SqlParameter("@OpenDate", lecturesInSemester.OpenDate));
                cmd.Parameters.Add(new SqlParameter("@EndDate", lecturesInSemester.EndDate));
                cmd.CommandText = "spDeleteLecturesInSemester";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteStudentInLecture(StudentsInLecture studentsInLecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", studentsInLecture.Lecture.LectureID));
                cmd.Parameters.Add(new SqlParameter("@StudentID", studentsInLecture.Student.StudentID));
                cmd.CommandText = "spDeleteStudentInLecture";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int UpdateStudentInLecture(StudentsInLecture studentsInLecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", studentsInLecture.Lecture.LectureID));
                cmd.Parameters.Add(new SqlParameter("@StudentID", studentsInLecture.Student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@StatusID", studentsInLecture.Status.StatusID));
                cmd.CommandText = "spUpdateStudentInLecture";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static string UpdateLectureTry(Lecture lecture)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", lecture.LectureID));
                cmd.Parameters.Add(new SqlParameter("@CourseID", lecture.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecture.Lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@ClassID", lecture.Class.ClassID));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecture.EndHour));
                cmd.Parameters.Add(new SqlParameter("@LectureDate", lecture.LectureDate));
                cmd.Parameters.Add(new SqlParameter("@IsCanceled", lecture.IsCanceled));
                cmd.CommandText = "spUpdateLectureTry";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                lecture = null;
                if (sdr.Read())
                {
                    lecture = new Lecture(Convert.ToBoolean(sdr["IsCanceled"].ToString()));
                }
                sdr.NextResult();
                List<Letter> letters = new List<Letter>();
                while (sdr.Read())
                {
                    Letter letter = null;
                    string token = sdr["Token"].ToString();
                    if (token != "")
                    {
                        if (lecture.IsCanceled)
                        {
                            letter = new Letter(token, $"ההרצאה בקורס {sdr["CourseName"].ToString()}", $"בתאריך {DateTime.Parse(sdr["LectureDate"].ToString()).ToString("dd/MM/yyyy")} התבטלה");
                        }
                        else
                        {
                            letter = new Letter(token, $"ההרצאה בקורס {sdr["CourseName"].ToString()}", $"תתקיים כהרגלה בתאריך {DateTime.Parse(sdr["LectureDate"].ToString()).ToString("dd/MM/yyyy")} בשעה {sdr["BeginHour"].ToString().Substring(0, 5)}");
                        }
                        letters.Add(letter);
                    }
                }
                sdr.NextResult();
                while (sdr.Read())
                {
                    Letter letter = null;
                    string token = sdr["Token"].ToString();
                    if (token != "")
                    {
                        if (lecture.IsCanceled)
                        {
                            letter = new Letter(token, $"ההרצאה במגמת {sdr["DepartmentName"].ToString()}", $"בקורס {sdr["CourseName"].ToString()} בתאריך {DateTime.Parse(sdr["LectureDate"].ToString()).ToString("dd/MM/yyyy")} התבטלה");
                        }
                        else
                        {
                            letter = new Letter(token, $"ההרצאה במגמת {sdr["DepartmentName"].ToString()}", $"בקורס {sdr["CourseName"].ToString()} תתקיים כהרגלה בתאריך {DateTime.Parse(sdr["LectureDate"].ToString()).ToString("dd/MM/yyyy")} בשעה {sdr["BeginHour"].ToString().Substring(0, 5)}");
                        }
                        letters.Add(letter);
                    }
                }
                foreach (Letter letter in letters)
                {
                    lettersToSend.Add(letter);
                }
                if (letters.Count > 0)
                {
                    sendNotificationsTimer.Enabled = true;
                    sendNotificationsTimer.Interval = 150;
                    sendNotificationsTimer.Elapsed += SendNotifications;
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return null;
        }

        public static int DeleteLecture(Lecture lecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", lecture.LectureID));
                cmd.CommandText = "spDeleteLecture";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static Administrator ValidateAdministrator(Administrator administrator)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(administrator.User.Password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@AdministratorID", administrator.AdministratorID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.CommandText = "spValidateAdministrator";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Role returnedRole = new Role(int.Parse(sdr["RoleID"].ToString()), sdr["RoleName"].ToString());
                    User returnedUser = new User(int.Parse(sdr["UserID"].ToString()), sdr["Password"].ToString(), returnedRole);
                    Administrator returnedAdministrator = new Administrator(int.Parse(sdr["AdministratorID"].ToString()), returnedUser, sdr["FirstName"].ToString(), sdr["LastName"].ToString(), sdr["Email"].ToString());
                    return returnedAdministrator;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static int DeleteLecturerHard(Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.CommandText = "spDeleteLecturerHard";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteLecturerSoft(Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.CommandText = "spDeleteLecturerSoft";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteClassHard(Class class1)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@ClassID", class1.ClassID));
                cmd.CommandText = "spDeleteClassHard";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteClassSoft(Class class1)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@ClassID", class1.ClassID));
                cmd.CommandText = "spDeleteClassSoft";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteDepartmentHard(Department department)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", department.DepartmentID));
                cmd.CommandText = "spDeleteDepartmentHard";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteDepartmentSoft(Department department)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", department.DepartmentID));
                cmd.CommandText = "spDeleteDepartmentSoft";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteCourseHard(Course course)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", course.CourseID));
                cmd.CommandText = "spDeleteCourseHard";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteCourseSoft(Course course)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", course.CourseID));
                cmd.CommandText = "spDeleteCourseSoft";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteCycleHard(Cycle cycle)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CycleID", cycle.CycleID));
                cmd.CommandText = "spDeleteCycleHard";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static int DeleteCycleSoft(Cycle cycle)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CycleID", cycle.CycleID));
                cmd.CommandText = "spDeleteCycleSoft";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1; // בעיה
        }

        public static string CheckAddLecturesInSemester(LecturesInSemester lecturesInSemester)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", lecturesInSemester.Lecture.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecturesInSemester.Lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecturesInSemester.Lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturesInSemester.Lecture.Lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@WeekdayID", lecturesInSemester.Weekday.WeekdayID));
                cmd.Parameters.Add(new SqlParameter("@ClassID", lecturesInSemester.Lecture.Class.ClassID));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecturesInSemester.Lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecturesInSemester.Lecture.EndHour));
                cmd.Parameters.Add(new SqlParameter("@OpenDate", lecturesInSemester.OpenDate));
                cmd.Parameters.Add(new SqlParameter("@EndDate", lecturesInSemester.EndDate));
                cmd.CommandText = "spCheckAddLecturesInSemester";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return null;
        }

        public static string AddLecturesInSemesterTry(LecturesInSemester lecturesInSemester)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", lecturesInSemester.Lecture.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecturesInSemester.Lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecturesInSemester.Lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturesInSemester.Lecture.Lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@WeekdayID", lecturesInSemester.Weekday.WeekdayID));
                cmd.Parameters.Add(new SqlParameter("@ClassID", lecturesInSemester.Lecture.Class.ClassID));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecturesInSemester.Lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecturesInSemester.Lecture.EndHour));
                cmd.Parameters.Add(new SqlParameter("@OpenDate", lecturesInSemester.OpenDate));
                cmd.Parameters.Add(new SqlParameter("@EndDate", lecturesInSemester.EndDate));
                cmd.CommandText = "spAddLecturesInSemesterTry";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return null;
        }

        public static int AddLecturesInSemester(LecturesInSemester lecturesInSemester)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", lecturesInSemester.Lecture.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecturesInSemester.Lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecturesInSemester.Lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturesInSemester.Lecture.Lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@WeekdayID", lecturesInSemester.Weekday.WeekdayID));
                cmd.Parameters.Add(new SqlParameter("@ClassID", lecturesInSemester.Lecture.Class.ClassID));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecturesInSemester.Lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecturesInSemester.Lecture.EndHour));
                cmd.Parameters.Add(new SqlParameter("@OpenDate", lecturesInSemester.OpenDate));
                cmd.Parameters.Add(new SqlParameter("@EndDate", lecturesInSemester.EndDate));
                cmd.CommandText = "spAddLecturesInSemester";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static string CheckAddLecture(Lecture lecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", lecture.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecture.Lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecture.EndHour));
                cmd.CommandText = "spCheckAddLecture";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return null;
        }

        public static string AddLectureTry(Lecture lecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", lecture.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", lecture.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", lecture.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecture.Lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@ClassID", lecture.Class.ClassID));
                cmd.Parameters.Add(new SqlParameter("@LectureDate", lecture.LectureDate));
                cmd.Parameters.Add(new SqlParameter("@BeginHour", lecture.BeginHour));
                cmd.Parameters.Add(new SqlParameter("@EndHour", lecture.EndHour));
                cmd.CommandText = "spAddLectureTry";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return null;
        }

        public static int UpdateStudent(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", student.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", student.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@FirstName", student.FirstName));
                cmd.Parameters.Add(new SqlParameter("@LastName", student.LastName));
                cmd.Parameters.Add(new SqlParameter("@Email", student.Email));
                cmd.Parameters.Add(new SqlParameter("@IsActive", student.IsActive));
                cmd.CommandText = "spUpdateStudent";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static string UpdateStudentTry(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", student.Department.DepartmentID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", student.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@FirstName", student.FirstName));
                cmd.Parameters.Add(new SqlParameter("@LastName", student.LastName));
                cmd.Parameters.Add(new SqlParameter("@Email", student.Email));
                cmd.Parameters.Add(new SqlParameter("@IsActive", student.IsActive));
                cmd.CommandText = "spUpdateStudentTry";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return null;
        }

        public static int UpdateCourseOfStudent(CoursesOfStudent coursesOfStudent, Cycle oldCycle)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@StudentID", coursesOfStudent.Student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@CourseID", coursesOfStudent.Course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@OldCycleID", oldCycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@CycleID", coursesOfStudent.Cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@IsActive", coursesOfStudent.IsActive));
                cmd.CommandText = "spUpdateCourseOfStudent";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static int ReplaceDepartmentsOfCourse(Course course, string listOfDepartments)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@ListOfDepartments", listOfDepartments));
                cmd.CommandText = "spReplaceDepartmentsOfCourse";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static int ReplaceCoursesOfDepartment(string listOfCourses, Department department)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@ListOfCourses", listOfCourses));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", department.DepartmentID));
                cmd.CommandText = "spReplaceCoursesOfDepartment";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static int ReplaceLecturersOfCourse(Course course, string listOfLecturers)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CourseID", course.CourseID));
                cmd.Parameters.Add(new SqlParameter("@ListOfLecturers", listOfLecturers));
                cmd.CommandText = "spReplaceLecturersOfCourse";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static int ReplaceCoursesOfLecturer(string listOfCourses, Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@ListOfCourses", listOfCourses));
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.CommandText = "spReplaceCoursesOfLecturer";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static int ReplaceDepartmentsOfCycle(Cycle cycle, string listOfDepartments)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@CycleID", cycle.CycleID));
                cmd.Parameters.Add(new SqlParameter("@ListOfDepartments", listOfDepartments));
                cmd.CommandText = "spReplaceDepartmentsOfCycle";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static int ReplaceCyclesOfDepartment(string listOfCycles, Department department)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@ListOfCycles", listOfCycles));
                cmd.Parameters.Add(new SqlParameter("@DepartmentID", department.DepartmentID));
                cmd.CommandText = "spReplaceCyclesOfDepartment";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                return cmd.ExecuteNonQuery(); // יחזיר 0 אם לא הצליח
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return -1;
        }

        public static Lecturer ValidateLecturer(int lecturerID, string password, string token)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturerID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.Parameters.Add(new SqlParameter("@Token", token));
                cmd.CommandText = "spValidateLecturer";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Role role = new Role(int.Parse(sdr["RoleID"].ToString()), sdr["RoleName"].ToString());
                    User user = new User(int.Parse(sdr["UserID"].ToString()), sdr["Password"].ToString(), role, sdr["Token"].ToString());
                    string picture = ConfigurationManager.AppSettings["LecturersImagesPath"] + sdr["Picture"].ToString();
                    return new Lecturer(int.Parse(sdr["LecturerID"].ToString()), user, sdr["FirstName"].ToString(), sdr["LastName"].ToString(), sdr["Email"].ToString(), picture, Convert.ToBoolean(sdr["QRMode"].ToString()));
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static Student ValidateStudent(int studentID, string password, string token)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@StudentID", studentID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.Parameters.Add(new SqlParameter("@Token", token));
                cmd.CommandText = "spValidateStudent";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Role role = new Role(int.Parse(sdr["RoleID"].ToString()), sdr["RoleName"].ToString());
                    User user = new User(int.Parse(sdr["UserID"].ToString()), sdr["Password"].ToString(), role, sdr["Token"].ToString());
                    Department department = new Department(int.Parse(sdr["DepartmentID"].ToString()), sdr["DepartmentName"].ToString());
                    Cycle cycle = new Cycle(int.Parse(sdr["CycleID"].ToString()), sdr["CycleName"].ToString(), int.Parse(sdr["Year"].ToString()));
                    string picture = ConfigurationManager.AppSettings["StudentsImagesPath"] + sdr["Picture"].ToString();
                    return new Student(int.Parse(sdr["StudentID"].ToString()), user, department, cycle, sdr["FirstName"].ToString(), sdr["LastName"].ToString(), sdr["Email"].ToString(), picture);
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static LocationManager ValidateLocationManager(int locationManagerID, string password, string token)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@LocationManagerID", locationManagerID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.Parameters.Add(new SqlParameter("@Token", token));
                cmd.CommandText = "spValidateLocationManager";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Role role = new Role(int.Parse(sdr["RoleID"].ToString()), sdr["RoleName"].ToString());
                    User user = new User(int.Parse(sdr["UserID"].ToString()), sdr["Password"].ToString(), role, sdr["Token"].ToString());
                    return new LocationManager(int.Parse(sdr["LocationManagerID"].ToString()), user, sdr["FirstName"].ToString(), sdr["LastName"].ToString(), sdr["Email"].ToString());
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static object GetNextLectureByLecturer(Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetNextLectureByLecturer", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                SqlParameter isLiveOutputParameter = new SqlParameter("@IsLive", SqlDbType.Bit);
                SqlParameter isExistOutputParameter = new SqlParameter("@IsExist", SqlDbType.Bit);
                isLiveOutputParameter.Direction = ParameterDirection.Output;
                isExistOutputParameter.Direction = ParameterDirection.Output;
                sda.SelectCommand.Parameters.Add(isLiveOutputParameter);
                sda.SelectCommand.Parameters.Add(isExistOutputParameter);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                bool isExist = Convert.ToBoolean(isExistOutputParameter.Value);
                if (isExist)
                {
                    bool isLive = Convert.ToBoolean(isLiveOutputParameter.Value);
                    if (isLive)
                    {
                        ds.Tables[0].TableName = "Lecture";
                        ds.Tables[1].TableName = "StudentsInLecture";
                        ds.Tables[2].TableName = "StatusCount";
                        Course course = new Course(int.Parse(ds.Tables["Lecture"].Rows[0]["CourseID"].ToString()), ds.Tables["Lecture"].Rows[0]["CourseName"].ToString());
                        Department department = new Department(int.Parse(ds.Tables["Lecture"].Rows[0]["DepartmentID"].ToString()), ds.Tables["Lecture"].Rows[0]["DepartmentName"].ToString());
                        Cycle cycle = new Cycle(int.Parse(ds.Tables["Lecture"].Rows[0]["CycleID"].ToString()), ds.Tables["Lecture"].Rows[0]["CycleName"].ToString(), int.Parse(ds.Tables["Lecture"].Rows[0]["Year"].ToString()));
                        Class class1 = new Class(int.Parse(ds.Tables["Lecture"].Rows[0]["ClassID"].ToString()), ds.Tables["Lecture"].Rows[0]["ClassName"].ToString(), ds.Tables["Lecture"].Rows[0]["Longitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["Lecture"].Rows[0]["Longitude"].ToString()), ds.Tables["Lecture"].Rows[0]["Latitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["Lecture"].Rows[0]["Latitude"].ToString()));
                        Lecture lecture = new Lecture(int.Parse(ds.Tables["Lecture"].Rows[0]["LectureID"].ToString()), course, department, cycle, class1, DateTime.Parse(ds.Tables["Lecture"].Rows[0]["LectureDate"].ToString()), ds.Tables["Lecture"].Rows[0]["BeginHour"].ToString(), ds.Tables["Lecture"].Rows[0]["EndHour"].ToString(), Convert.ToBoolean(ds.Tables["Lecture"].Rows[0]["IsCanceled"].ToString()), int.Parse(ds.Tables["Lecture"].Rows[0]["TimerLong"].ToString()), int.Parse(ds.Tables["Lecture"].Rows[0]["TimerRemaining"].ToString()), int.Parse(ds.Tables["Lecture"].Rows[0]["MinutesToEnd"].ToString()));

                        List<StudentsInLecture> studentsInLecture = new List<StudentsInLecture>();
                        foreach (DataRow dr in ds.Tables["StudentsInLecture"].Rows)
                        {
                            Status status = new Status(int.Parse(dr["StatusID"].ToString()), dr["StatusName"].ToString());
                            string picture = ConfigurationManager.AppSettings["StudentsImagesPath"] + dr["Picture"].ToString();
                            Student student = new Student(int.Parse(dr["StudentID"].ToString()), dr["FirstName"].ToString(), dr["LastName"].ToString(), picture);
                            StudentsInLecture studentInLecture = new StudentsInLecture(student, status);
                            studentsInLecture.Add(studentInLecture);
                        }
                        int missCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["MissCount"].ToString());
                        int lateCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["LateCount"].ToString());
                        int hereCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["HereCount"].ToString());
                        int justifyCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["JustifyCount"].ToString());
                        return new
                        {
                            isLive,
                            lecture,
                            studentsInLecture,
                            StatusCount = new { MissCount = missCount, LateCount = lateCount, HereCount = hereCount, JustifyCount = justifyCount }
                        };
                    }
                    else
                    {
                        ds.Tables[0].TableName = "Lecture";
                        Course course = new Course(int.Parse(ds.Tables["Lecture"].Rows[0]["CourseID"].ToString()), ds.Tables["Lecture"].Rows[0]["CourseName"].ToString());
                        Department department = new Department(int.Parse(ds.Tables["Lecture"].Rows[0]["DepartmentID"].ToString()), ds.Tables["Lecture"].Rows[0]["DepartmentName"].ToString());
                        Cycle cycle = new Cycle(int.Parse(ds.Tables["Lecture"].Rows[0]["CycleID"].ToString()), ds.Tables["Lecture"].Rows[0]["CycleName"].ToString(), int.Parse(ds.Tables["Lecture"].Rows[0]["Year"].ToString()));
                        Class class1 = new Class(int.Parse(ds.Tables["Lecture"].Rows[0]["ClassID"].ToString()), ds.Tables["Lecture"].Rows[0]["ClassName"].ToString(), ds.Tables["Lecture"].Rows[0]["Longitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["Lecture"].Rows[0]["Longitude"].ToString()), ds.Tables["Lecture"].Rows[0]["Latitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["Lecture"].Rows[0]["Latitude"].ToString()));
                        Lecture lecture = new Lecture(int.Parse(ds.Tables["Lecture"].Rows[0]["LectureID"].ToString()), course, department, cycle, class1, DateTime.Parse(ds.Tables["Lecture"].Rows[0]["LectureDate"].ToString()), ds.Tables["Lecture"].Rows[0]["BeginHour"].ToString(), ds.Tables["Lecture"].Rows[0]["EndHour"].ToString(), Convert.ToBoolean(ds.Tables["Lecture"].Rows[0]["IsCanceled"].ToString()), int.Parse(ds.Tables["Lecture"].Rows[0]["MinutesToBegin"].ToString()));


                        return new
                        {
                            isLive,
                            lecture
                        };
                    }
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static object GetNextLectureByStudent(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetNextLectureByStudent", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                SqlParameter isLiveOutputParameter = new SqlParameter("@IsLive", SqlDbType.Bit);
                SqlParameter isExistOutputParameter = new SqlParameter("@IsExist", SqlDbType.Bit);
                isLiveOutputParameter.Direction = ParameterDirection.Output;
                isExistOutputParameter.Direction = ParameterDirection.Output;
                sda.SelectCommand.Parameters.Add(isLiveOutputParameter);
                sda.SelectCommand.Parameters.Add(isExistOutputParameter);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                bool isExist = Convert.ToBoolean(isExistOutputParameter.Value);
                if (isExist)
                {
                    bool isLive = Convert.ToBoolean(isLiveOutputParameter.Value);
                    if (isLive)
                    {
                        ds.Tables[0].TableName = "StudentInLecture";
                        Course course = new Course(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["CourseID"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["CourseName"].ToString());
                        Department department = new Department(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["DepartmentID"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["DepartmentName"].ToString());
                        Cycle cycle = new Cycle(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["CycleID"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["CycleName"].ToString(), int.Parse(ds.Tables["StudentInLecture"].Rows[0]["Year"].ToString()));
                        Class class1 = new Class(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["ClassID"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["ClassName"].ToString(), ds.Tables["StudentInLecture"].Rows[0]["Longitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["StudentInLecture"].Rows[0]["Longitude"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["Latitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["StudentInLecture"].Rows[0]["Latitude"].ToString()));
                        string picture = ConfigurationManager.AppSettings["LecturersImagesPath"] + ds.Tables["StudentInLecture"].Rows[0]["Picture"].ToString();
                        Lecturer lecturer = new Lecturer(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["LecturerID"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["FirstName"].ToString(), ds.Tables["StudentInLecture"].Rows[0]["LastName"].ToString(), picture, Convert.ToBoolean(ds.Tables["StudentInLecture"].Rows[0]["QRMode"].ToString()));
                        Lecture lecture = new Lecture(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["LectureID"].ToString()), course, department, cycle, lecturer, class1, DateTime.Parse(ds.Tables["StudentInLecture"].Rows[0]["LectureDate"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["BeginHour"].ToString(), ds.Tables["StudentInLecture"].Rows[0]["EndHour"].ToString(), Convert.ToBoolean(ds.Tables["StudentInLecture"].Rows[0]["IsCanceled"].ToString()), int.Parse(ds.Tables["StudentInLecture"].Rows[0]["TimerLong"].ToString()), int.Parse(ds.Tables["StudentInLecture"].Rows[0]["TimerRemaining"].ToString()), int.Parse(ds.Tables["StudentInLecture"].Rows[0]["MinutesToEnd"].ToString()));
                        Status status = new Status(int.Parse(ds.Tables["StudentInLecture"].Rows[0]["StatusID"].ToString()), ds.Tables["StudentInLecture"].Rows[0]["StatusName"].ToString());
                        StudentsInLecture studentInLecture = new StudentsInLecture(lecture, status);


                        int totalLectureCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["TotalLectureCount"].ToString());
                        int pastLectureCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["PastLectureCount"].ToString());
                        int futureLectureCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["FutureLectureCount"].ToString());
                        int missCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["MissCount"].ToString());
                        int lateCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["LateCount"].ToString());
                        int hereCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["HereCount"].ToString());
                        int justifyCount = int.Parse(ds.Tables["StudentInLecture"].Rows[0]["JustifyCount"].ToString());
                        float missPercentage = float.Parse(ds.Tables["StudentInLecture"].Rows[0]["MissPercentage"].ToString());
                        float latePercentage = float.Parse(ds.Tables["StudentInLecture"].Rows[0]["LatePercentage"].ToString());
                        float herePercentage = float.Parse(ds.Tables["StudentInLecture"].Rows[0]["HerePercentage"].ToString());
                        float justifyPercentage = float.Parse(ds.Tables["StudentInLecture"].Rows[0]["JustifyPercentage"].ToString());
                        
                        return new
                        {
                            isLive,
                            studentInLecture,
                            CourseData = new
                            {
                                TotalLectureCount = totalLectureCount,
                                PastLectureCount = pastLectureCount,
                                FutureLectureCount = futureLectureCount,
                                MissCount = missCount,
                                LateCount = lateCount,
                                HereCount = hereCount,
                                JustifyCount = justifyCount,
                                MissPercentage = missPercentage,
                                LatePercentage = latePercentage,
                                HerePercentage = herePercentage,
                                JustifyPercentage = justifyPercentage
                            }
                        };
                    }
                    else
                    {
                        ds.Tables[0].TableName = "Lecture";
                        Course course = new Course(int.Parse(ds.Tables["Lecture"].Rows[0]["CourseID"].ToString()), ds.Tables["Lecture"].Rows[0]["CourseName"].ToString());
                        Department department = new Department(int.Parse(ds.Tables["Lecture"].Rows[0]["DepartmentID"].ToString()), ds.Tables["Lecture"].Rows[0]["DepartmentName"].ToString());
                        Cycle cycle = new Cycle(int.Parse(ds.Tables["Lecture"].Rows[0]["CycleID"].ToString()), ds.Tables["Lecture"].Rows[0]["CycleName"].ToString(), int.Parse(ds.Tables["Lecture"].Rows[0]["Year"].ToString()));
                        Class class1 = new Class(int.Parse(ds.Tables["Lecture"].Rows[0]["ClassID"].ToString()), ds.Tables["Lecture"].Rows[0]["ClassName"].ToString(), ds.Tables["Lecture"].Rows[0]["Longitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["Lecture"].Rows[0]["Longitude"].ToString()), ds.Tables["Lecture"].Rows[0]["Latitude"].ToString() == string.Empty ? 0 : double.Parse(ds.Tables["Lecture"].Rows[0]["Latitude"].ToString()));
                        Lecturer lecturer = new Lecturer(int.Parse(ds.Tables["Lecture"].Rows[0]["LecturerID"].ToString()), ds.Tables["Lecture"].Rows[0]["FirstName"].ToString(), ds.Tables["Lecture"].Rows[0]["LastName"].ToString(), ds.Tables["Lecture"].Rows[0]["Picture"].ToString());
                        Lecture lecture = new Lecture(int.Parse(ds.Tables["Lecture"].Rows[0]["LectureID"].ToString()), course, department, cycle, lecturer, class1, DateTime.Parse(ds.Tables["Lecture"].Rows[0]["LectureDate"].ToString()), ds.Tables["Lecture"].Rows[0]["BeginHour"].ToString(), ds.Tables["Lecture"].Rows[0]["EndHour"].ToString(), Convert.ToBoolean(ds.Tables["Lecture"].Rows[0]["IsCanceled"].ToString()), int.Parse(ds.Tables["Lecture"].Rows[0]["MinutesToBegin"].ToString()));

                        int totalLectureCount = int.Parse(ds.Tables["Lecture"].Rows[0]["TotalLectureCount"].ToString());
                        int pastLectureCount = int.Parse(ds.Tables["Lecture"].Rows[0]["PastLectureCount"].ToString());
                        int futureLectureCount = int.Parse(ds.Tables["Lecture"].Rows[0]["FutureLectureCount"].ToString());
                        int missCount = int.Parse(ds.Tables["Lecture"].Rows[0]["MissCount"].ToString());
                        int lateCount = int.Parse(ds.Tables["Lecture"].Rows[0]["LateCount"].ToString());
                        int hereCount = int.Parse(ds.Tables["Lecture"].Rows[0]["HereCount"].ToString());
                        int justifyCount = int.Parse(ds.Tables["Lecture"].Rows[0]["JustifyCount"].ToString());
                        float missPercentage = float.Parse(ds.Tables["Lecture"].Rows[0]["MissPercentage"].ToString());
                        float latePercentage = float.Parse(ds.Tables["Lecture"].Rows[0]["LatePercentage"].ToString());
                        float herePercentage = float.Parse(ds.Tables["Lecture"].Rows[0]["HerePercentage"].ToString());
                        float justifyPercentage = float.Parse(ds.Tables["Lecture"].Rows[0]["JustifyPercentage"].ToString());
                        
                        return new
                        {
                            isLive,
                            lecture,
                            CourseData = new
                            {
                                TotalLectureCount = totalLectureCount,
                                PastLectureCount = pastLectureCount,
                                FutureLectureCount = futureLectureCount,
                                MissCount = missCount,
                                LateCount = lateCount,
                                HereCount = hereCount,
                                JustifyCount = justifyCount,
                                MissPercentage = missPercentage,
                                LatePercentage = latePercentage,
                                HerePercentage = herePercentage,
                                JustifyPercentage = justifyPercentage
                            }
                        };
                    }
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static List<Lecture> GetLecturesByLecturerAndDate(Lecturer lecturer, Lecture lecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetLecturesByLecturerAndDate", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                sda.SelectCommand.Parameters.Add(new SqlParameter("@LectureDate", lecture.LectureDate));
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "Lectures";
                List<Lecture> lectures = new List<Lecture>();
                foreach (DataRow dr in ds.Tables["Lectures"].Rows)
                {
                    Course course = new Course(int.Parse(dr["CourseID"].ToString()), dr["CourseName"].ToString());
                    Department department = new Department(int.Parse(dr["DepartmentID"].ToString()), dr["DepartmentName"].ToString());
                    Cycle cycle = new Cycle(int.Parse(dr["CycleID"].ToString()), dr["CycleName"].ToString(), int.Parse(dr["Year"].ToString()));
                    Class class1 = new Class(int.Parse(dr["ClassID"].ToString()), dr["ClassName"].ToString());
                    lecture = new Lecture(int.Parse(dr["LectureID"].ToString()), course, department, cycle, class1, DateTime.Parse(dr["LectureDate"].ToString()), dr["BeginHour"].ToString(), dr["EndHour"].ToString(), Convert.ToBoolean(dr["IsCanceled"].ToString()), Convert.ToBoolean(dr["IsOld"].ToString()));
                    lectures.Add(lecture);
                }
                return lectures;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static List<StudentsInLecture> GetLecturesByStudentAndDate(Student student, Lecture lecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetLecturesByStudentAndDate", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                sda.SelectCommand.Parameters.Add(new SqlParameter("@LectureDate", lecture.LectureDate));
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "StudentsInLecture";
                List<StudentsInLecture> studentsInLecture = new List<StudentsInLecture>();
                foreach (DataRow dr in ds.Tables["StudentsInLecture"].Rows)
                {
                    Course course = new Course(int.Parse(dr["CourseID"].ToString()), dr["CourseName"].ToString());
                    Department department = new Department(int.Parse(dr["DepartmentID"].ToString()), dr["DepartmentName"].ToString());
                    Cycle cycle = new Cycle(int.Parse(dr["CycleID"].ToString()), dr["CycleName"].ToString(), int.Parse(dr["Year"].ToString()));
                    Lecturer lecturer = new Lecturer(int.Parse(dr["LecturerID"].ToString()), dr["FirstName"].ToString(), dr["LastName"].ToString());
                    Class class1 = new Class(int.Parse(dr["ClassID"].ToString()), dr["ClassName"].ToString());
                    lecture = new Lecture(int.Parse(dr["LectureID"].ToString()), course, department, cycle, lecturer, class1, DateTime.Parse(dr["LectureDate"].ToString()), dr["BeginHour"].ToString(), dr["EndHour"].ToString(), Convert.ToBoolean(dr["IsCanceled"].ToString()), Convert.ToBoolean(dr["IsOld"].ToString()));
                    Status status = new Status(int.Parse(dr["StatusID"].ToString()), dr["StatusName"].ToString());
                    StudentsInLecture studentInLecture = new StudentsInLecture(lecture, status);
                    studentsInLecture.Add(studentInLecture);
                }
                return studentsInLecture;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static object GetStudentsInLectureByLecture(Lecture lecture)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetStudentsInLectureByLecture", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@LectureID", lecture.LectureID));
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "StudentsInLecture";
                ds.Tables[1].TableName = "StatusCount";
                List<StudentsInLecture> studentsInLecture = new List<StudentsInLecture>();
                foreach (DataRow dr in ds.Tables["StudentsInLecture"].Rows)
                {
                    string picture = ConfigurationManager.AppSettings["StudentsImagesPath"] + dr["Picture"].ToString();
                    Student student = new Student(int.Parse(dr["StudentID"].ToString()), dr["FirstName"].ToString(), dr["LastName"].ToString(), picture);
                    Status status = new Status(int.Parse(dr["StatusID"].ToString()), dr["StatusName"].ToString());
                    StudentsInLecture studentInLecture = new StudentsInLecture(student, status);
                    studentsInLecture.Add(studentInLecture);
                }
                int missCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["MissCount"].ToString());
                int lateCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["LateCount"].ToString());
                int hereCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["HereCount"].ToString());
                int justifyCount = int.Parse(ds.Tables["StatusCount"].Rows[0]["JustifyCount"].ToString());
                return new { studentsInLecture, StatusCount = new { MissCount = missCount, LateCount = lateCount, HereCount = hereCount, JustifyCount = justifyCount } };
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static object FireTimer(Lecture lecture)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", lecture.LectureID));
                cmd.CommandText = "spFireTimer";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    lecture = new Lecture(int.Parse(sdr["LectureID"].ToString()), int.Parse(sdr["TimerLong"].ToString()));
                }
                sdr.NextResult();
                Status status = null;
                if (sdr.Read())
                {
                    status = new Status(int.Parse(sdr["StatusID"].ToString()), sdr["StatusName"].ToString());
                }
                return new { lecture, status };
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }
        
        public static Status UpdateStatusOfStudentByTimer(StudentsInLecture studentInLecture)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", studentInLecture.Lecture.LectureID));
                cmd.Parameters.Add(new SqlParameter("@StudentID", studentInLecture.Student.StudentID));
                cmd.CommandText = "spUpdateStatusOfStudentByTimer";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    Status status = new Status(int.Parse(sdr["StatusID"].ToString()), sdr["StatusName"].ToString());
                    return status;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static object UpdateStatusOfStudent(StudentsInLecture studentInLecture)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@LectureID", studentInLecture.Lecture.LectureID));
                cmd.Parameters.Add(new SqlParameter("@StudentID", studentInLecture.Student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@StatusID", studentInLecture.Status.StatusID));
                cmd.CommandText = "spUpdateStatusOfStudent";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                Status status = null;
                if (sdr.Read())
                {
                    status = new Status(int.Parse(sdr["StatusID"].ToString()), sdr["StatusName"].ToString());
                }

                sdr.NextResult();
                int missCount = 0;
                int lateCount = 0;
                int hereCount = 0;
                int justifyCount = 0;
                if (sdr.Read())
                {
                    missCount = int.Parse(sdr["MissCount"].ToString());
                    lateCount = int.Parse(sdr["LateCount"].ToString());
                    hereCount = int.Parse(sdr["HereCount"].ToString());
                    justifyCount = int.Parse(sdr["JustifyCount"].ToString());
                }

                return new { status, StatusCount = new { MissCount = missCount, LateCount = lateCount, HereCount = hereCount, JustifyCount = justifyCount } };
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static List<Letter> CheckUpcommingLectures()
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spCheckUpcommingLectures", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "StudentsInLecture"; // push notifications for students
                List<Letter> letters = new List<Letter>();
                foreach (DataRow dr in ds.Tables["StudentsInLecture"].Rows)
                {
                    string token = dr["Token"].ToString();
                    if (token != "")
                    {
                        string title = $"היי {dr["FirstName"].ToString()}! ההרצאה תכף מתחילה";
                        string body = $"קורס {dr["CourseName"].ToString()} בכיתה {dr["ClassName"].ToString()}";
                        letters.Add(new Letter(token, title, body));
                    }
                }
                ds.Tables[1].TableName = "Lectures"; // push notifications for lecturers
                foreach (DataRow dr in ds.Tables["Lectures"].Rows)
                {
                    string token = dr["Token"].ToString();
                    if (token != "")
                    {
                        string title = $"היי {dr["FirstName"].ToString()}! ההרצאה תכף מתחילה";
                        string body = $"קורס {dr["CourseName"].ToString()} של מגמת {dr["DepartmentName"].ToString()} {dr["CycleName"].ToString()} בכיתה {dr["ClassName"].ToString()}";
                        letters.Add(new Letter(token, title, body));
                    }
                }

                return letters;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static Lecture UpdateLectureCancel(Lecture lecture)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LectureID", lecture.LectureID));
                cmd.Parameters.Add(new SqlParameter("@IsCanceled", lecture.IsCanceled));
                cmd.CommandText = "spUpdateLectureCancel";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                lecture = null;
                if (sdr.Read())
                {
                    lecture = new Lecture(Convert.ToBoolean(sdr["IsCanceled"].ToString()));
                }
                sdr.NextResult();
                List<Letter> letters = new List<Letter>();
                while (sdr.Read())
                {
                    Letter letter = null;
                    string token = sdr["Token"].ToString();
                    if (token != "")
                    {
                        if (lecture.IsCanceled)
                        {
                            letter = new Letter(token, $"ההרצאה בקורס {sdr["CourseName"].ToString()}", $"בתאריך {DateTime.Parse(sdr["LectureDate"].ToString()).ToString("dd/MM/yyyy")} התבטלה");
                        }
                        else
                        {
                            letter = new Letter(token, $"ההרצאה בקורס {sdr["CourseName"].ToString()}", $"תתקיים כהרגלה בתאריך {DateTime.Parse(sdr["LectureDate"].ToString()).ToString("dd/MM/yyyy")} בשעה {sdr["BeginHour"].ToString().Substring(0, 5)}");
                        }
                        letters.Add(letter);
                    }
                }
                foreach (Letter letter in letters)
                {
                    lettersToSend.Add(letter);
                }
                if (letters.Count > 0)
                {
                    sendNotificationsTimer.Enabled = true;
                    sendNotificationsTimer.Interval = 150;
                    sendNotificationsTimer.Elapsed += SendNotifications;
                }
                return lecture;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static bool UpdateLecturerQRMode(Lecturer lecturer)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@QRMode", lecturer.QRMode));
                cmd.CommandText = "spUpdateLecturerQRMode";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                List<Letter> letters = new List<Letter>();
                while (sdr.Read())
                {
                    Letter letter = null;
                    string token = sdr["Token"].ToString();
                    if (token != "")
                    {
                        letter = new Letter(token, "ההרצאה הנוכחית הופעלה מחדש", "כנס כדי לסמן נוכחות ;)");
                        letters.Add(letter);
                    }
                }
                foreach (Letter letter in letters)
                {
                    lettersToSend.Add(letter);
                }
                if (letters.Count > 0)
                {
                    sendNotificationsTimer.Enabled = true;
                    sendNotificationsTimer.Interval = 150;
                    sendNotificationsTimer.Elapsed += SendNotifications;
                }
                return true;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateStudentPasswordForAdministrator(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(student.User.Password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.CommandText = "spUpdateStudentPasswordForAdministrator";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    string from = "orjerby@gmail.com";
                    string to = student.Email;
                    string subject = "סיסמה זמנית לאפליקציה";
                    string body = "הסיסמה הזמנית שלך היא: " + "\n" + student.User.Password;
                    MailMessage message = new MailMessage(from, to, subject, body);
                    SmtpClient smtp = new SmtpClient();
                    smtp.Send(message);
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateLecturerPasswordForAdministrator(Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(lecturer.User.Password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.CommandText = "spUpdateLecturerPasswordForAdministrator";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    string from = "orjerby@gmail.com";
                    string to = lecturer.Email;
                    string subject = "סיסמה זמנית לאפליקציה";
                    string body = "הסיסמה הזמנית שלך היא: " + lecturer.User.Password;
                    MailMessage message = new MailMessage(from, to, subject, body);
                    SmtpClient smtp = new SmtpClient();
                    smtp.Send(message);
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateLocationManagerPasswordForAdministrator(LocationManager locationManager)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(locationManager.User.Password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@LocationManagerID", locationManager.LocationManagerID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.CommandText = "spUpdateLocationManagerPasswordForAdministrator";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    string from = "orjerby@gmail.com";
                    string to = locationManager.Email;
                    string subject = "סיסמה זמנית לאפליקציה";
                    string body = "הסיסמה הזמנית שלך היא: " + locationManager.User.Password;
                    MailMessage message = new MailMessage(from, to, subject, body);
                    SmtpClient smtp = new SmtpClient();
                    smtp.Send(message);
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateAdministratorPassword(Administrator administrator)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(administrator.User.Password, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@AdministratorID", administrator.AdministratorID));
                cmd.Parameters.Add(new SqlParameter("@Password", encryptedPassword));
                cmd.CommandText = "spUpdateAdministratorPassword";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    string from = "orjerby@gmail.com";
                    string to = administrator.Email;
                    string subject = "סיסמה זמנית לאתר";
                    string body = "הסיסמה הזמנית שלך היא: " + administrator.User.Password;
                    MailMessage message = new MailMessage(from, to, subject, body);
                    SmtpClient smtp = new SmtpClient();
                    smtp.Send(message);
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateAdministratorPasswordFromSettingsPage(Administrator administrator, string currentPassword, string newPassword)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedCurrentPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(currentPassword, "SHA1");
                string encryptedNewPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(newPassword, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@AdministratorID", administrator.AdministratorID));
                cmd.Parameters.Add(new SqlParameter("@CurrentPassword", encryptedCurrentPassword));
                cmd.Parameters.Add(new SqlParameter("@NewPassword", encryptedNewPassword));
                cmd.CommandText = "spUpdateAdministratorPasswordFromSettingsPage";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static List<Course> GetCoursesByStudent(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetCoursesByStudent", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "Course";
                List<Course> courses = new List<Course>();
                foreach (DataRow dr in ds.Tables["Course"].Rows)
                {
                    Course course = new Course(int.Parse(dr["CourseID"].ToString()), dr["CourseName"].ToString());
                    courses.Add(course);
                }

                return courses;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static List<Course> GetCoursesByLecturer(Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetCoursesByLecturer", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "Course";
                List<Course> courses = new List<Course>();
                foreach (DataRow dr in ds.Tables["Course"].Rows)
                {
                    Course course = new Course(int.Parse(dr["CourseID"].ToString()), dr["CourseName"].ToString());
                    courses.Add(course);
                }

                return courses;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static object GetCourseDataByStudent(Student student, Course course)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@CourseID", course.CourseID));
                cmd.CommandText = "spGetCourseDataByStudent";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    int totalLectureCount = int.Parse(sdr["TotalLectureCount"].ToString());
                    int pastLectureCount = int.Parse(sdr["PastLectureCount"].ToString());
                    int futureLectureCount = int.Parse(sdr["FutureLectureCount"].ToString());
                    int missCount = int.Parse(sdr["MissCount"].ToString());
                    int lateCount = int.Parse(sdr["LateCount"].ToString());
                    int hereCount = int.Parse(sdr["HereCount"].ToString());
                    int justifyCount = int.Parse(sdr["JustifyCount"].ToString());
                    float missPercentage = float.Parse(sdr["MissPercentage"].ToString());
                    float latePercentage = float.Parse(sdr["LatePercentage"].ToString());
                    float herePercentage = float.Parse(sdr["HerePercentage"].ToString());
                    float justifyPercentage = float.Parse(sdr["JustifyPercentage"].ToString());

                    return new
                    {
                        CourseData = new
                        {
                            TotalLectureCount = totalLectureCount,
                            PastLectureCount = pastLectureCount,
                            FutureLectureCount = futureLectureCount,
                            MissCount = missCount,
                            LateCount = lateCount,
                            HereCount = hereCount,
                            JustifyCount = justifyCount,
                            MissPercentage = missPercentage,
                            LatePercentage = latePercentage,
                            HerePercentage = herePercentage,
                            JustifyPercentage = justifyPercentage
                        }
                    };
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static List<object> GetCourseDataByLecturer(Lecturer lecturer, Course course)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@CourseID", course.CourseID));
                cmd.CommandText = "spGetCourseDataByLecturer";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                List<object> CoursesData = new List<object>();
                do
                {
                    while (sdr.Read())
                    {
                        int totalLectureCount = int.Parse(sdr["TotalLectureCount"].ToString());
                        int pastLectureCount = int.Parse(sdr["PastLectureCount"].ToString());
                        int futureLectureCount = int.Parse(sdr["FutureLectureCount"].ToString());
                        int missCount = int.Parse(sdr["MissCount"].ToString());
                        int lateCount = int.Parse(sdr["LateCount"].ToString());
                        int hereCount = int.Parse(sdr["HereCount"].ToString());
                        int justifyCount = int.Parse(sdr["JustifyCount"].ToString());
                        float missPercentage = float.Parse(sdr["MissPercentage"].ToString());
                        float latePercentage = float.Parse(sdr["LatePercentage"].ToString());
                        float herePercentage = float.Parse(sdr["HerePercentage"].ToString());
                        float justifyPercentage = float.Parse(sdr["JustifyPercentage"].ToString());
                        Department department = new Department(int.Parse(sdr["DepartmentID"].ToString()), sdr["DepartmentName"].ToString());
                        Cycle cycle = new Cycle(int.Parse(sdr["CycleID"].ToString()), sdr["CycleName"].ToString());

                        CoursesData.Add(new
                        {
                            Department = new { department.DepartmentID, department.DepartmentName },
                            Cycle = new { cycle.CycleID, cycle.CycleName },
                            TotalLectureCount = totalLectureCount,
                            PastLectureCount = pastLectureCount,
                            FutureLectureCount = futureLectureCount,
                            MissCount = missCount,
                            LateCount = lateCount,
                            HereCount = hereCount,
                            JustifyCount = justifyCount,
                            MissPercentage = missPercentage,
                            LatePercentage = latePercentage,
                            HerePercentage = herePercentage,
                            JustifyPercentage = justifyPercentage
                        });
                        
                    }
                } while (sdr.NextResult());

                return CoursesData;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static bool UpdateStudentPassword(Student student, string currentPassword, string newPassword)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedCurrentPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(currentPassword, "SHA1");
                string encryptedNewPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(newPassword, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@CurrentPassword", encryptedCurrentPassword));
                cmd.Parameters.Add(new SqlParameter("@NewPassword", encryptedNewPassword));
                cmd.CommandText = "spUpdateStudentPassword";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateLecturerPassword(Lecturer lecturer, string currentPassword, string newPassword)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedCurrentPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(currentPassword, "SHA1");
                string encryptedNewPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(newPassword, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@CurrentPassword", encryptedCurrentPassword));
                cmd.Parameters.Add(new SqlParameter("@NewPassword", encryptedNewPassword));
                cmd.CommandText = "spUpdateLecturerPassword";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateLocationManagerPassword(LocationManager locationManager, string currentPassword, string newPassword)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                string encryptedCurrentPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(currentPassword, "SHA1");
                string encryptedNewPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(newPassword, "SHA1");
                cmd.Parameters.Add(new SqlParameter("@LocationManagerID", locationManager.LocationManagerID));
                cmd.Parameters.Add(new SqlParameter("@CurrentPassword", encryptedCurrentPassword));
                cmd.Parameters.Add(new SqlParameter("@NewPassword", encryptedNewPassword));
                cmd.CommandText = "spUpdateLocationManagerPassword";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateStudentEmail(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                cmd.Parameters.Add(new SqlParameter("@Email", student.Email));
                cmd.CommandText = "spUpdateStudentEmail";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateLecturerEmail(Lecturer lecturer)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@LecturerID", lecturer.LecturerID));
                cmd.Parameters.Add(new SqlParameter("@Email", lecturer.Email));
                cmd.CommandText = "spUpdateLecturerEmail";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static bool UpdateLocationManagerEmail(LocationManager locationManager)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@LocationManagerID", locationManager.LocationManagerID));
                cmd.Parameters.Add(new SqlParameter("@Email", locationManager.Email));
                cmd.CommandText = "spUpdateLocationManagerEmail";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    return true;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
            return false;
        }

        public static List<Class> GetClassesByLocationManager()
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetClassesByLocationManager", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "Class";
                List<Class> classes = new List<Class>();
                foreach (DataRow dr in ds.Tables["Class"].Rows)
                {
                    Class class1 = new Class(int.Parse(dr["ClassID"].ToString()), dr["ClassName"].ToString(), dr["Longitude"].ToString() == "" ? 0 : double.Parse(dr["Longitude"].ToString()), dr["Latitude"].ToString() == "" ? 0 : double.Parse(dr["Latitude"].ToString()), dr["LastLocationUpdate"].ToString() == "" ? DateTime.MinValue : DateTime.Parse(dr["LastLocationUpdate"].ToString()));
                    classes.Add(class1);
                }

                return classes;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static Class UpdateClassLocation(Class class1)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new SqlParameter("@ClassID", class1.ClassID));
                cmd.Parameters.Add(new SqlParameter("@Longitude", class1.Longitude));
                cmd.Parameters.Add(new SqlParameter("@Latitude", class1.Latitude));
                cmd.CommandText = "spUpdateClassLocation";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                class1 = null;
                if (sdr.Read())
                {
                    class1 = new Class(int.Parse(sdr["ClassID"].ToString()), sdr["ClassName"].ToString(), double.Parse(sdr["Longitude"].ToString()), double.Parse(sdr["Latitude"].ToString()), sdr["LastLocationUpdate"].ToString() == "" ? DateTime.MinValue : DateTime.Parse(sdr["LastLocationUpdate"].ToString()));
                    return class1;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return null;
        }

        public static bool AcceptForm(Form form)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@FormID", form.FormID));
                cmd.CommandText = "spAcceptForm";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    string token = sdr["Token"].ToString();
                    if (token != "")
                    {
                        Letter letter = new Letter(token, "עודכן סטטוס הבקשה שלך", "הבקשה אושרה");
                        lettersToSend.Add(letter);
                        sendNotificationsTimer.Enabled = true;
                        sendNotificationsTimer.Interval = 150;
                        sendNotificationsTimer.Elapsed += SendNotifications;
                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return false;
        }

        public static bool DeclineForm(Form form)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add(new SqlParameter("@FormID", form.FormID));
                cmd.CommandText = "spDeclineForm";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    string token = sdr["Token"].ToString();
                    if (token != "")
                    {
                        Letter letter = new Letter(token, "עודכן סטטוס הבקשה שלך", "הבקשה סורבה");
                        lettersToSend.Add(letter);
                        sendNotificationsTimer.Enabled = true;
                        sendNotificationsTimer.Interval = 150;
                        sendNotificationsTimer.Elapsed += SendNotifications;
                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return false;
        }

        public static int GetNumberOfWaitingForms()
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                cmd.CommandText = "spGetNumberOfWaitingForms";
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                sdr = cmd.ExecuteReader();
                if (sdr.Read())
                {
                    int waitingFormsCount = int.Parse(sdr["FormsCount"].ToString());
                    return waitingFormsCount;
                }
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    sdr.Close();
                    con.Close();
                }
            }
            return -1;
        }

        public static List<Form> GetFormsByStudent(Student student)
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(CS);
                SqlCommand cmd = new SqlCommand
                {
                    Connection = con,
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter sda = new SqlDataAdapter("spGetFormsByStudent", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.Add(new SqlParameter("@StudentID", student.StudentID));
                DataSet ds = new DataSet();
                sda.Fill(ds);
                ds.Tables[0].TableName = "Form";
                student = null;
                List<Form> forms = new List<Form>();
                foreach (DataRow dr in ds.Tables["Form"].Rows)
                {
                    student = new Student(int.Parse(dr["StudentID"].ToString()));
                    FormStatus formStatus = new FormStatus(int.Parse(dr["FormStatusID"].ToString()), dr["FormStatusName"].ToString());
                    string picture = ConfigurationManager.AppSettings["FormsImagesPath"] + dr["Picture"].ToString();
                    Form form = new Form(int.Parse(dr["FormID"].ToString()), student, DateTime.Parse(dr["OpenDate"].ToString()), DateTime.Parse(dr["EndDate"].ToString()), picture, formStatus);
                    forms.Add(form);
                }
                return forms;
            }
            catch (Exception e)
            {
                e.Message.ToString();
            }
            return null;
        }

        public static Form AddForm(Form form, string pictureName, string pictureBase64)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            using (TransactionScope tran = new TransactionScope())
            {
                try
                {
                    //string ImgName = form.Picture;
                    string path = HttpContext.Current.Server.MapPath($"~/Images/Forms/"); //Path
                    //set the image path
                    string imgPath = Path.Combine(path, pictureName);
                    byte[] imageBytes = Convert.FromBase64String(pictureBase64);

                    using (Image image = Image.FromStream(new MemoryStream(imageBytes)))
                    {
                        image.Save(imgPath, ImageFormat.Jpeg);
                    }

                    // string picture = ConfigurationManager.AppSettings["FormsImagesPath"] + pictureName;
                    
                    con = new SqlConnection(CS);
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@StudentID", form.Student.StudentID));
                    cmd.Parameters.Add(new SqlParameter("@OpenDate", form.OpenDate));
                    cmd.Parameters.Add(new SqlParameter("@EndDate", form.EndDate));
                    cmd.Parameters.Add(new SqlParameter("@Picture", pictureName));
                    cmd.CommandText = "spAddForm";
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    sdr = cmd.ExecuteReader();
                    form = null;
                    if (sdr.Read())
                    {
                        Student student = new Student(int.Parse(sdr["StudentID"].ToString()));
                        FormStatus formStatus = new FormStatus(int.Parse(sdr["FormStatusID"].ToString()), sdr["FormStatusName"].ToString());
                        string picture = ConfigurationManager.AppSettings["FormsImagesPath"] + sdr["Picture"].ToString();
                        form = new Form(int.Parse(sdr["FormID"].ToString()), student, DateTime.Parse(sdr["OpenDate"].ToString()), DateTime.Parse(sdr["EndDate"].ToString()), picture, formStatus);
                        tran.Complete();
                        return form;
                    }
                }
                catch (Exception e)
                {
                    e.Message.ToString();
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                    {
                        sdr.Close();
                        con.Close();
                    }
                }
                return null;
            }
        }

        public static bool DeleteForm(Form form)
        {
            SqlConnection con = null;
            SqlDataReader sdr = null;
            using (TransactionScope tran = new TransactionScope())
            {
                try
                {
                    con = new SqlConnection(CS);
                    SqlCommand cmd = new SqlCommand
                    {
                        Connection = con,
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@FormID", form.FormID));
                    cmd.CommandText = "spDeleteForm";
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }
                    sdr = cmd.ExecuteReader();
                    form = null;
                    string picture = null;
                    if (sdr.Read())
                    {
                        picture = sdr["Picture"].ToString();
                    }
                    if (picture != null)
                    {
                        // string path = ConfigurationManager.AppSettings["FormsImagesPath"];
                        // int pathLength = path.Length;
                        // string pictureName = picture.Substring(pathLength);
                        if (File.Exists(HttpContext.Current.Server.MapPath($"~/Images/Forms/" + picture)))
                        {
                            File.Delete(HttpContext.Current.Server.MapPath($"~/Images/Forms/" + picture));
                        }
                        tran.Complete();
                        return true;
                    }
                }
                catch (Exception e)
                {
                    e.Message.ToString();
                }
                finally
                {
                    if (con.State == ConnectionState.Open)
                    {
                        sdr.Close();
                        con.Close();
                    }
                }
                return false;
            }
        }

        static public void SendNotifications(object sender, EventArgs e)
        {
            if (lettersToSend.Count > 0)
            {
                Letter letterToSend = lettersToSend[0];
                lettersToSend.RemoveAt(0);
                ExpoPushHelper.SendPushNotification(letterToSend.Token, letterToSend.Title, letterToSend.Body);
            }
            else
            {
                sendNotificationsTimer.Enabled = false;
            }

        }

    }

}
