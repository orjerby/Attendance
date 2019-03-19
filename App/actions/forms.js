import {
  setConnectionMessage,
  setFetchingMessage,
  setUpdatingMessage
} from "./messages";
import { fetchData, WebServiceURL } from "../configuration";

export const setForms = formsObject => ({
  type: "SET_FORMS",
  formsObject
});

export const unsetForms = () => ({
  type: "UNSET_FORMS"
});

export const startSetForms = paramsObj => {
  return dispatch => {
    dispatch(setFetchingMessage());
    fetchData(`${WebServiceURL}GetFormsByStudent`, paramsObj)
      .then(data => {
        const formsObject = JSON.parse(data);
        dispatch(setForms(formsObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const addForm = formObject => ({
  type: "ADD_FORM",
  formObject
});

export const unsetAddFormMessage = () => ({
  type: "UNSET_ADD_FORM_MESSAGE"
});

export const startAddForm = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}AddForm`, paramsObj)
      .then(data => {
        const formObject = JSON.parse(data);
        dispatch(addForm(formObject));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};

export const deleteForm = (isOkObject, formID) => ({
  type: "DELETE_FORM",
  isOkObject,
  formID
});

export const unsetDeleteFormMessage = () => ({
  type: "UNSET_DELETE_FORM_MESSAGE"
});

export const startDeleteForm = paramsObj => {
  return dispatch => {
    dispatch(setUpdatingMessage());
    fetchData(`${WebServiceURL}DeleteForm`, paramsObj)
      .then(data => {
        const isOkObject = JSON.parse(data);
        dispatch(deleteForm(isOkObject, paramsObj.formID));
      })
      .catch(() => {
        dispatch(setConnectionMessage());
      });
  };
};
