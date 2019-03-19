import React from "react";
import { Text, View, Dimensions, Image, StatusBar } from "react-native";
import { ListItem, Icon } from "react-native-elements";
import { LECTURER, STUDENT } from "../../../configuration";

var { height: deviceHeight } = Dimensions.get("window");

export default class CourseList extends React.Component {
  render() {
    const {
      Fetching,
      RoleID,
      query,
      filteredCourses,
      coursesObject: { Course } = {}
    } = this.props;

    return (
      <View>
        {RoleID === LECTURER ? (
          !query && Course ? (
            Course.length > 0 ? (
              Course.map(course => {
                const { CourseID, CourseName } = course;
                return (
                  <ListItem
                    containerStyle={{
                      borderBottomColor: "#15aaaa",
                      backgroundColor: "#fff"
                    }}
                    key={CourseID}
                    avatar={
                      <Image
                        source={require("../../../assets/course.png")}
                        style={{ width: 25, height: 25 }}
                      />
                    }
                    titleStyle={{ textAlign: "left" }}
                    title={CourseName}
                    onPress={() => {
                      this.props.handleSelectCourse({ CourseID, CourseName });
                    }}
                    rightIcon={
                      <Icon name={"chevron-left"} size={35} color={"#15aaaa"} />
                    }
                  />
                );
              })
            ) : (
              <View>
                {!Fetching && (
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
                      אין קורסים
                    </Text>
                  </View>
                )}
              </View>
            )
          ) : filteredCourses.length > 0 ? (
            filteredCourses.map(course => {
              const { CourseID, CourseName } = course;
              return (
                <ListItem
                  containerStyle={{
                    borderBottomColor: "#15aaaa",
                    backgroundColor: "#fff"
                  }}
                  key={CourseID}
                  avatar={
                    <Image
                      source={require("../../../assets/course.png")}
                      style={{ width: 25, height: 25 }}
                    />
                  }
                  titleStyle={{ textAlign: "left" }}
                  title={CourseName}
                  onPress={() => {
                    this.props.handleSelectCourse({ CourseID, CourseName });
                  }}
                  rightIcon={
                    <Icon name={"chevron-left"} size={35} color={"#15aaaa"} />
                  }
                />
              );
            })
          ) : (
            <View>
              {!Fetching && (
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
                    אין קורסים
                  </Text>
                </View>
              )}
            </View>
          )
        ) : RoleID === STUDENT && (!query && Course) ? (
          Course.length > 0 ? (
            Course.map(course => {
              const { CourseID, CourseName } = course;
              return (
                <ListItem
                  containerStyle={{
                    borderBottomColor: "#15aaaa",
                    backgroundColor: "#fff"
                  }}
                  key={CourseID}
                  avatar={
                    <Image
                      source={require("../../../assets/course.png")}
                      style={{ width: 25, height: 25 }}
                    />
                  }
                  titleStyle={{ textAlign: "left" }}
                  title={CourseName}
                  onPress={() => {
                    this.props.handleSelectCourse({ CourseID, CourseName });
                  }}
                  rightIcon={
                    <Icon name={"chevron-left"} size={35} color={"#808080"} />
                  }
                />
              );
            })
          ) : (
            <View>
              {!Fetching && (
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
                    אין קורסים
                  </Text>
                </View>
              )}
            </View>
          )
        ) : filteredCourses.length > 0 ? (
          filteredCourses.map(course => {
            const { CourseID, CourseName } = course;
            return (
              <ListItem
                containerStyle={{
                  borderBottomColor: "#15aaaa",
                  backgroundColor: "#fff"
                }}
                key={CourseID}
                avatar={
                  <Image
                    source={require("../../../assets/course.png")}
                    style={{ width: 25, height: 25 }}
                  />
                }
                titleStyle={{ textAlign: "left" }}
                title={CourseName}
                onPress={() => {
                  this.props.handleSelectCourse({ CourseID, CourseName });
                }}
                rightIcon={
                  <Icon name={"chevron-left"} size={35} color={"#808080"} />
                }
              />
            );
          })
        ) : (
          <View>
            {!Fetching && (
              <View
                style={{
                  justifyContent: "center",
                  alignItems: "center",
                  height: deviceHeight - StatusBar.currentHeight - 55
                }}
              >
                <Text style={{ fontWeight: "600", fontSize: 20, opacity: 0.4 }}>
                  אין קורסים
                </Text>
              </View>
            )}
          </View>
        )}
      </View>
    );
  }
}
