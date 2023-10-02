abstract class LoginStates{}
  class Logininit extends LoginStates{}
  class LoginLodingState extends LoginStates{}
  class LoginErrorState extends LoginStates{
  String Error;
  LoginErrorState(this.Error);
}
  class LoginSucssesState extends LoginStates{}
  class GetUserInformation extends LoginStates{}
  class LoadingGetUserInformation extends GetUserInformation{}
  class SucssesGetUserData extends GetUserInformation{}
  class ErrorGetUserData extends GetUserInformation{
  String Error;

  ErrorGetUserData(this.Error);
}
