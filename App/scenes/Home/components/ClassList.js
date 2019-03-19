import React from "react";
import {
  Text,
  View,
  Dimensions,
  Image,
  StatusBar
} from "react-native";
import moment from "moment";
import { ListItem, Icon } from "react-native-elements";
var { height: deviceHeight } = Dimensions.get("window");

export default class Classes extends React.Component {
  handleUpdateClassLocation = ({ ClassID }) => {
    this.props.handleUpdateClassLocation({ ClassID });
  };

  render() {
    const { Class, Updating } = this.props;
    return (
      <View>
        {Class && (
          <View style={{ backgroundColor: Updating ? "#cccccc" : "#fff" }}>
            {Class.length > 0 ? (
              Class.map(class1 => {
                return (
                  <ListItem
                    key={class1.ClassID}
                    avatar={
                      <Image
                        source={require("../../../assets/class.png")}
                        style={{ width: 30, height: 30 }}
                      />
                    }
                    titleStyle={{ textAlign: "left" }}
                    title={class1.ClassName}
                    subtitleStyle={{ textAlign: "left" }}
                    subtitle={
                      class1.Longitude === 0 && class1.Latitude === 0
                        ? "עדכון אחרון: אף פעם"
                        : `עדכון אחרון: ${moment(
                            class1.LastLocationUpdate
                          ).format("DD/MM/YYYY")}`
                    }
                    rightIcon={
                      <Icon
                        name={"location-on"}
                        color={Updating ? "#108888" : "#15aaaa"}
                        size={40}
                        onPress={() =>
                          this.handleUpdateClassLocation({
                            ClassID: class1.ClassID
                          })
                        }
                      />
                    }
                  />
                );
              })
            ) : (
              <View>
                {!Fetching && (
                  <View
                    style={{
                      justifyContent: "center",
                      alignItems: "center",
                      height: deviceHeight - StatusBar.currentHeight - 55
                    }}
                  >
                    <Text
                      style={{ fontWeight: "600", fontSize: 20, opacity: 0.4 }}
                    >
                      אין כיתות
                    </Text>
                  </View>
                )}
              </View>
            )}
          </View>
        )}
      </View>
    );
  }
}
