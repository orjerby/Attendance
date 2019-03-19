import React from "react";
import { View, TouchableOpacity, Image } from "react-native";
import { connect } from "react-redux";

class DrawerButton extends React.Component {
  render() {
    const { Updating } = this.props.messagesObject;
    return (
      <View style={{ marginLeft: 20 }}>
        <TouchableOpacity
          onPress={() => {
            this.props.navigation.openDrawer();
          }}
          disabled={Updating}
        >
          <Image
            source={require("../../assets/drawerIcon.png")}
            style={{ width: 25, height: 25 }}
          />
        </TouchableOpacity>
      </View>
    );
  }
}

const mapStateToProps = state => ({
  messagesObject: state.messages
});

export default connect(
  mapStateToProps,
  null
)(DrawerButton);
