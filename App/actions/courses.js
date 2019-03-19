import { setConnectionMessage, setFetchingMessage } from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const setCourses = coursesObject => ({
  type: "SET_COURSES",
  coursesObject
});

export const unsetCourses = () => ({
  type: "UNSET_COURSES"
});

export const startSetCoursesForStudent = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetCoursesByStudent`, paramsObj)
      .then(data => {
        const coursesObject = JSON.parse(data);
        dispatch(setCourses(coursesObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetCoursesForLecturer = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetCoursesByLecturer`, paramsObj)
      .then(data => {
        const coursesObject = JSON.parse(data);
        dispatch(setCourses(coursesObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
