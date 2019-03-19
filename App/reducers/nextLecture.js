export default (state = { Lecture: null, StudentsInLecture: [] }, action) => {
  switch (action.type) {
    case "UNSET_NEXT_LECTURE":
      return {
        Lecture: null,
        StudentsInLecture: []
      };
    case "SET_NEXT_LECTURE_FIRST_TIME":
      return {
        ...action.nextLectureObject
      };
    case "SET_NEXT_LECTURE":
      return {
        ...action.nextLectureObject
      };
    case "FIRE_TIMER":
      const updatedStudents = state.StudentsInLecture.map(studentInLecture => {
        // check if lecture is disabled and update it
        return {
          Student: studentInLecture.Student,
          Status: action.studentsInLectureObject.StudentsInLecture.Status
        };
      });
      return {
        Lecture: {
          ...state.Lecture,
          TimerRemaining: action.studentsInLectureObject.Lecture.TimerLong
        },
        StatusCount: state.StatusCount,
        StudentsInLecture: updatedStudents
      };
    case "UPDATE_STATUS_OF_STUDENT":
      return {
        Lecture: {
          ...state.Lecture
        },
        StudentsInLecture: {
          Status: action.statusObject.Status
        }
      };
    default:
      return state;
  }
};
