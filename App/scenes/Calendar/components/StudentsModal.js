import React from "react";
import {
  Text,
  View,
  ScrollView,
  Modal,
  Dimensions,
  TouchableWithoutFeedback,
  Animated,
  ActivityIndicator
} from "react-native";
import StudentList from "../../components/StudentList";
import StatusMenu from "../../components/StatusMenu";
import StatusOptionsModal from "./StatusOptionsModal";
import { HERE } from "../../../configuration";
import { Icon } from "react-native-elements";
import Message from "../../components/Message";
var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

export default class StudentsModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      statusOptionsModalVisible: false,
      statusOptions: null,
      statusStudentsToShow: HERE,
      statusOptionsModalTop: null,
      titleHeight: 50,
      statusMenuHeight: 60,
      listItemHeight: 55,
      statusOptionsModalOpacity: new Animated.Value(0),
      pageY: 0
    };
  }

  handleSelectStatusOption = ({ statusID }) => {
    Animated.timing(this.state.statusOptionsModalOpacity, {
      duration: 200,
      toValue: 0
    }).start(() => {
      this.setState({ statusOptionsModalVisible: false });
      this.props.handleSelectStatusOption({
        statusID,
        chosenLecture: this.state.chosenLecture,
        chosenStudent: this.state.chosenStudent
      });
    });
  };

  handleOpenModalStatusOptions = ({
    listItemNumber,
    chosenStudent,
    chosenLecture,
    statusOptions
  }) => {
    const statusOptionsModalTop =
      this.state.listItemHeight * listItemNumber +
      this.state.titleHeight +
      this.state.statusMenuHeight -
      this.state.pageY;
    this.setState({
      statusOptionsModalVisible: true,
      chosenStudent,
      chosenLecture,
      statusOptions,
      statusOptionsModalTop
    });
  };

  handleSelectMenuItem = ({ statusStudentsToShow }) => {
    this.setState({ statusStudentsToShow, pageY: 0 });
    this.studentListScrollView.scrollTo({ y: 0, duration: 0 });
  };

  handleCloseModalStudents = () => {
    if (this.state.statusOptionsModalVisible) {
      this.handleCloseModalStatusOptions();
    } else {
      this.props.handleCloseModalStudents();
    }
  };

  handleCloseModalStatusOptions = () => {
    Animated.timing(this.state.statusOptionsModalOpacity, {
      duration: 200,
      toValue: 0
    }).start(() => this.setState({ statusOptionsModalVisible: false }));
  };

  handleCloseConnectionMessage = () => {
    this.props.handleCloseConnectionMessage();
  };

  render() {
    const {
      studentsInLectureObject,
      messagesObject: { ConnectionError, Fetching, Updating } = {}
    } = this.props;
    const {
      statusStudentsToShow,
      statusOptions,
      statusOptionsModalVisible
    } = this.state;
    const {
      StatusCount: { MissCount, LateCount, HereCount, JustifyCount } = {}
    } = studentsInLectureObject;

    return (
      <Modal
        onRequestClose={() => {
          this.handleCloseModalStudents();
        }}
        animationType="fade"
      >
        <TouchableWithoutFeedback
          onPress={this.handleCloseModalStatusOptions}
          disabled={statusOptionsModalVisible ? false : true}
        >
          <View style={{ flex: 1 }}>
            <View
              style={{
                backgroundColor: Updating ? "#108888" : "#15aaaa",
                width: deviceWidth,
                paddingLeft: 25,
                flexDirection: "row",
                height: this.state.titleHeight
              }}
            >
              <View style={{ width: 35, top: 8 }}>
                <Icon
                  name={"close"}
                  type={"AntDesign"}
                  size={35}
                  color={Updating ? "#cccccc" : "#fff"}
                  disabled={
                    this.state.statusOptionsModalVisible || Updating
                      ? true
                      : false
                  }
                  onPress={this.handleCloseModalStudents}
                  underlayColor={Updating ? "#108888" : "#15aaaa"}
                />
              </View>
              <Text
                style={{
                  color: Updating ? "#cccccc" : "#fff",
                  fontSize: 22,
                  left: 20,
                  top: 10
                }}
              >
                רשימת סטודנטים
              </Text>
            </View>

            <StatusMenu
              statusStudentsToShow={statusStudentsToShow}
              handleSelectMenuItem={this.handleSelectMenuItem}
              showJustify={true}
              MissCount={MissCount}
              LateCount={LateCount}
              HereCount={HereCount}
              JustifyCount={JustifyCount}
              height={this.state.statusMenuHeight}
              statusOptionsModalVisible={this.state.statusOptionsModalVisible}
              backgroundColor={Updating ? "#108888" : "#15aaaa"}
              color={Updating ? "#cccccc" : "#fff"}
              borderColor={Updating ? "#cc0000" : "#ff0000"}
              showPie={false}
            />

            <ScrollView
              ref={ref => {
                this.studentListScrollView = ref;
              }}
              style={{ backgroundColor: Updating ? "#cccccc" : "#fff" }}
              onScrollEndDrag={Animated.event([], {
                listener: event => {
                  const offsetY = event.nativeEvent.contentOffset.y;
                  this.setState({ pageY: offsetY });
                }
              })}
              onMomentumScrollEnd={Animated.event([], {
                listener: event => {
                  const offsetY = event.nativeEvent.contentOffset.y;
                  this.setState({ pageY: offsetY });
                }
              })}
            >
              <View style={{ flex: 1 }}>
                <StudentList
                  studentsInLectureObject={studentsInLectureObject}
                  statusStudentsToShow={statusStudentsToShow}
                  handleOpenModalStatusOptions={
                    this.handleOpenModalStatusOptions
                  }
                  showStudentOptions={true}
                  itemHeight={this.state.listItemHeight}
                  statusOptionsModalVisible={
                    this.state.statusOptionsModalVisible
                  }
                  Updating={Updating}
                />
              </View>
            </ScrollView>

            {statusOptionsModalVisible && (
              <StatusOptionsModal
                statusOptions={statusOptions}
                handleSelectStatusOption={this.handleSelectStatusOption}
                modalTop={this.state.statusOptionsModalTop}
                modalOpacity={this.state.statusOptionsModalOpacity}
              />
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
        </TouchableWithoutFeedback>
      </Modal>
    );
  }
}
