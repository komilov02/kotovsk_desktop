
import 'package:file_picker/file_picker.dart';



Future<void> uploadFiles() async {
  FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'svg', 'webp'],
  );
  if (resultFile != null) {
    PlatformFile file = resultFile.files.first;
    print(file.name);
    print(file.bytes);
    print(file.extension);
    print(file.path);
  } else {
    // Handle if no file is picked
  }
}
