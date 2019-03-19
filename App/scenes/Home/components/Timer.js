import React from "react";
import { Text, View, Image } from "react-native";

export default class Timer extends React.Component {
  render() {
    const { TimerRemaining } = this.props;

    let minutes = Math.floor(TimerRemaining / 60);
    let seconds = TimerRemaining - minutes * 60;

    return (
      <View>
        <Image
          source={require("../../../assets/stopwatch.png")}
          style={{ position: "absolute", width: 100, height: 100 }}
        />

        <View>
          <View
            style={{
              marginLeft: 15,
              width: 70,
              height: 30,
              backgroundColor: "white",
              justifyContent: "center",
              marginTop: 38,
              marginBottom: 26
            }}
          >
            <Text
              style={{
                alignSelf: "center",
                fontSize: 16,
                fontWeight: "bold",
                color: "#424A60"
              }}
            >
              {minutes < 10 ? `0${minutes}` : minutes}:
              {seconds < 10 ? `0${seconds}` : seconds}
            </Text>
          </View>
        </View>
      </View>
    );
  }
}
