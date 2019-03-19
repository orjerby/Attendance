export default (state = { User: null }, action) => {
  switch (action.type) {
    case "SET_USER":
      if (action.userObject.User) {
        return {
          ...action.userObject
        };
      }
    case "UNSET_USER":
      return {
        User: null
      };
    case "UPDATE_LECTURER_QRMODE":
      return {
        ...state,
        Lecturer: {
          ...state.Lecturer,
          QRMode: action.qRModeObject.QRMode
        }
      };
    case "UPDATE_EMAIL":
      if (action.isOkObject.IsOk) {
        if (state.Lecturer) {
          return {
            ...state,
            Lecturer: {
              ...state.Lecturer,
              Email: action.email
            }
          };
        }
        if (state.Student) {
          return {
            ...state,
            Student: {
              ...state.Student,
              Email: action.email
            }
          };
        }
        if (state.LocationManager) {
          return {
            ...state,
            LocationManager: {
              ...state.LocationManager,
              Email: action.email
            }
          };
        }
      }
    default:
      return state;
  }
};
