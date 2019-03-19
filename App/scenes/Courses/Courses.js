import React from "react";
import { connect } from "react-redux";
import {
  View,
  ActivityIndicator,
  Dimensions,
  ScrollView,
  StatusBar
} from "react-native";
import {
  startSetCoursesForLecturer,
  startSetCoursesForStudent,
  unsetCourses
} from "../../actions/courses";
import {
  startSetCourseDataByLecturer,
  startSetCourseDataByStudent,
  unsetCourseData
} from "../../actions/courseData";
import { unsetConnectionMessage } from "../../actions/messages";
import { SearchBar } from "react-native-elements";
import { LECTURER, STUDENT } from "../../configuration";
import CourseDataModal from "./components/CourseDataModal";
import CourseList from "./components/CourseList";
import Message from "../components/Message";

var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

class Courses extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      query: null,
      filteredCourses: [],
      courseModalVisible: false,
      chosenCourse: null
    };
  }

  componentWillUnmount = () => {
    this.props.unsetCourses();
    this.props.unsetConnectionMessage();
  };

  componentDidMount = () => {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {}
    } = this.props.userObject;
    const {
      navigation: { state: { params: { screenIsActive } = {} } = {} } = {}
    } = this.props;

    if (screenIsActive) {
      if (RoleID === LECTURER) {
        this.props.startSetCoursesForLecturer({ lecturerID: LecturerID });
      } else if (RoleID === STUDENT) {
        this.props.startSetCoursesForStudent({ studentID: StudentID });
      }
    }
  };

  handleOnChangeText = query => {
    const { Course } = this.props.coursesObject;

    let filteredCourses = [];
    if (Course) {
      filteredCourses = Course.filter(course => {
        return course.CourseName.toLowerCase().includes(query.toLowerCase());
      });
      if (!query) {
        filteredCourses = Course;
      }
    }
    this.setState({ query, filteredCourses });
  };

  handleBackCourseDataModal = () => {
    this.setState({ courseModalVisible: false, chosenCourse: null });
    this.props.unsetConnectionMessage();
    this.props.unsetCourseData();
  };

  handleSelectCourse = ({ CourseID, CourseName }) => {
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {},
      User: { Role: { RoleID } = {} } = {}
    } = this.props.userObject;
    this.props.unsetCourseData();
    this.setState({ courseModalVisible: true, chosenCourse: CourseName });
    if (RoleID === LECTURER) {
      this.props.startSetCourseDataByLecturer({
        lecturerID: LecturerID,
        courseID: CourseID
      });
    } else if (RoleID === STUDENT) {
      this.props.startSetCourseDataByStudent({
        studentID: StudentID,
        courseID: CourseID
      });
    }
  };

  handleCloseConnectionMessage = () => {
    this.props.unsetConnectionMessage();
  };

  render() {
    const { ConnectionError, Fetching } = this.props.messagesObject;
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {},
      User: { Role: { RoleID } = {} } = {}
    } = this.props.userObject;
    const { filteredCourses } = this.state;
    const { CourseData } = this.props.courseDataObject;
    const {
      navigation: {
        state: { params: { screenIsActive = true } = {} } = {}
      } = {}
    } = this.props;
    if (!screenIsActive) {
      return <View />;
    } else {
      return (
        <View style={{ flex: 1, backgroundColor: "#fff" }}>
          <StatusBar backgroundColor={"#15aaaa"} />

          <SearchBar
            round
            containerStyle={{
              backgroundColor: "#15aaaa",
              width: deviceWidth,
              height: 55,
              borderBottomColor: "#fff",
              borderBottomWidth: 0.5,
              alignItems: "center",
              borderTopWidth: 0
            }}
            inputStyle={{
              width: deviceWidth - 150,
              backgroundColor: "#18c1c1",
              color: "#fff"
            }}
            placeholderTextColor={"#fff"}
            textAlign="right"
            onChangeText={query => {
              this.handleOnChangeText(query);
            }}
            placeholder="חפש קורס..."
            noIcon
          />

          <ScrollView>
            <View style={{ marginBottom: 75 }}>
              <CourseList
                RoleID={RoleID}
                query={this.state.query}
                filteredCourses={filteredCourses}
                coursesObject={this.props.coursesObject}
                handleSelectCourse={this.handleSelectCourse}
                Fetching={Fetching}
              />
            </View>

            {this.state.courseModalVisible && (
              <CourseDataModal
                RoleID={RoleID}
                chosenCourse={this.state.chosenCourse}
                CourseData={CourseData}
                messagesObject={this.props.messagesObject}
                handleBack={this.handleBackCourseDataModal}
                handleCloseConnectionMessage={this.handleCloseConnectionMessage}
              />
            )}
          </ScrollView>

          {Fetching && (
            <View
              style={{
                position: "absolute",
                width: deviceWidth,
                height: deviceHeight,
                justifyContent: "center"
              }}
            >
              <View>
                <ActivityIndicator size="large" color="#0000ff" />
              </View>
            </View>
          )}

          {ConnectionError && (
            <Message
              type={"בעיה"}
              firstLine={"נראה שאין חיבור לרשת."}
              secondLine={"בדוק את החיבור."}
              handleCloseMessage={this.handleCloseConnectionMessage}
            />
          )}
        </View>
      );
    }
  }
}

const mapStateToProps = state => ({
  userObject: state.user,
  coursesObject: state.courses,
  courseDataObject: state.courseData,
  messagesObject: state.messages
});

const mapDispatchToProps = dispatch => ({
  startSetCoursesForLecturer: paramsObj =>
    dispatch(startSetCoursesForLecturer(paramsObj)),
  startSetCoursesForStudent: paramsObj =>
    dispatch(startSetCoursesForStudent(paramsObj)),
  startSetCourseDataByLecturer: paramsObj =>
    dispatch(startSetCourseDataByLecturer(paramsObj)),
  startSetCourseDataByStudent: paramsObj =>
    dispatch(startSetCourseDataByStudent(paramsObj)),
  unsetCourseData: () => dispatch(unsetCourseData()),
  unsetConnectionMessage: () => dispatch(unsetConnectionMessage()),
  unsetCourses: () => dispatch(unsetCourses())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Courses);
