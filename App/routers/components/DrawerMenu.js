import React, { Component } from "react";
import { StyleSheet, View, FlatList, BackHandler } from "react-native";
import { connect } from "react-redux";
import DrawerProfile from "./DrawerProfile";
import DrawerItem from "./DrawerItem";
import { popRoute } from "../../actions/routes";
import { StackActions, NavigationActions } from "react-navigation";
import { LECTURER, STUDENT, LOCATION_MANAGER } from "../../configuration";

class DrawerMenu extends Component {
  constructor(props) {
    super(props);
    this.state = {
      menuData: []
    };
  }

  componentDidMount() {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;
    BackHandler.addEventListener("hardwareBackPress", this.handleBackPress);
    let menuData = [];

    if (RoleID === LECTURER) {
      menuData = [
        { icon: "ios-home", name: "בית", screenName: "Home", key: "1" },
        {
          icon: "ios-calendar",
          name: "לוח שנה",
          screenName: "Calendar",
          key: "2"
        },
        { icon: "ios-pie", name: "קורסים", screenName: "Courses", key: "3" },
        {
          icon: "ios-settings",
          name: "הגדרות",
          screenName: "Settings",
          key: "4"
        },
        { icon: "ios-log-out", name: "יציאה", screenName: "Login", key: "5" }
      ];
    } else if (RoleID === STUDENT) {
      menuData = [
        { icon: "ios-home", name: "בית", screenName: "Home", key: "1" },
        {
          icon: "ios-calendar",
          name: "לוח שנה",
          screenName: "Calendar",
          key: "2"
        },
        { icon: "ios-pie", name: "קורסים", screenName: "Courses", key: "3" },
        { icon: "ios-paper", name: "אישורים", screenName: "Forms", key: "4" },
        {
          icon: "ios-settings",
          name: "הגדרות",
          screenName: "Settings",
          key: "5"
        },
        { icon: "ios-log-out", name: "יציאה", screenName: "Login", key: "6" }
      ];
    } else if (RoleID === LOCATION_MANAGER) {
      menuData = [
        { icon: "ios-home", name: "בית", screenName: "Home", key: "1" },
        {
          icon: "ios-settings",
          name: "הגדרות",
          screenName: "Settings",
          key: "2"
        },
        { icon: "ios-log-out", name: "יציאה", screenName: "Login", key: "3" }
      ];
    }

    this.setState({ menuData: menuData });
  }

  componentWillUnmount() {
    BackHandler.removeEventListener("hardwareBackPress", this.handleBackPress);
  }

  handleBackPress = () => {
    this.props.popRoute();
    let length = this.props.routes.length;
    if (length === 0) {
      return false;
    }
    let actions = this.props.routes.map((routeName, key) => {
      if (key === length - 1) {
        return NavigationActions.navigate({
          routeName: routeName,
          params: { screenIsActive: true }
        });
      } else {
        return NavigationActions.navigate({
          routeName: routeName,
          params: { screenIsActive: false }
        });
      }
    });
    const resetAction = StackActions.reset({
      index: length - 1,
      actions: [...actions]
    });
    this.props.navigation.dispatch(resetAction);
    return true;
  };

  render() {
    const { User } = this.props.userObject;
    const { Role: { RoleID } = {} } = User;

    return (
      <View style={styles.container}>
        {RoleID === LECTURER ? (
          <DrawerProfile
            picture={this.props.userObject.Lecturer.Picture}
            fullName={`${this.props.userObject.Lecturer.FirstName} ${
              this.props.userObject.Lecturer.LastName
            }`}
            email={this.props.userObject.Lecturer.Email}
          />
        ) : RoleID === STUDENT ? (
          <DrawerProfile
            picture={this.props.userObject.Student.Picture}
            fullName={`${this.props.userObject.Student.FirstName} ${
              this.props.userObject.Student.LastName
            }`}
            email={this.props.userObject.Student.Email}
          />
        ) : (
          RoleID === LOCATION_MANAGER && (
            <DrawerProfile
              fullName={`${this.props.userObject.LocationManager.FirstName} ${
                this.props.userObject.LocationManager.LastName
              }`}
              email={this.props.userObject.LocationManager.Email}
            />
          )
        )}
        <FlatList
          data={this.state.menuData}
          renderItem={({ item }) => (
            <DrawerItem
              navigation={this.props.navigation}
              screenName={item.screenName}
              icon={item.icon}
              name={item.name}
              key={item.key}
            />
          )}
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
  popRoute: () => dispatch(popRoute())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(DrawerMenu);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff"
  },
  menuItem: {
    flexDirection: "row"
  },
  menuItemText: {
    fontSize: 15,
    fontWeight: "300",
    margin: 15
  }
});
