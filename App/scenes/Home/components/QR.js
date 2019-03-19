import React from "react";
import { View, Dimensions } from "react-native";
import QRCode from "react-native-qrcode";
import Ripple from "react-native-material-ripple";
var { width: deviceWidth } = Dimensions.get("window");

export default class QR extends React.Component {
  render() {
    const { QRData, QRIsOpen } = this.props;

    return (
      <View>
        {QRIsOpen ? (
          <QRCode
            value={QRData}
            size={deviceWidth - 10}
            bgColor="#15aaaa"
            fgColor="white"
          />
        ) : (
          <Ripple onPress={this.props.handleOpenQR} rippleCentered={true}>
            <QRCode
              value={QRData}
              size={100}
              bgColor="#15aaaa"
              fgColor="white"
            />
          </Ripple>
        )}
      </View>
    );
  }
}
