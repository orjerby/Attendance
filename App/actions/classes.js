import {
  setConnectionMessage,
  setFetchingMessage,
  setUpdatingMessage
} from "./messages";
import { Location } from "expo";
import { fetchData, WebServiceURL } from "../configuration";

export const setClasses = classesObject => ({
  type: "SET_CLASSES",
  classesObject
});

export const unsetClasses = () => ({
  type: "UNSET_CLASSES"
});

export const startSetClasses = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetClassesByLocationManager`, paramsObj)
      .then(data => {
        const classesObject = JSON.parse(data);
        dispatch(setClasses(classesObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const updateClassLocation = classObject => ({
  type: "UPDATE_CLASS_LOCATION",
  classObject
});

export const unsetUpdateClassMessage = () => ({
  type: "UNSET_UPDATE_CLASS_MESSAGE"
});

export const startUpdateClassLocation = classID => {
  return async dispatch => {
    dispatch(setUpdatingMessage());
    const location = await Location.getCurrentPositionAsync({
      enableHighAccuracy: true
    });
    const paramsObj = {
      classID: classID,
      longitude: location.coords.longitude,
      latitude: location.coords.latitude
    };
    fetchData(`${WebServiceURL}UpdateClassLocation`, paramsObj)
      .then(data => {
        const classObject = JSON.parse(data);
        dispatch(updateClassLocation(classObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
