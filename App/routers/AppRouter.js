import React from "react";
import { connect } from "react-redux";
import Login from "../scenes/Login/Login";
import { createStackNavigator, createDrawerNavigator } from "react-navigation";
import DrawerMenu from "./components/DrawerMenu";
import { LECTURER, STUDENT, LOCATION_MANAGER } from "../configuration";
import { Dimensions, StatusBar } from "react-native";

import Home from "./../scenes/Home/Home";
import Calendar from "./../scenes/Calendar/Calendar";
import Courses from "./../scenes/Courses/Courses";
import Settings from "./../scenes/Settings/Settings";
import Forms from "./../scenes/Forms/Forms";
import DrawerButton from "./components/DrawerButton";

var { width: deviceWidth } = Dimensions.get("window");

const stackForLecturer = createStackNavigator(
  {
    Home: {
      screen: Home
    },
    Calendar: {
      screen: Calendar
    },
    Courses: {
      screen: Courses
    },
    Settings: {
      screen: Settings
    },
    Login: {
      screen: Login
    }
  },
  {
    navigationOptions: ({ navigation }) => ({
      headerLeft: <DrawerButton navigation={navigation} />,
      headerTransparent: true,
      headerStyle: { marginTop: -StatusBar.currentHeight }
    })
  }
);

const stackForStudent = createStackNavigator(
  {
    Home: {
      screen: Home
    },
    Calendar: {
      screen: Calendar
    },
    Courses: {
      screen: Courses
    },
    Forms: {
      screen: Forms
    },
    Settings: {
      screen: Settings
    },
    Login: {
      screen: Login
    }
  },
  {
    navigationOptions: ({ navigation }) => ({
      headerLeft: <DrawerButton navigation={navigation} />,
      headerTransparent: true,
      headerStyle: { marginTop: -StatusBar.currentHeight }
    })
  }
);

const stackForLocationManager = createStackNavigator(
  {
    Home: {
      screen: Home
    },
    Settings: {
      screen: Settings
    },
    Login: {
      screen: Login
    }
  },
  {
    navigationOptions: ({ navigation }) => ({
      headerLeft: <DrawerButton navigation={navigation} />,
      headerTransparent: true,
      headerStyle: { marginTop: -StatusBar.currentHeight }
    })
  }
);

const DrawerForLocationManager = createDrawerNavigator(
  {
    Main: { screen: stackForLocationManager }
  },
  {
    drawerPosition: "left",
    drawerWidth: (deviceWidth * 60) / 100,
    contentComponent: DrawerMenu
  }
);

const DrawerForLecturer = createDrawerNavigator(
  {
    Main: { screen: stackForLecturer }
  },
  {
    drawerPosition: "left",
    drawerWidth: (deviceWidth * 60) / 100,
    contentComponent: DrawerMenu
  }
);

const DrawerForStudent = createDrawerNavigator(
  {
    Main: { screen: stackForStudent }
  },
  {
    drawerPosition: "left",
    drawerWidth: (deviceWidth * 60) / 100,
    contentComponent: DrawerMenu
  }
);

class AppRouter extends React.Component {
  render() {
    if (this.props.userObject.User === null) {
      return <Login />;
    } else if (
      this.props.userObject.User &&
      this.props.userObject.User.Role.RoleID === LECTURER
    ) {
      return <DrawerForLecturer />;
    } else if (
      this.props.userObject.User &&
      this.props.userObject.User.Role.RoleID === STUDENT
    ) {
      return <DrawerForStudent />;
    } else if (
      this.props.userObject.User &&
      this.props.userObject.User.Role.RoleID === LOCATION_MANAGER
    ) {
      return <DrawerForLocationManager />;
    }
  }
}

const mapStateToProps = state => ({
  userObject: state.user
});

export default connect(mapStateToProps)(AppRouter);
