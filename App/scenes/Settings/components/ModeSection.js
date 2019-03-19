import React from "react";
import { Text, View, Dimensions, TextInput } from "react-native";
import Ripple from "react-native-material-ripple";
var { width: deviceWidth } = Dimensions.get("window");

export default class ModeSection extends React.Component {
  handleChangeMode = ({ qRMode }) => {
    this.props.handleChangeMode({ qRMode });
  };

  render() {
    const { QRMode, Updating } = this.props;

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
            מצב הרצאה נוכחי
          </Text>
          <TextInput
            style={{ marginLeft: deviceWidth / 2, marginLeft: 5, height: 18 }}
            textAlign="right"
            underlineColorAndroid="transparent"
            value={QRMode ? "ברקוד" : "טיימר"}
            editable={false}
          />
          <View
            style={{
              marginTop: 2,
              borderBottomColor: Updating ? "#666666" : "#808080",
              borderBottomWidth: 0.5
            }}
          />
        </View>
        {QRMode ? (
          <Ripple
            style={{
              backgroundColor: Updating ? "#108888" : "#15aaaa",
              width: deviceWidth - 20,
              height: 25,
              alignSelf: "center",
              marginTop: 5
            }}
            onPress={() => {
              this.handleChangeMode({ qRMode: false });
            }}
            rippleCentered={true}
            disabled={Updating}
          >
            <Text
              style={{
                textAlign: "center",
                color: Updating ? "#cccccc" : "#fff",
                fontSize: 15,
                marginTop: 1
              }}
            >
              שנה למצב טיימר
            </Text>
          </Ripple>
        ) : (
          <Ripple
            style={{
              backgroundColor: Updating ? "#108888" : "#15aaaa",
              width: deviceWidth - 20,
              height: 25,
              alignSelf: "center",
              marginTop: 5
            }}
            onPress={() => {
              this.handleChangeMode({ qRMode: true });
            }}
            rippleCentered={true}
            disabled={Updating}
          >
            <Text
              style={{
                textAlign: "center",
                color: Updating ? "#cccccc" : "#fff",
                fontSize: 15,
                marginTop: 1
              }}
            >
              שנה למצב ברקוד
            </Text>
          </Ripple>
        )}
      </View>
    );
  }
}
