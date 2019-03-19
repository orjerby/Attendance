import React from "react";
import { connect } from "react-redux";
import {
  Text,
  View,
  ActivityIndicator,
  Image,
  ScrollView,
  Dimensions,
  StatusBar,
  BackHandler
} from "react-native";
import {
  startSetNextLectureByStudentFirstTime,
  startSetNextLectureByStudent,
  startSetNextLectureByLecturerFirstTime,
  startSetNextLectureByLecturer,
  startFireTimer,
  startUpdateStatusOfStudentByTimer,
  startUpdateStatusOfStudent,
  unsetNextLecture
} from "../../actions/nextLecture";
import {
  startSetClasses,
  startUpdateClassLocation,
  unsetClasses
} from "../../actions/classes";
import {
  unsetConnectionMessage,
  setLocationMessage,
  setCameraMessage,
  unsetLocationMessage,
  unsetCameraMessage
} from "../../actions/messages";
import { unsetCourseData } from "../../actions/courseData";
import { Permissions, KeepAwake, Location } from "expo";
import moment from "moment";
import {
  MISS,
  LATE,
  HERE,
  STUDENT,
  LECTURER,
  LOCATION_MANAGER,
  JUSTIFY,
  ALL_STATUSES
} from "../../configuration";
import Timer from "./components/Timer";
import Status from "./components/Status";
import QRScanner from "./components/QRScanner";
import QR from "./components/QR";
import Students from "./components/Students";
import FireTimerButton from "./components/FireTimerButton";
import ClassList from "./components/ClassList";
import { Divider, Icon } from "react-native-elements";
import CoursePie from "../components/CoursePie";
import Message from "../components/Message";

var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

function distance(lon1, lat1, lon2, lat2) {
  var R = 6371; // Radius of the earth in km
  var dLat = ((lat2 - lat1) * Math.PI) / 180; // Javascript functions in radians
  var dLon = ((lon2 - lon1) * Math.PI) / 180;
  var a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c; // Distance in km
  return d * 1000; // meters
}

