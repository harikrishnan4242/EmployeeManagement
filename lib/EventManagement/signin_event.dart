abstract class SignInEvent{}

class SignInInitialEvent extends SignInEvent{

}

class SignInProgressEvent extends SignInEvent{

}

class SignInSuccessEvent extends SignInEvent{

}

class SignInLoadEvent extends SignInEvent{
  
}

class SignInErrorEvent extends SignInEvent{
  final String error;
  SignInErrorEvent({required this.error});
}