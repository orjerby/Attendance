import { setConnectionMessage, setUpdatingMessage } from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const setUser = userObject => ({
  type: "SET_USER",
  userObject
});

export const unsetUser = () => ({
  type: "UNSET_USER"
});

export const startSetLecturer = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}ValidateLecturer`, paramsObj)
      .then(data => {
        const userObject = JSON.parse(data);
        dispatch(setUser(userObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetStudent = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}ValidateStudent`, paramsObj)
      .then(data => {
        const userObject = JSON.parse(data);
        dispatch(setUser(userObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetLocationManager = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}ValidateLocationManager`, paramsObj)
      .then(data => {
        const userObject = JSON.parse(data);
        dispatch(setUser(userObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const setToken = token => ({
  type: "SET_TOKEN",
  token
});

export const updateLecturerQRMode = qRModeObject => ({
  type: "UPDATE_LECTURER_QRMODE",
  qRModeObject
});

export const startUpdateLecturerQRMode = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateLecturerQRMode`, paramsObj)
      .then(data => {
        const qRModeObject = JSON.parse(data);
        dispatch(updateLecturerQRMode(qRModeObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const updatePassword = isOkObject => ({
  type: "UPDATE_PASSWORD",
  isOkObject
});

export const startUpdateStudentPassword = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateStudentPassword`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(updatePassword(isOkObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startUpdateLecturerPassword = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateLecturerPassword`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(updatePassword(isOkObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startUpdateLocationManagerPassword = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateLocationManagerPassword`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(updatePassword(isOkObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const updateEmail = (isOkObject, email) => ({
  type: "UPDATE_EMAIL",
  isOkObject,
  email
});

export const startUpdateStudentEmail = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateStudentEmail`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(updateEmail(isOkObject, paramsObj.email));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startUpdateLecturerEmail = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateLecturerEmail`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(updateEmail(isOkObject, paramsObj.email));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startUpdateLocationManagerEmail = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateLocationManagerEmail`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(updateEmail(isOkObject, paramsObj.email));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
