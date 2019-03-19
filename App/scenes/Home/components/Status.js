import React from "react";
import { Text, View, Dimensions } from "react-native";
import { HERE, LATE, MISS, JUSTIFY } from "../../../configuration";
var { width: deviceWidth } = Dimensions.get("window");

export default class Status extends React.Component {
  render() {
    const { QRMode, StatusID, StatusName } = this.props;
    return (
      <View>
        {!QRMode && (
          <View style={{ width: deviceWidth - 50 }}>
            <Text
              style={{
                marginTop: 5,
                marginBottom: 8,
                fontSize: 20,
                textAlign: "center",
                color: "#000",
                fontWeight: "600"
              }}
            >
              סטטוס:{" "}
              <Text
                style={{
                  color:
                    StatusID === HERE
                      ? "green"
                      : StatusID === LATE
                      ? "orange"
                      : StatusID === MISS
                      ? "red"
                      : StatusID === JUSTIFY && "purple"
                }}
              >
                {StatusName}
              </Text>
            </Text>

            <Text
              style={{
                textAlign: "left",
                marginLeft: 15,
                fontSize: 15,
                color:
                  StatusID === MISS
                    ? "black"
                    : StatusID === LATE
                    ? "darkgray"
                    : StatusID === HERE
                    ? "darkgray"
                    : StatusID === JUSTIFY && "darkgray"
              }}
            >
              1. היכנס לכיתה
            </Text>
            <Text
              style={{
                textAlign: "left",
                marginBottom: 5,
                marginLeft: 15,
                fontSize: 15,
                color:
                  StatusID === MISS
                    ? "black"
                    : StatusID === LATE
                    ? "black"
                    : StatusID === HERE
                    ? "darkgray"
                    : StatusID === JUSTIFY && "darkgray"
              }}
            >
              2. עשה זאת תוך 15 דקות מתחילת השיעור
            </Text>
          </View>
        )}

        {QRMode && (
          <View style={{ width: deviceWidth - 50 }}>
            <Text
              style={{
                marginTop: 5,
                marginBottom: 8,
                fontSize: 20,
                textAlign: "center",
                color: "#000",
                fontWeight: "600"
              }}
            >
              סטטוס:{" "}
              <Text
                style={{
                  color:
                    StatusID === HERE
                      ? "green"
                      : StatusID === LATE
                      ? "orange"
                      : StatusID === MISS
                      ? "red"
                      : StatusID === JUSTIFY && "purple"
                }}
              >
                {StatusName}
              </Text>
            </Text>

            <Text
              style={{
                textAlign: "left",
                marginLeft: 15,
                fontSize: 15,
                color:
                  StatusID === MISS
                    ? "black"
                    : StatusID === LATE
                    ? "darkgray"
                    : StatusID === HERE
                    ? "darkgray"
                    : StatusID === JUSTIFY && "darkgray"
              }}
            >
              1. היכנס לכיתה
            </Text>
            <Text
              style={{
                textAlign: "left",
                marginBottom: 5,
                marginLeft: 15,
                fontSize: 15,
                color:
                  StatusID === MISS
                    ? "black"
                    : StatusID === LATE
                    ? "black"
                    : StatusID === HERE
                    ? "darkgray"
                    : StatusID === JUSTIFY && "darkgray"
              }}
            >
              2. סרוק את הברקוד של המרצה
            </Text>
          </View>
        )}
      </View>
    );
  }
}
