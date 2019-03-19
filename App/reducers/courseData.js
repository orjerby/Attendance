export default (state = { CourseData: null }, action) => {
  switch (action.type) {
    case "SET_COURSE_DATA":
      return {
        CourseData: action.courseDataObject.CourseData
      };
    case "SET_NEXT_LECTURE":
      return {
        CourseData: action.nextLectureObject.CourseData
      };
    case "SET_NEXT_LECTURE_FIRST_TIME":
      return {
        CourseData: action.nextLectureObject.CourseData
      };
    case "UNSET_COURSE_DATA":
      return {
        CourseData: null
      };
    default:
      return state;
  }
};