class Home extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      refreshInterval: null,
      locationInterval: null,
      nextLectureInterval: null,
      hasLocationPermission: true,
      hasCameraPermission: true,
      QRData: "",
      statusStudentsToShow: ALL_STATUSES,
      QRIsOpen: false
    };
  }

  checkLocationAsync = async () => {
    const {
      Lecture,
      StudentsInLecture: { Status: { StatusID = {} } = {} } = {}
    } = this.props.nextLectureObject;
    const {
      Lecturer: { QRMode } = {},
      Class: { Longitude = {}, Latitude = {} } = {},
      LectureID,
      IsLive,
      IsCanceled
    } = Lecture === null ? {} : Lecture;
    const { Student: { StudentID } = {} } = this.props.userObject;
    const location = await Location.getCurrentPositionAsync({
      enableHighAccuracy: true
    });
    const distanceInMeters = distance(
      Longitude,
      Latitude,
      location.coords.longitude,
      location.coords.latitude
    ); // distance between class's location and student's location
    if (IsLive && !IsCanceled) {
      if (distanceInMeters < 100 && QRMode && StatusID === MISS) {
        // distance is bellow 100 meters, it's QR mode and student's status is MISS
        // update the status to LATE
        this.props.startUpdateStatusOfStudent({
          lectureID: LectureID,
          studentID: StudentID,
          statusID: LATE
        });
      } else if (distanceInMeters < 100 && !QRMode && StatusID === MISS) {
        // distance is bellow 100 meters, it's timer mode and student's status is MISS
        // update the status to LATE / HERE, based on the timer (the check is in SQL's procedure)
        this.props.startUpdateStatusOfStudentByTimer({
          lectureID: LectureID,
          studentID: StudentID
        });
      }
    }
  };

  askForPermissionsAsync = async () => {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;

    if (RoleID === STUDENT) {
      const { status: statusLocation } = await Permissions.getAsync(
        Permissions.LOCATION
      );
      const { status: statusCamera } = await Permissions.getAsync(
        Permissions.CAMERA
      );
      this.setState({
        hasLocationPermission: statusLocation === "granted",
        hasCameraPermission: statusCamera === "granted"
      });
      if (statusLocation !== "granted") {
        setTimeout(() => {
          this.props.setLocationMessage();
        }, 2000);
      }
      if (statusCamera !== "granted") {
        setTimeout(() => {
          this.props.setCameraMessage();
        }, 2000);
      }
    }
  };

  updateClassLocationAsync = async classID => {
    const { status: statusLocation } = await Permissions.getAsync(
      Permissions.LOCATION
    );
    if (statusLocation !== "granted") {
      this.props.setLocationMessage();
    } else {
      this.props.startUpdateClassLocation(classID);
    }
  };

  componentDidMount = () => {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    const { Student: { StudentID } = {} } = this.props.userObject;
    const {
      navigation: {
        state: { params: { screenIsActive = true } = {} } = {}
      } = {}
    } = this.props;

    if (screenIsActive) {
      this.askForPermissionsAsync();

      if (RoleID === LECTURER) {
        BackHandler.addEventListener("hardwareBackPress", this.handleBackPress);
        this.props.startSetNextLectureByLecturerFirstTime({
          lecturerID: this.props.userObject.Lecturer.LecturerID
        });
        const refreshInterval = setInterval(() => {
          const { Lecture } = this.props.nextLectureObject;
          const { LectureID, IsLive, IsCanceled } =
            Lecture === null ? {} : Lecture;
          const { QRMode } = this.props.userObject.Lecturer;
          const { Lecturer: { LecturerID } = {} } = this.props.userObject;

          this.props.startSetNextLectureByLecturer({ lecturerID: LecturerID });
          if (IsLive && !IsCanceled && QRMode) {
            this.setState({ QRData: `${moment().unix()};${LectureID}` });
          }
        }, 1000);

        this.setState({ refreshInterval });
      } else if (RoleID === STUDENT) {
        this.props.startSetNextLectureByStudentFirstTime({
          studentID: StudentID
        });
        nextLectureInterval = setInterval(() => {
          const { Student: { StudentID } = {} } = this.props.userObject;
          this.props.startSetNextLectureByStudent({
            studentID: StudentID
          });
        }, 1000);
        locationInterval = setInterval(() => {
          const {
            Lecture,
            StudentsInLecture: { Status: { StatusID = {} } = {} } = {}
          } = this.props.nextLectureObject;
          const { IsLive, IsCanceled } = Lecture === null ? {} : Lecture;
          const { hasLocationPermission } = this.state;

          if (IsLive && !IsCanceled && StatusID === MISS) {
            if (hasLocationPermission) {
              this.checkLocationAsync();
            }
          }
        }, 5000);

        this.setState({ nextLectureInterval, locationInterval });
      } else if (RoleID === LOCATION_MANAGER) {
        this.props.startSetClasses({});
      }
    }
  };

  componentWillUnmount = () => {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;

    if (RoleID === LECTURER) {
      BackHandler.removeEventListener(
        "hardwareBackPress",
        this.handleBackPress
      );
      clearInterval(this.state.refreshInterval);
      this.props.unsetNextLecture();
      this.props.unsetCourseData();
    } else if (RoleID === STUDENT) {
      clearInterval(this.state.refreshInterval);
      clearInterval(this.state.nextLectureInterval);
      this.props.unsetNextLecture();
      this.props.unsetCourseData();
    } else {
      this.props.unsetClasses();
    }
    this.props.unsetConnectionMessage();
    this.props.unsetLocationMessage();
    this.props.unsetCameraMessage();
  };

  handleBackPress = () => {
    if (this.state.QRIsOpen) {
      this.closeQR();
      return true;
    }
    return false;
  };

  handleSelectMenuItem = ({ statusStudentsToShow }) => {
    this.setState({ statusStudentsToShow });
  };

  handleBarCodeRead = ({ data }) => {
    // data is a string that includes the time (timestamp) the QR got created, then ';' and then the LectureID of the current lecture
    const {
      Lecture,
      StudentsInLecture: { Status: { StatusID = {} } = {} }
    } = this.props.nextLectureObject;
    const { LectureID } = Lecture === null ? {} : Lecture;
    const { StudentID } = this.props.userObject.Student;
    var timeAndLecture = data.split(";");
    var now = moment().unix();
    var before = timeAndLecture[0];
    var lectureID = parseInt(timeAndLecture[1]);
    if (
      lectureID === LectureID &&
      now - before <= 3 &&
      StatusID !== HERE &&
      StatusID != JUSTIFY
    ) {
      // it's the same lecture, student's status is not HERE / JUSTIFY and the QR got created 0-3 seconds ago
      // update the status to HERE
      this.props.startUpdateStatusOfStudent({
        lectureID: LectureID,
        studentID: StudentID,
        statusID: HERE
      });
    }
  };

  handleFireTimer = () => {
    const { Lecture } = this.props.nextLectureObject;
    const { LectureID } = Lecture === null ? {} : Lecture;
    this.props.startFireTimer({ lectureID: LectureID });
  };

  handleUpdateClassLocation = ({ ClassID }) => {
    this.updateClassLocationAsync(ClassID);
  };

  openQR = () => {
    this.setState({ QRIsOpen: true });
  };

  closeQR = () => {
    this.setState({ QRIsOpen: false });
  };

  handleCloseLocationMessage = () => {
    this.props.unsetLocationMessage();
  };

  handleCloseCameraMessage = () => {
    this.props.unsetCameraMessage();
  };

  handleLocation = async () => {
    const { status: statusLocation } = await Permissions.askAsync(
      Permissions.LOCATION
    );
    this.setState({
      hasLocationPermission: statusLocation === "granted"
    });
    this.props.unsetLocationMessage();
  };

  handleCamera = async () => {
    const { status: statusCamera } = await Permissions.askAsync(
      Permissions.CAMERA
    );
    this.setState({
      hasCameraPermission: statusCamera === "granted"
    });
    this.props.unsetCameraMessage();
  };

  handleCloseConnectionMessage = () => {
    this.props.unsetConnectionMessage();
  };

  render() {
    const {
      ConnectionError,
      Fetching,
      Updating,
      LocationError,
      CameraError
    } = this.props.messagesObject;
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    const { Lecture } = this.props.nextLectureObject;
    const { Class } = this.props.classesObject;
    const { hasCameraPermission } = this.state;
    const {
      TimerRemaining,
      IsLive,
      IsCanceled,
      Lecturer,
      MinutesToBegin,
      MinutesToEnd
    } = Lecture === null ? {} : Lecture;
    const { QRMode: QRModeStudent } = Lecturer === undefined ? {} : Lecturer;
    const {
      StudentsInLecture: { Status: { StatusID, StatusName } = {} } = {}
    } = this.props.nextLectureObject;
    const { Lecturer: { QRMode: QRModeLecturer } = {} } = this.props.userObject;
    const {
      navigation: {
        state: { params: { screenIsActive = true } = {} } = {}
      } = {}
    } = this.props;
    const {
      Department: { DepartmentName } = {},
      Course: { CourseName } = {},
      Class: { ClassName, Longitude, Latitude } = {},
      Cycle: { CycleName } = {},
      Lecturer: { FirstName, LastName } = {},
      BeginHour,
      EndHour
    } = Lecture === null ? {} : Lecture;
    const { CourseData } = this.props.courseDataObject;

    if (!screenIsActive) {
      return <View />;
    } else {
      return (
        <View
          style={{
            zIndex: this.state.QRIsOpen ? 1 : 0,
            flex: 1,
            backgroundColor: "#fff"
          }}
        >
          <StatusBar backgroundColor={Updating ? "#108888" : "#15aaaa"} />

          {RoleID === LOCATION_MANAGER && (
            <View
              style={{
                backgroundColor: Updating ? "#108888" : "#15aaaa",
                width: deviceWidth,
                height: 55,
                alignItems: "center"
              }}
            >
              <Text
                style={{
                  fontWeight: "600",
                  fontSize: 20,
                  color: Updating ? "#cccccc" : "#fff",
                  marginTop: 14
                }}
              >
                הגדרת מיקום כיתות
              </Text>
            </View>
          )}

          <View>
            <KeepAwake />
            {RoleID !== LOCATION_MANAGER && (
              <View
                style={{
                  backgroundColor: "#15aaaa",
                  width: deviceWidth,
                  height: 55,
                  alignItems: "center",
                  borderBottomColor: "#fff",
                  borderBottomWidth: 0.5
                }}
              >
                {IsLive === true || IsLive === false ? (
                  <View style={{ alignItems: "center" }}>
                    <Text
                      style={{
                        fontWeight: "600",
                        fontSize: 20,
                        color: "#fff",
                        marginTop:
                          IsLive === true ? 2 : IsLive === false ? 2 : 12
                      }}
                    >
                      {IsLive === true
                        ? "ההרצאה הנוכחית"
                        : IsLive === false && "ההרצאה הבאה"}
                    </Text>
                    <Text style={{ fontSize: 15, color: "#fff" }}>
                      {IsLive === true && !IsCanceled ? (
                        `תסתיים בעוד ${
                          Math.floor(MinutesToEnd / 60) === 0
                            ? `${MinutesToEnd % 60} דקות`
                            : Math.floor(MinutesToEnd / 60) === 1
                            ? MinutesToEnd % 60 === 0
                              ? `שעה`
                              : MinutesToEnd % 60 === 1
                              ? `שעה ודקה`
                              : `שעה ו-${MinutesToEnd % 60} דקות`
                            : Math.floor(MinutesToEnd / 60) === 2
                            ? MinutesToEnd % 60 === 0
                              ? `שעתיים`
                              : MinutesToEnd % 60 === 1
                              ? `שעתיים ודקה`
                              : `שעתיים ו-${MinutesToEnd % 60} דקות`
                            : MinutesToEnd % 60 === 0
                            ? `${Math.floor(MinutesToEnd / 60)} שעות`
                            : `${Math.floor(MinutesToEnd / 60)} שעות ו${
                                MinutesToEnd % 60 < 10
                                  ? "דקה"
                                  : `-${MinutesToEnd % 60} דקות`
                              }`
                        }`
                      ) : IsLive === false && !IsCanceled ? (
                        `תתחיל בעוד ${
                          Math.floor(MinutesToBegin / 60) === 0
                            ? `${MinutesToBegin % 60} דקות`
                            : Math.floor(MinutesToBegin / 60) === 1
                            ? MinutesToBegin % 60 === 0
                              ? `שעה`
                              : MinutesToBegin % 60 === 1
                              ? `שעה ודקה`
                              : `שעה ו-${MinutesToBegin % 60} דקות`
                            : Math.floor(MinutesToBegin / 60) === 2
                            ? MinutesToBegin % 60 === 0
                              ? `שעתיים`
                              : MinutesToBegin % 60 === 1
                              ? `שעתיים ודקה`
                              : `שעתיים ו-${MinutesToBegin % 60} דקות`
                            : MinutesToBegin % 60 === 0
                            ? `${Math.floor(MinutesToBegin / 60)} שעות`
                            : `${Math.floor(MinutesToBegin / 60)} שעות ו-${
                                MinutesToBegin % 60 < 10
                                  ? "דקה"
                                  : `-${MinutesToBegin % 60} דקות`
                              }`
                        }`
                      ) : IsCanceled ? (
                        <Text
                          style={{
                            color: "red",
                            fontWeight: "300",
                            fontSize: 14
                          }}
                        >
                          מבוטלת
                        </Text>
                      ) : (
                        ""
                      )}
                    </Text>
                  </View>
                ) : (
                  <View style={{ marginTop: 10 }}>
                    <Image
                      source={require("../../assets/logo.png")}
                      style={{ width: 32, height: 32 }}
                    />
                  </View>
                )}
              </View>
            )}

            <ScrollView style={{ height: deviceHeight + 5 }}>
              {RoleID === LOCATION_MANAGER && (
                <View style={{ marginBottom: 50 }}>
                  <ClassList
                    Class={Class}
                    handleUpdateClassLocation={this.handleUpdateClassLocation}
                    Updating={Updating}
                    Fetching={Fetching}
                  />
                </View>
              )}

              {RoleID === LECTURER &&
                IsLive &&
                !IsCanceled &&
                QRModeLecturer &&
                this.state.QRIsOpen && (
                  <View
                    style={{ backgroundColor: "#15aaaa", height: deviceHeight }}
                  >
                    <View
                      style={{
                        backgroundColor: "#15aaaa",
                        paddingLeft: 25,
                        flexDirection: "row",
                        height: 55
                      }}
                    >
                      <View style={{ width: 35, top: 10 }}>
                        <Icon
                          name={"close"}
                          type={"AntDesign"}
                          size={35}
                          color={"#fff"}
                          onPress={this.closeQR}
                          underlayColor={"#15aaaa"}
                        />
                      </View>
                    </View>

                    <View
                      style={{
                        width: deviceWidth,
                        height: deviceWidth,
                        backgroundColor: "#fff",
                        justifyContent: "center",
                        alignItems: "center"
                      }}
                    >
                      <QR QRData={this.state.QRData} QRIsOpen={true} />
                    </View>
                  </View>
                )}

              {RoleID !== LOCATION_MANAGER && !Lecture && !Fetching && (
                <View
                  style={{
                    justifyContent: "center",
                    alignItems: "center",
                    height: deviceHeight - StatusBar.currentHeight - 55
                  }}
                >
                  <Text
                    style={{ fontWeight: "600", fontSize: 20, opacity: 0.4 }}
                  >
                    אין עוד הרצאות להיום
                  </Text>
                </View>
              )}

              {RoleID !== LOCATION_MANAGER && Lecture && !this.state.QRIsOpen && (
                <View
                  style={{
                    width: deviceWidth - 20,
                    alignSelf: "center",
                    borderWidth: 1,
                    borderColor: "#15aaaa",
                    marginTop: 5,
                    marginBottom: 150,
                    backgroundColor: "#fff"
                  }}
                >
                  <View
                    style={{
                      flexDirection: "row",
                      justifyContent: "space-between"
                    }}
                  >
                    <View style={{ marginLeft: 15, marginTop: 5 }}>
                      <Text
                        style={{
                          fontWeight: "600",
                          fontSize: 20,
                          textAlign: "left",
                          color: "#000"
                        }}
                      >
                        {CourseName}
                      </Text>
                      {RoleID === LECTURER ? (
                        <Text
                          style={{
                            fontWeight: "300",
                            fontSize: 15,
                            color: "#323232",
                            textAlign: "left"
                          }}
                        >
                          {DepartmentName} - {CycleName}
                        </Text>
                      ) : (
                        RoleID === STUDENT && (
                          <Text
                            style={{
                              fontWeight: "300",
                              fontSize: 15,
                              color: "#323232",
                              textAlign: "left"
                            }}
                          >
                            {FirstName} {LastName}
                          </Text>
                        )
                      )}

                      <Text
                        style={{
                          fontWeight: "300",
                          fontSize: 15,
                          color:
                            Longitude === 0 && Latitude === 0
                              ? "red"
                              : "#323232",
                          textAlign: "left"
                        }}
                      >
                        {ClassName}
                      </Text>
                      <Text
                        style={{
                          fontWeight: "300",
                          fontSize: 15,
                          color: "#323232",
                          textAlign: "left"
                        }}
                      >
                        {BeginHour.slice(0, 5)}-{EndHour.slice(0, 5)}
                      </Text>
                    </View>

                    <View style={{ width: 100, height: 100 }}>
                      {RoleID === LECTURER &&
                        IsLive &&
                        !IsCanceled &&
                        !QRModeLecturer &&
                        TimerRemaining >= 0 && (
                          <Timer TimerRemaining={TimerRemaining} />
                        )}

                      {RoleID === STUDENT &&
                        IsLive &&
                        !IsCanceled &&
                        !QRModeStudent &&
                        TimerRemaining >= 0 &&
                        StatusID !== HERE && (
                          <Timer TimerRemaining={TimerRemaining} />
                        )}

                      {RoleID === LECTURER &&
                        IsLive &&
                        !IsCanceled &&
                        QRModeLecturer && (
                          <QR
                            QRData={this.state.QRData}
                            QRIsOpen={false}
                            handleOpenQR={this.openQR}
                          />
                        )}

                      {RoleID === STUDENT &&
                        IsLive &&
                        !IsCanceled &&
                        QRModeStudent &&
                        StatusID !== HERE && (
                          <QRScanner
                            hasCameraPermission={hasCameraPermission}
                            handleBarCodeRead={this.handleBarCodeRead}
                          />
                        )}

                      {RoleID === LECTURER &&
                        IsLive &&
                        !IsCanceled &&
                        !QRModeLecturer &&
                        TimerRemaining < 0 && (
                          <FireTimerButton
                            handleFireTimer={this.handleFireTimer}
                          />
                        )}
                    </View>
                  </View>

                  {RoleID === LECTURER && IsLive && (
                    <View>
                      <Divider style={{ backgroundColor: "#15aaaa" }} />
                      <Students
                        IsLive={IsLive}
                        IsCanceled={IsCanceled}
                        statusStudentsToShow={this.state.statusStudentsToShow}
                        handleSelectMenuItem={this.handleSelectMenuItem}
                        studentsInLectureObject={this.props.nextLectureObject}
                        showStudentOptions={false}
                      />
                    </View>
                  )}

                  {RoleID === STUDENT && IsLive && !IsCanceled && (
                    <View style={{ marginBottom: 10 }}>
                      <Divider style={{ backgroundColor: "#15aaaa" }} />
                      <Status
                        QRMode={QRModeStudent}
                        StatusID={StatusID}
                        StatusName={StatusName}
                      />
                    </View>
                  )}

                  {RoleID === STUDENT && !IsCanceled && (
                    <View style={{ marginBottom: 5 }}>
                      <Divider
                        style={{ backgroundColor: "#15aaaa", marginBottom: 5 }}
                      />
                      <CoursePie
                        CourseData={CourseData}
                        Fetching={Fetching}
                        size={"small"}
                        progressBar={true}
                      />
                    </View>
                  )}
                </View>
              )}
            </ScrollView>
          </View>

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

          {LocationError && !ConnectionError && (
            <Message
              type="התראה"
              firstLine="שירותי המיקום אינם זמינים"
              button="לחץ כאן להפעלה"
              handleCloseMessage={this.handleCloseLocationMessage}
              handleOnClickButton={this.handleLocation}
            />
          )}

          {CameraError && !LocationError && !ConnectionError && (
            <Message
              type="התראה"
              firstLine="המצלמה לא זמינה"
              button="לחץ כאן להפעלה"
              handleCloseMessage={this.handleCloseCameraMessage}
              handleOnClickButton={this.handleCamera}
            />
          )}
        </View>
      );
    }
  }
}

