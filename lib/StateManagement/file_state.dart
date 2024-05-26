import 'package:image_picker/image_picker.dart';

abstract class FileStates{}

class ImageInitialState extends FileStates{
  
}

class ImageFileState extends FileStates{
  final XFile filePath;
  ImageFileState({required this.filePath});
}