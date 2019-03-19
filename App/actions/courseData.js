import { setConnectionMessage, setFetchingMessage } from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const setCourseData = courseDataObject => ({
  type: "SET_COURSE_DATA",
  courseDataObject
});

export const unsetCourseData = () => ({
  type: "UNSET_COURSE_DATA"
});

export const startSetCourseDataByStudent = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetCourseDataByStudent`, paramsObj)
      .then(data => {
        const courseDataObject = JSON.parse(data);
        dispatch(setCourseData(courseDataObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const startSetCourseDataByLecturer = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetCourseDataByLecturer`, paramsObj)
      .then(data => {
        const courseDataObject = JSON.parse(data);
        dispatch(setCourseData(courseDataObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
