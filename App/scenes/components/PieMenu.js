import React from "react";
import { Text, View } from "react-native";

export default class PieMenu extends React.Component {
  render() {
    const { progressBar } = this.props;

    return (
      <View>
        {progressBar ? (
          <View style={{ flexDirection: "row" }}>
            <Text>נוכחות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#ff0000",
                width: 10,
                height: 10
              }}
            />
            <Text> איחורים </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#ffa500",
                width: 10,
                height: 10
              }}
            />
            <Text> העדרויות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#008000",
                width: 10,
                height: 10
              }}
            />
            <Text> הצדקות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#800080",
                width: 10,
                height: 10
              }}
            />
            <Text> התקדמות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "black",
                width: 10,
                height: 10
              }}
            />
          </View>
        ) : (
          <View style={{ flexDirection: "row" }}>
            <Text>נוכחות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#ff0000",
                width: 10,
                height: 10
              }}
            />
            <Text> איחורים </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#ffa500",
                width: 10,
                height: 10
              }}
            />
            <Text> העדרויות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#008000",
                width: 10,
                height: 10
              }}
            />
            <Text> הצדקות </Text>
            <View
              style={{
                top: 5,
                backgroundColor: "#800080",
                width: 10,
                height: 10
              }}
            />
          </View>
        )}
      </View>
    );
  }
}
