abstract class SignInStates {}

class SignInInitialStates extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSuccessState extends SignInStates {}

class SignInEmailInitStateState extends SignInStates {}

class SignInErrorState extends SignInStates {
  String msg;
  SignInErrorState(
    this.msg,
  );
}
