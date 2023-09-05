import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectoryPath {
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        await openAppSettings();
        return false;
      }
    }
    return false;
  }

  getPath() async {
    Directory? tempDir;
    if (Platform.isIOS) {
      // if (await _requestPermission(Permission.photos)) {
      //   tempDir = await getTemporaryDirectory();
      // } else {
      //   return false;
      // }
      tempDir = await getApplicationDocumentsDirectory();
    } else {
      tempDir = await getExternalStorageDirectory();
    }

    final filePath = Directory("${tempDir!.path}/files");
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }
}
//  if (Platform.isAndroid) {
//             if (await _requestPermission(Permission.storage)) {
//               directory = await getExternalStorageDirectory();
//               String newPath = "";
//               print(directory);
//               List<String> paths = directory.path.split("/");
//               for (int x = 1; x < paths.length; x++) {
//                 String folder = paths[x];
//                 if (folder != "Android") {
//                   newPath += "/$folder";
//                 } else {
//                   break;
//                 }
//               }
//               newPath = "$newPath/RPSApp";
//               directory = Directory(newPath);
//             } else {
//               return false;
//             }
//           } else {
//             if (await _requestPermission(Permission.photos)) {
//               directory = await getTemporaryDirectory();
//             } else {
//               return false;
//             }
//           }



//           class DirectoryPath {
//   getPath() async {
//     Directory? tempDir;
//     if (Platform.isIOS) {
//       tempDir = await getApplicationDocumentsDirectory();
//     } else {
//       tempDir = await getExternalStorageDirectory();
//     }

//     final filePath = Directory("${tempDir!.path}/files");
//     if (await filePath.exists()) {
//       return filePath.path;
//     } else {
//       await filePath.create(recursive: true);
//       return filePath.path;
//     }
//   }
// }