import React from "react";
import { View, Text } from "react-native";
import { Avatar } from "react-native-elements";

export default (DrawerProfile = ({ picture, fullName, email }) => (
  <View style={{ padding: 15, backgroundColor: "#15aaaa" }}>
    <View
      style={{
        marginTop: 20,
        marginBottom: 5,
        borderRadius: 50,
        alignSelf: "center"
      }}
    >
      <Avatar
        width={60}
        height={60}
        rounded
        source={{ uri: picture }}
        overlayContainerStyle={{ backgroundColor: "#15aaaa" }}
      />
    </View>

    <View style={{ justifyContent: "center" }}>
      <Text
        style={{
          fontWeight: "600",
          fontSize: 18,
          color: "#fff",
          textAlign: "center"
        }}
      >
        {fullName}
      </Text>
      <Text
        style={{
          fontWeight: "300",
          fontSize: 12,
          color: "#e5e5e5",
          textAlign: "center"
        }}
      >
        {email}
      </Text>
    </View>
  </View>
));
