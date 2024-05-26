import 'package:image_picker/image_picker.dart';

abstract class FilesEvent{

}

class ImageFileEvent extends FilesEvent{
 final XFile filePath;
 ImageFileEvent({required this.filePath});
}