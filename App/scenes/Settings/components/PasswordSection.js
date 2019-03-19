import React from "react";
import { Text, View, Dimensions, TextInput } from "react-native";
import Ripple from "react-native-material-ripple";
var { width: deviceWidth } = Dimensions.get("window");

export default class PasswordSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentPasswordInput: "",
      newPasswordInput: "",
      newPasswordAgainInput: "",
      currentPasswordFocused: false,
      newPasswordFocused: false,
      newPasswordAgainFocused: false
    };
  }

  handleUpdatePassword = () => {
    this.props.handleUpdatePassword({
      currentPassword: this.state.currentPasswordInput,
      newPassword: this.state.newPasswordInput
    });
  };

  isValidPassword = () => {
    if (
      this.state.newPasswordInput.length >= 3 &&
      this.state.newPasswordAgainInput.length >= 3 &&
      this.state.newPasswordInput === this.state.newPasswordAgainInput &&
      this.state.currentPasswordInput.length >= 3
    ) {
      return true;
    }
    return false;
  };

  render() {
    const { Updating } = this.props;
    const {
      currentPasswordFocused,
      newPasswordFocused,
      newPasswordAgainFocused
    } = this.state;
    let currentPasswordBorderColor = null;
    let newPasswordBorderColor = null;
    let newPasswordAgainBorderColor = null;

    if (currentPasswordFocused) {
      if (Updating) {
        currentPasswordBorderColor = "#108888";
      } else {
        currentPasswordBorderColor = "#15aaaa";
      }
    } else {
      if (Updating) {
        currentPasswordBorderColor = "#cccccc";
      } else {
        currentPasswordBorderColor = "#fff";
      }
    }

    if (newPasswordFocused) {
      if (Updating) {
        newPasswordBorderColor = "#108888";
      } else {
        newPasswordBorderColor = "#15aaaa";
      }
    } else {
      if (Updating) {
        newPasswordBorderColor = "#cccccc";
      } else {
        newPasswordBorderColor = "#fff";
      }
    }

    if (newPasswordAgainFocused) {
      if (Updating) {
        newPasswordAgainBorderColor = "#108888";
      } else {
        newPasswordAgainBorderColor = "#15aaaa";
      }
    } else {
      if (Updating) {
        newPasswordAgainBorderColor = "#cccccc";
      } else {
        newPasswordAgainBorderColor = "#fff";
      }
    }

    return (
      <View>
        <View
          style={{
            backgroundColor: this.props.Updating ? "#cccccc" : "#fff",
            width: deviceWidth - 20,
            borderWidth: 1,
            borderColor: Updating ? "#108888" : "#15aaaa",
            alignSelf: "flex-start",
            alignSelf: "center"
          }}
        >
          <Text style={{ fontSize: 12, marginLeft: 5, marginTop: 5 }}>
            סיסמה נוכחית
          </Text>
          <TextInput
            style={{
              borderWidth: 1,
              borderColor: currentPasswordBorderColor,
              marginLeft: 5,
              marginRight: 50,
              height: 18
            }}
            textAlign="right"
            underlineColorAndroid="transparent"
            onChangeText={currentPasswordInput =>
              this.setState({ currentPasswordInput })
            }
            value={this.state.currentPasswordInput}
            onFocus={() => this.setState({ currentPasswordFocused: true })}
            onEndEditing={() =>
              this.setState({ currentPasswordFocused: false })
            }
            secureTextEntry={true}
            editable={Updating ? false : true}
          />
          <View
            style={{
              marginTop: 2,
              marginBottom: 2,
              borderBottomColor: Updating ? "#666666" : "#808080",
              borderBottomWidth: 0.5
            }}
          />
          <Text style={{ fontSize: 12, marginLeft: 5 }}>סיסמה חדשה</Text>
          <TextInput
            style={{
              borderWidth: 1,
              borderColor: newPasswordBorderColor,
              marginLeft: 5,
              marginRight: 50,
              height: 18
            }}
            textAlign="right"
            underlineColorAndroid="transparent"
            onChangeText={newPasswordInput =>
              this.setState({ newPasswordInput })
            }
            value={this.state.newPasswordInput}
            onFocus={() => this.setState({ newPasswordFocused: true })}
            onEndEditing={() => this.setState({ newPasswordFocused: false })}
            secureTextEntry={true}
            editable={Updating ? false : true}
          />
          <View
            style={{
              marginTop: 2,
              marginBottom: 2,
              borderBottomColor: Updating ? "#666666" : "#808080",
              borderBottomWidth: 0.5
            }}
          />
          <Text style={{ fontSize: 12, marginLeft: 5 }}>
            הקלד שוב סיסמה חדשה
          </Text>
          <TextInput
            style={{
              borderWidth: 1,
              borderColor: newPasswordAgainBorderColor,
              marginLeft: 5,
              marginRight: 50,
              height: 18
            }}
            textAlign="right"
            underlineColorAndroid="transparent"
            onChangeText={newPasswordAgainInput =>
              this.setState({ newPasswordAgainInput })
            }
            value={this.state.newPasswordAgainInput}
            onFocus={() => this.setState({ newPasswordAgainFocused: true })}
            onEndEditing={() =>
              this.setState({ newPasswordAgainFocused: false })
            }
            secureTextEntry={true}
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
            opacity: this.isValidPassword() ? 1 : 0.5
          }}
          onPress={() => {
            this.handleUpdatePassword();
          }}
          rippleCentered={true}
          disabled={!this.isValidPassword() || Updating}
        >
          <Text
            style={{
              textAlign: "center",
              color: Updating ? "#cccccc" : "#fff",
              fontSize: 15,
              marginTop: 1
            }}
          >
            שנה סיסמה
          </Text>
        </Ripple>
      </View>
    );
  }
}
