import React from "react";
import { View, Dimensions, Modal, Image, StatusBar } from "react-native";
import { Icon } from "react-native-elements";
var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

export default class PictureModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  handleBack = () => {
    this.props.handleBack();
  };

  render() {
    const { picture } = this.props;
    return (
      <Modal
        onRequestClose={() => {
          this.handleBack();
        }}
        animationType="fade"
      >
        <View
          style={{
            width: deviceWidth,
            height: deviceHeight,
            backgroundColor: "#fff"
          }}
        >
          <View>
            <View
              style={{
                backgroundColor: "#15aaaa",
                width: deviceWidth,
                flexDirection: "row",
                height: 54,
                justifyContent: "space-between"
              }}
            >
              <View style={{ width: 35, top: 13, marginLeft: 15 }}>
                <Icon
                  name={"close"}
                  type={"AntDesign"}
                  size={35}
                  color={"#fff"}
                  onPress={this.props.handleBack}
                  underlayColor={"#15aaaa"}
                />
              </View>
            </View>

            <View
              style={{
                width: deviceWidth,
                height: deviceHeight - 54 - StatusBar.currentHeight
              }}
            >
              <Image
                source={{ uri: picture }}
                style={{ flex: 1 }}
                resizeMode={"stretch"}
              />
            </View>
          </View>
        </View>
      </Modal>
    );
  }
}
