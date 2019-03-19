export default (state = {}, action) => {
  switch (action.type) {
    case "SET_CONNECTION_MESSAGE":
      return {
        ...state,
        ConnectionError: true,
        Fetching: false,
        Updating: false
      };
    case "UNSET_CONNECTION_MESSAGE":
      return {
        ...state,
        ConnectionError: false
      };
    case "SET_FETCHING_MESSAGE":
      return {
        Fetching: true
      };
    case "SET_UPDATING_MESSAGE":
      return {
        Updating: true
      };
    case "SET_USER":
      if (action.userObject.User === null) {
        return {
          ...state,
          LoginError: true,
          Updating: false
        };
      } else {
        return {
          ...state,
          LoginError: false,
          Updating: false
        };
      }
    case "UNSET_USER_MESSAGE":
      return {
        ...state,
        LoginError: null
      };
    case "UPDATE_PASSWORD":
      if (action.isOkObject.IsOk) {
        return {
          ...state,
          UpdatePasswordError: false,
          Updating: false
        };
      } else {
        return {
          ...state,
          UpdatePasswordError: true,
          Updating: false
        };
      }
    case "UNSET_PASSWORD_MESSAGE":
      return {
        ...state,
        UpdatePasswordError: null
      };
    case "UPDATE_EMAIL":
      if (action.isOkObject.IsOk) {
        return {
          ...state,
          UpdateEmailError: false,
          Updating: false
        };
      } else {
        return {
          ...state,
          UpdateEmailError: true,
          Updating: false
        };
      }
    case "UNSET_EMAIL_MESSAGE":
      return {
        ...state,
        UpdateEmailError: null
      };
    case "SET_LOCATION_MESSAGE":
      return {
        ...state,
        LocationError: true
      };
    case "UNSET_LOCATION_MESSAGE":
      return {
        ...state,
        LocationError: null
      };
    case "SET_CAMERA_MESSAGE":
      return {
        ...state,
        CameraError: true
      };
    case "UNSET_CAMERA_MESSAGE":
      return {
        ...state,
        CameraError: null
      };
    case "SET_FORMS":
      return {
        ...state,
        Fetching: false
      };
    case "ADD_FORM":
      return {
        ...state,
        Updating: false
      };
    case "DELETE_FORM":
      return {
        ...state,
        Updating: false
      };
    case "UPDATE_CLASS_LOCATION":
      return {
        ...state,
        Updating: false
      };
    case "UPDATE_LECTURER_QRMODE":
      return {
        ...state,
        Updating: false
      };
    case "UPDATE_LECTURE_CANCEL":
      return {
        ...state,
        Updating: false
      };
    case "UPDATE_STATUS_OF_STUDENT_BY_LECTURER":
      return {
        ...state,
        Updating: false
      };
    case "SET_NEXT_LECTURE_FIRST_TIME":
      return {
        ...state,
        Fetching: false
      };
    case "SET_LECTURES_BY_DATE":
      return {
        ...state,
        Fetching: false
      };
    case "SET_COURSES":
      return {
        ...state,
        Fetching: false
      };
    case "SET_COURSE_DATA":
      return {
        ...state,
        Fetching: false
      };
    case "SET_CLASSES":
      return {
        ...state,
        Fetching: false
      };
    case "SET_STUDENTS_IN_LECTURE":
      return {
        ...state,
        Fetching: false
      };
    case "SET_LECTURES_BY_DATE_FOR_STUDENT":
      return {
        ...state,
        Fetching: false
      };
    case "SET_LECTURES_BY_DATE_FOR_LECTURER":
      return {
        ...state,
        Fetching: false
      };
    default:
      return state;
  }
};
