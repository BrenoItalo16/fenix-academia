bool emailValid(String email) {
  final RegExp regex = RegExp(
    r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$",
  );
  return regex.hasMatch(email);
}

weightValid(weightVal) {
  // final RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  // return regex.hasMatch(weightVal);
  return weightVal
      .replaceAll(RegExp(r'/\D/g'), '')
      .replaceAll(RegExp(r'/\D/g'), '');
}
