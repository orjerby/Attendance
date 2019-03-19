import React from "react";
import { Text, View, Dimensions, TextInput } from "react-native";
import Ripple from "react-native-material-ripple";
var { width: deviceWidth } = Dimensions.get("window");

export default class EmailSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      newEmailInput: "",
      newEmailFocused: false
    };
  }

  handleUpdateEmail = () => {
    this.props.handleUpdateEmail({ email: this.state.newEmailInput });
  };

  isValidEmail = () => {
    const reg = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (reg.test(this.state.newEmailInput) === false) {
      return false;
    } else {
      return true;
    }
  };

  render() {
    const { Email, Updating } = this.props;
    const { newEmailFocused } = this.state;
    let newEmailBorderColor = null;

    if (newEmailFocused) {
      if (Updating) {
        newEmailBorderColor = "#108888";
      } else {
        newEmailBorderColor = "#15aaaa";
      }
    } else {
      if (Updating) {
        newEmailBorderColor = "#cccccc";
      } else {
        newEmailBorderColor = "#fff";
      }
    }

    return (
      <View>
        <View
          style={{
            backgroundColor: Updating ? "#cccccc" : "#fff",
            width: deviceWidth - 20,
            borderWidth: 1,
            borderColor: Updating ? "#108888" : "#15aaaa",
            alignSelf: "flex-start",
            alignSelf: "center"
          }}
        >
          <Text style={{ fontSize: 12, marginLeft: 5, marginTop: 5 }}>
            אימייל נוכחי
          </Text>
          <TextInput
            style={{
              marginLeft: deviceWidth / 2,
              marginLeft: 5,
              height: 18,
              backgroundColor: Updating ? "#cccccc" : "#fff"
            }}
            textAlign="right"
            underlineColorAndroid="transparent"
            value={Email}
            editable={false}
          />
          <View
            style={{
              marginTop: 2,
              marginBottom: 2,
              borderBottomColor: Updating ? "#666666" : "#808080",
              borderBottomWidth: 0.5
            }}
          />
          <Text style={{ fontSize: 12, marginLeft: 5 }}>אימייל חדש</Text>
          <TextInput
            style={{
              borderWidth: 1,
              borderColor: newEmailBorderColor,
              marginLeft: 5,
              marginRight: 50,
              height: 18,
              backgroundColor: Updating ? "#cccccc" : "#fff"
            }}
            textAlign="right"
            underlineColorAndroid="transparent"
            onChangeText={newEmailInput => this.setState({ newEmailInput })}
            value={this.state.newEmailInput}
            onFocus={() => this.setState({ newEmailFocused: true })}
            onEndEditing={() => this.setState({ newEmailFocused: false })}
            editable={Updating ? false : true}
          />
          <View
            style={{
              marginTop: 2,
              borderBottomColor: Updating ? "#666666" : "#808080",
              borderBottomWidth: 0.5
            }}
          />
        </View>

        <Ripple
          style={{
            backgroundColor: Updating ? "#108888" : "#15aaaa",
            width: deviceWidth - 20,
            height: 25,
            alignSelf: "center",
            marginTop: 5,
            opacity: this.isValidEmail() ? 1 : 0.5
          }}
          onPress={() => {
            this.handleUpdateEmail();
          }}
          rippleCentered={true}
          disabled={!this.isValidEmail() || Updating}
        >
          <Text
            style={{
              textAlign: "center",
              color: Updating ? "#cccccc" : "#fff",
              fontSize: 15,
              marginTop: 1
            }}
          >
            שנה אימייל
          </Text>
        </Ripple>
      </View>
    );
  }
}
