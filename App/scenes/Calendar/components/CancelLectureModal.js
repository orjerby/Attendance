import React from "react";
import { StyleSheet, Text, Animated } from "react-native";
import Ripple from "react-native-material-ripple";

export default class CancelLectureModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      right: new Animated.Value(-50),
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
  };

  handleCancelLecture = ({ wantToCancel, lectureID }) => {
    this.props.handleCancelLecture({ wantToCancel, lectureID });
  };

  render() {
    const { wantToCancel, lectureID } = this.props;
    return (
      <Animated.View
        style={{
          opacity: this.props.modalOpacity,
          width: 120,
          height: 45,
          backgroundColor: "#fff",
          position: "absolute",
          top: 6,
          right: this.state.right,
          borderRadius: 2,
          elevation: 10
        }}
      >
        <Ripple
          style={{ paddingTop: 10, paddingBottom: 10 }}
          onPress={() => {
            this.handleCancelLecture({
              wantToCancel: wantToCancel,
              lectureID: lectureID
            });
          }}
          disabled={this.state.optionDisable ? true : false}
          rippleCentered={true}
        >
          <Text style={{ fontSize: 18, marginLeft: 10 }}>
            {wantToCancel ? "בטל הרצאה" : "קיים הרצאה"}
          </Text>
        </Ripple>
      </Animated.View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center"
  }
});
