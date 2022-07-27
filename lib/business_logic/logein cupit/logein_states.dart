abstract class LoginState {}

class IntiLoginState extends LoginState {}

class LodingLoginState extends LoginState {}
class ScLoginState extends LoginState {}
class ErrorLoginState extends LoginState {
  final String error;
  ErrorLoginState(this.error);
}

class LodingRegisteState extends LoginState {}
class ScRegisteState extends LoginState {}
class ErrorRegisteState extends LoginState {
  final String error;
  ErrorRegisteState(this.error);
}



class ChangeLang extends LoginState {}
