import React from "react";
import { StyleSheet, Text, Dimensions, Animated } from "react-native";
import Ripple from "react-native-material-ripple";
import { Divider } from "react-native-elements";
var { height: deviceHeight } = Dimensions.get("window");

export default class StatusOptionsModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      modalTop: new Animated.Value(this.props.modalTop),
      modalRight: new Animated.Value(-100),
      optionsDisabled: true
    };
  }

  componentDidMount = () => {
    const { modalOpacity, modalTop } = this.props;

    setTimeout(() => {
      this.setState({ optionsDisabled: false });
    }, 200);

    Animated.timing(modalOpacity, {
      duration: 200,
      toValue: 1
    }).start();
    if (deviceHeight - modalTop - 60 < 135) {
      Animated.timing(this.state.modalTop, {
        duration: 200,
        toValue: modalTop - 125
      }).start();
      Animated.timing(this.state.modalRight, {
        duration: 200,
        toValue: 0
      }).start();
    } else {
      Animated.timing(this.state.modalTop, {
        duration: 200,
        toValue: modalTop + 45
      }).start();
      Animated.timing(this.state.modalRight, {
        duration: 200,
        toValue: 0
      }).start();
    }
  };

  handleSelectStatusOption = ({ statusID }) => {
    this.props.handleSelectStatusOption({ statusID });
  };

  render() {
    const { statusOptions, modalOpacity } = this.props;
    const { modalTop, modalRight, optionsDisabled } = this.state;

    return (
      <Animated.View
        style={{
          backgroundColor: "#fff",
          top: modalTop,
          right: modalRight,
          position: "absolute",
          width: 115,
          height: 135,
          opacity: modalOpacity,
          borderRadius: 2,
          elevation: 10
        }}
      >
        <Text style={{ marginBottom: 10, fontSize: 18, textAlign: "center" }}>
          שנה סטטוס
        </Text>
        <Divider />
        {statusOptions &&
          statusOptions.map(statusOption => {
            return (
              <Ripple
                key={statusOption.StatusID}
                style={{ paddingTop: 13, paddingBottom: 13, marginRight: 5 }}
                onPress={() => {
                  this.handleSelectStatusOption({
                    statusID: statusOption.StatusID
                  });
                }}
                disabled={optionsDisabled ? true : false}
                rippleCentered={true}
              >
                <Text style={{ fontSize: 18, marginLeft: 10 }}>
                  {statusOption.StatusName}
                </Text>
              </Ripple>
            );
          })}
      </Animated.View>
    );
  }
}
