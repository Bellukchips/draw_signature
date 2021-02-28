import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

Future<Uint8List> getImages(String path) async {
  File file = new File(path);

  if (file.existsSync()) {
    var image = await file.readAsBytes();
    return image;
  } else {
    //convert string to bytes
    List<int> list = path.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    //
    Uint8List newPng = await removeWhiteBackground(bytes);
    file.writeAsBytes(newPng);
    return newPng;
  }
}

Future<Uint8List> removeWhiteBackground(Uint8List bytes) async {
  Image image = decodeImage(bytes);
  Image transparentImage = await colorTransparent(image, 255, 255, 255);
  var newPng = encodePng(transparentImage);
  return newPng;
}

Future<Image>colorTransparent(Image src, int red, int green, int blue) async {
  var pixels = src.getBytes(
    format: Format.rgb
  );
  for (int i = 0, len = pixels.length; i < len; i += 4) {
    if (pixels[i] == red && pixels[i + 1] == green && pixels[i + 2] == blue) {
      pixels[i + 3] = 0;
    }
  }

  return src;
}