const mapStateToProps = state => ({
  nextLectureObject: state.nextLecture,
  userObject: state.user,
  messagesObject: state.messages,
  classesObject: state.classes,
  courseDataObject: state.courseData
});

const mapDispatchToProps = dispatch => ({
  startSetNextLectureByLecturerFirstTime: paramsObj =>
    dispatch(startSetNextLectureByLecturerFirstTime(paramsObj)),
  startSetNextLectureByLecturer: paramsObj =>
    dispatch(startSetNextLectureByLecturer(paramsObj)),
  startFireTimer: paramsObj => dispatch(startFireTimer(paramsObj)),
  unsetConnectionMessage: () => dispatch(unsetConnectionMessage()),
  startSetNextLectureByStudentFirstTime: paramsObj =>
    dispatch(startSetNextLectureByStudentFirstTime(paramsObj)),
  startSetNextLectureByStudent: paramsObj =>
    dispatch(startSetNextLectureByStudent(paramsObj)),
  startSetClasses: paramsObj => dispatch(startSetClasses(paramsObj)),
  startUpdateClassLocation: classID =>
    dispatch(startUpdateClassLocation(classID)),
  startUpdateStatusOfStudentByTimer: paramsObj =>
    dispatch(startUpdateStatusOfStudentByTimer(paramsObj)),
  startUpdateStatusOfStudent: paramsObj =>
    dispatch(startUpdateStatusOfStudent(paramsObj)),
  setLocationMessage: () => dispatch(setLocationMessage()),
  unsetLocationMessage: () => dispatch(unsetLocationMessage()),
  setCameraMessage: () => dispatch(setCameraMessage()),
  unsetCameraMessage: () => dispatch(unsetCameraMessage()),
  unsetNextLecture: () => dispatch(unsetNextLecture()),
  unsetCourseData: () => dispatch(unsetCourseData()),
  unsetClasses: () => dispatch(unsetClasses())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Home);
