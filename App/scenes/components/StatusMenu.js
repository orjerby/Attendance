import React from "react";
import { Text, View } from "react-native";
import Ripple from "react-native-material-ripple";
import { MISS, LATE, HERE, JUSTIFY, ALL_STATUSES } from "../../configuration";

export default class StatusMenu extends React.Component {
  handleSelectMenuItem = ({ statusStudentsToShow }) => {
    this.props.handleSelectMenuItem({ statusStudentsToShow });
  };

  render() {
    const {
      statusStudentsToShow,
      showJustify,
      MissCount,
      LateCount,
      HereCount,
      JustifyCount,
      height,
      statusOptionsModalVisible = false,
      backgroundColor,
      color,
      borderColor,
      showPie
    } = this.props;

    return (
      <View style={{ flexDirection: "row" }}>
        {showPie === true && (
          <Ripple
            style={{
              flex: 1,
              height: height,
              backgroundColor: backgroundColor,
              borderBottomWidth: 3,
              borderBottomColor:
                statusStudentsToShow === ALL_STATUSES
                  ? borderColor
                  : backgroundColor
            }}
            onPress={() => {
              statusStudentsToShow === ALL_STATUSES
                ? {}
                : this.handleSelectMenuItem({
                    statusStudentsToShow: ALL_STATUSES
                  });
            }}
            disabled={statusOptionsModalVisible ? true : false}
            rippleCentered={true}
          >
            <View style={{ alignSelf: "center", marginTop: 20 }}>
              <Text
                style={
                  statusStudentsToShow === ALL_STATUSES
                    ? { color: borderColor, fontSize: 15 }
                    : { color: color, fontSize: 15 }
                }
              >
                סטטיסטיקה
              </Text>
            </View>
          </Ripple>
        )}
        <Ripple
          style={{
            flex: 1,
            height: height,
            backgroundColor: backgroundColor,
            borderBottomWidth: 3,
            borderBottomColor:
              statusStudentsToShow === HERE ? borderColor : backgroundColor
          }}
          onPress={() => {
            statusStudentsToShow === HERE
              ? {}
              : this.handleSelectMenuItem({ statusStudentsToShow: HERE });
          }}
          disabled={statusOptionsModalVisible ? true : false}
          rippleCentered={true}
        >
          <View style={{ alignSelf: "center", marginTop: 20 }}>
            <Text
              style={
                statusStudentsToShow === HERE
                  ? { color: borderColor, fontSize: 15 }
                  : { color: color, fontSize: 15 }
              }
            >
              נוכחים ({HereCount})
            </Text>
          </View>
        </Ripple>
        {showJustify === true && (
          <Ripple
            style={{
              flex: 1,
              height: height,
              backgroundColor: backgroundColor,
              borderBottomWidth: 3,
              borderBottomColor:
                statusStudentsToShow === JUSTIFY ? borderColor : backgroundColor
            }}
            onPress={() => {
              statusStudentsToShow === JUSTIFY
                ? {}
                : this.handleSelectMenuItem({ statusStudentsToShow: JUSTIFY });
            }}
            disabled={statusOptionsModalVisible ? true : false}
            rippleCentered={true}
          >
            <View style={{ alignSelf: "center", marginTop: 20 }}>
              <Text
                style={
                  statusStudentsToShow === JUSTIFY
                    ? { color: borderColor, fontSize: 15 }
                    : { color: color, fontSize: 15 }
                }
              >
                מוצדקים ({JustifyCount})
              </Text>
            </View>
          </Ripple>
        )}
        <Ripple
          style={{
            flex: 1,
            height: height,
            backgroundColor: backgroundColor,
            borderBottomWidth: 3,
            borderBottomColor:
              statusStudentsToShow === LATE ? borderColor : backgroundColor
          }}
          onPress={() => {
            statusStudentsToShow === LATE
              ? {}
              : this.handleSelectMenuItem({ statusStudentsToShow: LATE });
          }}
          disabled={statusOptionsModalVisible ? true : false}
          rippleCentered={true}
        >
          <View style={{ alignSelf: "center", marginTop: 20 }}>
            <Text
              style={
                statusStudentsToShow === LATE
                  ? { color: borderColor, fontSize: 15 }
                  : { color: color, fontSize: 15 }
              }
            >
              מאחרים ({LateCount})
            </Text>
          </View>
        </Ripple>
        <Ripple
          style={{
            flex: 1,
            height: height,
            backgroundColor: backgroundColor,
            borderBottomWidth: 3,
            borderBottomColor:
              statusStudentsToShow === MISS ? borderColor : backgroundColor
          }}
          onPress={() => {
            statusStudentsToShow === MISS
              ? {}
              : this.handleSelectMenuItem({ statusStudentsToShow: MISS });
          }}
          disabled={statusOptionsModalVisible ? true : false}
          rippleCentered={true}
        >
          <View style={{ alignSelf: "center", marginTop: 20 }}>
            <Text
              style={
                statusStudentsToShow === MISS
                  ? { color: borderColor, fontSize: 15 }
                  : { color: color, fontSize: 15 }
              }
            >
              נעדרים ({MissCount})
            </Text>
          </View>
        </Ripple>
      </View>
    );
  }
}
