import React from "react";
import { View, Image } from "react-native";
import Ripple from "react-native-material-ripple";
import { MISS, LATE, HERE, JUSTIFY, ALL_STATUSES } from "../../configuration";
import { ListItem, Avatar } from "react-native-elements";
import CoursePie from "./CoursePie";

export default class StudentList extends React.Component {
  handleOpenModalStatusOptions = ({
    listItemNumber,
    chosenStudent,
    chosenLecture,
    statusOptions
  }) => {
    this.props.handleOpenModalStatusOptions({
      listItemNumber,
      chosenStudent,
      chosenLecture,
      statusOptions
    });
  };

  renderStudents = () => {
    const {
      studentsInLectureObject,
      statusStudentsToShow,
      showStudentOptions,
      itemHeight,
      statusOptionsModalVisible = false,
      Updating
    } = this.props;
    const {
      Lecture,
      StudentsInLecture,
      StatusCount: { MissCount, LateCount, HereCount, JustifyCount } = {}
    } = studentsInLectureObject;
    const { LectureID } = Lecture === null ? {} : Lecture;

    if (StudentsInLecture && StudentsInLecture.length > 0) {
      switch (statusStudentsToShow) {
        case HERE:
          const here = StudentsInLecture.filter(studentInLecture => {
            const { Status: { StatusID } = {} } = studentInLecture;
            return StatusID === HERE;
          });

          const hereStudents = here.map((studentInLecture, listItemNumber) => {
            const {
              Student: { StudentID, FirstName, LastName, Picture } = ({} = {})
            } = studentInLecture;
            return (
              <ListItem
                key={StudentID}
                containerStyle={{
                  borderBottomColor: Updating ? "#108888" : "#15aaaa",
                  height: itemHeight
                }}
                avatar={
                  <Avatar
                    rounded
                    source={{ uri: Picture }}
                    overlayContainerStyle={{
                      backgroundColor: Updating ? "#108888" : "#15aaaa"
                    }}
                  />
                }
                titleStyle={{ textAlign: "left" }}
                title={`${LastName} ${FirstName}`}
                rightIcon={
                  <Ripple
                    style={{ position: "absolute", right: -10, padding: 12 }}
                    onPress={() => {
                      this.handleOpenModalStatusOptions({
                        listItemNumber: listItemNumber,
                        chosenStudent: StudentID,
                        chosenLecture: LectureID,
                        statusOptions: [
                          { StatusID: MISS, StatusName: "נעדר" },
                          { StatusID: LATE, StatusName: "איחר" }
                        ]
                      });
                    }}
                    disabled={
                      statusOptionsModalVisible || Updating ? true : false
                    }
                    rippleCentered={true}
                  >
                    <Image
                      source={require("../../assets/options.png")}
                      style={{ width: 20, height: 20 }}
                    />
                  </Ripple>
                }
                hideChevron={showStudentOptions === true ? false : true}
              />
            );
          });

          return hereStudents;

        case MISS:
          const miss = StudentsInLecture.filter(studentInLecture => {
            const { Status: { StatusID } = {} } = studentInLecture;
            return StatusID === MISS;
          });

          const missStudents = miss.map((studentInLecture, listItemNumber) => {
            const {
              Student: { StudentID, FirstName, LastName, Picture } = ({} = {}),
              Status: { StatusID } = {}
            } = studentInLecture;
            return (
              <ListItem
                key={StudentID}
                containerStyle={{
                  borderBottomColor: Updating ? "#108888" : "#15aaaa",
                  height: itemHeight
                }}
                avatar={
                  <Avatar
                    rounded
                    source={{ uri: Picture }}
                    overlayContainerStyle={{
                      backgroundColor: Updating ? "#108888" : "#15aaaa"
                    }}
                  />
                }
                titleStyle={{ textAlign: "left" }}
                title={`${LastName} ${FirstName}`}
                rightIcon={
                  <Ripple
                    style={{ position: "absolute", right: -10, padding: 12 }}
                    onPress={() => {
                      this.handleOpenModalStatusOptions({
                        listItemNumber: listItemNumber,
                        chosenStudent: StudentID,
                        chosenLecture: LectureID,
                        statusOptions: [
                          { StatusID: LATE, StatusName: "איחר" },
                          { StatusID: HERE, StatusName: "נכח" }
                        ]
                      });
                    }}
                    disabled={
                      statusOptionsModalVisible || Updating ? true : false
                    }
                    rippleCentered={true}
                  >
                    <Image
                      source={require("../../assets/options.png")}
                      style={{
                        width: 19,
                        height: 19,
                        marginTop: 2,
                        marginLeft: 6
                      }}
                    />
                  </Ripple>
                }
                hideChevron={showStudentOptions === true ? false : true}
              />
            );
          });

          return missStudents;

        case LATE:
          const late = StudentsInLecture.filter(studentInLecture => {
            const { Status: { StatusID } = {} } = studentInLecture;
            return StatusID === LATE;
          });

          const lateStudents = late.map((studentInLecture, listItemNumber) => {
            const {
              Student: { StudentID, FirstName, LastName, Picture } = ({} = {}),
              Status: { StatusID } = {}
            } = studentInLecture;
            return (
              <ListItem
                key={StudentID}
                containerStyle={{
                  borderBottomColor: Updating ? "#108888" : "#15aaaa",
                  height: itemHeight
                }}
                avatar={
                  <Avatar
                    rounded
                    source={{ uri: Picture }}
                    overlayContainerStyle={{
                      backgroundColor: Updating ? "#108888" : "#15aaaa"
                    }}
                  />
                }
                titleStyle={{ textAlign: "left" }}
                title={`${LastName} ${FirstName}`}
                rightIcon={
                  <Ripple
                    style={{ position: "absolute", right: -10, padding: 12 }}
                    onPress={() => {
                      this.handleOpenModalStatusOptions({
                        listItemNumber: listItemNumber,
                        chosenStudent: StudentID,
                        chosenLecture: LectureID,
                        statusOptions: [
                          { StatusID: MISS, StatusName: "נעדר" },
                          { StatusID: HERE, StatusName: "נכח" }
                        ]
                      });
                    }}
                    disabled={
                      statusOptionsModalVisible || Updating ? true : false
                    }
                    rippleCentered={true}
                  >
                    <Image
                      source={require("../../assets/options.png")}
                      style={{
                        width: 19,
                        height: 19,
                        marginTop: 2,
                        marginLeft: 6
                      }}
                    />
                  </Ripple>
                }
                hideChevron={showStudentOptions === true ? false : true}
              />
            );
          });

          return lateStudents;

        case JUSTIFY:
          const justify = StudentsInLecture.filter(studentInLecture => {
            const { Status: { StatusID } = {} } = studentInLecture;
            return StatusID === JUSTIFY;
          });

          const justifyStudents = justify.map(studentInLecture => {
            const {
              Student: { StudentID, FirstName, LastName, Picture } = ({} = {})
            } = studentInLecture;
            return (
              <ListItem
                key={StudentID}
                containerStyle={{
                  borderBottomColor: Updating ? "#108888" : "#15aaaa",
                  height: itemHeight
                }}
                avatar={
                  <Avatar
                    rounded
                    source={{ uri: Picture }}
                    overlayContainerStyle={{
                      backgroundColor: Updating ? "#108888" : "#15aaaa"
                    }}
                  />
                }
                titleStyle={{ textAlign: "left" }}
                title={`${LastName} ${FirstName}`}
                hideChevron={true}
              />
            );
          });

          return justifyStudents;

        case ALL_STATUSES:
          const totalStudents =
            MissCount + LateCount + HereCount + JustifyCount;
          const CourseData = {
            MissCount,
            LateCount,
            HereCount,
            JustifyCount,
            MissPercentage: ((MissCount / totalStudents) * 100).toFixed(1),
            LatePercentage: ((LateCount / totalStudents) * 100).toFixed(1),
            HerePercentage: ((HereCount / totalStudents) * 100).toFixed(1),
            JustifyPercentage: ((JustifyCount / totalStudents) * 100).toFixed(1)
          };

          return (
            <View style={{ marginTop: 10, marginBottom: 10 }}>
              <CoursePie
                CourseData={CourseData}
                size={"small"}
                progressBar={false}
              />
            </View>
          );
      }
    }
  };

  render() {
    const { Updating } = this.props;
    return (
      <View style={{ backgroundColor: Updating ? "#cccccc" : "#fff" }}>
        {this.renderStudents()}
      </View>
    );
  }
}
