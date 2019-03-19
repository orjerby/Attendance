import React from "react";
import { Text, Animated } from "react-native";
import Ripple from "react-native-material-ripple";

export default class DeleteFormModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      right: new Animated.Value(-50),
      top: new Animated.Value(0),
      optionDisable: true
    };
  }

  componentDidMount = () => {
    setTimeout(() => {
      this.setState({ optionDisable: false });
    }, 200);

    Animated.timing(this.state.right, {
      duration: 100,
      toValue: 40
    }).start();

    Animated.timing(this.state.top, {
      duration: 100,
      toValue: 54
    }).start();
  };

  handleDeleteForm = () => {
    this.props.handleDeleteForm();
  };

  render() {
    return (
      <Animated.View
        style={{
          opacity: this.props.modalOpacity,
          width: 120,
          height: 45,
          backgroundColor: "#fff",
          position: "absolute",
          top: this.state.top,
          right: 0,
          borderRadius: 2,
          elevation: 10,
          zIndex: 2
        }}
      >
        <Ripple
          style={{ paddingTop: 10, paddingBottom: 10 }}
          onPress={() => {
            this.handleDeleteForm();
          }}
          disabled={this.state.optionDisable ? true : false}
          rippleCentered={true}
        >
          <Text style={{ fontSize: 18, marginLeft: 10 }}>מחק אישור</Text>
        </Ripple>
      </Animated.View>
    );
  }
}
