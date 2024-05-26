import 'package:image_picker/image_picker.dart';

class ImagePickerProperty {
  Future<XFile?> getGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

    Future<XFile?> getCameraImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    return image;
  }
}
