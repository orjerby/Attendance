import React from "react";
import { Text, View, Dimensions, Modal, ActivityIndicator } from "react-native";
import { Svg } from "expo";
import CoursePie from "../../components/CoursePie";
import { Icon } from "react-native-elements";
import { LECTURER } from "../../../configuration";
import Carousel, { Pagination } from "react-native-snap-carousel";
import Message from "../../components/Message";

var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");
const { Text: SvgText } = Svg;

export default class CourseDataModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      activeSlide: 0
    };
  }

  _renderItem = ({ item, index }) => {
    const {
      CourseData,
      messagesObject: { ConnectionError, Fetching } = {}
    } = this.props;
    return (
      <View style={{ flex: 1 }}>
        <Text
          style={{
            fontSize: 20,
            textAlign: "center",
            color: "#fff",
            backgroundColor: "#129393"
          }}
        >
          {item.Department.DepartmentName}
        </Text>
        <Text
          style={{
            fontSize: 20,
            textAlign: "center",
            color: "#fff",
            backgroundColor: "#129393"
          }}
        >
          {item.Cycle.CycleName}
        </Text>
        <View style={{ flex: 1 }}>
          <CoursePie
            CourseData={item}
            Fetching={Fetching}
            size={"medium"}
            progressBar={true}
            enableMomentum={true}
            loopClonesPerSide={CourseData.length}
          />
        </View>
      </View>
    );
  };

  get pagination() {
    const { CourseData } = this.props;
    const { activeSlide } = this.state;
    return CourseData.length <= 1 ? (
      <View style={{ margin: 35 }} />
    ) : (
      <Pagination
        dotsLength={CourseData.length}
        activeDotIndex={activeSlide}
        dotStyle={{
          width: 10,
          height: 10,
          borderRadius: 5,
          marginHorizontal: 8,
          backgroundColor: "#15aaaa"
        }}
        inactiveDotStyle={
          {
            // Define styles for inactive dots here
          }
        }
        inactiveDotOpacity={0.4}
        inactiveDotScale={0.6}
      />
    );
  }

  handleChangePie = slideIndex => {
    this.setState({ activeSlide: slideIndex });
  };

  handleCloseConnectionMessage = () => {
    this.props.handleCloseConnectionMessage();
  };

  render() {
    const {
      RoleID,
      chosenCourse,
      CourseData,
      messagesObject: { ConnectionError, Fetching } = {}
    } = this.props;

    const Labels = ({ slices }) => {
      return slices.map((slice, index) => {
        const { pieCentroid, data } = slice;
        return (
          <SvgText
            key={index}
            x={pieCentroid[0]}
            y={pieCentroid[1]}
            fill={"black"}
            textAnchor={"middle"}
            alignmentBaseline={"middle"}
            fontSize={15}
            stroke={"black"}
            strokeWidth={0.5}
          >
            {`${data.percentage !== 0 ? `${data.percentage}%` : ""}${
              data.count !== 0 ? ` (${data.count})` : ""
            }`}
          </SvgText>
        );
      });
    };

    return (
      <Modal
        onRequestClose={() => {
          this.props.handleBack();
        }}
        animationType="fade"
      >
        <View style={{ flex: 1, backgroundColor: "#fff" }}>
          <View
            style={{
              backgroundColor: "#15aaaa",
              width: deviceWidth,
              paddingLeft: 25,
              flexDirection: "row",
              height: 54
            }}
          >
            <View style={{ width: 35, top: 13 }}>
              <Icon
                name={"close"}
                type={"AntDesign"}
                size={35}
                color={"#fff"}
                onPress={this.props.handleBack}
                underlayColor={"#15aaaa"}
              />
            </View>
            <Text style={{ color: "#fff", fontSize: 22, left: 20, top: 15 }}>
              {chosenCourse}
            </Text>
          </View>

          {RoleID === LECTURER ? (
            <View style={{ flex: 1 }}>
              {CourseData && CourseData.length > 0 ? (
                <View style={{ flex: 1 }}>
                  <Carousel
                    ref={c => {
                      this._carousel = c;
                    }}
                    data={CourseData}
                    renderItem={this._renderItem}
                    sliderWidth={deviceWidth}
                    itemWidth={deviceWidth}
                    onBeforeSnapToItem={this.handleChangePie}
                    inactiveSlideScale={1}
                    inactiveSlideOpacity={1}
                  />
                  {this.pagination}
                </View>
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
                        style={{
                          fontWeight: "600",
                          fontSize: 20,
                          opacity: 0.4
                        }}
                      >
                        אין מידע על הקורס
                      </Text>
                    </View>
                  )}
                </View>
              )}
            </View>
          ) : (
            <CoursePie
              CourseData={CourseData}
              Fetching={Fetching}
              size={"medium"}
              progressBar={true}
            />
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
      </Modal>
    );
  }
}
