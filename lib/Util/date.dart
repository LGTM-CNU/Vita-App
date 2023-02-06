class Date {
  static String _numberToString(int n) {
    return "$n".length == 1 ? "0$n" : "$n";
  }

  static String serialize(DateTime date) {
    var meridiem = date.hour >= 12 ? "PM" : "AM";
    var hour = date.hour > 12 ? date.hour - 12 : date.hour;
    return "${date.year}/${_numberToString(date.month)}/${_numberToString(date.day)} ${_numberToString(hour)}:${_numberToString(date.minute)} $meridiem";
  }
}
