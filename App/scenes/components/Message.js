import React from "react";
import { Text, View, Dimensions, Animated } from "react-native";

import Icon from "react-native-vector-icons/FontAwesome";
import Ripple from "react-native-material-ripple";
var { width: deviceWidth } = Dimensions.get("window");

export default class Message extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      messageBottom: new Animated.Value(-60)
    };
  }

  componentDidMount = () => {
    Animated.timing(this.state.messageBottom, {
      duration: 500,
      toValue: 0
    }).start();
  };

  handleCloseMessage = () => {
    Animated.timing(this.state.messageBottom, {
      duration: 500,
      toValue: -60
    }).start(() => this.props.handleCloseMessage());
  };

  handleOnClickButton = () => {
    Animated.timing(this.state.messageBottom, {
      duration: 500,
      toValue: -60
    }).start(() => this.props.handleOnClickButton());
  };

  render() {
    const { type, firstLine, secondLine, button } = this.props;
    return (
      <Animated.View
        style={{
          backgroundColor: "#b2b2b2",
          position: "absolute",
          bottom: this.state.messageBottom,
          width: deviceWidth,
          height: 60,
          padding: 10
        }}
      >
        <View
          style={{
            flexDirection: "row",
            flexWrap: "wrap",
            justifyContent: "space-between"
          }}
        >
          <Text
            style={{
              color: "red",
              marginLeft: 5,
              fontSize: 14,
              marginBottom: 2
            }}
          >
            {type}
          </Text>
          <View style={{ flex: 0.8 }}>
            <Text style={{ marginBottom: 2, fontSize: 14 }}>{firstLine}</Text>
            {button ? (
              <Ripple onPress={this.handleOnClickButton} rippleCentered={true}>
                <Text
                  style={{ marginBottom: 2, fontSize: 12, fontWeight: "700" }}
                >
                  {button}
                </Text>
              </Ripple>
            ) : (
              <Text style={{ marginBottom: 2, fontSize: 14 }}>
                {secondLine}
              </Text>
            )}
          </View>
          <Ripple onPress={this.handleCloseMessage} rippleCentered={true}>
            <Icon name="times" size={20} color="gray" />
          </Ripple>
        </View>
      </Animated.View>
    );
  }
}
