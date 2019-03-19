export default (state = { Lecture: null }, action) => {
  switch (action.type) {
    case "UNSET_LECTURES":
      return {
        Lecture: null
      };
    case "SET_LECTURES_BY_DATE_FOR_STUDENT":
      return {
        ...action.studentInLecturesObject
      };
    case "SET_LECTURES_BY_DATE_FOR_LECTURER":
      return {
        ...action.lecturesObject
      };
    case "UPDATE_LECTURE_CANCEL":
      const updatedLectures2 = state.Lecture.map(lecture => {
        if (lecture.LectureID === action.lectureID) {
          return {
            ...lecture,
            IsCanceled: action.isCanceledObject.IsCanceled
          };
        } else {
          return lecture;
        }
      });
      return {
        Lecture: updatedLectures2
      };
    default:
      return state;
  }
};
