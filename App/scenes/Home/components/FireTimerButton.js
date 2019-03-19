import React from "react";
import { Text } from "react-native";
import Ripple from "react-native-material-ripple";

export default class FireTimerButton extends React.Component {
  handleFireTimer = () => {
    this.props.handleFireTimer();
  };

  render() {
    return (
      <Ripple
        style={{ marginTop: 45 }}
        onPress={() => {
          this.handleFireTimer();
        }}
        rippleCentered={true}
      >
        <Text style={{ color: "#15aaaa", fontSize: 15, alignSelf: "center" }}>
          הפעל טיימר
        </Text>
      </Ripple>
    );
  }
}
