import { createStore, combineReducers, applyMiddleware, compose } from "redux";
import thunk from "redux-thunk";
import lecturesReducer from "../reducers/lectures";
import nextLectureReducer from "../reducers/nextLecture";
import studentsInLectureReducer from "../reducers/studentsInLecture";
import userReducer from "../reducers/user";
import coursesReducer from "../reducers/courses";
import courseDataReducer from "../reducers/courseData";
import messagesReducer from "../reducers/messages";
import classesReducer from "../reducers/classes";
import formsReducer from "../reducers/forms";
import routesReducer from "../reducers/routes";
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

export default () => {
  const store = createStore(
    combineReducers({
      lectures: lecturesReducer,
      nextLecture: nextLectureReducer,
      studentsInLecture: studentsInLectureReducer,
      user: userReducer,
      courses: coursesReducer,
      courseData: courseDataReducer,
      messages: messagesReducer,
      classes: classesReducer,
      forms: formsReducer,
      routes: routesReducer
    }),
    composeEnhancers(applyMiddleware(thunk))
  );

  return store;
};
