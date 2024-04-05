import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class MediaService {
  static Future<XFile?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: source, maxWidth: 400, maxHeight: 400);

      return image;
    } catch (e) {
      return null;
    }
  }

  static Future<Uint8List> compressImage(Uint8List bytes,
      {int maxLength = 1000000}) async {
    int imageLength = bytes.length;
    if (imageLength < maxLength) return bytes;
    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return Uint8List.fromList(newByte);
  }
}
