import React from "react";
import { Button, Image, View } from "react-native";
import { ImagePicker } from "expo";

export default class ImagePick extends React.Component {
  state = {
    image: null
  };

  render() {
    let { image } = this.state;

    return (
      <View style={{ alignItems: "center", justifyContent: "center" }}>
        <Button title="בחר תמונה" onPress={this._pickImage} />
        {image && (
          <Image source={{ uri: image }} style={{ width: 200, height: 200 }} />
        )}
      </View>
    );
  }

  _pickImage = async () => {
    let result = await ImagePicker.launchImageLibraryAsync({
      base64: true,
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      quality: 1
    });

    if (!result.cancelled) {
      this.setState({ image: result.uri });
    }

    this.props.handleImage(result);
  };
}
