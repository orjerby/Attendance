import React from "react";
import { connect } from "react-redux";
import {
  Text,
  View,
  ActivityIndicator,
  Animated,
  ScrollView,
  Dimensions,
  TouchableWithoutFeedback,
  BackHandler,
  StatusBar
} from "react-native";
import {
  startSetLectureByLecturerAndDate,
  startUpdateLectureCancel,
  unsetLectures,
  startSetLecturesByStudent,
  startSetLectureByStudentAndDate
} from "../../actions/lectures";
import {
  startSetStudentsInLectureByLecture,
  unsetStudentsInLecture,
  startUpdateStatusOfStudentByLecturer
} from "../../actions/studentsInLecture";
import { unsetConnectionMessage } from "../../actions/messages";
import moment from "moment";
import StudentsModal from "./components/StudentsModal";
import CalendarModal from "./components/CalendarModal";
import LectureList from "./components/LectureList";
import Ripple from "react-native-material-ripple";
import { Icon } from "react-native-elements";
import { LECTURER, STUDENT } from "../../configuration";
import Message from "../components/Message";
var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

class Calendar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      scrollY: new Animated.Value(0),
      chosenDate: null,
      calendarModalVisible: false,
      studentsModalVisible: false,
      cancelLectureModalOpacity: new Animated.Value(0),
      cancelLectureModalToShow: null
    };
  }

  componentDidMount = () => {
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {},
      User: { Role: { RoleID } = {} } = {}
    } = this.props.userObject;
    const {
      navigation: { state: { params: { screenIsActive } = {} } = {} } = {}
    } = this.props;

    BackHandler.addEventListener("hardwareBackPress", this.handleBackPress);

    if (screenIsActive) {
      this.setState({ chosenDate: moment().format("DD/MM/YYYY") });
      if (RoleID === LECTURER) {
        this.props.startSetLectureByLecturerAndDate({
          lecturerID: LecturerID,
          lectureDate: moment.utc()
        });
      } else if (RoleID === STUDENT) {
        this.props.startSetLectureByStudentAndDate({
          studentID: StudentID,
          lectureDate: moment.utc()
        });
      }
    }
  };

  componentWillUnmount() {
    BackHandler.removeEventListener("hardwareBackPress", this.handleBackPress);
    this.props.unsetLectures();
    this.props.unsetConnectionMessage();
  }

  handleBackPress = () => {
    const { Updating } = this.props.messagesObject;
    if (this.state.cancelLectureModalToShow) {
      this.handleCloseModalCancelLecture();
      return true;
    }
    if (Updating) {
      return true;
    }
    return false;
  };

  handleOnDayPress = day => {
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {},
      User: { Role: { RoleID } = {} } = {}
    } = this.props.userObject;
    this.setState({
      chosenDate: moment(day.dateString).format("DD/MM/YYYY"),
      calendarModalVisible: false
    });
    this.props.unsetLectures();
    if (RoleID === LECTURER) {
      this.props.startSetLectureByLecturerAndDate({
        lecturerID: LecturerID,
        lectureDate: moment.utc(day.timestamp)
      });
    } else if (RoleID === STUDENT) {
      this.props.startSetLectureByStudentAndDate({
        studentID: StudentID,
        lectureDate: moment.utc(day.timestamp)
      });
    }
  };

  handleOpenModalCalendar = () => {
    this.setState({ calendarModalVisible: true });
  };

  handleOpenModalCancelLecture = ({ cancelLectureModalToShow }) => {
    this.setState(
      {
        cancelLectureModalOpacity: new Animated.Value(0),
        cancelLectureModalToShow
      },
      () => {
        Animated.timing(this.state.cancelLectureModalOpacity, {
          duration: 200,
          toValue: 1
        }).start();
      }
    );
  };

  handleSelectStatusOption = ({ statusID, chosenLecture, chosenStudent }) => {
    this.props.startUpdateStatusOfStudentByLecturer({
      lectureID: chosenLecture,
      studentID: chosenStudent,
      statusID
    });
  };

  handleOpenModalStudents = ({ LectureID }) => {
    this.setState({ studentsModalVisible: true });
    this.props.startSetStudentsInLectureByLecture({ lectureID: LectureID });
  };

  handleCancelLecture = ({ wantToCancel, lectureID }) => {
    this.props.startUpdateLectureCancel({
      lectureID: lectureID,
      isCanceled: wantToCancel
    });
    this.handleCloseModalCancelLecture();
  };

  handleCloseModalStudents = () => {
    const { Updating } = this.props.messagesObject;
    if (!Updating) {
      this.setState({ studentsModalVisible: false });
      this.props.unsetStudentsInLecture();
      this.props.unsetConnectionMessage();
    }
  };

  handleBackCalendarModal = () => {
    this.setState({ calendarModalVisible: false });
  };

  handleCloseModalCancelLecture = () => {
    Animated.timing(this.state.cancelLectureModalOpacity, {
      duration: 200,
      toValue: 0
    }).start(() => this.setState({ cancelLectureModalToShow: null }));
  };

  handleCloseConnectionMessage = () => {
    this.props.unsetConnectionMessage();
  };

  render() {
    const { ConnectionError, Fetching, Updating } = this.props.messagesObject;
    const { RoleID } = this.props.userObject.User.Role;
    const {
      navigation: { state: { params: { screenIsActive } = {} } = {} } = {}
    } = this.props;

    const titleOpacity = this.state.scrollY.interpolate({
      inputRange: [0, 100],
      outputRange: [0, 1],
      extrapolate: "clamp",
      useNativeDriver: true
    });

    const boxOpacity = this.state.scrollY.interpolate({
      inputRange: [0, 80],
      outputRange: [1, 0],
      extrapolate: "clamp",
      useNativeDriver: true
    });

    const hiddenColorOpacity = this.state.scrollY.interpolate({
      inputRange: [0, 85, 85],
      outputRange: [0, 0, 1],
      extrapolate: "clamp",
      useNativeDriver: true
    });

    if (!screenIsActive) {
      return <View />;
    } else {
      return (
        <View
          style={{ flex: 1, backgroundColor: Updating ? "#cccccc" : "#fff" }}
        >
          <StatusBar backgroundColor={"#15aaaa"} />

          <View>
            <TouchableWithoutFeedback
              onPress={this.handleCloseModalCancelLecture}
              disabled={
                this.state.cancelLectureModalToShow === null ? true : false
              }
            >
              <View>
                <View
                  style={{
                    position: "absolute",
                    zIndex: 1,
                    left: 0,
                    right: 0,
                    paddingBottom: 10
                  }}
                >
                  <Animated.View
                    style={{
                      position: "absolute",
                      backgroundColor: "#15aaaa",
                      opacity: hiddenColorOpacity,
                      width: "100%",
                      height: "100%"
                    }}
                  />
                  <Ripple
                    style={{
                      borderRadius: 25,
                      marginLeft: 70,
                      marginRight: 50,
                      padding: 10,
                      backgroundColor: "#15aaaa",
                      opacity: titleOpacity
                    }}
                    onPress={() => {
                      !this.state.studentsModalVisible
                        ? this.handleOpenModalCalendar()
                        : {};
                    }}
                    disabled={
                      this.state.cancelLectureModalToShow === null
                        ? false
                        : true
                    }
                    rippleCentered={true}
                  >
                    <View
                      style={{
                        display: "flex",
                        justifyContent: "space-between",
                        flexDirection: "row-reverse",
                        marginRight: 30,
                        marginLeft: 30
                      }}
                    >
                      <Icon
                        name={"search"}
                        type={"Octicons"}
                        size={33}
                        color={"#fff"}
                        iconStyle={{ marginTop: 2 }}
                      />
                      <Text
                        style={{
                          fontSize: 18,
                          marginTop: 5,
                          textAlign: "left",
                          color: "#fff",
                          fontWeight: "bold"
                        }}
                      >
                        {this.state.chosenDate
                          ? this.state.chosenDate
                          : "בחר תאריך"}
                      </Text>
                    </View>
                  </Ripple>
                </View>

                <ScrollView
                  showsVerticalScrollIndicator={false}
                  ref={ref => (this.scrollView = ref)}
                  scrollEventThrottle={16}
                  onScrollEndDrag={Animated.event(
                    [
                      {
                        nativeEvent: {
                          contentOffset: { y: this.state.scrollY }
                        }
                      }
                    ],
                    {
                      listener: event => {
                        const offsetY = event.nativeEvent.contentOffset.y;
                        if (offsetY < 60) {
                          this.scrollView.scrollTo(
                            { y: 0, duration: 1000 },
                            { animated: true }
                          );
                        } else if (offsetY >= 60 && offsetY <= 145) {
                          this.scrollView.scrollTo(
                            { y: 145, duration: 1000 },
                            { animated: true }
                          );
                        }
                      }
                    },
                    {
                      useNativeDriver: true
                    }
                  )}
                  onScroll={Animated.event([
                    {
                      nativeEvent: { contentOffset: { y: this.state.scrollY } }
                    }
                  ])}
                >
                  <View>
                    <Animated.View style={{ height: 200 }}>
                      <Animated.View
                        style={{
                          position: "absolute",
                          width: deviceWidth,
                          height: 200,
                          backgroundColor: "#15aaaa"
                        }}
                      />
                      <Animated.Image
                        style={{
                          position: "absolute",
                          opacity: boxOpacity,
                          width: deviceWidth,
                          height: 200
                        }}
                        source={require("../../assets/calendarImage.jpg")}
                      />

                      <Animated.View style={{ opacity: boxOpacity }}>
                        <Ripple
                          rippleCentered={true}
                          rippleDuration={600}
                          rippleSize={400}
                          rippleContainerBorderRadius={25}
                          style={{
                            backgroundColor: "#fff",
                            borderRadius: 25,
                            marginLeft: 20,
                            marginRight: 20,
                            marginTop: 100,
                            padding: 10
                          }}
                          onPress={() => {
                            !this.state.studentsModalVisible
                              ? this.handleOpenModalCalendar()
                              : {};
                          }}
                          disabled={
                            this.state.cancelLectureModalToShow === null
                              ? false
                              : true
                          }
                        >
                          <View
                            style={{
                              display: "flex",
                              justifyContent: "space-between",
                              flexDirection: "row-reverse",
                              marginRight: 20,
                              marginLeft: 20
                            }}
                          >
                            <Icon
                              name={"search"}
                              type={"Octicons"}
                              size={30}
                              color={"gray"}
                            />
                            <Text
                              style={{
                                fontSize: 15,
                                marginTop: 5,
                                textAlign: "left",
                                color: "gray",
                                fontWeight: "bold"
                              }}
                            >
                              {this.state.chosenDate
                                ? this.state.chosenDate
                                : "בחר תאריך"}
                            </Text>
                          </View>
                        </Ripple>
                      </Animated.View>
                    </Animated.View>

                    <View style={{ marginTop: 10 }}>
                      {RoleID === LECTURER ? (
                        <LectureList
                          RoleID={RoleID}
                          lecturesObject={this.props.lecturesObject}
                          handleOpenModalCancelLecture={
                            this.handleOpenModalCancelLecture
                          }
                          handleOpenModalStudents={this.handleOpenModalStudents}
                          handleCancelLecture={this.handleCancelLecture}
                          cancelLectureModalOpacity={
                            this.state.cancelLectureModalOpacity
                          }
                          cancelLectureModalToShow={
                            this.state.cancelLectureModalToShow
                          }
                          calendarModalVisible={this.state.calendarModalVisible}
                          Updating={Updating}
                          Fetching={Fetching}
                        />
                      ) : (
                        RoleID === STUDENT && (
                          <LectureList
                            RoleID={RoleID}
                            lecturesObject={this.props.lecturesObject}
                            Fetching={Fetching}
                          />
                        )
                      )}

                      {/* <View style={{ height: 1000 }}></View> */}
                    </View>
                  </View>
                </ScrollView>

                <View style={{ flex: 1 }}>
                  {this.state.studentsModalVisible && RoleID === LECTURER && (
                    <StudentsModal
                      studentsInLectureObject={
                        this.props.studentsInLectureObject
                      }
                      handleCloseModalStudents={this.handleCloseModalStudents}
                      handleSelectStatusOption={this.handleSelectStatusOption}
                      messagesObject={this.props.messagesObject}
                      handleCloseConnectionMessage={
                        this.handleCloseConnectionMessage
                      }
                    />
                  )}
                </View>

                {this.state.calendarModalVisible && (
                  <CalendarModal
                    handleOnDayPress={this.handleOnDayPress}
                    handleBack={this.handleBackCalendarModal}
                  />
                )}
              </View>
            </TouchableWithoutFeedback>
          </View>

          {Updating && (
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
  lecturesObject: state.lectures,
  studentsInLectureObject: state.studentsInLecture,
  userObject: state.user,
  messagesObject: state.messages
});

const mapDispatchToProps = dispatch => ({
  setLectureDate: lectureDate => dispatch(setLectureDate(lectureDate)),
  startSetStudentsInLectureByLecture: paramsObj =>
    dispatch(startSetStudentsInLectureByLecture(paramsObj)),
  unsetStudentsInLecture: () => dispatch(unsetStudentsInLecture()),
  startSetLectureByLecturerAndDate: paramsObj =>
    dispatch(startSetLectureByLecturerAndDate(paramsObj)),
  startUpdateLectureCancel: paramsObj =>
    dispatch(startUpdateLectureCancel(paramsObj)),
  startUpdateStatusOfStudentByLecturer: paramsObj =>
    dispatch(startUpdateStatusOfStudentByLecturer(paramsObj)),
  unsetLectures: paramsObj => dispatch(unsetLectures(paramsObj)),
  unsetConnectionMessage: () => dispatch(unsetConnectionMessage()),
  startSetLecturesByStudent: paramsObj =>
    dispatch(startSetLecturesByStudent(paramsObj)),
  startSetLectureByStudentAndDate: paramsObj =>
    dispatch(startSetLectureByStudentAndDate(paramsObj))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Calendar);
