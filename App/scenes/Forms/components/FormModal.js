import React from "react";
import {
  Text,
  View,
  Dimensions,
  Modal,
  Image,
  TouchableWithoutFeedback,
  Animated,
  StatusBar
} from "react-native";
import { Icon } from "react-native-elements";
import DeleteFormModal from "./DeleteFormModal";
import moment from "moment";

var { width: deviceWidth, height: deviceHeight } = Dimensions.get("window");

export default class FormModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      deleteFormModalVisible: false,
      deleteFormModalOpacity: new Animated.Value(0)
    };
  }

  handleDeleteForm = () => {
    this.props.handleDeleteForm();
    this.handleCloseModalDeleteForm();
  };

  handleOpenModalDeleteForm = () => {
    this.setState(
      {
        deleteFormModalVisible: true,
        deleteFormModalOpacity: new Animated.Value(0)
      },
      () => {
        Animated.timing(this.state.deleteFormModalOpacity, {
          duration: 200,
          toValue: 1
        }).start();
      }
    );
  };

  handleCloseModalDeleteForm = () => {
    Animated.timing(this.state.deleteFormModalOpacity, {
      duration: 200,
      toValue: 0
    }).start(() => this.setState({ deleteFormModalVisible: false }));
  };

  handleBack = () => {
    if (this.state.deleteFormModalVisible) {
      this.handleCloseModalDeleteForm();
    } else {
      this.props.handleBack();
    }
  };

  render() {
    const { formID, openDate, endDate, picture } = this.props;
    const { deleteFormModalVisible } = this.state;
    return (
      <Modal
        onRequestClose={() => {
          this.handleBack();
        }}
        animationType="fade"
      >
        <TouchableWithoutFeedback onPress={this.handleCloseModalDeleteForm}>
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
                    onPress={
                      this.state.deleteFormModalVisible
                        ? this.handleCloseModalDeleteForm
                        : this.props.handleBack
                    }
                    disabled={
                      this.state.deleteFormModalVisible === false ? false : true
                    }
                    underlayColor={"#15aaaa"}
                  />
                </View>
                <Text
                  style={{ color: "#fff", fontSize: 18, top: 18 }}
                >{`${moment.utc(endDate).format("DD/MM/YYYY")} - ${moment
                  .utc(openDate)
                  .format("DD/MM/YYYY")}`}</Text>
                <View style={{ width: 35, top: 18, marginRight: 15 }}>
                  <Icon
                    name={"delete"}
                    type={"Ionicons"}
                    size={25}
                    color={"#fff"}
                    onPress={this.handleOpenModalDeleteForm}
                    underlayColor={"#15aaaa"}
                    disabled={
                      this.state.deleteFormModalVisible === false ? false : true
                    }
                  />
                </View>
              </View>

              {deleteFormModalVisible && (
                <DeleteFormModal
                  handleDeleteForm={this.handleDeleteForm}
                  modalOpacity={this.state.deleteFormModalOpacity}
                />
              )}

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
        </TouchableWithoutFeedback>
      </Modal>
    );
  }
}
