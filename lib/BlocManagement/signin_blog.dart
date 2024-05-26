import 'package:flutter_bloc/flutter_bloc.dart';

import '../EventManagement/signin_event.dart';
import '../StateManagement/signin_state.dart';

class SignInBlog extends Bloc<SignInEvent,SignInState>{
  SignInBlog() : super(SignInInitialState()){

    on<SignInLoadEvent>((event, emit) {
      emit(SignInLoadState());
    },);

    on<SignInSuccessEvent>((event, emit) {
      emit(SignInSuccessState());
    },);

    on<SignInErrorEvent>((event, emit) {
      emit(SignInFailed(error: event.error));
    },);

    on<SignInInitialEvent>((event, emit) {
      emit(SignInInitialState());
    },);
  }
  
}