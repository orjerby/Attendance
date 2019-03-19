import React from "react";
import { Text, View, Image, Dimensions } from "react-native";
import Ripple from "react-native-material-ripple";
import {
  MISS,
  LATE,
  HERE,
  JUSTIFY,
  LECTURER,
  STUDENT
} from "../../../configuration";
import { Divider, ListItem, Icon } from "react-native-elements";
import CancelLectureModal from "./CancelLectureModal";
var { width: deviceWidth } = Dimensions.get("window");

export default class LectureList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      wantToCancel: null,
      chosenLecture: null
    };
  }

  handleOpenModalCancelLecture = ({
    chosenLecture,
    wantToCancel,
    cancelLectureModalToShow
  }) => {
    this.setState({ wantToCancel, chosenLecture });
    this.props.handleOpenModalCancelLecture({ cancelLectureModalToShow });
  };

  handleOpenModalStudents = ({ LectureID }) => {
    this.props.handleOpenModalStudents({ LectureID });
  };

  handleCancelLecture = ({ wantToCancel, lectureID }) => {
    this.props.handleCancelLecture({ wantToCancel, lectureID });
  };

  render() {
    const {
      lecturesObject,
      RoleID,
      cancelLectureModalToShow,
      calendarModalVisible,
      Updating,
      Fetching
    } = this.props;
    const { Lecture, StudentInLecture } = lecturesObject;

    if (RoleID === LECTURER) {
      return (
        <View>
          {Lecture && Lecture.length > 0 ? (
            Lecture.map((lecture, listItemNumber) => {
              const {
                Department: { DepartmentName } = {},
                Cycle: { CycleName } = {},
                Course: { CourseName } = {},
                Class: { ClassName } = {},
                BeginHour,
                EndHour,
                IsCanceled,
                LectureID,
                IsOld
              } = lecture;
              return (
                <View
                  key={LectureID}
                  style={{
                    marginBottom: 10,
                    marginLeft: 20,
                    marginRight: 20,
                    borderRadius: 5,
                    backgroundColor: Updating ? "#cccccc" : "#fff"
                  }}
                >
                  <ListItem
                    containerStyle={{
                      borderWidth: 1,
                      borderColor: Updating ? "#108888" : "#15aaaa",
                      borderBottomWidth: 1,
                      borderBottomColor: Updating ? "#108888" : "#15aaaa",
                      borderTopLeftRadius: 5,
                      borderTopRightRadius: 5,
                      borderBottomLeftRadius: 2,
                      borderBottomRightRadius: 2
                    }}
                    avatar={
                      <View style={{ left: 10 }}>
                        <Image
                          source={require("../../../assets/lecture.png")}
                          style={{ width: 30, height: 30 }}
                        />
                      </View>
                    }
                    titleStyle={{ textAlign: "left" }}
                    title={
                      <View style={{ left: 20 }}>
                        <Text
                          style={{
                            textAlign: "left",
                            fontSize: 20,
                            fontWeight: "bold"
                          }}
                        >
                          {CourseName}
                        </Text>
                        <Divider
                          style={{
                            backgroundColor: Updating ? "#108888" : "#15aaaa",
                            height: 0.3,
                            width: deviceWidth - 180
                          }}
                        />
                      </View>
                    }
                    subtitle={
                      <View style={{ left: 20 }}>
                        <Text style={{ textAlign: "left" }}>
                          {DepartmentName} - {CycleName}
                        </Text>
                        <Text style={{ textAlign: "left" }}>{ClassName}</Text>
                        <Text style={{ textAlign: "left" }}>
                          {BeginHour.slice(0, 5)}-{EndHour.slice(0, 5)}
                        </Text>
                        {IsCanceled && (
                          <Text
                            style={{
                              textAlign: "left",
                              color: Updating ? "#cc0000" : "#ff0000"
                            }}
                          >
                            ההרצאה בוטלה
                          </Text>
                        )}
                      </View>
                    }
                    onPress={
                      IsOld && !IsCanceled && cancelLectureModalToShow === null
                        ? () => this.handleOpenModalStudents({ LectureID })
                        : null
                    }
                    rightIcon={
                      !IsOld && !IsCanceled ? (
                        <Ripple
                          style={{
                            position: "absolute",
                            top: -10,
                            right: -10,
                            padding: 10
                          }}
                          onPress={() => {
                            this.handleOpenModalCancelLecture({
                              chosenLecture: LectureID,
                              wantToCancel: true,
                              cancelLectureModalToShow: listItemNumber
                            });
                          }}
                          disabled={
                            cancelLectureModalToShow === null ||
                            !calendarModalVisible ||
                            !Updating
                              ? false
                              : true
                          }
                          rippleCentered={true}
                        >
                          <Image
                            source={require("../../../assets/options.png")}
                            style={{ width: 20, height: 20 }}
                          />
                        </Ripple>
                      ) : !IsOld && IsCanceled ? (
                        <Ripple
                          style={{
                            position: "absolute",
                            top: -10,
                            right: -10,
                            padding: 10
                          }}
                          onPress={() => {
                            this.handleOpenModalCancelLecture({
                              chosenLecture: LectureID,
                              wantToCancel: false,
                              cancelLectureModalToShow: listItemNumber
                            });
                          }}
                          disabled={
                            cancelLectureModalToShow === null ||
                            !calendarModalVisible ||
                            !Updating
                              ? false
                              : true
                          }
                          rippleCentered={true}
                        >
                          <Image
                            source={require("../../../assets/options.png")}
                            style={{ width: 20, height: 20 }}
                          />
                        </Ripple>
                      ) : (
                        <Icon
                          name={"chevron-left"}
                          size={35}
                          color={Updating ? "#108888" : "#15aaaa"}
                        />
                      )
                    }
                    hideChevron={IsOld && IsCanceled ? true : false}
                    disabled={calendarModalVisible || Updating ? true : false}
                    disabledStyle={{ opacity: 1 }}
                  />
                  {cancelLectureModalToShow === listItemNumber && (
                    <CancelLectureModal
                      handleCancelLecture={this.handleCancelLecture}
                      wantToCancel={this.state.wantToCancel}
                      lectureID={LectureID}
                      modalOpacity={this.props.cancelLectureModalOpacity}
                    />
                  )}
                </View>
              );
            })
          ) : (
            <View>
              {!Fetching && (
                <View style={{ alignItems: "center", marginTop: 20 }}>
                  <Text
                    style={{ fontWeight: "600", fontSize: 20, opacity: 0.4 }}
                  >
                    אין הרצאות בתאריך הנבחר
                  </Text>
                </View>
              )}
            </View>
          )}
        </View>
      );
    } else if (RoleID === STUDENT) {
      return (
        <View>
          {StudentInLecture && StudentInLecture.length > 0 ? (
            StudentInLecture.map(studentInLecture => {
              const { Lecture, Status } = studentInLecture;
              const {
                Department: { DepartmentName } = {},
                Cycle: { CycleName } = {},
                Course: { CourseName } = {},
                Class: { ClassName } = {},
                Lecturer: { FirstName, LastName } = {},
                BeginHour,
                EndHour,
                IsCanceled,
                LectureID,
                IsOld
              } = Lecture;
              const { StatusID, StatusName } = Status;
              return (
                <View
                  key={LectureID}
                  style={{
                    marginBottom: 10,
                    marginLeft: 20,
                    marginRight: 20,
                    borderRadius: 5,
                    backgroundColor: "#fff"
                  }}
                >
                  <ListItem
                    containerStyle={{
                      borderWidth: 1,
                      borderColor: "#15aaaa",
                      borderBottomWidth: 1,
                      borderBottomColor: "#15aaaa",
                      borderTopLeftRadius: 5,
                      borderTopRightRadius: 5,
                      borderBottomLeftRadius: 2,
                      borderBottomRightRadius: 2
                    }}
                    avatar={
                      <View style={{ left: 10 }}>
                        <Image
                          source={require("../../../assets/lecture.png")}
                          style={{ width: 30, height: 30 }}
                        />
                      </View>
                    }
                    titleStyle={{ textAlign: "left" }}
                    title={
                      <View style={{ left: 20 }}>
                        <Text
                          style={{
                            textAlign: "left",
                            fontSize: 20,
                            fontWeight: "bold"
                          }}
                        >
                          {CourseName}
                        </Text>
                        <Divider
                          style={{
                            backgroundColor: "#15aaaa",
                            height: 0.3,
                            width: deviceWidth - 180
                          }}
                        />
                      </View>
                    }
                    subtitle={
                      <View style={{ left: 20 }}>
                        <Text style={{ textAlign: "left" }}>
                          {FirstName} {LastName}
                        </Text>
                        <Text style={{ textAlign: "left" }}>{ClassName}</Text>
                        <Text style={{ textAlign: "left" }}>
                          {BeginHour.slice(0, 5)}-{EndHour.slice(0, 5)}
                        </Text>
                        {IsOld && !IsCanceled && StatusID === MISS ? (
                          <Text style={{ textAlign: "left", color: "red" }}>
                            {StatusName}
                          </Text>
                        ) : IsOld && !IsCanceled && StatusID === LATE ? (
                          <Text style={{ textAlign: "left", color: "orange" }}>
                            {StatusName}
                          </Text>
                        ) : IsOld && !IsCanceled && StatusID === HERE ? (
                          <Text style={{ textAlign: "left", color: "green" }}>
                            {StatusName}
                          </Text>
                        ) : IsOld && !IsCanceled && StatusID === JUSTIFY ? (
                          <Text style={{ textAlign: "left", color: "purple" }}>
                            {StatusName}
                          </Text>
                        ) : (
                          IsCanceled && (
                            <Text style={{ textAlign: "left", color: "red" }}>
                              ההרצאה בוטלה
                            </Text>
                          )
                        )}
                      </View>
                    }
                    hideChevron={true}
                  />
                </View>
              );
            })
          ) : (
            <View>
              {!Fetching && (
                <View style={{ alignItems: "center", marginTop: 20 }}>
                  <Text
                    style={{ fontWeight: "600", fontSize: 20, opacity: 0.4 }}
                  >
                    אין הרצאות בתאריך הנבחר
                  </Text>
                </View>
              )}
            </View>
          )}
        </View>
      );
    }
  }
}
