abstract class SignInState{

}

class SignInSuccessState extends SignInState{

}

class SignInFailed extends SignInState{
  final String error;
  SignInFailed({required this.error});
}

class SignInLoadState extends SignInState{

}

class SignInInitialState extends SignInState{
  
}