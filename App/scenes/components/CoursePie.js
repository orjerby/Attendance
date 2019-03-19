import React from "react";
import { StyleSheet, Text, View, Dimensions, StatusBar } from "react-native";
import { PieChart, ProgressCircle } from "react-native-svg-charts";
import { Svg } from "expo";
import PieMenu from "./PieMenu";

var { height: deviceHeight } = Dimensions.get("window");
const { Text: SvgText } = Svg;

export default class CoursePie extends React.Component {
  statusData = () => {
    const { CourseData } = this.props;
    const {
      MissCount,
      LateCount,
      HereCount,
      JustifyCount,
      MissPercentage,
      LatePercentage,
      HerePercentage,
      JustifyPercentage
    } = CourseData === null ? {} : CourseData;
    if (CourseData) {
      return [
        {
          key: 1,
          count: MissCount,
          percentage: MissPercentage,
          svg: { fill: "#ff0000" }
        },
        {
          key: 2,
          count: LateCount,
          percentage: LatePercentage,
          svg: { fill: "#ffa500" }
        },
        {
          key: 3,
          count: HereCount,
          percentage: HerePercentage,
          svg: { fill: "#008000" }
        },
        {
          key: 4,
          count: JustifyCount,
          percentage: JustifyPercentage,
          svg: { fill: "#800080" }
        }
      ];
    }
  };

  render() {
    const { CourseData, Fetching, size, progressBar } = this.props;
    const { TotalLectureCount, PastLectureCount, FutureLectureCount } =
      CourseData === null ? {} : CourseData;

    const Labels = ({ slices }) => {
      return slices.map((slice, index) => {
        const { pieCentroid, data } = slice;
        return (
          <SvgText
            key={index}
            x={pieCentroid[0]}
            y={pieCentroid[1]}
            fill={"black"}
            textAnchor={"middle"}
            alignmentBaseline={"middle"}
            fontSize={size === "small" ? 12 : size === "medium" && 15}
            stroke={"black"}
            strokeWidth={0.5}
          >
            {progressBar
              ? `${
                  data.percentage > 10
                    ? `${data.percentage}% (${data.count})`
                    : ""
                }`
              : `${
                  parseFloat(data.percentage) > 10 ? `${data.percentage}%` : ""
                }`}
          </SvgText>
        );
      });
    };

    return (
      <View style={{ flex: 1 }}>
        {CourseData ? (
          <View style={styles.container}>
            <View style={{ marginBottom: 10 }}>
              <PieChart
                style={{
                  height: size === "small" ? 200 : size === "medium" && 300,
                  width: size === "small" ? 200 : size === "medium" && 300
                }}
                valueAccessor={({ item }) => item.count}
                data={this.statusData()}
                spacing={0}
                outerRadius={"95%"}
              >
                <Labels />
              </PieChart>

              {progressBar && (
                <ProgressCircle
                  style={{
                    height:
                      size === "small"
                        ? 200 * 0.4833
                        : size === "medium" && 300 * 0.4833,
                    width:
                      size === "small"
                        ? 200 * 0.4833
                        : size === "medium" && 300 * 0.4833,
                    position: "absolute", // 145 * 0.4833
                    left:
                      size === "small"
                        ? 200 / 2 - (200 * 0.4833) / 2
                        : size === "medium" && 300 / 2 - (300 * 0.4833) / 2,
                    top:
                      size === "small"
                        ? 200 * 0.26
                        : size === "medium" && 300 * 0.26
                  }}
                  progress={PastLectureCount / TotalLectureCount}
                  progressColor={"black"}
                />
              )}

              {progressBar && (
                <Text
                  style={{
                    position: "absolute",
                    left:
                      size === "small"
                        ? 200 / 2 - 26
                        : size === "medium" && 300 / 2 - 30,
                    top:
                      size === "small"
                        ? 200 * 0.4333
                        : size === "medium" && 300 * 0.4333,
                    textAlign: "center",
                    fontWeight: "bold",
                    fontSize: size === "small" ? 12 : size === "medium" && 16
                  }}
                >
                  {FutureLectureCount === 0
                    ? `אין עוד     ${"\n"}הרצאות      `
                    : FutureLectureCount === 1
                    ? `נשארה${"\n"}   הרצאה אחת `
                    : `נשארו ${FutureLectureCount}     ${"\n"} הרצאות     `}
                </Text>
              )}
            </View>

            <PieMenu progressBar={progressBar} />
          </View>
        ) : (
          !Fetching && (
            <View
              style={{
                justifyContent: "center",
                alignItems: "center",
                height: deviceHeight - StatusBar.currentHeight - 55
              }}
            >
              <Text style={{ fontWeight: "600", fontSize: 20, opacity: 0.4 }}>
                אין מידע על הקורס
              </Text>
            </View>
          )
        )}
      </View>
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
