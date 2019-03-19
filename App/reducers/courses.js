export default (state = { Course: null }, action) => {
  switch (action.type) {
    case "SET_COURSES":
      return action.coursesObject;
    case "UNSET_COURSES":
      return {
        Course: null
      };
    default:
      return state;
  }
};
