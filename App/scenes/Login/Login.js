import React from "react";
import { connect } from "react-redux";
import {
  unsetUser,
  startSetLecturer,
  startSetStudent,
  startSetLocationManager
} from "../../actions/user";
import { unsetLectures } from "../../actions/lectures";
import { unsetStudentsInLecture } from "../../actions/studentsInLecture";
import { unsetNextLecture } from "../../actions/nextLecture";
import { unsetCourseData } from "../../actions/courseData";
import {
  Text,
  View,
  TextInput,
  ActivityIndicator,
  Dimensions,
  StatusBar,
  Image
} from "react-native";
import {
  unsetConnectionMessage,
  unsetUserMessage,
  setUpdatingMessage
} from "../../actions/messages";
import { Permissions, Notifications } from "expo";
import { ButtonGroup } from "react-native-elements";
import Icon from "react-native-vector-icons/FontAwesome";
import Ripple from "react-native-material-ripple";
import Message from "../components/Message";
var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

async function registerForPushNotificationsAsync() {
  const { status: existingStatus } = await Permissions.getAsync(
    Permissions.NOTIFICATIONS
  );
  let finalStatus = existingStatus;
  if (existingStatus !== "granted") {
    const { status } = await Permissions.askAsync(Permissions.NOTIFICATIONS);
    finalStatus = status;
  }
  if (finalStatus !== "granted") {
    return;
  }
  let token = await Notifications.getExpoPushTokenAsync();
  return token;
}

