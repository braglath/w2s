import 'package:get_storage/get_storage.dart';

class UserLoggedIn {
  final _userLoggedInBox = GetStorage();
  final _userLoggedInkey = 'userLoggedIn';

  // ? check user loggedin or not
  bool checkisUserLoggedIn() =>
      _userLoggedInBox.read(_userLoggedInkey) ?? false;
  // ? write user logged in or logged out
  Future<void> userLoggedIn(bool userLoggedIn) =>
      _userLoggedInBox.write(_userLoggedInkey, userLoggedIn);
}

class UserDetails {
  final _userNameBox = GetStorage();
  final _userPhoneBox = GetStorage();
  final _userEmailBox = GetStorage();
  final _userPasswordBox = GetStorage();
  final _userProfilePicBox = GetStorage();

  final _userNamekey = 'userName';
  final _userPhonekey = 'userPhoneNumber';
  final _userEmailkey = 'userEmail';
  final _userPasswordkey = 'userPassword';
  final _userProfilePickey = 'userProfilePic';

  // ? write user details
  Future<void> saveUserNametoBox(String userName) =>
      _userNameBox.write(_userNamekey, userName);

  Future<void> saveUserPhonetoBox(String userPhone) =>
      _userPhoneBox.write(_userPhonekey, userPhone);

  Future<void> saveUserEmailtoBox(String userEmail) =>
      _userEmailBox.write(_userEmailkey, userEmail);

  Future<void> saveUserPasswordtoBox(String userPassword) =>
      _userPasswordBox.write(_userPasswordkey, userPassword);

  Future<void> saveUserProfilePictoBox(String userProfilePic) =>
      _userProfilePicBox.write(_userProfilePickey, userProfilePic);

  // ? read user details
  String readUserNamefromBox() => _userNameBox.read(_userNamekey);
  String readUserPhonefromBox() => _userPhoneBox.read(_userPhonekey);
  String readUserEmailfromBox() => _userEmailBox.read(_userEmailkey);
  String readUserPasswordfromBox() => _userPasswordBox.read(_userPasswordkey);
  String readUserProfilePicfromBox() =>
      _userProfilePicBox.read(_userProfilePickey);

  // ? delete user details
  void deleteUserDetailsfromBox() {
    _userNameBox.erase();
    _userPhoneBox.erase();
    _userEmailBox.erase();
    _userPasswordBox.erase();
    _userProfilePicBox.erase();
    UserLoggedIn().userLoggedIn(false);
  }

  // ? save user details
  void saveUserDetailstoBox({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String profilepic,
  }) {
    saveUserNametoBox(name);
    saveUserPhonetoBox(phone);
    saveUserEmailtoBox(email);
    saveUserPasswordtoBox(password);
    saveUserProfilePictoBox(profilepic);
    UserLoggedIn().userLoggedIn(true);
  }
}
