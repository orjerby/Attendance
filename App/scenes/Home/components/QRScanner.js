import React from "react";
import { View } from "react-native";
import { BarCodeScanner } from "expo";

export default class QRScanner extends React.Component {
  handleBarCodeRead = ({ data }) => {
    this.props.handleBarCodeRead({ data });
  };

  render() {
    const { hasCameraPermission } = this.props;
    return (
      <View>
        {hasCameraPermission && (
          <BarCodeScanner
            onBarCodeRead={this.props.handleBarCodeRead}
            style={{ height: 100, width: 100 }}
          />
        )}
      </View>
    );
  }
}
