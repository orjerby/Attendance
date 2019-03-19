import React from "react";
import { connect } from "react-redux";
import {
  Text,
  View,
  ActivityIndicator,
  Dimensions,
  StatusBar,
  BackHandler
} from "react-native";
import {
  startUpdateLecturerQRMode,
  startUpdateLecturerPassword,
  startUpdateLecturerEmail,
  startUpdateLocationManagerPassword,
  startUpdateLocationManagerEmail,
  startUpdateStudentPassword,
  startUpdateStudentEmail
} from "../../actions/user";
import {
  unsetConnectionMessage,
  unsetPasswordMessage,
  unsetEmailMessage
} from "../../actions/messages";
import { STUDENT, LECTURER, LOCATION_MANAGER } from "../../configuration";
import PasswordSection from "./components/PasswordSection";
import EmailSection from "./components/EmailSection";
import ModeSection from "./components/ModeSection";
import Message from "../components/Message";
var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

class Settings extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      newEmailInput: "",
      newEmailBorderColor: "white"
    };
  }

  componentDidMount = () => {
    BackHandler.addEventListener("hardwareBackPress", this.handleBackPress);
  };

  componentWillUnmount = () => {
    BackHandler.removeEventListener("hardwareBackPress", this.handleBackPress);
    this.props.unsetConnectionMessage();
    this.props.unsetPasswordMessage();
    this.props.unsetEmailMessage();
  };

  handleBackPress = () => {
    const { Updating } = this.props.messagesObject;
    if (Updating) {
      return true;
    }
    return false;
  };

  handleUpdatePassword = ({ currentPassword, newPassword }) => {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {},
      LocationManager: { LocationManagerID } = {}
    } = this.props.userObject;

    if (RoleID === LECTURER) {
      this.props.startUpdateLecturerPassword({
        lecturerID: LecturerID,
        currentPassword: currentPassword,
        newPassword: newPassword
      });
    } else if (RoleID === STUDENT) {
      this.props.startUpdateStudentPassword({
        studentID: StudentID,
        currentPassword: currentPassword,
        newPassword: newPassword
      });
    } else if (RoleID === LOCATION_MANAGER) {
      this.props.startUpdateLocationManagerPassword({
        locationManagerID: LocationManagerID,
        currentPassword: currentPassword,
        newPassword: newPassword
      });
    }
  };

  handleUpdateEmail = ({ email }) => {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    const {
      Lecturer: { LecturerID } = {},
      Student: { StudentID } = {},
      LocationManager: { LocationManagerID } = {}
    } = this.props.userObject;

    if (RoleID === LECTURER) {
      this.props.startUpdateLecturerEmail({
        lecturerID: LecturerID,
        email: email
      });
    } else if (RoleID === STUDENT) {
      this.props.startUpdateStudentEmail({
        studentID: StudentID,
        email: email
      });
    } else if (RoleID === LOCATION_MANAGER) {
      this.props.startUpdateLocationManagerEmail({
        locationManagerID: LocationManagerID,
        email: email
      });
    }
  };

  handleChangeMode = ({ qRMode }) => {
    const { Lecturer: { LecturerID } = {} } = this.props.userObject;

    this.props.startUpdateLecturerQRMode({
      lecturerID: LecturerID,
      qRMode: qRMode
    });
  };

  handleClosePasswordMessage = () => {
    this.props.unsetPasswordMessage();
  };

  handleCloseEmailMessage = () => {
    this.props.unsetEmailMessage();
  };

  handleCloseConnectionMessage = () => {
    this.props.unsetConnectionMessage();
  };

  render() {
    const {
      ConnectionError,
      Updating,
      UpdatePasswordError,
      UpdateEmailError
    } = this.props.messagesObject;
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    const {
      Lecturer: { Email: EmailLecturer, QRMode } = {}
    } = this.props.userObject;
    const { Student: { Email: EmailStudent } = {} } = this.props.userObject;
    const {
      LocationManager: { Email: EmailLocationManager } = {}
    } = this.props.userObject;
    const {
      navigation: { state: { params: { screenIsActive } = {} } = {} } = {}
    } = this.props;

    if (!screenIsActive) {
      return <View />;
    } else {
      return (
        <View
          style={{ flex: 1, backgroundColor: Updating ? "#999999" : "#fff" }}
        >
          <StatusBar backgroundColor={Updating ? "#108888" : "#15aaaa"} />

          <View
            style={{
              backgroundColor: Updating ? "#108888" : "#15aaaa",
              width: deviceWidth,
              height: 45,
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
              הגדרות
            </Text>
          </View>

          <View style={{ margin: 2 }} />

          <PasswordSection
            handleUpdatePassword={this.handleUpdatePassword}
            Updating={Updating}
          />

          <View style={{ margin: 2 }} />

          {RoleID === LECTURER ? (
            <EmailSection
              Email={EmailLecturer}
              handleUpdateEmail={this.handleUpdateEmail}
              Updating={Updating}
            />
          ) : RoleID === STUDENT ? (
            <EmailSection
              Email={EmailStudent}
              handleUpdateEmail={this.handleUpdateEmail}
              Updating={Updating}
            />
          ) : (
            RoleID === LOCATION_MANAGER && (
              <EmailSection
                Email={EmailLocationManager}
                handleUpdateEmail={this.handleUpdateEmail}
                Updating={Updating}
              />
            )
          )}

          {RoleID === LECTURER && (
            <View>
              <View style={{ margin: 2 }} />
              <ModeSection
                QRMode={QRMode}
                handleChangeMode={this.handleChangeMode}
                Updating={Updating}
              />
            </View>
          )}

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
          {ConnectionError && (
            <Message
              type={"בעיה"}
              firstLine={"נראה שאין חיבור לרשת."}
              secondLine={"בדוק את החיבור."}
              handleCloseMessage={this.handleCloseConnectionMessage}
            />
          )}
          {UpdatePasswordError && (
            <Message
              type={"בעיה"}
              firstLine={"סיסמה נוכחית שגויה."}
              secondLine={"נסה שוב."}
              handleCloseMessage={this.handleClosePasswordMessage}
            />
          )}
          {UpdateEmailError && (
            <Message
              type={"בעיה"}
              firstLine={"האימייל שבחרת שגוי."}
              secondLine={"נסה שוב."}
              handleCloseMessage={this.handleCloseEmailMessage}
            />
          )}
        </View>
      );
    }
  }
}

const mapStateToProps = state => ({
  userObject: state.user,
  messagesObject: state.messages
});

const mapDispatchToProps = dispatch => ({
  startUpdateLecturerQRMode: paramsObj =>
    dispatch(startUpdateLecturerQRMode(paramsObj)),
  startUpdateLecturerPassword: paramsObj =>
    dispatch(startUpdateLecturerPassword(paramsObj)),
  startUpdateLecturerEmail: paramsObj =>
    dispatch(startUpdateLecturerEmail(paramsObj)),
  unsetConnectionMessage: () => dispatch(unsetConnectionMessage()),
  unsetPasswordMessage: () => dispatch(unsetPasswordMessage()),
  unsetEmailMessage: () => dispatch(unsetEmailMessage()),
  startUpdateLocationManagerPassword: paramsObj =>
    dispatch(startUpdateLocationManagerPassword(paramsObj)),
  startUpdateLocationManagerEmail: paramsObj =>
    dispatch(startUpdateLocationManagerEmail(paramsObj)),
  startUpdateStudentPassword: paramsObj =>
    dispatch(startUpdateStudentPassword(paramsObj)),
  startUpdateStudentEmail: paramsObj =>
    dispatch(startUpdateStudentEmail(paramsObj))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Settings);