class Login extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      iD: "",
      password: "",
      selectedIndex: 0,
      showPassword: true,
      showMessage: false
    };
  }

  componentDidMount = () => {
    this.props.unsetUser();
  };

  Login = () => {
    const { selectedIndex } = this.state;

    this.props.unsetStudentsInLecture();
    this.props.unsetLectures();
    this.props.unsetNextLecture();
    this.props.unsetCourseData();
    this.props.setUpdatingMessage();

    switch (selectedIndex) {
      case 0:
        registerForPushNotificationsAsync().then(token => {
          this.props.startSetStudent({
            studentID: this.state.iD,
            password: this.state.password,
            token
          });
        });

        break;
      case 1:
        registerForPushNotificationsAsync().then(token => {
          this.props.startSetLecturer({
            lecturerID: this.state.iD,
            password: this.state.password,
            token
          });
        });
        break;
      case 2:
        registerForPushNotificationsAsync().then(token => {
          this.props.startSetLocationManager({
            locationManagerID: this.state.iD,
            password: this.state.password,
            token
          });
        });
        break;
      default:
        break;
    }
  };

  updateIndex = selectedIndex => {
    this.setState({ selectedIndex });
  };

  handleCloseLoginMessage = () => {
    this.props.unsetUserMessage();
  };

  handleCloseConnectionMessage = () => {
    this.props.unsetConnectionMessage();
  };

  render() {
    const { ConnectionError, Updating, LoginError } = this.props.messagesObject;
    const buttons = ["סטודנט", "מרצה", "אחראי מיקום"];
    const { selectedIndex } = this.state;
    return (
      <View
        style={{ backgroundColor: Updating ? "#108888" : "#15aaaa", flex: 1 }}
      >
        <StatusBar backgroundColor={Updating ? "#108888" : "#15aaaa"} />

        <View style={{ margin: 10 }}>
          <View style={{ alignItems: "center" }}>
            <Image
              source={require("../../assets/logo.png")}
              style={{ width: 64, height: 64 }}
            />
          </View>

          <View style={{ margin: 10 }} />

          <Text
            style={{
              color: Updating ? "#cccccc" : "#fff",
              fontSize: 15,
              fontWeight: "900",
              marginLeft: 5,
              marginTop: 5
            }}
          >
            מספר זהות
          </Text>

          <TextInput
            style={{
              backgroundColor: Updating ? "#108888" : "#15aaaa",
              height: 40,
              paddingLeft: 5,
              color: Updating ? "#cccccc" : "#fff",
              marginTop: 5,
              paddingBottom: 5
            }}
            textAlign="right"
            keyboardType="numeric"
            maxLength={9}
            underlineColorAndroid={Updating ? "#cccccc" : "#fff"}
            onChangeText={iD =>
              !isNaN(iD) && !iD.includes(".") && this.setState({ iD })
            }
            value={this.state.iD}
            editable={Updating ? false : true}
          />

          <View
            style={{
              flexDirection: "row",
              justifyContent: "space-between",
              marginTop: 5
            }}
          >
            <Text
              style={{
                color: Updating ? "#cccccc" : "#fff",
                fontSize: 15,
                fontWeight: "900",
                marginLeft: 5
              }}
            >
              סיסמה
            </Text>
            <Ripple
              onPress={() => {
                this.passwordInput.blur();
                this.setState({ showPassword: !this.state.showPassword });
              }}
              rippleCentered={true}
            >
              <Text
                style={{
                  color: Updating ? "#cccccc" : "#fff",
                  fontSize: 12,
                  marginRight: 5,
                  fontWeight: "900",
                  marginTop: 3
                }}
              >
                {this.state.showPassword ? "הראה" : "הסתר"}
              </Text>
            </Ripple>
          </View>

          <TextInput
            ref={ref => (this.passwordInput = ref)}
            style={{
              backgroundColor: Updating ? "#108888" : "#15aaaa",
              height: 40,
              paddingLeft: 5,
              color: Updating ? "#cccccc" : "#fff",
              marginTop: 5,
              paddingBottom: 5
            }}
            textAlign="right"
            secureTextEntry={this.state.showPassword}
            underlineColorAndroid={Updating ? "#cccccc" : "#fff"}
            onChangeText={password => this.setState({ password })}
            value={this.state.password}
            editable={Updating ? false : true}
          />

          <View style={{ display: "flex", flexDirection: "row", margin: 8 }}>
            <ButtonGroup
              onPress={Updating ? () => {} : this.updateIndex}
              selectedIndex={selectedIndex}
              buttons={buttons}
              innerBorderStyle={{ color: Updating ? "#108888" : "#15aaaa" }}
              buttonStyle={{ backgroundColor: "#129393" }}
              containerStyle={{
                borderColor: Updating ? "#108888" : "#15aaaa",
                flex: 1
              }}
              textStyle={{
                color: Updating ? "#8e8e8e" : "#b2b2b2",
                fontSize: 11
              }}
              selectedTextStyle={{
                color: Updating ? "#b2b2b2" : "#fff",
                fontWeight: "900",
                fontSize: 13
              }}
              underlayColor={"#18c1c1"}
            />

            <Ripple
              style={{
                borderRadius: 50,
                width: 39,
                height: 39,
                backgroundColor: Updating ? "#cccccc" : "#fff",
                justifyContent: "center",
                alignItems: "center",
                marginTop: 5,
                opacity:
                  this.state.iD.length < 9 || this.state.password === ""
                    ? 0.5
                    : 1
              }}
              onPress={this.Login}
              disabled={
                this.state.iD.length < 9 ||
                this.state.password === "" ||
                Updating
                  ? true
                  : false
              }
              rippleCentered={true}
            >
              <Icon
                name="angle-left"
                color={Updating ? "#108888" : "#15aaaa"}
                size={27}
              />
            </Ripple>
          </View>
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
        {ConnectionError && (
          <Message
            type={"בעיה"}
            firstLine={"נראה שאין חיבור לרשת."}
            secondLine={"בדוק את החיבור."}
            handleCloseMessage={this.handleCloseConnectionMessage}
          />
        )}
        {LoginError && (
          <Message
            type={"בעיה"}
            firstLine={"נראה שההתחברות נכשלה."}
            secondLine={"נסה שוב."}
            handleCloseMessage={this.handleCloseLoginMessage}
          />
        )}
      </View>
    );
  }
}

const mapStateToProps = state => ({
  userObject: state.user,
  messagesObject: state.messages
});

const mapDispatchToProps = dispatch => ({
  startSetLecturer: paramsObj => dispatch(startSetLecturer(paramsObj)),
  startSetStudent: paramsObj => dispatch(startSetStudent(paramsObj)),
  startSetLocationManager: paramsObj =>
    dispatch(startSetLocationManager(paramsObj)),
  unsetUser: () => dispatch(unsetUser()),
  unsetLectures: () => dispatch(unsetLectures()),
  unsetStudentsInLecture: () => dispatch(unsetStudentsInLecture()),
  unsetNextLecture: () => dispatch(unsetNextLecture()),
  unsetUserMessage: () => dispatch(unsetUserMessage()),
  unsetCourseData: () => dispatch(unsetCourseData()),
  unsetConnectionMessage: () => dispatch(unsetConnectionMessage()),
  setUpdatingMessage: () => dispatch(setUpdatingMessage())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Login);
