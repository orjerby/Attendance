export default (state = { Lecture: null }, action) => {
  switch (action.type) {
    case "SET_STUDENTS_IN_LECTURE":
      return {
        ...action.studentsInLectureObject,
        isReady: true
      };
    case "UNSET_STUDENTS_IN_LECTURE":
      return {
        Lecture: null
      };
    case "UPDATE_STATUS_OF_STUDENT_BY_LECTURER":
      const updatedStudents = state.StudentsInLecture.map(studentInLecture => {
        // check if lecture is disabled and update it
        if (studentInLecture.Student.StudentID === action.studentID) {
          return {
            ...studentInLecture,
            Status: action.statusObject.Status
          };
        } else {
          return studentInLecture;
        }
      });
      return {
        Lecture: state.Lecture,
        StudentsInLecture: updatedStudents,
        StatusCount: action.statusObject.StatusCount
      };
    case "UPDATE_LECTURE_CANCEL":
      return {
        ...state,
        Lecture: {
          ...state.Lecture,
          IsCanceled: action.isCanceledObject.IsCanceled
        }
      };
    default:
      return state;
  }
};
