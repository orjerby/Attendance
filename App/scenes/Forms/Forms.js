import React from "react";
import { connect } from "react-redux";
import {
  Text,
  View,
  Image,
  ActivityIndicator,
  StatusBar,
  Dimensions,
  ScrollView,
  BackHandler
} from "react-native";
import {
  startAddForm,
  startDeleteForm,
  startSetForms,
  unsetForms
} from "../../actions/forms";
import { unsetConnectionMessage } from "../../actions/messages";
import moment from "moment";
import { ListItem, Icon } from "react-native-elements";
import { FORM_ACCEPTED, FORM_DENIED } from "../../configuration/index";
import FormModal from "./components/FormModal";
import Calendar from "react-native-calendar-select";
import Ripple from "react-native-material-ripple";
import PictureModal from "./components/PictureModal";
import Message from "../components/Message";
import { ImagePicker } from "expo";
var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

class Forms extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      openDate: "",
      endDate: "",
      pictureBase64: null,
      formModalVisible: false,
      formID: 0,
      picture: null,
      chosenOpenDate: null,
      chosenEndDate: null,
      image: null,
      pictureModalVisible: false
    };
  }

  componentDidMount = () => {
    const { Student: { StudentID } = {} } = this.props.userObject;
    const {
      navigation: { state: { params: { screenIsActive } = {} } = {} } = {}
    } = this.props;
    if (screenIsActive) {
      BackHandler.addEventListener("hardwareBackPress", this.handleBackPress);
      this.props.startSetForms({ studentID: StudentID });
    }
  };

  componentWillUnmount = () => {
    BackHandler.removeEventListener("hardwareBackPress", this.handleBackPress);
    this.props.unsetForms();
    this.props.unsetConnectionMessage();
  };

  handleBackPress = () => {
    const { Updating } = this.props.messagesObject;
    if (Updating) {
      return true;
    }
    return false;
  };

  handleBackFormModal = () => {
    this.setState({
      formModalVisible: false,
      formID: null,
      openDate: null,
      endDate: null,
      picture: null
    });
  };

  handleSelectForm = ({ FormID, OpenDate, EndDate, Picture }) => {
    this.setState({
      formModalVisible: true,
      formID: FormID,
      openDate: OpenDate,
      endDate: EndDate,
      picture: Picture
    });
  };

  handleImage = ({ base64 }) => {
    this.setState({ pictureBase64: base64 });
  };

  handleDeleteForm = () => {
    const { formID } = this.state;
    this.props.startDeleteForm({ formID: formID });
    this.setState({ formModalVisible: false });
  };

  confirmDate = ({ startDate, endDate, startMoment, endMoment }) => {
    this.setState({
      chosenOpenDate: startDate,
      chosenEndDate: endDate
    });
  };

  openCalendar = () => {
    this.calendar && this.calendar.open();
  };

  _pickImage = async () => {
    let result = await ImagePicker.launchImageLibraryAsync({
      base64: true,
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      quality: 0.8
    });

    if (!result.cancelled) {
      this.setState({ image: result.uri });
    }

    this.handleImage(result);
  };

  handleBackPictureModal = () => {
    this.setState({ pictureModalVisible: false });
  };

  handleCloseConnectionMessage = () => {
    this.props.unsetConnectionMessage();
  };

  render() {
    const { ConnectionError, Fetching, Updating } = this.props.messagesObject;
    const { StudentID } = this.props.userObject.Student;
    const { Form } = this.props.formsObject;
    const {
      navigation: {
        state: { params: { screenIsActive = true } = {} } = {}
      } = {}
    } = this.props;

    if (!screenIsActive) {
      return <View />;
    } else {
      let customI18n = {
        w: ["", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת", "ראשון"],
        weekday: ["", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת", "ראשון"],
        text: {
          start: "התחלה",
          end: "סוף",
          date: "תאריך",
          save: "שמור",
          clear: "אפס"
        },
        date: "MM / DD" // date format
      };

      return (
        <View
          style={{ flex: 1, backgroundColor: Updating ? "#cccccc" : "#fff" }}
        >
          <StatusBar backgroundColor={Updating ? "#108888" : "#15aaaa"} />

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
              אישורים
            </Text>
          </View>

          {Form && (
            <ScrollView>
              {this.state.formModalVisible && (
                <FormModal
                  formID={this.state.formID}
                  openDate={this.state.openDate}
                  endDate={this.state.endDate}
                  picture={this.state.picture}
                  handleBack={this.handleBackFormModal}
                  handleDeleteForm={this.handleDeleteForm}
                />
              )}

              {this.state.pictureModalVisible && (
                <PictureModal
                  picture={this.state.image}
                  handleBack={this.handleBackPictureModal}
                />
              )}

              <Calendar
                i18n="en"
                ref={calendar => {
                  this.calendar = calendar;
                }}
                customI18n={customI18n}
                format="YYYYMMDD"
                startDate={this.state.chosenOpenDate}
                endDate={this.state.chosenEndDate}
                onConfirm={this.confirmDate}
                minDate={moment()
                  .subtract(2, "M")
                  .startOf("month")
                  .format("YYYYMMDD")}
                maxDate={moment()
                  .add(1, "M")
                  .endOf("month")
                  .format("YYYYMMDD")}
                disabled={Updating ? true : false}
              />

              <View style={{ backgroundColor: Updating ? "#cccccc" : "#fff" }}>
                <View
                  style={{
                    width: deviceWidth - 40,
                    height: 40,
                    borderBottomWidth: 1,
                    borderColor: Updating ? "#108888" : "#15aaaa",
                    alignItems: "center",
                    justifyContent: "center",
                    backgroundColor: Updating ? "#cccccc" : "#fff",
                    marginLeft: 20,
                    marginRight: 20
                  }}
                >
                  <Text
                    style={{
                      fontSize: 18,
                      color: Updating ? "#108888" : "#15aaaa"
                    }}
                  >
                    הוספת אישור
                  </Text>
                </View>

                <View
                  style={{
                    flexDirection: "row",
                    justifyContent: "space-between",
                    height: deviceWidth / 2 + 50
                  }}
                >
                  <View
                    style={{
                      width: 20,
                      backgroundColor: Updating ? "#cccccc" : "#fff"
                    }}
                  />

                  <View style={{ flex: 1, flexDirection: "column" }}>
                    <Ripple
                      style={{
                        height: 30,
                        padding: 10,
                        alignItems: "center",
                        justifyContent: "center",
                        borderColor: Updating ? "#108888" : "#15aaaa",
                        borderBottomWidth: 0.5,
                        borderLeftWidth: 1
                      }}
                      rippleDuration={200}
                      onPress={() => setTimeout(this._pickImage, 100)}
                      rippleCentered={true}
                      disabled={Updating ? true : false}
                    >
                      <Text style={{ fontSize: 15, fontWeight: "bold" }}>
                        בחר תמונה
                      </Text>
                    </Ripple>

                    {this.state.image ? (
                      <Ripple
                        style={{
                          flex: 1,
                          borderLeftWidth: 1,
                          borderColor: Updating ? "#108888" : "#15aaaa",
                          borderBottomWidth: 1
                        }}
                        onPress={() =>
                          this.setState({ pictureModalVisible: true })
                        }
                        rippleCentered={true}
                      >
                        <Image
                          source={{ uri: this.state.image }}
                          style={{ flex: 1 }}
                          resizeMode={"stretch"}
                        />
                      </Ripple>
                    ) : (
                      <View
                        style={{
                          flex: 1,
                          borderLeftWidth: 1,
                          borderColor: Updating ? "#108888" : "#15aaaa",
                          borderBottomWidth: 1
                        }}
                      />
                    )}
                  </View>

                  <View style={{ flex: 1, flexDirection: "column" }}>
                    <Ripple
                      style={{
                        height: 60,
                        padding: 10,
                        alignItems: "center",
                        justifyContent: "center",
                        borderLeftWidth: 0.5,
                        borderColor: Fetching ? "#108888" : "#15aaaa",
                        borderBottomWidth: 0.5,
                        borderRightWidth: 1
                      }}
                      onPress={this.openCalendar}
                      rippleCentered={true}
                      disabled={Updating ? true : false}
                    >
                      <Text style={{ fontSize: 15, fontWeight: "bold" }}>
                        בחר תאריכים
                      </Text>
                      {this.state.chosenOpenDate && this.state.chosenEndDate ? (
                        <Text style={{ fontSize: 12 }}>{`${moment(
                          this.state.chosenEndDate
                        ).format("DD/MM/YYYY")} - ${moment(
                          this.state.chosenOpenDate
                        ).format("DD/MM/YYYY")}`}</Text>
                      ) : (
                        this.state.chosenOpenDate &&
                        !this.state.chosenEndDate && (
                          <Text style={{ fontSize: 12 }}>
                            {moment(this.state.chosenOpenDate).format(
                              "DD/MM/YYYY"
                            )}
                          </Text>
                        )
                      )}
                    </Ripple>

                    <View
                      style={{
                        flex: 1,
                        alignItems: "center",
                        justifyContent: "center",
                        borderLeftWidth: 0.5,
                        borderColor: Updating ? "#108888" : "#15aaaa",
                        borderRightWidth: 1,
                        borderBottomWidth: 1
                      }}
                    >
                      {this.state.pictureBase64 && this.state.chosenOpenDate ? (
                        <Ripple
                          style={{ padding: 10 }}
                          onPress={() => {
                            this.props.startAddForm({
                              studentID: StudentID,
                              openDate: this.state.chosenOpenDate,
                              endDate: this.state.chosenEndDate
                                ? this.state.chosenEndDate
                                : this.state.chosenOpenDate,
                              pictureName: `${moment().unix()}${StudentID}.jpg`,
                              pictureBase64: this.state.pictureBase64
                            });
                            this.setState({ pictureBase64: null, image: null });
                          }}
                          rippleCentered={true}
                          disabled={Updating}
                        >
                          <Text
                            style={{
                              fontSize: 15,
                              fontWeight: "bold",
                              color: Updating ? "#108888" : "#15aaaa"
                            }}
                          >
                            הוסף אישור
                          </Text>
                        </Ripple>
                      ) : (
                        <View style={{ padding: 10 }}>
                          <Text
                            style={{
                              fontSize: 15,
                              color: Updating ? "#666666" : "#808080"
                            }}
                          >
                            הוסף אישור
                          </Text>
                        </View>
                      )}
                    </View>
                  </View>
                  <View
                    style={{
                      width: 20,
                      backgroundColor: Updating ? "#cccccc" : "#fff"
                    }}
                  />
                </View>
              </View>

              <View
                style={{
                  width: deviceWidth,
                  height: 40,
                  borderBottomWidth: 1,
                  borderColor: Updating ? "#108888" : "#15aaaa",
                  alignItems: "center",
                  justifyContent: "center",
                  backgroundColor: Updating ? "#cccccc" : "#fff"
                }}
              >
                <Text
                  style={{
                    fontSize: 18,
                    color: Updating ? "#108888" : "#15aaaa"
                  }}
                >
                  אישורים קיימים
                </Text>
              </View>

              <View>
                {Form.length > 0 ? (
                  Form.map(form => {
                    const {
                      FormID,
                      OpenDate,
                      EndDate,
                      Picture,
                      FormStatus: { FormStatusID, FormStatusName } = {}
                    } = form;
                    return (
                      <ListItem
                        containerStyle={{
                          borderBottomColor: Updating ? "#108888" : "#15aaaa",
                          backgroundColor: Updating ? "#cccccc" : "#fff"
                        }}
                        key={FormID}
                        avatar={
                          <Image
                            source={require("../../assets/form.png")}
                            style={{ width: 25, height: 25 }}
                          />
                        }
                        titleStyle={{ textAlign: "left" }}
                        title={`${moment
                          .utc(OpenDate)
                          .format("DD/MM/YYYY")}-${moment
                          .utc(EndDate)
                          .format("DD/MM/YYYY")}`}
                        subtitleStyle={{
                          textAlign: "left",
                          color:
                            FormStatusID === FORM_ACCEPTED
                              ? "green"
                              : FormStatusID === FORM_DENIED
                              ? "red"
                              : "gray"
                        }}
                        subtitle={FormStatusName}
                        onPress={() => {
                          this.handleSelectForm(form);
                        }}
                        rightIcon={
                          <Icon
                            name={"chevron-left"}
                            size={35}
                            color={Updating ? "#108888" : "#15aaaa"}
                          />
                        }
                        disabled={Updating ? true : false}
                        disabledStyle={{ opacity: 1 }}
                      />
                    );
                  })
                ) : (
                  <View>
                    {!Fetching && (
                      <View style={{ alignItems: "center", marginTop: 20 }}>
                        <Text
                          style={{
                            fontWeight: "600",
                            fontSize: 20,
                            opacity: 0.4
                          }}
                        >
                          אין אישורים
                        </Text>
                      </View>
                    )}
                  </View>
                )}
              </View>
            </ScrollView>
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
  formsObject: state.forms,
  messagesObject: state.messages
});

const mapDispatchToProps = dispatch => ({
  startSetForms: paramsObj => dispatch(startSetForms(paramsObj)),
  startAddForm: paramsObj => dispatch(startAddForm(paramsObj)),
  startDeleteForm: paramsObj => dispatch(startDeleteForm(paramsObj)),
  unsetConnectionMessage: () => dispatch(unsetConnectionMessage()),
  unsetForms: () => dispatch(unsetForms())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Forms);
