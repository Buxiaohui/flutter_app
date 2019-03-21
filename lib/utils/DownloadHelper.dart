import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/Md5Helper.dart';
import 'package:flutter_app/utils/PathHelper.dart';
import 'package:simple_permissions/simple_permissions.dart';

class DownloadHelper {
  static void download(String url, String path, Function callback,
      {OnDownloadProgress onDownloadProgress}) async {
    Dio dio = new Dio();
    Response response =
        await dio.download(url, path, onProgress: onDownloadProgress);
    if (response != null) {
      print(response.data.hashCode);
    } else {
      print("response is null");
    }
    if (callback != null) {
      callback(url, path, response);
    }
  }

  static Future<bool> onImageLongPressed(BuildContext ctx, String url) async {
    return showDialog(
          context: ctx,
          builder: (context) => new AlertDialog(
                title: new Text('Download'),
                content: new Text('下载图片到本地'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text('No'),
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      downloadImage(url);
                    },
                    child: new Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  static requestPermission(Permission permission) async {
    final res = await SimplePermissions.requestPermission(permission);
    print("permission request result is " + res.toString());
  }

  static checkPermission(Permission permission) async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
  }

  static getPermissionStatus(Permission permission) async {
    final res = await SimplePermissions.getPermissionStatus(permission);
    print("permission status is " + res.toString());
  }

  static void downloadImage(String url) async {
    bool resCheck = await SimplePermissions.checkPermission(
        Permission.WriteExternalStorage);
    if (resCheck) {
      realDownload(url);
    } else {
      PermissionStatus permissionStatus =
          await SimplePermissions.requestPermission(
              Permission.WriteExternalStorage);
      if (PermissionStatus.authorized == permissionStatus) {
        realDownload(url);
      }
    }
  }

  static void realDownload(String url) async {
    String path = await PathHelper.getExternalStorageDir();
    List<String> strs = url.split(".");
    path =
        path + "/" + Md5Helper.generateMd5(url) + "." + strs[strs.length - 1];
    DownloadHelper.download(url, path,
        (String url, String path, Response response) {
      print("downloadImage $url ...  $path");
      if (response != null) {
        print("downloadImage $response.data");
      }
    }, onDownloadProgress: (int received, int total) {
      double d = (received / total) * 100;
      String dp = d.toString() + "%";
      print("downloadImage $total ...  $received ... $dp");
    });
  }
}
