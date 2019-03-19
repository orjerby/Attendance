import React, { Component } from "react";
import DatePicker from "react-native-datepicker";

export default class DatePick extends Component {
  constructor(props) {
    super(props);
    this.state = { date: "" };
  }

  render() {
    return (
      <DatePicker
        androidMode={"spinner"}
        style={{ width: 200 }}
        date={this.state.date}
        mode="date"
        placeholder={
          this.props.placeholder ? this.props.placeholder : "בחר תאריך"
        }
        format="DD/MM/YYYY"
        minDate={this.props.minDate ? this.props.minDate : "1970-01-01"}
        confirmBtnText="אשר"
        cancelBtnText="בטל"
        customStyles={{
          dateIcon: {
            position: "absolute",
            left: 0,
            top: 4,
            marginLeft: 0
          },
          dateInput: {
            marginLeft: 36
          }
        }}
        onDateChange={date => {
          this.setState({ date: date });
          this.props.handleDate(date);
        }}
      />
    );
  }
}
