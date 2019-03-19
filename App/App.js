import React from "react";
import { Provider } from "react-redux";
import configureStore from "./store/configureStore";
import AppRouter from "./routers/AppRouter";
import { Asset, AppLoading, Font } from "expo";

const store = configureStore();

console.disableYellowBox = true;

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isReady: false
    };
  }

  async _cacheResourcesAsync() {
    await Font.loadAsync({
      Ionicons: require("./assets/Ionicons.ttf"),
      MaterialIcons: require("./assets/MaterialIcons.ttf"),
      FontAwesome: require("./assets/FontAwesome.ttf")
    });

    const images = [
      require("./assets/calendar.png"),
      require("./assets/drawerIcon.png"),
      require("./assets/error.png"),
      require("./assets/options.png"),
      require("./assets/lecture.png"),
      require("./assets/students.png"),
      require("./assets/success.png"),
      require("./assets/stopwatch.png"),
      require("./assets/calendarImage.jpg"),
      require("./assets/navigationGreen.png"),
      require("./assets/navigationRed.png"),
      require("./assets/class.png"),
      require("./assets/course.png"),
      require("./assets/form.png"),
      require("./assets/logo.png")
    ];

    const cacheImages = images.map(image => {
      return Asset.fromModule(image).downloadAsync();
    });
    return Promise.all(cacheImages);
  }

  render() {
    return this.state.isReady ? (
      <Provider store={store}>
        <AppRouter />
      </Provider>
    ) : (
      <AppLoading
        startAsync={this._cacheResourcesAsync}
        onFinish={() => this.setState({ isReady: true })}
        onError={this._cacheResourcesAsync}
      />
    );
  }
}
