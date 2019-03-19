import React from "react";
import {
  StyleSheet,
  View,
  Modal,
  Dimensions,
  Text,
  Platform,
  TouchableHighlight
} from "react-native";
import { CalendarList, LocaleConfig } from "react-native-calendars";
var { width: deviceWidth } = Dimensions.get("window");
import { Icon } from "react-native-elements";

LocaleConfig.locales["he"] = {
  monthNames: [
    "ינואר",
    "פברואר",
    "מרץ",
    "אפריל",
    "מאי",
    "יוני",
    "יולי",
    "אוגוסט",
    "ספטמבר",
    "אוקטובר",
    "נובמבר",
    "דצמבר"
  ],
  monthNamesShort: [
    "ינואר",
    "פברואר",
    "מרץ",
    "אפריל",
    "מאי",
    "יוני",
    "יולי",
    "אוגוסט",
    "ספטמבר",
    "אוקטובר",
    "נובמבר",
    "דצמבר"
  ],
  dayNames: ["ראשון", "שני", "שלישי", "רביעי", "חמישי", "שישי", "שבת"],
  dayNamesShort: ["א'", "ב'", "ג'", "ד'", "ה'", "ו'", "ש'"]
};

LocaleConfig.defaultLocale = "he";

export default class CalendarModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      markedDay: {},
      chosenDay: ""
    };
  }

  handleOnDayPress = day => {
    this.props.handleOnDayPress(day);
  };

  handleBack = () => {
    this.props.handleBack();
  };

  openCalendar = () => {
    this.calendar && this.calendar.open();
  };

  select = day => {
    if (day.dateString === this.state.chosenDay.dateString) {
      this.setState({ markedDay: {}, chosenDay: "" });
    } else {
      const markedDay = { [day.dateString]: { selected: true } };
      this.setState({ markedDay: markedDay, chosenDay: day });
    }
  };

  render() {
    return (
      <Modal
        onRequestClose={() => {
          this.handleBack();
        }}
        animationType="slide"
      >
        <View
          style={{ flex: 1, justifyContent: "center", alignItems: "center" }}
        >
          <View
            style={{
              backgroundColor: "#15aaaa",
              width: deviceWidth,
              paddingLeft: 25,
              flexDirection: "row",
              height: 50
            }}
          >
            <View style={{ width: 35, top: 8 }}>
              <Icon
                name={"close"}
                type={"AntDesign"}
                size={35}
                color={"#fff"}
                onPress={this.handleBack}
                underlayColor={"#15aaaa"}
              />
            </View>
            <Text style={{ color: "#fff", fontSize: 22, left: 20, top: 10 }}>
              בחר תאריך
            </Text>
          </View>

          <View
            style={{
              flexDirection: "row",
              backgroundColor: "#15aaaa",
              paddingTop: 10,
              paddingBottom: 10,
              borderColor: "#15aaaa",
              borderBottomColor: "#fff",
              borderWidth: 0.5
            }}
          >
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                marginLeft: 15,
                color: "#fff"
              }}
            >
              ראשון
            </Text>
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                color: "#fff"
              }}
            >
              שני
            </Text>
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                color: "#fff"
              }}
            >
              שלישי
            </Text>
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                color: "#fff"
              }}
            >
              רביעי
            </Text>
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                color: "#fff"
              }}
            >
              חמישי
            </Text>
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                color: "#fff"
              }}
            >
              שישי
            </Text>
            <Text
              style={{
                flex: 1,
                fontSize: 15,
                textAlign: "center",
                marginRight: 15,
                color: "#fff"
              }}
            >
              שבת
            </Text>
          </View>

          <CalendarList
            theme={{
              calendarBackground: "#15aaaa",
              selectedDayTextColor: "#15aaaa",
              todayTextColor: "#fff",
              textDisabledColor: "#d9e1e8",
              selectedDotColor: "#ffffff",
              monthTextColor: "#fff",
              textDayFontFamily: "monospace",
              textMonthFontFamily: "monospace",
              textMonthFontWeight: "bold",
              textMonthFontSize: 24,
              textDayHeaderFontSize: 0,
              "stylesheet.calendar.header": {
                header: {
                  paddingLeft: 10,
                  paddingRight: 10
                },
                week: {
                  marginTop: -20,
                  flexDirection: "row",
                  justifyContent: "space-between"
                }
              },
              "stylesheet.calendar.main": {
                week: {
                  marginTop: 15,
                  marginBottom: 15,
                  flexDirection: "row",
                  justifyContent: "space-around"
                },
                dayContainer: {
                  width: 45
                }
              },
              "stylesheet.day.basic": {
                base: {
                  width: 45,
                  height: 45,
                  alignItems: "center",
                  marginBottom: -13,
                  marginTop: -13
                },
                selected: {
                  backgroundColor: "#fff",
                  borderRadius: 50
                },
                today: {
                  backgroundColor: "#15aaaa",
                  borderColor: "#fff",
                  borderWidth: 1,
                  borderRadius: 50
                },
                text: {
                  marginTop: Platform.OS === "android" ? 12 : 14,
                  fontSize: 16,
                  fontFamily: "monospace",
                  fontWeight: "300",
                  color: "#fff",
                  backgroundColor: "rgba(255, 255, 255, 0)"
                }
              },
              "stylesheet.calendar-list.main": {
                placeholderText: {
                  fontSize: 30,
                  fontWeight: "200",
                  color: "#fff"
                }
              }
            }}
            calendarWidth={deviceWidth}
            onDayPress={this.select}
            markedDates={this.state.markedDay}
            pastScrollRange={12}
            futureScrollRange={12}
          />

          <View
            style={{
              backgroundColor: "#15aaaa",
              borderColor: "#15aaaa",
              borderTopColor: "#fff",
              borderWidth: 1,
              width: deviceWidth
            }}
          >
            <TouchableHighlight
              disabled={this.state.chosenDay === "" ? true : false}
              underlayColor="rgba(255, 255, 255, 0.45)"
              onPress={() => {
                this.handleOnDayPress(this.state.chosenDay);
                this.handleBack();
              }}
              style={{
                paddingTop: 10,
                paddingBottom: 10,
                backgroundColor:
                  this.state.chosenDay === ""
                    ? "rgba(255, 255, 255, 0.20)"
                    : "rgba(255, 255, 255, 0.45)",
                margin: 10,
                borderRadius: 4,
                flexDirection: "row"
              }}
            >
              <Text
                style={{
                  flex: 1,
                  fontSize: 20,
                  textAlign: "center",
                  marginRight: 15,
                  color: "#fff"
                }}
              >
                שמור
              </Text>
            </TouchableHighlight>
          </View>
        </View>
      </Modal>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center"
  }
});
