import 'package:flutter_bloc/flutter_bloc.dart';

import '../EventManagement/file_event.dart';
import '../StateManagement/file_state.dart';

class FileHandlerBloc extends Bloc<FilesEvent,FileStates>{
  FileHandlerBloc() : super(ImageInitialState()){
    on<ImageFileEvent>((event, emit) {
      emit(ImageFileState(filePath: event.filePath));
    },);
  }
}