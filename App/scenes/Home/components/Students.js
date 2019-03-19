import React from "react";
import { View } from "react-native";
import StatusMenu from "../../components/StatusMenu";
import StudentList from "../../components/StudentList";
import { Divider } from "react-native-elements";

export default class Students extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      statusMenuHeight: 60,
      listItemHeight: 55
    };
  }

  render() {
    const {
      IsLive,
      IsCanceled,
      statusStudentsToShow,
      studentsInLectureObject,
      showStudentOptions
    } = this.props;
    const {
      StatusCount: { MissCount, LateCount, HereCount } = {}
    } = studentsInLectureObject;

    return (
      <View>
        {IsLive && !IsCanceled && (
          <View style={{ flex: 1 }}>
            <StatusMenu
              statusStudentsToShow={statusStudentsToShow}
              handleSelectMenuItem={this.props.handleSelectMenuItem}
              showJustify={false}
              MissCount={MissCount}
              LateCount={LateCount}
              HereCount={HereCount}
              height={this.state.statusMenuHeight}
              backgroundColor={"#fff"}
              color={"black"}
              borderColor={"#15aaaa"}
              showPie={true}
            />
            <Divider style={{ backgroundColor: "#15aaaa", paddingTop: 1.5 }} />
            <StudentList
              studentsInLectureObject={studentsInLectureObject}
              statusStudentsToShow={statusStudentsToShow}
              showStudentOptions={showStudentOptions}
              itemHeight={this.state.listItemHeight}
            />
          </View>
        )}
      </View>
    );
  }
}
