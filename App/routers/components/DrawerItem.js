import React, { Component } from "react";
import { TouchableOpacity, Text, StyleSheet, View } from "react-native";
import { Divider } from "react-native-elements";
import Icon from "react-native-vector-icons/Ionicons";
import { connect } from "react-redux";
import { StackActions, NavigationActions } from "react-navigation";
import { pushRoute, clearRoutes } from "../../actions/routes";

class DrawerItem extends Component {
  render() {
    const { navigation, icon, name, screenName } = this.props;

    return (
      <View>
        <TouchableOpacity
          style={styles.menuItem}
          onPress={() => {
            if (screenName === "Login") {
              this.props.clearRoutes();
            } else {
              this.props.pushRoute(screenName);
            }
            let length = this.props.routes.length;
            let actions = this.props.routes.map(routeName => {
              return NavigationActions.navigate({
                routeName: routeName,
                params: { screenIsActive: false }
              });
            });

            const resetAction = StackActions.reset({
              index: length,
              actions: [
                ...actions,
                NavigationActions.navigate({
                  routeName: screenName,
                  params: { screenIsActive: true }
                })
              ]
            });
            navigation.dispatch(resetAction);
          }}
        >
          <Icon
            name={icon}
            size={25}
            color="#15aaaa"
            style={{ margin: 15, marginLeft: 35 }}
          />
          <Text style={styles.menuItemText}>{name}</Text>
        </TouchableOpacity>
        <Divider
          style={{
            backgroundColor: "#15aaaa",
            height: 1,
            marginLeft: 15,
            marginRight: 15
          }}
        />
      </View>
    );
  }
}

const mapStateToProps = state => ({
  userObject: state.user,
  routes: state.routes
});

const mapDispatchToProps = dispatch => ({
  pushRoute: routeName => dispatch(pushRoute(routeName)),
  clearRoutes: () => dispatch(clearRoutes())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DrawerItem);

const styles = StyleSheet.create({
  menuItem: {
    flexDirection: "row",
    justifyContent: "flex-start"
  },
  menuItemText: {
    fontSize: 15,
    fontWeight: "600",
    margin: 18,
    marginLeft: 10,
    color: "#15aaaa"
  }
});
