import { setConnectionMessage, setFetchingMessage } from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const unsetNextLecture = () => ({
  type: "UNSET_NEXT_LECTURE"
});

export const setNextLecture = nextLectureObject => ({
  type: "SET_NEXT_LECTURE",
  nextLectureObject
});

export const setNextLectureFirstTime = nextLectureObject => ({
  type: "SET_NEXT_LECTURE_FIRST_TIME",
  nextLectureObject
});

export const startSetNextLectureByLecturer = paramsObj => {
  return dispatch => {
    fetchData(`${WebServiceURL}GetNextLectureByLecturer`, paramsObj)
      .then(data => {
        const nextLectureObject = JSON.parse(data);
        dispatch(setNextLecture(nextLectureObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetNextLectureByLecturerFirstTime = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetNextLectureByLecturer`, paramsObj)
      .then(data => {
        const nextLectureObject = JSON.parse(data);
        dispatch(setNextLectureFirstTime(nextLectureObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetNextLectureByStudent = paramsObj => {
  return dispatch => {
    fetchData(`${WebServiceURL}GetNextLectureByStudent`, paramsObj)
      .then(data => {
        const nextLectureObject = JSON.parse(data);
        dispatch(setNextLecture(nextLectureObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetNextLectureByStudentFirstTime = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetNextLectureByStudent`, paramsObj)
      .then(data => {
        const nextLectureObject = JSON.parse(data);
        dispatch(setNextLectureFirstTime(nextLectureObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const fireTimer = studentsInLectureObject => ({
  type: "FIRE_TIMER",
  studentsInLectureObject
});

export const unsetFireTimerMessage = () => ({
  type: "UNSET_FIRE_TIMER_MESSAGE"
});

export const startFireTimer = paramsObj => {
  return dispatch => {
    fetchData(`${WebServiceURL}FireTimer`, paramsObj)
      .then(data => {
        const studentsInLectureObject = JSON.parse(data);
        dispatch(fireTimer(studentsInLectureObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const UpdateStatusOfStudent = statusObject => ({
  type: "UPDATE_STATUS_OF_STUDENT",
  statusObject
});

export const startUpdateStatusOfStudentByTimer = paramsObj => {
  return dispatch => {
    fetchData(`${WebServiceURL}UpdateStatusOfStudentByTimer`, paramsObj)
      .then(data => {
        const statusObject = JSON.parse(data);
        dispatch(UpdateStatusOfStudent(statusObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startUpdateStatusOfStudent = paramsObj => {
  return dispatch => {
    fetchData(`${WebServiceURL}UpdateStatusOfStudent`, paramsObj)
      .then(data => {
        const statusObject = JSON.parse(data);
        dispatch(UpdateStatusOfStudent(statusObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
