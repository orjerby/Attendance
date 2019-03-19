using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BEL;
using DAL;

namespace BAL
{
    public class Operations
    {
        public static int DeleteLecturesInSemester(LecturesInSemester lecturesInSemester)
        {
            return DBConnections.DeleteLecturesInSemester(lecturesInSemester);
        }

        public static int DeleteStudentInLecture(StudentsInLecture studentsInLecture)
        {
            return DBConnections.DeleteStudentInLecture(studentsInLecture);
        }

        public static int UpdateStudentInLecture(StudentsInLecture studentsInLecture)
        {
            return DBConnections.UpdateStudentInLecture(studentsInLecture);
        }

        public static string UpdateLectureTry(Lecture lecture)
        {
            return DBConnections.UpdateLectureTry(lecture);
        }

        public static int DeleteLecture(Lecture lecture)
        {
            return DBConnections.DeleteLecture(lecture);
        }

        public static Administrator ValidateAdministrator(Administrator administrator)
        {
            return DBConnections.ValidateAdministrator(administrator);
        }

        public static int DeleteLecturerHard(Lecturer lecturer)
        {
            return DBConnections.DeleteLecturerHard(lecturer);
        }

        public static int DeleteLecturerSoft(Lecturer lecturer)
        {
            return DBConnections.DeleteLecturerSoft(lecturer);
        }

        public static int DeleteClassHard(Class class1)
        {
            return DBConnections.DeleteClassHard(class1);
        }

        public static int DeleteClassSoft(Class class1)
        {
            return DBConnections.DeleteClassSoft(class1);
        }

        public static int DeleteDepartmentHard(Department department)
        {
            return DBConnections.DeleteDepartmentHard(department);
        }

        public static int DeleteDepartmentSoft(Department department)
        {
            return DBConnections.DeleteDepartmentSoft(department);
        }

        public static int DeleteCourseHard(Course course)
        {
            return DBConnections.DeleteCourseHard(course);
        }

        public static int DeleteCourseSoft(Course course)
        {
            return DBConnections.DeleteCourseSoft(course);
        }

        public static int DeleteCycleHard(Cycle cycle)
        {
            return DBConnections.DeleteCycleHard(cycle);
        }

        public static int DeleteCycleSoft(Cycle cycle)
        {
            return DBConnections.DeleteCycleSoft(cycle);
        }

        public static string CheckAddLecturesInSemester(LecturesInSemester lecturesInSemester)
        {
            return DBConnections.CheckAddLecturesInSemester(lecturesInSemester);
        }

        public static string AddLecturesInSemesterTry(LecturesInSemester lecturesInSemester)
        {
            return DBConnections.AddLecturesInSemesterTry(lecturesInSemester);
        }

        public static int AddLecturesInSemester(LecturesInSemester lecturesInSemester)
        {
            return DBConnections.AddLecturesInSemester(lecturesInSemester);
        }

        public static string CheckAddLecture(Lecture lecture)
        {
            return DBConnections.CheckAddLecture(lecture);
        }

        public static string AddLectureTry(Lecture lecture)
        {
            return DBConnections.AddLectureTry(lecture);
        }

        public static int UpdateStudent(Student student)
        {
            return DBConnections.UpdateStudent(student);
        }

        public static string UpdateStudentTry(Student student)
        {
            return DBConnections.UpdateStudentTry(student);
        }

        public static int UpdateCourseOfStudent(CoursesOfStudent coursesOfStudent, Cycle oldCycle)
        {
            return DBConnections.UpdateCourseOfStudent(coursesOfStudent, oldCycle);
        }

        public static int ReplaceDepartmentsOfCourse(Course course, string listOfDepartments)
        {
            return DBConnections.ReplaceDepartmentsOfCourse(course, listOfDepartments);
        }

        public static int ReplaceCoursesOfDepartment(string listOfCourses, Department department)
        {
            return DBConnections.ReplaceCoursesOfDepartment(listOfCourses, department);
        }

        public static int ReplaceLecturersOfCourse(Course course, string listOfLecturers)
        {
            return DBConnections.ReplaceLecturersOfCourse(course, listOfLecturers);
        }

        public static int ReplaceCoursesOfLecturer(string listOfCourses, Lecturer lecturer)
        {
            return DBConnections.ReplaceCoursesOfLecturer(listOfCourses, lecturer);
        }

        public static int ReplaceDepartmentsOfCycle(Cycle cycle, string listOfDepartments)
        {
            return DBConnections.ReplaceDepartmentsOfCycle(cycle, listOfDepartments);
        }

        public static int ReplaceCyclesOfDepartment(string listOfCycles, Department department)
        {
            return DBConnections.ReplaceCyclesOfDepartment(listOfCycles, department);
        }
        
        public static Lecturer ValidateLecturer(int lecturerID, string password, string token)
        {
            return DBConnections.ValidateLecturer(lecturerID, password, token);
        }

        public static Student ValidateStudent(int studentID, string password, string token)
        {
            return DBConnections.ValidateStudent(studentID, password, token);
        }

        public static LocationManager ValidateLocationManager(int locationManagerID, string password, string token)
        {
            return DBConnections.ValidateLocationManager(locationManagerID, password, token);
        }

