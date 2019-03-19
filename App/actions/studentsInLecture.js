import {
  setConnectionMessage,
  setFetchingMessage,
  setUpdatingMessage
} from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const setStudentsInLecture = (studentsInLectureObject, lectureID) => ({
  type: "SET_STUDENTS_IN_LECTURE",
  studentsInLectureObject,
  lectureID
});

export const unsetStudentsInLecture = () => ({
  type: "UNSET_STUDENTS_IN_LECTURE"
});

export const startSetStudentsInLectureByLecture = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetStudentsInLectureByLecture`, paramsObj)
      .then(data => {
        const studentsInLectureObject = JSON.parse(data);
        dispatch(
          setStudentsInLecture(studentsInLectureObject, paramsObj.lectureID)
        );
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const updateStatusOfStudentByLecturer = (statusObject, studentID) => ({
  type: "UPDATE_STATUS_OF_STUDENT_BY_LECTURER",
  statusObject,
  studentID
});

export const startUpdateStatusOfStudentByLecturer = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}UpdateStatusOfStudent`, paramsObj)
      .then(data => {
        const statusObject = JSON.parse(data);
        dispatch(
          updateStatusOfStudentByLecturer(statusObject, paramsObj.studentID)
        );
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
