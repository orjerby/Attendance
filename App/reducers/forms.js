export default (state = { Form: null }, action) => {
  switch (action.type) {
    case "SET_FORMS":
      return action.formsObject;
    case "UNSET_FORMS":
      return {
        Form: null
      };
    case "ADD_FORM":
      return {
        Form: [action.formObject.Form, ...state.Form]
      };
    case "DELETE_FORM":
      if (action.isOkObject.IsOk) {
        return {
          Form: state.Form.filter(({ FormID }) => FormID !== action.formID)
        };
      }
    default:
      return state;
  }
};
