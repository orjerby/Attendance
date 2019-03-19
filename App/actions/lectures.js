import {
  setConnectionMessage,
  setFetchingMessage,
  setUpdatingMessage
} from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const unsetLectures = () => ({
  type: "UNSET_LECTURES"
});

export const setLecturesByDateForLecturer = (lecturesObject, lectureDate) => ({
  type: "SET_LECTURES_BY_DATE_FOR_LECTURER",
  lecturesObject,
  lectureDate
});

export const setLecturesByDateForStudent = (
  studentInLecturesObject,
  lectureDate
) => ({
  type: "SET_LECTURES_BY_DATE_FOR_STUDENT",
  studentInLecturesObject,
  lectureDate
});

export const startSetLectureByLecturerAndDate = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetLecturesByLecturerAndDate`, paramsObj)
      .then(data => {
        const lecturesObject = JSON.parse(data);
        dispatch(
          setLecturesByDateForLecturer(lecturesObject, paramsObj.lectureDate)
        );
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetLectureByStudentAndDate = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetLecturesByStudentAndDate`, paramsObj)
      .then(data => {
        const studentInLecturesObject = JSON.parse(data);
        dispatch(
          setLecturesByDateForStudent(
            studentInLecturesObject,
            paramsObj.lectureDate
          )
        );
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const updateLectureCancel = (isCanceledObject, lectureID) => ({
  type: "UPDATE_LECTURE_CANCEL",
  isCanceledObject,
  lectureID
});

export const unsetUpdateLectureCancelMessage = () => ({
  type: "UNSET_UPDATE_LECTURE_CANCEL_MESSAGE"
});

export const startUpdateLectureCancel = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateLectureCancel`, paramsObj)
      .then(data => {
        const isCanceledObject = JSON.parse(data);
        dispatch(updateLectureCancel(isCanceledObject, paramsObj.lectureID));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