        public static object GetNextLectureByLecturer(Lecturer lecturer)
        {
            return DBConnections.GetNextLectureByLecturer(lecturer);
        }

        public static object GetNextLectureByStudent(Student student)
        {
            return DBConnections.GetNextLectureByStudent(student);
        }

        public static List<Lecture> GetLecturesByLecturerAndDate(Lecturer lecturer, Lecture lecture)
        {
            return DBConnections.GetLecturesByLecturerAndDate(lecturer, lecture);
        }

        public static List<StudentsInLecture> GetLecturesByStudentAndDate(Student student, Lecture lecture)
        {
            return DBConnections.GetLecturesByStudentAndDate(student, lecture);
        }

        public static object GetStudentsInLectureByLecture(Lecture lecture)
        {
            return DBConnections.GetStudentsInLectureByLecture(lecture);
        }

        public static object FireTimer(Lecture lecture)
        {
            return DBConnections.FireTimer(lecture);
        }
        
        public static Status UpdateStatusOfStudentByTimer(StudentsInLecture studentInLecture)
        {
            return DBConnections.UpdateStatusOfStudentByTimer(studentInLecture);
        }

        public static object UpdateStatusOfStudent(StudentsInLecture studentInLecture)
        {
            return DBConnections.UpdateStatusOfStudent(studentInLecture);
        }

        public static List<Letter> CheckUpcommingLectures()
        {
            return DBConnections.CheckUpcommingLectures();
        }

        public static Lecture UpdateLectureCancel(Lecture lecture)
        {
            return DBConnections.UpdateLectureCancel(lecture);
        }

        public static bool UpdateLecturerQRMode(Lecturer lecturer)
        {
            return DBConnections.UpdateLecturerQRMode(lecturer);
        }

        public static bool UpdateStudentPasswordForAdministrator(Student student)
        {
            return DBConnections.UpdateStudentPasswordForAdministrator(student);
        }

        public static bool UpdateLecturerPasswordForAdministrator(Lecturer lecturer)
        {
            return DBConnections.UpdateLecturerPasswordForAdministrator(lecturer);
        }

        public static bool UpdateLocationManagerPasswordForAdministrator(LocationManager locationManager)
        {
            return DBConnections.UpdateLocationManagerPasswordForAdministrator(locationManager);
        }

        public static bool UpdateAdministratorPassword(Administrator administrator)
        {
            return DBConnections.UpdateAdministratorPassword(administrator);
        }

        public static bool UpdateAdministratorPasswordFromSettingsPage(Administrator administrator, string currentPassword, string newPassword)
        {
            return DBConnections.UpdateAdministratorPasswordFromSettingsPage(administrator, currentPassword, newPassword);
        }

        public static List<Course> GetCoursesByStudent(Student student)
        {
            return DBConnections.GetCoursesByStudent(student);
        }

        public static List<Course> GetCoursesByLecturer(Lecturer lecturer)
        {
            return DBConnections.GetCoursesByLecturer(lecturer);
        }

        public static object GetCourseDataByStudent(Student student, Course course)
        {
            return DBConnections.GetCourseDataByStudent(student, course);
        }

        public static List<object> GetCourseDataByLecturer(Lecturer lecturer, Course course)
        {
            return DBConnections.GetCourseDataByLecturer(lecturer, course);
        }

        public static bool UpdateStudentPassword(Student student, string currentPassword, string newPassword)
        {
            return DBConnections.UpdateStudentPassword(student, currentPassword, newPassword);
        }

        public static bool UpdateLecturerPassword(Lecturer lecturer, string currentPassword, string newPassword)
        {
            return DBConnections.UpdateLecturerPassword(lecturer, currentPassword, newPassword);
        }

        public static bool UpdateLocationManagerPassword(LocationManager locationManager, string currentPassword, string newPassword)
        {
            return DBConnections.UpdateLocationManagerPassword(locationManager, currentPassword, newPassword);
        }

        public static bool UpdateStudentEmail(Student student)
        {
            return DBConnections.UpdateStudentEmail(student);
        }

        public static bool UpdateLecturerEmail(Lecturer lecturer)
        {
            return DBConnections.UpdateLecturerEmail(lecturer);
        }

        public static bool UpdateLocationManagerEmail(LocationManager locationManager)
        {
            return DBConnections.UpdateLocationManagerEmail(locationManager);
        }

        public static List<Class> GetClassesByLocationManager()
        {
            return DBConnections.GetClassesByLocationManager();
        }

        public static Class UpdateClassLocation(Class class1)
        {
            return DBConnections.UpdateClassLocation(class1);
        }

        public static bool AcceptForm(Form form)
        {
            return DBConnections.AcceptForm(form);
        }

        public static bool DeclineForm(Form form)
        {
            return DBConnections.DeclineForm(form);
        }

        public static int GetNumberOfWaitingForms()
        {
            return DBConnections.GetNumberOfWaitingForms();
        }

        public static List<Form> GetFormsByStudent(Student student)
        {
            return DBConnections.GetFormsByStudent(student);
        }

        public static Form AddForm(Form form, string pictureName, string pictureBase64)
        {
            return DBConnections.AddForm(form, pictureName, pictureBase64);
        }

        public static bool DeleteForm(Form form)
        {
            return DBConnections.DeleteForm(form);
        }
    }
}