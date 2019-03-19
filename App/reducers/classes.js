export default (state = { Class: null }, action) => {
  switch (action.type) {
    case "SET_CLASSES":
      return action.classesObject;
    case "UNSET_CLASSES":
      return {
        Class: null
      };
    case "UPDATE_CLASS_LOCATION":
      const oldClasses = state.Class.map(class1 => {
        if (class1.ClassID === action.classObject.Class.ClassID) {
          return action.classObject.Class;
        } else {
          return class1;
        }
      });
      return {
        Class: oldClasses
      };
    default:
      return state;
  }
};
