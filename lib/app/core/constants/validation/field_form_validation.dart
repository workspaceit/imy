// todo -> username validation
String? usernameValidation(String value) {
  if (value.isEmpty) {
    return "Please, fill up this field.";
  } else {
    return null;
  }
}

// todo -> email validation
String? emailValidation(String value) {
  if (value.isEmpty) {
    return "Please enter email";
  } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Please enter valid email";
  } else {
    return null;
  }
}

// todo -> password validation
String? passwordValidation(String value) {
  if (value.isEmpty) {
    return "Please enter password.";
  } else if(value.length < 4){
    return "Please enter valid password";
  }else{
    return null;
  }
}

// todo -> phone number validation
String? contactNumberValidation(String value) {
  if (value.isEmpty) {
    return "Please enter contact number";
  } else if(! RegExp(r'^0*(\d{3})-*(\d{3})-*(\d{4})$').hasMatch(value)){
    return "Please enter valid contact number";
  }else {
    return null;
  }
}